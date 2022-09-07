//
//  GJPictureUploadView.m
//  XingJiGuanJia
//
//  Created by 成焱 on 2019/12/18.
//  Copyright © 2019 cheng.yan. All rights reserved.
//

#import "CYPictureUploadView.h"
#import <Masonry/Masonry.h>
#import "CYKit/CYKitDefines.h"
#import "UITapGestureRecognizer+CYAddition.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface CYPictureUploadView ()
@property (nonatomic, strong) NSMutableArray <UIImageView *> * imageViews;
@property (nonatomic, strong) NSMutableArray <UIImage *> *imgs;
@end

@implementation CYPictureUploadView

- (id) initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if(self){
      self.backgroundColor = [UIColor whiteColor];
      [self setupSubviews];
      [self addConstrainss];
      
  }
  return self;
}

- (void) setupSubviews
{
    for (int i = 0; i < 5; i++) {
        UIImageView *imgView = [UIImageView new];
        UIImageView *closeImageView = [UIImageView new];
        closeImageView.image = [UIImage imageNamed:@"feedback_close"];
        closeImageView.tag = 88;
        [imgView addSubview:closeImageView];
        [self addSubview:imgView];
        [self.imageViews addObject: imgView];
    }
}

- (void) addConstrainss
{
    CGFloat gap = 15;
    CGFloat space = 7;
    NSInteger count = 5;
    CGFloat width = (kScreenWidth - gap * 2 - space * (count - 1)) / count;
    for (int i = 0; i < 5; i++) {
        UIImageView *imgView = [self.imageViews objectAtIndex:i];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(gap + i * width + i * space);
            make.width.offset(width);
            make.height.offset(width);
            make.top.offset(gap);
        }];
        
        UIImageView *closeImage = [imgView viewWithTag:88];
        [closeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.offset(16);
            make.centerX.mas_equalTo(imgView.mas_right);
            make.centerY.mas_equalTo(imgView.mas_top);
        }];
    }
}

- (void) configModel:(id)model
{
    if ([model isKindOfClass:[NSArray class]]) {
        self.imgs = [model mutableCopy];
        [self.imageViews enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSInteger count = self.imgs.count;
            if (idx < count) {
                obj.image = self.imgs[idx];
                obj.hidden = NO;
                obj.layer.cornerRadius = 6.f;
                obj.userInteractionEnabled= YES;
                
                UIImage *uploadpic = [UIImage imageNamed:@"feedback_img_add"];
                if (obj.image == uploadpic) {
                    [obj viewWithTag:88].hidden = YES;
                    
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleAddTap:)];
                    
                    tap.numberOfTapsRequired = 1;
                    [obj addGestureRecognizer:tap];
                }
                else{
                    [obj viewWithTag:88].hidden = NO;
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                        self.deleteBlock ? self.deleteBlock(@(idx)):nil;
                    }];
                    tap.numberOfTapsRequired = 1;
                    [obj addGestureRecognizer:tap];
                }
            
            }
            else{
                obj.hidden = YES;
            }
        }];
        
        [self invalidateIntrinsicContentSize];
    }
}

- (void) handleAddTap:(id)sender{
    self.uploadPicBlock? self.uploadPicBlock():nil;
}

- (NSMutableArray <UIImageView *>*) imageViews
{
    if (!_imageViews) {
        _imageViews = [NSMutableArray array];
    }
    return _imageViews;
}

- (NSMutableArray <UIImage *> *) imgs
{
    if (!_imgs) {
        _imgs = [NSMutableArray array];
    }
    return _imgs;
}

- (CGSize) intrinsicContentSize
{
    CGFloat gap = 15;
    CGFloat space = 7;
    NSInteger count = 5;
    CGFloat width = (kScreenWidth - gap * 2 - space * (count - 1)) / count;
//    if (self.imgs.count <= 3) {
//        return CGSizeMake(kScreenWidth-24, width + gap + gap);
//    }
//    else if(self.imgs.count <= 6){
//        return CGSizeMake(kScreenWidth-24, (width+gap) *2 + gap);
//    }
//    else{
//        return CGSizeMake(kScreenWidth-24, (width+gap) *3 + gap * 2);
//    }
    
    return CGSizeMake(kScreenWidth, width+gap*2);
}
- (NSInteger) maxPicCount
{
    return 5;
}
@end
