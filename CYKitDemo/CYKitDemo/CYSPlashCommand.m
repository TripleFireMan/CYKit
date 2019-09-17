//
//  CYSPlashCommand.m
//  CYKitDemo
//
//  Created by 成焱 on 2019/9/17.
//  Copyright © 2019 cheng.yan. All rights reserved.
//

#import "CYSPlashCommand.h"

@implementation CYSPlashCommand
- (NSString *)url
{
    NSString *url = @"https://paytest.sooyie.cn/Controller/service/Client2.ashx?action=GetSplashScreen";
    
    return url;
}

- (NSDictionary *)params
{
    NSDictionary *param = @{@"scale":@"16_9"};
    return param;
}
@end
