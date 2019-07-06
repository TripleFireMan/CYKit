////
////  CYBubbleView.m
////  Bubble
////
////  Created by chengyan on 2017/9/11.
////  Copyright © 2017年 Youku.inc. All rights reserved.
////
//
//#import "CYTailBubbleView.h"
//#import "Masonry.h"
//#import "BlocksKit+UIKit.h"
//
//#ifndef PingFangRegularFont
//#define PingFangRegularFont(x)      ([[[UIDevice currentDevice]systemVersion]floatValue] >= 9.0) ? \
//[UIFont fontWithName:@"PingFangSC-Regular" size:x] : [UIFont boldSystemFontOfSize:x]
//#endif
//#ifndef PingFangMediumFont
//#define PingFangMediumFont(x)       ([[[UIDevice currentDevice]systemVersion]floatValue] >= 9.0) ? \
//[UIFont fontWithName:@"PingFangSC-Medium" size:x] : [UIFont systemFontOfSize:x]
//#endif
//
//#define DefaultTitleFont    PingFangMediumFont(13.f)
//#define DefaultTitleColor   [UIColor colorWithRed:34.f/255.f green:34.f/255.f blue:34.f/255.f alpha:1]
//#define DefaultBGColor      [UIColor colorWithRed:255.f/255.f green:224.f/255.f blue:0 alpha:1]
//
//
//
////static const CGFloat cornerWidthForUpdown = 15.f;//上下 ，左右为8
//static const CGFloat cornerHeightForUpdown = 8.f;//上下，左右为9
//static const CGFloat cornerWidthForLeftRight = 8.f;
////static const CGFloat cornerHeightForLeftRight = 9.f;
//
//@interface CYTailBubbleBackgroundView : UIView
//@property (nonatomic, assign) CYTailBubbleViewCornerType xCorner;
//@property (nonatomic, assign) CYTailBubbleViewCornerType yCorner;
//@property (nonatomic, strong) UIColor *color;
//@property (nonatomic, assign) CGPoint cornerPoint;
//@property (nonatomic, assign) BOOL shadowNeeds;
//
//- (instancetype)initWithFrame:(CGRect)frame xCorner:(CYTailBubbleViewCornerType)xCorner yCorner:(CYTailBubbleViewCornerType)yCorner bgColor:(UIColor *)bgcolor cornerPoint:(CGPoint)cornerPoint;
//@end
//
//
//@implementation CYTailBubbleBackgroundView
//
//- (instancetype)initWithFrame:(CGRect)frame xCorner:(CYTailBubbleViewCornerType)xCorner yCorner:(CYTailBubbleViewCornerType)yCorner bgColor:(UIColor *)bgcolor cornerPoint:(CGPoint)cornerPoint
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.xCorner = xCorner;
//        self.yCorner = yCorner;
//        self.color = bgcolor;
//        self.cornerPoint = cornerPoint;
//    }
//    return self;
//}
//
//- (void)drawRect:(CGRect)rect
//{
//    CGFloat width = rect.size.width;
//    CGFloat height = rect.size.height;
//    UIEdgeInsets insets = UIEdgeInsetsZero;
//
////    CGSize size = CGSizeZero;
////    CGPoint point = CGPointZero;
//    CGPoint startPoint = CGPointZero;
//    CGPoint endPoint = CGPointZero;
//    CGPoint ctlPoint = CGPointZero;
//
//    if (self.xCorner == CYTailBubbleViewCornerLeft) {
//        insets.left = cornerWidthForLeftRight;
//    }else if (self.xCorner == CYTailBubbleViewCornerRight){
//        insets.right = cornerWidthForLeftRight;
//    }else if (self.xCorner == CYTailBubbleViewCornerTop){
//        insets.top = cornerHeightForUpdown;
//    }else if (self.xCorner == CYTailBubbleViewCornerBottom){
//        insets.bottom = cornerHeightForUpdown;
//    }
//
//    CGFloat radius = (height - insets.bottom - insets.top) / 2.f;
//    CGFloat realX = insets.left;
//    CGFloat realY = insets.top;
//
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(realX + radius, realY)];
//
//    if (self.xCorner == CYTailBubbleViewCornerTop) {
//        if (!CGPointEqualToPoint(self.cornerPoint, CGPointZero)) {
//            CGFloat pointx = self.cornerPoint.x;
//            if (pointx <= width / 2) {
//                //左侧
//                startPoint = CGPointMake(pointx - 6, realY);
//                ctlPoint = CGPointMake(pointx - 5, realY / 2);
//                endPoint = CGPointMake(pointx, 0);
//                [path addLineToPoint:startPoint];
//                [path addQuadCurveToPoint:endPoint controlPoint:ctlPoint];
//                ctlPoint = CGPointMake(pointx + 2, realY / 2 + 3);
//                endPoint = CGPointMake(pointx + 8, realY);
//                [path addQuadCurveToPoint:endPoint controlPoint:ctlPoint];
//            }
//            else{
//                startPoint = CGPointMake(pointx - 8, realY);
//                ctlPoint = CGPointMake(pointx - 2, realY / 2 +3);
//                endPoint = CGPointMake(pointx, 0);
//                [path addLineToPoint:startPoint];
//                [path addQuadCurveToPoint:endPoint controlPoint:ctlPoint];
//                ctlPoint = CGPointMake(pointx + 5 , realY / 2 );
//                endPoint = CGPointMake(pointx + 6, realY);
//            }
//        }
//        else{
//            if (self.yCorner == CYTailBubbleViewCornerLeft) {
//                startPoint = CGPointMake((width) / 3 - 6, realY);
//                ctlPoint = CGPointMake((width) / 3 - 5, realY / 2);
//                endPoint = CGPointMake((width) / 3, 0);
//                [path addLineToPoint:startPoint];
//                [path addQuadCurveToPoint:endPoint controlPoint:ctlPoint];
//                ctlPoint = CGPointMake((width) / 3 + 2, realY / 2 + 3);
//                endPoint = CGPointMake((width) / 3 + 8, realY);
//                [path addQuadCurveToPoint:endPoint controlPoint:ctlPoint];
//            }
//            else if(self.yCorner == CYTailBubbleViewCornerCenter){
//                startPoint = CGPointMake(width / 2.f - 8, realY);
//                ctlPoint = CGPointMake(width / 2.f - 2, realY / 2 +3);
//                endPoint = CGPointMake(width / 2, 0);
//                [path addLineToPoint:startPoint];
//                [path addQuadCurveToPoint:endPoint controlPoint:ctlPoint];
//                ctlPoint = CGPointMake(width / 2.f + 5 , realY / 2 );
//                endPoint = CGPointMake(width / 2.f + 6, realY);
//                [path addQuadCurveToPoint:endPoint controlPoint:ctlPoint];
//            }else if(self.yCorner == CYTailBubbleViewCornerRight){
//                startPoint = CGPointMake(width / 2.f - 8, realY);
//                ctlPoint = CGPointMake(width / 2.f - 2, realY / 2 +3);
//                endPoint = CGPointMake(width / 2, 0);
//                [path addLineToPoint:startPoint];
//                [path addQuadCurveToPoint:endPoint controlPoint:ctlPoint];
//                ctlPoint = CGPointMake(width / 2.f + 5 , realY / 2 );
//                endPoint = CGPointMake(width / 2.f + 6, realY);
//            }
//        }
//    }
//
//    [path addLineToPoint:CGPointMake(width - insets.right - radius, realY)];
//
//    [path addArcWithCenter:CGPointMake(width - insets.right - radius - insets.left, realY + radius ) radius:radius startAngle:-M_PI / 2  endAngle:-M_PI/2 + M_PI clockwise:YES];
//
////    [path addQuadCurveToPoint:CGPointMake(width - insets.right, insets.top + radius) controlPoint:CGPointMake(width - insets.right, realY)];
//
//    ///纵向绘制使用的关键点
//    CGFloat x5 = 4;
//    CGFloat x6 = 3;
//    CGFloat x7 = 4;
//    CGFloat x8 = 2;
//
//    if (self.xCorner == CYTailBubbleViewCornerLeft) {
//        if (!CGPointEqualToPoint(self.cornerPoint, CGPointZero)) {
//            NSLog(@"暂不支持左侧---自定义尾部气泡");
//        }
//        else{
//            if (self.yCorner == CYTailBubbleViewCornerTop) {
//                NSLog(@"暂不支持左侧---偏上位置尾部气泡");
//            }
//            else if(self.yCorner == CYTailBubbleViewCornerCenter){
//                startPoint = CGPointMake(insets.left + 2, height / 2 - x5);
//                ctlPoint = CGPointMake(insets.left / 2, height/ 2 - x6);
//                endPoint = CGPointMake(0, height /2 + x7);
//                [path moveToPoint:startPoint];
//                [path addQuadCurveToPoint:endPoint controlPoint:ctlPoint];
//                ctlPoint = CGPointMake(insets.left / 2 , height / 2 + x8);
//                endPoint = CGPointMake(insets.left + 2, height /2 + x7);
//                [path addQuadCurveToPoint:endPoint controlPoint:ctlPoint];
//                [self.color setFill];
//                [path fill];
////                [path moveToPoint:CGPointMake(width - insets.right, insets.top + radius)];
//            }else if(self.yCorner == CYTailBubbleViewCornerBottom){
//                NSLog(@"暂不支持左侧---偏上位置尾部气泡");
//            }
//        }
//    }
//
////    [path addQuadCurveToPoint:CGPointMake(width - insets.right - radius, height - insets.bottom) controlPoint:CGPointMake(width - insets.right, height - insets.bottom)];
//
////    [path addQuadCurveToPoint:CGPointMake(width - insets.right - radius, height - insets.bottom) controlPoint:CGPointMake(width - insets.right, height - insets.bottom)];
//
//    if (self.xCorner == CYTailBubbleViewCornerBottom) {
//        if (!CGPointEqualToPoint(self.cornerPoint, CGPointZero)) {
//            CGFloat pointx = self.cornerPoint.x;
//
//            if (pointx <= width / 2) {
//                //左侧
//                startPoint = CGPointMake(pointx - 6, height - insets.bottom);
//                ctlPoint = CGPointMake(pointx - 5, height - insets.bottom /2.f);
//                endPoint = CGPointMake(pointx, height);
//                [path addLineToPoint:startPoint];
//                [path addQuadCurveToPoint:endPoint controlPoint:ctlPoint];
//                ctlPoint = CGPointMake(pointx + 2, height - insets.bottom /2.f - 3);
//                endPoint = CGPointMake(pointx + 8, height - insets.bottom);
//                [path addQuadCurveToPoint:endPoint controlPoint:ctlPoint];
//            }
//            else{
//                startPoint = CGPointMake(pointx + 6, height - insets.bottom);
//                ctlPoint = CGPointMake(pointx + 5, height - insets.bottom /2.f);
//                endPoint = CGPointMake(pointx, height);
//                [path addLineToPoint:startPoint];
//                [path addQuadCurveToPoint:endPoint controlPoint:ctlPoint];
//                ctlPoint = CGPointMake(pointx - 2 , height - insets.bottom /2.f  -3);
//                endPoint = CGPointMake(pointx - 8, height - insets.bottom);
//                [path addQuadCurveToPoint:endPoint controlPoint:ctlPoint];
//            }
//        }
//        else{
//            if (self.yCorner == CYTailBubbleViewCornerLeft) {
//                startPoint = CGPointMake((width) / 3 - 6, height - insets.bottom);
//                ctlPoint = CGPointMake((width) / 3 - 5, height - insets.bottom /2.f);
//                endPoint = CGPointMake((width) / 3, height);
//                [path addLineToPoint:startPoint];
//                [path addQuadCurveToPoint:endPoint controlPoint:ctlPoint];
//                ctlPoint = CGPointMake((width) / 3 + 2, height - insets.bottom /2.f - 3);
//                endPoint = CGPointMake((width) / 3 + 8, height - insets.bottom);
//                [path addQuadCurveToPoint:endPoint controlPoint:ctlPoint];
//            }
//            else if(self.yCorner == CYTailBubbleViewCornerCenter){
//                startPoint = CGPointMake(width / 2.f + 6, height - insets.bottom);
//                ctlPoint = CGPointMake(width / 2.f + 5, height - insets.bottom /2.f);
//                endPoint = CGPointMake(width / 2, height);
//                [path addLineToPoint:startPoint];
//                [path addQuadCurveToPoint:endPoint controlPoint:ctlPoint];
//                ctlPoint = CGPointMake(width / 2.f - 2 , height - insets.bottom /2.f  -3);
//                endPoint = CGPointMake(width / 2.f - 8, height - insets.bottom);
//                [path addQuadCurveToPoint:endPoint controlPoint:ctlPoint];
//            }else if(self.yCorner == CYTailBubbleViewCornerRight){
//                startPoint = CGPointMake(width / 2.f + 6, height - insets.bottom);
//                ctlPoint = CGPointMake(width / 2.f + 5, height - insets.bottom /2.f);
//                endPoint = CGPointMake(width / 2, height);
//                [path addLineToPoint:startPoint];
//                [path addQuadCurveToPoint:endPoint controlPoint:ctlPoint];
//                ctlPoint = CGPointMake(width / 2.f - 2 , height - insets.bottom /2.f  -3);
//                endPoint = CGPointMake(width / 2.f - 8, height - insets.bottom);
//                [path addQuadCurveToPoint:endPoint controlPoint:ctlPoint];
//            }
//        }
//    }
//
//    [path addLineToPoint:CGPointMake(realX + radius, height - insets.bottom)];
//
//
//    [path addArcWithCenter:CGPointMake(realX + radius, realY + (height - insets.bottom - insets.top) / 2) radius:radius startAngle:-M_PI/2 + M_PI endAngle:M_PI / 2 + M_PI clockwise:YES];
//
//    [path closePath];
//    [path addClip];
//    [self.color setFill];
//    [path fill];
//
//    if (self.shadowNeeds) {
//        self.layer.shadowPath = path.CGPath;
//        self.layer.shadowOpacity = 0.26f;
//        self.layer.shadowColor = [[UIColor colorWithRed:44.f/255 green:44.f/255.f blue:44.f/255 alpha:1]CGColor];
//        self.layer.shadowOffset = CGSizeMake(0, 1.5);
//        self.layer.shadowRadius = 2.f;
//    }else{
//        self.layer.shadowPath = nil;
//    }
//}
//
//@end
//
//
//@interface CYTailBubbleView ()
//
//@property (nonatomic, strong) UIView        *contentView;
//@property (nonatomic, strong) UILabel       *messageLabel;
//@property (nonatomic, strong) UIImageView   *rightImageView;
//@property (nonatomic, strong) CALayer       *bgLayer;
//
//@property (nonatomic, assign) CYTailBubbleViewCornerType xCorner;
//@property (nonatomic, assign) CYTailBubbleViewCornerType yCorner;
//@property (nonatomic, strong) UIFont        *labelFont;
//@property (nonatomic, strong) UIColor       *labelColor;
//
//@property (nonatomic, strong) CYTailBubbleBackgroundView *bgView;
//@end
//
//@implementation CYTailBubbleView
//
//- (instancetype)initWithFrame:(CGRect)frame titleMessage:(NSString *)message{
//
//    return [self initWithFrame:frame titleMessage:message titleFont:nil titleColor:nil backgroundColor:nil rightImage:nil tailInXCorner:CYTailBubbleViewCornerBottom tailInYCorner:CYTailBubbleViewCornerCenter cornerPoint:CGPointZero closeCallBack:nil];
//}
//
//- (instancetype)initWithFrame:(CGRect)frame titleMessage:(NSString *)message rightImage:(UIImage *)rightImage{
//    return [self initWithFrame:frame titleMessage:message titleFont:nil titleColor:nil backgroundColor:nil rightImage:rightImage tailInXCorner:CYTailBubbleViewCornerBottom tailInYCorner:CYTailBubbleViewCornerCenter cornerPoint:CGPointZero closeCallBack:nil];
//}
//- (instancetype)initWithFrame:(CGRect)frame titleMessage:(NSString *)message titleFont:(UIFont *)font titleColor:(UIColor *)color{
//    return [self initWithFrame:frame titleMessage:message titleFont:font titleColor:color backgroundColor:nil rightImage:nil tailInXCorner:CYTailBubbleViewCornerBottom tailInYCorner:CYTailBubbleViewCornerCenter cornerPoint:CGPointZero closeCallBack:nil];
//}
//- (instancetype)initWithFrame:(CGRect)frame titleMessage:(NSString *)message titleFont:(UIFont *)font titleColor:(UIColor *)color rightImage:(UIImage *)rightImage{
//    return [self initWithFrame:frame titleMessage:message titleFont:font titleColor:color backgroundColor:nil rightImage:rightImage tailInXCorner:CYTailBubbleViewCornerBottom tailInYCorner:CYTailBubbleViewCornerCenter cornerPoint:CGPointZero closeCallBack:nil];
//}
//
//- (instancetype)initWithFrame:(CGRect)frame titleMessage:(NSString *)message titleFont:(UIFont *)font titleColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor rightImage:(UIImage *)rightImage tailInXCorner:(CYTailBubbleViewCornerType)xCorner tailInYCorner:(CYTailBubbleViewCornerType)yCorner cornerPoint:(CGPoint)cornerPoint closeCallBack:(void (^)())closeBlock
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        NSAssert(message, @"message cannot nil");
//        if (!message) return nil;
//
//        UIFont *lableFont = font;
//        UIColor *lableColor = color;
//        UIColor *bgColor = backgroundColor;
//        if (!lableFont) {
//            lableFont = DefaultTitleFont;
//        }
//        if (!lableColor) {
//            lableColor = DefaultTitleColor;
//        }
//        if (!bgColor) {
//            bgColor = DefaultBGColor;
//        }
//
//        self.labelFont = lableFont;
//        self.labelColor = lableColor;
//        self.xCorner = xCorner;
//        self.yCorner = yCorner;
//        self.rightImage = rightImage;
//        self.closeBlock = closeBlock;
//
//        BOOL existRightImage = rightImage?YES:NO;
//
//        CGRect bounds   = self.bounds;
//        CGRect bgViewFrame = bounds;
//
//        self.bgView = [[CYTailBubbleBackgroundView alloc]initWithFrame:bgViewFrame xCorner:xCorner yCorner:yCorner bgColor:bgColor cornerPoint:cornerPoint];
//        self.bgView.backgroundColor = [UIColor clearColor];
//        [self addSubview:self.bgView];
//        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self);
//        }];
//
//
//        CGFloat lableX = 0;
//        CGFloat lableY = 0;
//
//        [self p_getLabelPosition:&lableX lblY:&lableY];
//
//        if (existRightImage) {
//            CGFloat imgLeftGap = 10.f;
//            CGFloat imagewidth = rightImage.size.width;
//            CGFloat imageheigth = rightImage.size.height;
//
//            self.messageLabel = [UILabel new];
//            self.messageLabel.font = lableFont;
//            self.messageLabel.textColor = lableColor;
//            self.messageLabel.text = message;
//            self.messageLabel.textAlignment = NSTextAlignmentCenter;
//            self.messageLabel.backgroundColor = [UIColor clearColor];
//
//            [self addSubview:self.messageLabel];
//
//            [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.with.offset(lableX);
//                make.top.with.offset(lableY);
//            }];
//
//            self.rightImageView = [UIImageView new];
//            self.rightImageView.image = rightImage;
//            [self addSubview:self.rightImageView];
//
//            [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(self.messageLabel.mas_right).with.offset(imgLeftGap);
//                make.width.with.offset(imagewidth);
//                make.height.with.offset(imageheigth);
//                make.centerY.equalTo(self.messageLabel);
//            }];
//
//
//        }
//        else{
//            self.messageLabel = [UILabel new];
//            self.messageLabel.font = lableFont;
//            self.messageLabel.textColor = lableColor;
//            self.messageLabel.text = message;
//            self.messageLabel.textAlignment = NSTextAlignmentCenter;
//            [self addSubview:self.messageLabel];
//
//            [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerX.mas_equalTo(self);
//                make.top.with.offset(lableY);
//            }];
//        }
//
//        __weak typeof(self) wf = self;
//        [self addGestureRecognizer:[UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
//            if (wf.closeBlock) {
//                wf.closeBlock();
//            }
//            [wf dismissWithAnimate:YES];
//        }]];
//    }
//    return self;
//}
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//
//    CGFloat lableX = 0;
//    CGFloat lableY = 0;
//
//    [self p_getLabelPosition:&lableX lblY:&lableY];
//
//    if (self.rightImageView) {
//        CGFloat imgLeftGap = 10.f;
//        CGFloat imagewidth = self.rightImage.size.width;
//        CGFloat imageheigth = self.rightImage.size.height;
//        [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.with.offset(lableX);
//            make.top.with.offset(lableY);
//        }];
//
//        [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.messageLabel.mas_right).with.offset(imgLeftGap);
//            make.width.with.offset(imagewidth);
//            make.height.with.offset(imageheigth);
//            make.centerY.equalTo(self.messageLabel);
//        }];
//    }
//    else{
//        [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            if(!(self.xCorner == CYTailBubbleViewCornerLeft || self.xCorner == CYTailBubbleViewCornerRight)){
//                make.centerX.mas_equalTo(self);
//            }else{
//                CGFloat offset = self.xCorner == CYTailBubbleViewCornerLeft ? cornerWidthForLeftRight/2.f : -cornerWidthForLeftRight/2.f;
//                make.centerX.equalTo(self.mas_centerX).with.offset(offset);
//            }
//            make.top.with.offset(lableY);
//        }];
//    }
//}
//
//- (CGSize)intrinsicContentSize
//{
//    CGFloat width = 30.f;
//    CGFloat height = 34.f;
//    if (self.xCorner == CYTailBubbleViewCornerTop || self.xCorner == CYTailBubbleViewCornerBottom) {
//        height = 41.f;
//    }else{
//        height = 34.f;
//    }
//    if (self.rightImageView) {
//        width += self.rightImage.size.width;
//        width += 10.f;
//    }
//    width += self.messageLabel.intrinsicContentSize.width;
//    return CGSizeMake(width, height);
//}
//
//- (void)dismiss
//{
//    [self dismissWithAnimate:NO];
//}
//
//- (void)dismissWithAnimate:(BOOL)animate
//{
//    if (self.superview) {
//        [UIView animateWithDuration:animate?0.15f:0.f animations:^{
//            self.alpha = 0.f;
//        } completion:^(BOOL finished) {
//            [self removeFromSuperview];
//        }];
//    }
//}
//
//#pragma mark - getter && setter
//
//- (void)setCornerPoint:(CGPoint)cornerPoint
//{
//    [self willChangeValueForKey:@"cornerPoint"];
//    _cornerPoint = cornerPoint;
//    [self didChangeValueForKey:@"cornerPoint"];
//    self.bgView.cornerPoint = _cornerPoint;
//    [self.bgView setNeedsDisplay];
//}
//
//- (void)setRightImage:(UIImage *)rightImage
//{
//    [self willChangeValueForKey:@"rightImage"];
//    _rightImage = rightImage;
//    [self didChangeValueForKey:@"rightImage"];
//
//    [self setNeedsLayout];
//}
//
//- (void)setLabelFont:(UIFont *)labelFont
//{
//    [self willChangeValueForKey:@"labelFont"];
//    _labelFont = labelFont;
//    [self didChangeValueForKey:@"labelFont"];
//
//    self.messageLabel.font = _labelFont;
//}
//
//- (void)setLabelColor:(UIColor *)labelColor
//{
//    [self willChangeValueForKey:@"labelColor"];
//    _labelColor = labelColor;
//    [self didChangeValueForKey:@"labelColor"];
//    self.messageLabel.textColor = _labelColor;
//}
//
//- (void)setMessage:(NSString *)message
//{
//    [self willChangeValueForKey:@"message"];
//    _message = [message copy];
//    [self didChangeValueForKey:@"message"];
//    self.messageLabel.text = _message;
//    [self setNeedsLayout];
//}
//
//- (void)setShadowNeeds:(BOOL)shadowNeeds
//{
//    [self willChangeValueForKey:@"shadowNeeds"];
//    _shadowNeeds = shadowNeeds;
//    [self didChangeValueForKey:@"shadowNeeds"];
//    self.bgView.shadowNeeds = _shadowNeeds;
//    [self.bgView setNeedsDisplay];
//}
//
//#pragma mark - privateMethods
//- (void)p_getLabelPosition:(CGFloat *)lableX lblY:(CGFloat *)lableY
//{
//    CGFloat lableLeftGap = 15.f;
//    CGRect bounds   = self.bounds;
//    CGFloat lableMargin = ((bounds.size.height - cornerHeightForUpdown) - self.labelFont.lineHeight) / 2;
//    if (self.xCorner == CYTailBubbleViewCornerTop) {
//        *lableY = lableMargin + cornerHeightForUpdown;
//        *lableX = lableLeftGap;
//    }else if (self.xCorner == CYTailBubbleViewCornerBottom){
//        *lableY = lableMargin;
//        *lableX = lableLeftGap;
//    }else if(self.xCorner == CYTailBubbleViewCornerLeft){
//        *lableY = (bounds.size.height - self.labelFont.lineHeight) / 2;
//        *lableX = cornerWidthForLeftRight + lableLeftGap;
//    }else if (self.xCorner == CYTailBubbleViewCornerRight){
//        *lableY = (bounds.size.height - self.labelFont.lineHeight) / 2;
//        *lableX = cornerWidthForLeftRight + lableLeftGap;
//    }
//}
//
//@end
//
//
