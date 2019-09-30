//
//  SYHelpUsContentCollectionViewCell.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/7.
//  Copyright © 2019 sy. All rights reserved.
//

#import "SYHelpUsContentCollectionViewCell.h"
#import "SYHelpUsModel.h"

@interface SYHelpUsContentCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *indicator;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (nonatomic, strong) SYHelpUsModel *model;


@end
@implementation SYHelpUsContentCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) config:(id)sender
{
    self.model = sender;
    self.titleLabel.text = self.model.Title;
    [self.imageIcon setImageWithURL:[NSURL URLWithString:self.model.Pic_Url] placeholder:[UIImage imageNamed:@"sy_help_cate_seleted"]];
    if (self.model.isSeleted) {
        self.indicator.hidden = NO;
        self.titleLabel.textColor = RGBColor(250, 41, 0);
        self.contentView.backgroundColor = RGBColor(247, 247, 247);
    }
    else{
        self.indicator.hidden = YES;
        self.titleLabel.textColor = RGBColor(85, 85, 85);
        self.contentView.backgroundColor = RGBColor(255, 255, 255);
    }
}

- (UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes
{
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGSize size = [self.contentView systemLayoutSizeFittingSize: layoutAttributes.size];
    CGRect cellFrame = layoutAttributes.frame;
    cellFrame.size.height= size.height;
    layoutAttributes.frame= cellFrame;
    return layoutAttributes;
}

@end
