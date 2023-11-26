//
//  ViewController.m
//  ocdemo
//
//  Created by haosimac on 2023/3/6.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "SunnyInterview.h"
#import <WebKit/WebKit.h>
#import "CTDisplayView.h"
#import "TestB.h"
#import <CoreLocation/CoreLocation.h>
#import "LHMapViewController.h"
#import "mmap_example.h"
#import "hookmsg.h"

#define NEW_SEL(sel) sel_registerName([NSString stringWithFormat:@"xx_%s", sel_getName(sel)].UTF8String)

@interface NSObject(LHAdd)

@end

@implementation NSObject(LHAdd)

+ (void)swizzlingInstanceMethod:(SEL)originalMethodSel withNewMethod:(SEL)newMethodSel {
    Method originalMethod = class_getInstanceMethod(self, originalMethodSel);
    Method newMethod = class_getInstanceMethod(self, newMethodSel);
    if (!originalMethod || !newMethod) {
        return;
    }
    class_addMethod(self, originalMethodSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    class_addMethod(self, newMethodSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    method_exchangeImplementations(originalMethod, newMethod);
}

@end


@interface LHHookModel : NSObject
@property (nonatomic, assign) IMP func;
@property (nonatomic, assign) SEL sel;
@end

@implementation LHHookModel

@end

@interface CLLocationManager(LHAdd)

@end

@implementation CLLocationManager(LHAdd)

static NSMutableArray *hookModels = nil;
static NSMutableArray *hookClasses = nil;

+ (void)load {
    [CLLocationManager swizzlingInstanceMethod:@selector(setDelegate:) withNewMethod:@selector(xx_setDelegate:)];
    hookModels = @[].mutableCopy;
    {
        LHHookModel *model = [LHHookModel new];
        model.sel = (SEL)"locationManager:didUpdateLocations:";
        model.func = (IMP)xx_locationManagerDidUpdateLocations;
        [hookModels addObject:model];
    }
    hookClasses = @[ViewController.class].mutableCopy;
}

static void xx_locationManagerDidUpdateLocations(id self, SEL cmd, CLLocationManager *manager, NSArray<CLLocation *> *locations) {
    NSLog(@"self.class:%@", [self class]);
    typeof(&xx_locationManagerDidUpdateLocations) updateLocations = (typeof(&xx_locationManagerDidUpdateLocations))method_getImplementation(class_getInstanceMethod([self class], NEW_SEL(cmd)));
    if (updateLocations) {
//        CLLocation *lct = [[`CLLocation` alloc] initWithLatitude:31.231706 longitude:121.472644];
        updateLocations(self, cmd, manager, locations);
    }
}

- (void)xx_setDelegate:(id)delegate {
    [self xx_setDelegate:delegate];
    if (![hookClasses containsObject:[delegate class]]) {
        return;
    }
    static void *delegateClsAssocoatedObjKey = &delegateClsAssocoatedObjKey;
    Class delegateCls = [delegate class];
    BOOL exist = [objc_getAssociatedObject(delegateCls, delegateClsAssocoatedObjKey) boolValue];
    for (LHHookModel *model in hookModels) {
        Method originalMethod = class_getInstanceMethod(delegateCls, model.sel);
        if (!exist && originalMethod) {
            objc_setAssociatedObject(delegateCls, delegateClsAssocoatedObjKey, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            class_addMethod(delegateCls, NEW_SEL(model.sel), model.func, method_getTypeEncoding(originalMethod));
            [delegateCls swizzlingInstanceMethod:model.sel withNewMethod:NEW_SEL(model.sel)];
        }
    }
}

@end

@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

+ (void)load {
//    [self swizzlingInstanceMethod:@selector(locationManager:didUpdateLocations:) withNewMethod:@selector(xx_locationManager:didUpdateLocations:)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestAlwaysAuthorization];
    _locationManager = locationManager;
    
    [self.tableView addObserver:self forKeyPath:@"delegate" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)dealloc {
    
    [self.tableView removeObserver:self forKeyPath:@"delegate"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.tableView) {
        if ([keyPath isEqualToString:@"delegate"]) {
            id value = change[NSKeyValueChangeNewKey];
            if (![value isKindOfClass:nil]) {
                self.tableView.delegate = nil;
                
            }
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        
//        struct objc_super {
//            /// Specifies an instance of a class.
//            __unsafe_unretained _Nonnull id receiver;
//
//            /// Specifies the particular superclass of the instance to message.
//            __unsafe_unretained _Nonnull Class super_class;
//
//            /* super_class is the first class to search */
//        };
        struct objc_super s = {self, class_getSuperclass(object_getClass(self))};
        ((void(*)(struct objc_super *,SEL,id,id,id,void*))objc_msgSendSuper)(&s,@selector(observeValueForKeyPath:ofObject:change:context:),keyPath,object,change,context);
    }
}

- (IBAction)pushButton:(id)sender {
    
    LHMapViewController *mapVc = [[LHMapViewController alloc] init];
    [self.navigationController pushViewController:mapVc animated:YES];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    printFileContent();
//    static BOOL toggle = NO;
//    if (!toggle) {
//        [self.locationManager startUpdatingLocation];
//    } else {
//        [self.locationManager stopUpdatingHeading];
//    }
//    [self locationManager:nil didUpdateLocations:nil];
}
//- (void)xx_locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
//    [self xx_locationManager:manager didUpdateLocations:locations];
//}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"locations:%@", locations);
    CLLocation *newLocation = locations.firstObject;
    if (CLLocationCoordinate2DIsValid(newLocation.coordinate)) {
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error) {
            if (array.count > 0) {
                CLPlacemark *placemark = [array objectAtIndex:0];
                NSLog(@"placemark:%@",placemark);
            }
        }];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"status:%d", status);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"error:%@",error);
}

@end
