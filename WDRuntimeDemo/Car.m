//
//  Car.m
//  WDRuntimeDemo
//
//  Created by wangduan on 16/4/14.
//  Copyright © 2016年 wangduan. All rights reserved.
//

#import "Car.h"
#import <objc/runtime.h>

@interface Car ()<NSCoding>

@property (nonatomic, copy) NSString * car_Color;
@property (nonatomic, copy) NSString * car_Price;

@end


@implementation Car

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count;
    //获得指向当前类的所有属性的指针
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        //获取指向当前类的某一个属性的指针
        objc_property_t property = properties[i];
        //获取C字符串属性名
        const char *name = property_getName(property);
        //C字符串转OC字符串
        NSString *propertyName = [NSString stringWithUTF8String:name];
        //通过关键词取值
        NSString *propertyValue = [self valueForKey:propertyName];
        //编码属性
        [aCoder encodeObject:propertyValue forKey:propertyName];
    }
    //释放
    free(properties);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    unsigned int count;
    //获得指向当前类的所有属性的指针
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        //获取指向当前类的某一个属性的指针
        objc_property_t property = properties[i];
        //获取C字符串属性名
        const char *name = property_getName(property);
        //C字符串转OC字符串
        NSString *propertyName = [NSString stringWithUTF8String:name];
        //解码属性值
        NSString *propertyValue = [aDecoder decodeObjectForKey:propertyName];
        [self setValue:propertyValue forKey:propertyName];
    }
    //释放
    free(properties);
    return self;
}

- (void)carToSport{
    NSLog(@"carToSport");
}
@end
