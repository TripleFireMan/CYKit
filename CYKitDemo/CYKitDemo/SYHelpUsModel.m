//
//  SYHelpUsModel.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/7.
//  Copyright © 2019 sy. All rights reserved.
//

#import "SYHelpUsModel.h"

@implementation SYHelpUsModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"children":[SYHelpUsSubModel class]};
    
}
@end


@implementation SYHelpUsSubModel


@end
