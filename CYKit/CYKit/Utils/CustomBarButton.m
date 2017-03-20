//
//  CustomBarButton.m
//  CustomTabBarDemo
//
//  Created by chengyan on 17/2/21.
//  Copyright © 2017年 Youku.inc. All rights reserved.
//

#import "CustomBarButton.h"

#define ANIMATION_DURATION 0.35f

@interface CustomBarButton ()

@property (nonatomic, strong) UIImageView   *imgView;
@property (nonatomic, strong) UILabel       *textLabel;
@property (nonatomic, strong) UIImageView   *redPointImgView;
//@property (nonatomic, strong) UIButton      *realButton;

@end

@implementation CustomBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame item:nil selectedColor:nil normalColor:nil];
    if (self) {
    
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
               item:(UITabBarItem *)item
      selectedColor:(UIColor *)sColor
        normalColor:(UIColor *)nColor
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.selectedColor = sColor;
        self.normalColor = nColor;
        self.item = item;
        _redPointHidden = YES;
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (_item.image || _item.selectedImage) {
        _imgView = [UIImageView new];
        _imgView.image = _item.image ? _item.image : _item.selectedImage;
        _imgView.contentMode = UIViewContentModeCenter;
        [self addSubview:_imgView];
    }
    
    if (_item.title) {
        _textLabel = [UILabel new];
        _textLabel.text =  _item.title;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont systemFontOfSize:11.f];
        _textLabel.textColor = self.normalColor;
//        _textLabel.backgroundColor = [UIColor redColor];
        [self addSubview:_textLabel];
        
        self.title = _item.title;
    }
    
//    if (_item) {
//        _realButton = [UIButton buttonWithType:UIButtonTypeCustom];
////        _realButton.backgroundColor = [UIColor blueColor];
//        [self addSubview:_realButton];
//    }
    
    _redPointImgView = [UIImageView new];
    _redPointImgView.backgroundColor = [UIColor redColor];
    _redPointImgView.layer.masksToBounds = YES;
    [self addSubview:_redPointImgView];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _textLabel.text = _title;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setSubviewFrame];
}

- (void)setSubviewFrame
{
    CGFloat buttonW = self.frame.size.width;
    CGFloat buttonH = self.frame.size.height;
    

    
    if (_imgView) {
        
        CGFloat imgW = _imgView.image.size.width;
        CGFloat imgH = _imgView.image.size.height;
        
        NSLog(@"imgw = %f, imgh = %f",imgW,imgH);
        
        CGFloat imgX = (buttonW - imgW) / 2;
        CGFloat imgY = 7;
        
        _imgView.frame = CGRectMake(imgX, imgY, imgW, imgH);
    }
    
    if (_textLabel) {
        CGFloat textX = 0;
        CGFloat textY;
        CGFloat textW = buttonW;
        CGFloat textH;
        
        if (_imgView) {
            textY = _imgView.frame.origin.y + _imgView.frame.size.height + 4;
            textH = buttonH - textY - 5;
        }else{
            textY = 0.f;
            textH = buttonH;
        }
        
        _textLabel.frame = CGRectMake(textX, textY, textW, textH);
    }
    
//    if (_realButton) {
//        _realButton.frame = self.bounds;
//    }
    
    _redPointImgView.frame = CGRectMake(_imgView.frame.origin.x  + _imgView.frame.size.width - 3, _imgView.frame.origin.y - 3, 6, 6);
    _redPointImgView.layer.cornerRadius = 3.f;
    _redPointImgView.hidden = _redPointHidden;
}

- (void)setRedPointHidden:(BOOL)redPointHidden
{
    _redPointHidden = redPointHidden;
    
    _redPointImgView.hidden = _redPointHidden;
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected  = isSelected;
    
    if (_isSelected) {
        self.imgView.image = self.item.selectedImage;
        self.textLabel.textColor = self.selectedColor;
    }else{
        self.imgView.image = self.item.image;
        self.textLabel.textColor = self.normalColor;
    }
}

- (void)addTarget:(id)target action:(SEL)action
{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setTitle:(NSString *)title animated:(BOOL)animated
{
    self.title = title;
    self.textLabel.alpha = 0;
    self.textLabel.text = title;
    [UIView animateWithDuration:animated?ANIMATION_DURATION:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.textLabel.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
}
@end
