//
//  LHMapViewController.m
//  ocdemo
//
//  Created by haosimac on 2023/11/20.
//

#import "LHMapViewController.h"
#import <MapKit/MapKit.h>

@interface LHMapViewController () <MKMapViewDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) UIButton *copyButton;

@property (nonatomic) CLLocationCoordinate2D currentCoordinate;
@property (strong, nonatomic) UIButton *locateButton;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation LHMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.frame = self.view.bounds;
    self.locateButton.frame = CGRectMake(15, self.view.frame.size.height-20-34, 20, 20);
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.locateButton];
    // 初始化定位管理器
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // 请求定位权限
    [self.locationManager requestWhenInUseAuthorization];
    
    // 添加长按手势
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self.mapView addGestureRecognizer:longPressGesture];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.copyButton];
    
    [self.locationManager startUpdatingLocation];
}

// 长按手势处理方法
- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        // 获取手势发生的点
        CGPoint touchPoint = [gesture locationInView:self.mapView];
        
        // 将屏幕上的点转换为地图坐标
        CLLocationCoordinate2D coordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
        
        // 更新当前坐标
        self.currentCoordinate = coordinate;
        
        // 更新地图标注
        [self updateMapAnnotation];
        
        // 激活复制按钮
        self.copyButton.enabled = YES;
    }
}

// 更新地图标注
- (void)updateMapAnnotation {
    // 清除所有标注
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    // 创建新的标注
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = self.currentCoordinate;
    
    // 将标注添加到地图
    [self.mapView addAnnotation:annotation];
    
    // 设置地图显示区域以包含标注
    MKCoordinateRegion region = MKCoordinateRegionMake(self.currentCoordinate, self.mapView.region.span);
    [self.mapView setRegion:region animated:YES];
}

// 复制按钮点击事件
- (void)copyButtonTapped:(id)sender {
    // 将当前经纬度字符串复制到剪贴板
    NSString *coordinateString = [NSString stringWithFormat:@"%.6f, %.6f", self.currentCoordinate.latitude, self.currentCoordinate.longitude];
    [UIPasteboard generalPasteboard].string = coordinateString;
    
    // 提示复制成功
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"成功复制" message:@"当前经纬度已复制到剪贴板" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

// 定位按钮点击事件
- (void)locateButtonTapped:(id)sender {
    // 请求定位服务
    [self.locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    // 获取用户当前位置
    CLLocation *location = [locations firstObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    // 更新当前坐标
    self.currentCoordinate = coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.currentCoordinate, 500, 500);
    [self.mapView setRegion:region animated:NO];
    
    // 更新地图标注
    [self updateMapAnnotation];
    
    // 停止定位服务
    [self.locationManager stopUpdatingLocation];
}

- (MKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MKMapView alloc] initWithFrame:CGRectZero];
        _mapView.delegate = self;
        _mapView.backgroundColor = [UIColor whiteColor];
    }
    return _mapView;
}

- (UIButton *)copyButton {
    if (!_copyButton) {
        _copyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _copyButton.frame = CGRectMake(0, 0, 50, 32);
        _copyButton.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        [_copyButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_copyButton setTitleColor:UIColor.whiteColor forState:UIControlStateHighlighted];
        [_copyButton setTitle:@"复制" forState:UIControlStateNormal];
        _copyButton.backgroundColor = [UIColor systemBlueColor];
        _copyButton.layer.cornerRadius = 16;
        _copyButton.layer.masksToBounds = YES;
        [_copyButton addTarget:self action:@selector(copyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        _copyButton.enabled = NO;
    }
    return _copyButton;
}
- (UIButton *)locateButton {
    if (!_locateButton) {
        _locateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _locateButton.frame = CGRectMake(0, 0, 20, 20);
        _locateButton.backgroundColor = [UIColor systemRedColor];
        _locateButton.layer.cornerRadius = 10;
        _locateButton.layer.masksToBounds = YES;
        [_locateButton addTarget:self action:@selector(locateButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _locateButton;
}
@end
