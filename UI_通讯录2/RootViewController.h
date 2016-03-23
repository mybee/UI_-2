//
//  RootViewController.h
//  UI_通讯录2
//
//  Created by dllo on 16/3/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *contactArray;
@property (nonatomic, assign)NSInteger number;
@end
