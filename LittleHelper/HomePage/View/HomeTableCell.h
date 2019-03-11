//
//  HomeTableCell.h
//  KdFM
//
//  Created by hexuren on 17/6/20.
//  Copyright © 2017年 hexuren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentCategoryModel.h"

@interface HomeTableCell : UITableViewCell

- (void)updateCellValueWithDict:(NSDictionary *)categoryListModel;

@end
