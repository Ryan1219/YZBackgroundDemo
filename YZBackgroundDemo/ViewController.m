//
//  ViewController.m
//  YZBackgroundDemo
//
//  Created by zhangliangwang on 17/4/18.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

#define kLocationChangeUpdate @"locationChangeUpdate"

@interface ViewController ()<CLLocationManagerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //终了时调用
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locaUpdate) name:kLocationChangeUpdate object:UIApplicationWillTerminateNotification];
    
    //后台时调用
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locaUpdate) name:kLocationChangeUpdate object:UIApplicationDidEnterBackgroundNotification];

    
    [self locationUpdate];
    
}

- (void)locaUpdate {
    
    CLLocationManager *locationMgr = [[CLLocationManager alloc] init];
    [locationMgr startMonitoringSignificantLocationChanges];
    [locationMgr startUpdatingLocation];
}

- (void)locationUpdate {
    
    CLLocationManager *locationMgr = [[CLLocationManager alloc] init];
    [locationMgr setAllowsBackgroundLocationUpdates:true];
    
    // 判断手机是否打开了定位服务
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务可能还没打开，请前往设置");
        return;
    } else {
        
        NSLog(@"定位服务已经打开");
    }
    
    //判断用户是否授权
    //    CLAuthorizationStatus statau = [CLLocationManager authorizationStatus];
    //    switch (statau) {
    //        case kCLAuthorizationStatusNotDetermined: {
    //            NSLog(@"--kCLAuthorizationStatusNotDetermined--");
    //            [mgr requestAlwaysAuthorization];
    //        }
    //            break;
    //        case kCLAuthorizationStatusRestricted: {
    //            NSLog(@"--kCLAuthorizationStatusRestricted--");
    //        }
    //            break;
    //        case kCLAuthorizationStatusDenied: {
    //            NSLog(@"--kCLAuthorizationStatusDenied--");
    //        }
    //            break;
    //        case kCLAuthorizationStatusAuthorizedAlways: {
    //            NSLog(@"--kCLAuthorizationStatusAuthorizedAlways--");
    //        }
    //            break;
    //        case kCLAuthorizationStatusAuthorizedWhenInUse: {
    //            NSLog(@"--kCLAuthorizationStatusAuthorizedWhenInUse--");
    //        }
    //            break;
    //        default:
    //            break;
    //    }
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [locationMgr requestAlwaysAuthorization];
        NSLog(@"请求用户授权");
    } else {
        NSLog(@"可以使用");
        locationMgr.delegate = self;
        locationMgr.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        locationMgr.distanceFilter = 0.1;
        
        locationMgr.allowsBackgroundLocationUpdates = true;
        [locationMgr startUpdatingLocation];
        [locationMgr startMonitoringSignificantLocationChanges];
        
    }

}

//MARK:- CLLocationManagerDelegate
//如果用户位置发生改变，则调用下面的函数
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    
}

@end

















































































