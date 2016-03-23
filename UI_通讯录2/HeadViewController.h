//
//  HeadViewController.h
//  UI_通讯录2
//
//  Created by dllo on 16/3/15.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  HeadViewControllerDelegate<NSObject>

- (void)sendImage:(UIImage *)image;

@end

@interface HeadViewController : UIViewController

@property (nonatomic, retain)id<HeadViewControllerDelegate>delegate;

@property (nonatomic, assign)NSInteger count;

@end
