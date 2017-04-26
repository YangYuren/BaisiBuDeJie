//
//  UITextField+placeholder.m
//  BaiSi
//
//  Created by Yang on 2017/4/24.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "UITextField+placeholder.h"
#import <objc/message.h>
@implementation UITextField (placeholder)
+(void)load{
    Method m1 = class_getClassMethod(self, @selector(setPlaceholder:));
    Method m2 = class_getClassMethod(self, @selector(setXMG_Placeholder:));
    method_exchangeImplementations(m1, m2);
    
}
-(void)setPlaceholderFast:(UIColor *)placeholderFast{
    objc_setAssociatedObject(self, @"placeholderFast", placeholderFast, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UILabel * label = [self valueForKey:@"placeholderLabel"];
    label.textColor =placeholderFast;

}
-(UIColor *)placeholderFast{
    return objc_getAssociatedObject(self, @"placeholderFast");
}
-(void)setXMG_Placeholder:(NSString *)placeholder{
    [self setPlaceholder:placeholder];
    self.placeholderFast = self.placeholderFast;
}
@end
