//
//  SYTitleDebugTableViewCell.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/26.
//  Copyright © 2019 sy. All rights reserved.
//

#import "SYTitleDebugTableViewCell.h"
#import "SYDebugModel.h"
@interface SYTitleDebugTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) SYDebugClearUserInfoModel *model;


@end
@implementation SYTitleDebugTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

- (void) setData:(id)obj
{
    self.model = obj;
    self.titleLabel.text = self.model.title;
}

@end
