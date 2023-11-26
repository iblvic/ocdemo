//
//  ViewController.m
//  ocdemo
//
//  Created by 吕凌浩 on 2023/11/26.
//

#import "ViewController.h"
#import "LHMapViewController.h"
#import "hookmsg.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)push:(id)sender {
    LHMapViewController *vc = [[LHMapViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)print:(id)sender {
    
    printFileContent();
}

@end
