//
//  CYRefreshFooter.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/8.
//  Copyright © 2019 sy. All rights reserved.
//

#import "CYRefreshFooter.h"
#import "CYKitDefines.h"
@implementation CYRefreshFooter

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
    self.stateLabel.textColor = RGBColor(160, 160, 160);
    self.stateLabel.font = [UIFont systemFontOfSize:13.f];
    self.arrowView.mj_size = CGSizeMake(self.arrowView.image.size.width * 0.8,self.arrowView.image.size.height * 0.8);
    CGPoint center = self.arrowView.center;
    CGFloat y = self.mj_h / 2.f;
    center.y = y;
    self.arrowView.center = center;
    self.arrowView.tintColor = self.stateLabel.textColor;
}

@end
