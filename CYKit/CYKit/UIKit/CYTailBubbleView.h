////
////  CYBubbleView.h
////  Bubble
////
////  Created by chengyan on 2017/9/11.
////  Copyright © 2017年 Youku.inc. All rights reserved.
////
//
//#import <UIKit/UIKit.h>
//
//typedef NS_ENUM(NSInteger, CYTailBubbleViewCornerType){
//    CYTailBubbleViewCornerNone      =0,
//    CYTailBubbleViewCornerTop       =1,
//    CYTailBubbleViewCornerLeft      =2,
//    CYTailBubbleViewCornerBottom    =3,
//    CYTailBubbleViewCornerRight     =4,
//    CYTailBubbleViewCornerCenter    =5,
//};
//
//@interface CYTailBubbleView : UIView
//
/////-----------------------------------------------------------------------------------------------------------
///// @name 气泡，支持frame和autolayout，目前只支持尾部在上下的情况，支持气泡尾部在左右俩侧中间位置的情况。
/////-----------------------------------------------------------------------------------------------------------
//
///*
// * 使用方式如下
// *  CYTailBubbleView * view = [[CYTailBubbleView alloc]initWithFrame:CGRectZero titleMessage:@"文案显示区域" titleFont:nil titleColor:nil backgroundColor:nil rightImage:[UIImage imageNamed:@"弹层关闭"] tailInXCorner:CYTailBubbleViewCornerTop tailInYCorner:CYTailBubbleViewCornerLeft cornerPoint:CGPointZero closeCallBack:nil];
// *  [self.view addSubview:view];
// *  [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.offset(10);
//            make.top.offset(100);}];
// */
///**
// 气泡上文字
// */
//@property (nonatomic, strong) NSString *message;
//
///**
// 气泡右侧图片
// */
//@property (nonatomic, strong) UIImage *rightImage;
//
///**
// 气泡的具体位置，这个点是指气泡上尖的那个点
// */
//@property (nonatomic, assign) CGPoint cornerPoint;
//
///**
// 是否需要阴影
// */
//@property (nonatomic, assign) BOOL shadowNeeds;
//
///**
// 关闭事件回调，方便统计相关
// */
//@property (nonatomic, copy) void(^closeBlock)(void);
//
//
///**
// 适用于只有标题文字，没有右侧图片，且气泡尾巴位于底部中间的情况,xcorner默认是CYTailBubbleViewCornerBottom，ycorner默认是CYTailBubbleViewCornerCenter
//
// @param frame 气泡的位置
// @param message 消息
// @return 气泡
// */
//- (instancetype)initWithFrame:(CGRect)frame titleMessage:(NSString *)message;
//
///**
// 适用于有标题文字，有右侧图片，且气泡位于底部中间的情况,xcorner默认是CYTailBubbleViewCornerBottom，ycorner默认是CYTailBubbleViewCornerCenter
//
// @param frame 气泡的位置
// @param message 消息
// @param rightImage 右侧图片
// @return 气泡
// */
//- (instancetype)initWithFrame:(CGRect)frame titleMessage:(NSString *)message rightImage:(UIImage *)rightImage;
//
///**
// 适用于有标题文字，需要自定义文字字体及颜色，且气泡位于底部中间的情况,xcorner默认是CYTailBubbleViewCornerBottom，ycorner默认是CYTailBubbleViewCornerCenter
//
// @param frame 气泡的位置
// @param message 消息
// @param font 字体
// @param color 颜色
// @return 气泡
// */
//- (instancetype)initWithFrame:(CGRect)frame titleMessage:(NSString *)message titleFont:(UIFont *)font titleColor:(UIColor *)color;
//
///**
// 适用于有标题文字，需要自定义文字字体及颜色，有右侧图片，且气泡位于底部中间的情况,xcorner默认是CYTailBubbleViewCornerBottom，ycorner默认是CYTailBubbleViewCornerCenter
//
// @param frame 气泡的位置
// @param message 消息
// @param font 字体
// @param color 颜色
// @param rightImage 右侧图片
// @return 气泡
// */
//- (instancetype)initWithFrame:(CGRect)frame titleMessage:(NSString *)message titleFont:(UIFont *)font titleColor:(UIColor *)color rightImage:(UIImage *)rightImage;
//
///**
// 使用于所有情况，自定义尾部位置、气泡标题，字体及大小、右侧图片、关闭回调，尾部尖尖所在的点，气泡背景色。
//
// @param frame 气泡的位置
// @param message 消息
// @param font 字体
// @param color 颜色
// @param backgroundColor 背景色，默认是明黄色
// @param rightImage 右侧图片
// @param xCorner 气泡在上下左右方向大的位置
// @param yCorner 气泡在上下左右上，居中还是位于左右侧二级位置定位，举个例子，xcorner为top,ycorener为left，那么气泡所在的位置就是顶部三分之一处。xcorner为bottom,ycorner为center，那么就是底部中间位置。
// @param cornerPoint 气泡位置可自定义
// @param closeBlock 关闭回调
// @return 气泡
// */
//- (instancetype)initWithFrame:(CGRect)frame titleMessage:(NSString *)message titleFont:(UIFont *)font titleColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor rightImage:(UIImage *)rightImage tailInXCorner:(CYTailBubbleViewCornerType)xCorner tailInYCorner:(CYTailBubbleViewCornerType)yCorner cornerPoint:(CGPoint)cornerPoint closeCallBack:(void(^)())closeBlock;
//
///**
// 气泡消失，不带动画
// */
//- (void)dismiss;
//
///**
// 气泡消失，带是否需要动画的参数
//
// @param animate 简单的透明度渐变的动画
// */
//- (void)dismissWithAnimate:(BOOL)animate;
//@end
