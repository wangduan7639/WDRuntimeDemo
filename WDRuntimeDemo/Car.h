//
//  Car.h
//  WDRuntimeDemo
//
//  Created by wangduan on 16/4/14.
//  Copyright © 2016年 wangduan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CarDelegate;
@interface Car : NSObject

@property (nonatomic, assign) id<CarDelegate> delegate;
@property (nonatomic, copy) NSString *car_Name;
@property (nonatomic, copy) NSString *car_Brand;
@property (nonatomic, assign) float car_Length;
@property (nonatomic, assign) float car_Height;
@property (nonatomic, assign) float car_Width;

- (void)carToSport;

@end


@protocol CarDelegate <NSObject>

- (void)carToLauch;

- (void)carToStop;

@end