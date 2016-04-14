//
//  Car+Category.m
//  WDRuntimeDemo
//
//  Created by wangduan on 16/4/14.
//  Copyright © 2016年 wangduan. All rights reserved.
//

#import "Car+Category.h"
#import <objc/runtime.h>

static const void *CategoryKey = &CategoryKey;

@implementation Car (Category)

- (void)setCategory:(NSString *)category {
    objc_setAssociatedObject(self, CategoryKey, category, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)category {
    return objc_getAssociatedObject(self, CategoryKey);
}
@end
