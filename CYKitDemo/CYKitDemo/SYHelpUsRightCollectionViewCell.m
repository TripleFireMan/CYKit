//
//  SYHelpUsRightCollectionViewCell.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/7.
//  Copyright © 2019 sy. All rights reserved.
//

#import "SYHelpUsRightCollectionViewCell.h"
#import "SYHelpUsModel.h"
@interface SYHelpUsRightCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) SYHelpUsSubModel *subModel;
@end
@implementation SYHelpUsRightCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void) configModel:(id)model
{
    self.subModel = model;
    self.titleLabel.text = self.subModel.Title;
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
