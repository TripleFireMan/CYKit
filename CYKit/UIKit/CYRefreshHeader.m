//
//  CYRefreshHeader.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/8.
//  Copyright © 2019 sy. All rights reserved.
//

#import "CYRefreshHeader.h"
#import "CYKitDefines.h"
@implementation CYRefreshHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) placeSubviews
{
    [super placeSubviews];
    self.lastUpdatedTimeLabel.hidden = YES;
    CGPoint p = self.stateLabel.center;
    CGFloat y = self.mj_h / 2.f;
    p = CGPointMake(p.x, y);
    self.stateLabel.center = p;
    self.stateLabel.textColor = RGBColor(160, 160, 160);
    self.arrowView.tintColor = self.stateLabel.textColor;
    self.arrowView.mj_size = CGSizeMake(self.arrowView.image.size.width * 0.8, self.arrowView.image.size.height * 0.8) ;
    self.stateLabel.font = [UIFont systemFontOfSize:13.f];
    
    
    // 箭头的中心点
    CGFloat arrowCenterX = self.mj_w * 0.5;
    if (!self.stateLabel.hidden) {
        CGFloat stateWidth = self.stateLabel.mj_textWith;
        CGFloat timeWidth = 0.0;
        if (!self.lastUpdatedTimeLabel.hidden) {
            timeWidth = self.lastUpdatedTimeLabel.mj_textWith;
        }
        CGFloat textWidth = MAX(stateWidth, timeWidth);
        arrowCenterX -= textWidth / 2 + self.labelLeftInset;
    }
    CGFloat arrowCenterY = self.mj_h * 0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // 箭头
    if (self.arrowView.constraints.count == 0) {
        self.arrowView.mj_size = CGSizeMake(self.arrowView.image.size.width * 0.8, self.arrowView.image.size.height * 0.8) ;
        self.arrowView.center = arrowCenter;
    }
}

@end
