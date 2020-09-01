//
//  UIView+CYAddition.m
//  CYKit
//
//  Created by 成焱 on 2019/9/3.
//

#import "UIView+CYAddition.h"
#import <objc/runtime.h>
#import "Masonry.h"
#import "UIGestureRecognizer+YYAdd.h"
#import "CYKitDefines.h"

static NSString * kErrorImage;
static NSString * kErrorMsg;

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

- (void) setCy_errorMsgLabel:(UILabel *)cy_errorMsgLabel
{
    objc_setAssociatedObject(self, &kErrorMsg, cy_errorMsgLabel, OBJC_ASSOCIATION_RETAIN);
}

- (UILabel *) cy_errorMsgLabel
{
    return objc_getAssociatedObject(self, &kErrorMsg);
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
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            complete?complete():nil;
        }];
        tap.numberOfTapsRequired = 1;
        self.cy_errorImageView.userInteractionEnabled = YES;
        [self.cy_errorImageView addGestureRecognizer:tap];
    }
    
}

- (void) cy_showEmptyImage:(NSString *)name text:(NSString *)text clickRefresh:(void (^)(void))complete
{
    if (name && text) {
        [self cy_showEmptyImage:name text:text topMargin:0 clickRefresh:complete];
    }
}

- (void) cy_showEmptyImage:(NSString *)name text:(NSString *)text topMargin:(CGFloat)margin clickRefresh:(void (^)(void))complete
{
    if (name && text) {
        [self cy_hideAll];
        self.cy_errorImageView = [UIImageView new];
        self.cy_errorImageView.image = [UIImage imageNamed:name];
        self.cy_errorImageView.userInteractionEnabled = YES;
        [self addSubview:self.cy_errorImageView];
        [self.cy_errorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.centerY.offset(-margin/2.f);
        }];
        
        self.cy_errorMsgLabel = [UILabel new];
        self.cy_errorMsgLabel.text = text;
        self.cy_errorMsgLabel.textColor = [UIColor colorWithRed:200/255.f green:200/255.f blue:200/255.f alpha:1];
        self.cy_errorMsgLabel.font = CYPingFangSCRegular(13.f);
        self.cy_errorMsgLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.cy_errorMsgLabel];
        [self.cy_errorMsgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.cy_errorImageView.mas_bottom).offset(8);
            make.centerX.offset(0);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            complete?complete():nil;
        }];
        tap.numberOfTapsRequired = 1;
        self.cy_errorImageView.userInteractionEnabled = YES;
        [self.cy_errorImageView addGestureRecognizer:tap];
    }
}

- (void) cy_hideImages
{
    [self.cy_errorImageView removeFromSuperview];
    self.cy_errorImageView = nil;
}

- (void) cy_hideAll
{
    [self.cy_errorImageView removeFromSuperview];
    self.cy_errorImageView = nil;
    [self.cy_errorMsgLabel removeFromSuperview];
    self.cy_errorMsgLabel = nil;
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
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0
    if (@available(iOS 13, *)) {
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        
    }
#endif
}

- (void) cy_gradientLayerWithColor:(UIColor *)fromColor toColor:(UIColor *)toColor Horizontal:(BOOL)isHorizontal
{
    
    [[self.layer sublayers] enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAGradientLayer class]]) {
            *stop = YES;
            return;
        }
    }];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    
    gl.frame = CGRectMake(0 ,0,self.frame.size.width,self.frame.size.height);
    if (isHorizontal) {
        gl.startPoint = CGPointMake(1, 0);
        gl.endPoint = CGPointMake(0, 0);
    }
    else{
        gl.startPoint = CGPointMake(0.5, 1);
        gl.endPoint = CGPointMake(0.5, 0);
    }

    gl.colors = @[(__bridge id)fromColor.CGColor,(__bridge id)toColor.CGColor];
    gl.locations = @[@(0),@(1.0f)];
    [self.layer insertSublayer:gl atIndex:0];
}
@end
