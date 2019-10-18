//
//  UIView+CYAddition.m
//  CYKit
//
//  Created by 成焱 on 2019/9/3.
//

#import "UIView+CYAddition.h"
#import <objc/runtime.h>
#import "Masonry.h"
#import "BlocksKit+UIKit.h"

static NSString * kErrorImage;


@implementation UIView (CYAddition)

+(id ) cy_loadCurrentViewFromNib{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil];
    if (array.count == 0) {
        NSString *info = [NSString stringWithFormat:@"找不到%@.xib",NSStringFromClass(self)];
        NSLog(@"类别: %@  \n方法: %@ \n行号:%d \n调试信息: %@",self,NSStringFromSelector(_cmd),__LINE__, info);
        return nil;
    }
    return [array firstObject];
}

- (void) setCy_errorImageView:(UIImageView *)cy_errorImageView
{
    objc_setAssociatedObject(self, &kErrorImage, cy_errorImageView, OBJC_ASSOCIATION_RETAIN);
}

- (UIImageView *) cy_errorImageView
{
    return objc_getAssociatedObject(self, &kErrorImage);
}

- (void) cy_showEmptyImage:(NSString *)name clickRefresh:(void (^)(void))complete
{
    if (name) {
        [self cy_hideImages];
        self.cy_errorImageView = [UIImageView new];
        self.cy_errorImageView.image = [UIImage imageNamed:name];
        self.cy_errorImageView.userInteractionEnabled = YES;
        [self addSubview:self.cy_errorImageView];
        [self.cy_errorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
        }];
        
        [self.cy_errorImageView bk_whenTapped:^{
            complete?complete():nil;
        }];
    }
    
}

- (void) cy_hideImages
{
    [self.cy_errorImageView removeFromSuperview];
    self.cy_errorImageView = nil;
}

- (void) cy_cornerRound:(UIRectCorner)corner size:(CGSize)size
{
    [self.superview layoutIfNeeded];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:size];
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
}

- (void) cy_adjustForIOS13
{
    if (@available(iOS 13, *)) {
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
}
@end
