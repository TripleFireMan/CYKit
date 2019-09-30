//
//  SYSwitchDebugTableViewCell.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/26.
//  Copyright © 2019 sy. All rights reserved.
//

#import "SYSwitchDebugTableViewCell.h"
#import "SYDebugModel.h"

@interface SYSwitchDebugTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switchItem;
@property (nonatomic, strong) SYDebugFaceIDTouchIDModel *model;

@end
@implementation SYSwitchDebugTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    @weakify(self);
    [self.switchItem bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.model.isOpen = [NSNumber numberWithBool:self.switchItem.isOn];
    } forControlEvents:UIControlEventValueChanged];
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
    NSNumber *switchValue = [[NSUserDefaults standardUserDefaults] objectForKey:k_UserDefauleUseFaceIDKey];
    if (switchValue) {
        self.switchItem.on = [switchValue boolValue];
    }
    else{
        self.switchItem.on = NO;
    }
}

@end
