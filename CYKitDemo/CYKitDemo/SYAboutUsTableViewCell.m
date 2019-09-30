//
//  SYAboutUsTableViewCell.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/7.
//  Copyright © 2019 sy. All rights reserved.
//

#import "SYAboutUsTableViewCell.h"
#import "SYAboutUsModel.h"
@interface SYAboutUsTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) SYAboutUsModel *model;
@end
@implementation SYAboutUsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) config:(id)model
{
    if ([model isKindOfClass:[SYAboutUsModel class]]) {
        self.model = model;
        self.nameLabel.text = self.model.name;
    }
}

@end
