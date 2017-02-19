//
//  UIImage+CYAddtion.m
//  CYKit
//
//  Created by 成焱 on 2017/2/19.
//  Copyright © 2017年 chengyan. All rights reserved.
//

#import "UIImage+CYAddtion.h"

@implementation UIImage (CYAddtion)
+ (instancetype)cy_imageNamed:(NSString *)name
{
    NSLog(@"image = %@",[UIImage imageNamed:@"1"]);
    
    return [UIImage imageNamed:name];
}
@end
