# WDRuntimeDemo
wangduan空闲时间关于Runtime的一些小用法。


# Function 
* 利用Runtime获取一个类的所有成员变量名、方法名、protocol名称等等。
* 利用Runtime为一个类的Category添加变量、归档解档等等。
# Example
```example
//用法
/**
*  获取全部属性名称
*/
- (NSMutableArray *)getAllProperty {
unsigned int count;

NSMutableArray *propertyArray = [NSMutableArray array];

//获得指向该类所有属性的指针
objc_property_t *properties = class_copyPropertyList([Car class], &count);

for (int i = 0; i < count; i++) {
//获得该类的一个属性的指针
objc_property_t property = properties[i];
//获取属性的名称
const char *name = property_getName(property);
//将C的字符串转为OC的
NSString *key = [NSString stringWithUTF8String:name];

[propertyArray addObject:key];

}
//释放
free(properties);
return propertyArray;
}

/**
*  获取全部方法
*/
- (void)getAllMethod {
unsigned int count;

//获取指向该类所有方法的指针
Method *methods = class_copyMethodList([Car class], &count);

for (int i = 0; i < count; i++) {
//获取该类的一个方法的指针
Method method = methods[i];
//获取方法
SEL methodSEL = method_getName(method);
//将方法转换为C字符串
const char *name = sel_getName(methodSEL);
//将C字符串转为OC字符串
NSString *methodName = [NSString stringWithUTF8String:name];

//获取方法参数个数
int arguments = method_getNumberOfArguments(method);

NSLog(@"%d == %@ %d",i,methodName,arguments);
}
//释放
free(methods);
}

/**
*  获取遵循的全部协议
*/
- (void)getAllProtocol {
unsigned int count;

//获取指向该类遵循的所有协议的指针
__unsafe_unretained Protocol **protocols = class_copyProtocolList([self class], &count);

for (int i = 0; i < count; i++) {
//获取该类遵循的一个协议指针
Protocol *protocol = protocols[i];
//获取C字符串协议名
const char *name = protocol_getName(protocol);
//C字符串转OC字符串
NSString *protocolName = [NSString stringWithUTF8String:name];
NSLog(@"%d == %@",i,protocolName);
}
//释放
free(protocols);
}

/**
*  归档/解档
*/
- (void)archiverUnarchiver {
Car *car = [[Car alloc] init];
car.car_Name = @"N1";
car.car_Brand = @"小牛";
car.car_Width = 50.0;
car.car_Length = 120.0;
car.car_Height = 80.0;

NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
NSString *path = [NSString stringWithFormat:@"%@/archive",[paths objectAtIndex:0]];
[NSKeyedArchiver archiveRootObject:car toFile:path];

Car *unarchiverCar = [NSKeyedUnarchiver unarchiveObjectWithFile:path];

NSLog(@"path:%@\nunarchiverCar:%@",path,unarchiverCar);
}
```

