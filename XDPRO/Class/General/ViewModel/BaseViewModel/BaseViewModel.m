//
//  BaseViewModel.m
//  Reactcocao
//
//  Created by XiaDian on 2016/11/25.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "BaseViewModel.h"
@implementation BaseViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        Class tempClass = [self class];
        while (tempClass != [NSObject class]) {
            unsigned int count = 0 ;
            objc_property_t *propertyList = class_copyPropertyList(tempClass, &count);
            for (int i = 0; i < count; i ++) {
                objc_property_t property = propertyList[i];
                NSString *propertyName = [NSString stringWithUTF8String: property_getName(property)];
                const char * type = property_getAttributes(property);
                NSString *attr = [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
            //    NSLog(@"%@",attr);
                if ([attr hasPrefix:@"T@"] && [attr length] > 1) {
                    NSString * typeClassName = [attr substringWithRange:NSMakeRange(3, [attr length]-4)];
                    if ([typeClassName containsString:@"NSString"]) {
                        [self setValue:@"" forKey:propertyName];
                    }
                    if ([typeClassName containsString:@"NSNumber"]) {
                        [self setValue:@(0) forKey:propertyName];
                    }
                    Class typeClass = NSClassFromString(typeClassName);
                    if (typeClass != nil) {
                        // Here is the corresponding class even for nil values
                    }
                }
                if ([attr hasPrefix:@"N,V_"]&&[attr length] > 1) {
                    NSString * typeClassName = [attr substringWithRange:NSMakeRange(3, [attr length]-4)];
                    if ([typeClassName containsString:@"TB"]) {
                        [self setValue:0 forUndefinedKey:propertyName];
                    }
                }
            }
            free(propertyList);
            tempClass = [tempClass superclass];
        }
    }
    return self;
}
- (NSString *)description{
    NSString *descriptionString = NSStringFromClass([self class]);
    Class tempClass = [self class];
    while (tempClass != [NSObject class]) {
        unsigned int count = 0 ;
        objc_property_t *propertyList = class_copyPropertyList(tempClass, &count);
        
        for (int i = 0; i < count; i ++) {
            objc_property_t property = propertyList[i];
            NSString *propertyName = [NSString stringWithUTF8String: property_getName(property)];
            NSString *propertyValue = [self valueForKey:propertyName];
            NSString *keyValueDic = [NSString stringWithFormat:@" %@--%@, ",propertyName,propertyValue];
            
            descriptionString = [descriptionString stringByAppendingString:keyValueDic];
        }
        free(propertyList);
        tempClass = [tempClass superclass];
    }
    return descriptionString;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
