//
//  SYInterfaceDebugTableViewCell.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/26.
//  Copyright © 2019 sy. All rights reserved.
//

#import "SYInterfaceDebugTableViewCell.h"
#import "SYDebugModel.h"


@interface SYInterfaceDebugTableViewCell()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (nonatomic, strong) SYInterfaceDebugModel *model;

@end
@implementation SYInterfaceDebugTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    @weakify(self);
//    [self.segment bk_addEventHandler:^(id sender) {
//        @strongify(self);
//        if (self.segment.selectedSegmentIndex == 0) {
//            self.model.isDebug = YES;
//        }
//        else{
//            self.model.isDebug = NO;
//        }
//    } forControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setData:(id)obj
{
    self.model = obj;
    if (self.model.isDebug) {
        self.segment.selectedSegmentIndex = 0;
    }
    else{
        self.segment.selectedSegmentIndex = 1;
    }
}

@end
