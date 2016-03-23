//
//  SecViewController.h
//  UI_通讯录2
//
//  Created by dllo on 16/3/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol SecViewControllerDelegate <NSObject>

- (void)sendName:(NSString *)string phone:(NSString *)phone address:(NSString *)address age:(NSString *)age hobby:(NSString *)hobby image:(UIImage *)image;

@end

@interface SecViewController : UIViewController


@property (nonatomic, retain)UITextField *nameTextField;
@property (nonatomic, retain)UITextField *phoneNumberTextField;
@property (nonatomic, retain)UITextField *ageTextField;
@property (nonatomic, retain)UITextField *addressTextField;
@property (nonatomic, retain)UITextField *hobbyTextField;
@property (nonatomic, retain)UIButton *contactImageButton;
@property (nonatomic, retain)NSString *nameString;
@property (nonatomic, retain)NSString *phoneString;
@property (nonatomic, retain)NSString *ageString;
@property (nonatomic, retain)NSString *addressString;
@property (nonatomic, retain)NSString *hobbyString;
@property (nonatomic, assign)NSInteger index;
@property (nonatomic, retain)UIImage *headImage;//接收头像
@property (nonatomic, retain)id<SecViewControllerDelegate>delegate;

@end
