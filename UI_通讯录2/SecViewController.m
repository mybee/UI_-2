//
//  SecViewController.m
//  UI_通讯录2
//
//  Created by dllo on 16/3/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "SecViewController.h"
#import "HeadViewController.h"
@interface SecViewController ()<UITextFieldDelegate, HeadViewControllerDelegate>
@property (nonatomic, assign)NSInteger number;
@property (nonatomic, retain)UIImageView *headImageView;
@end

@implementation SecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.title = @"详细信息";
    self.view.backgroundColor = [UIColor whiteColor];
    //头像标签
    UILabel *contactImageLabel = [[UILabel alloc]initWithFrame:CGRectMake(60,120, 100, 40)];
    contactImageLabel.text = @"头像";
    [self.view addSubview:contactImageLabel];
    [contactImageLabel release];
    //头像
    self.contactImageButton = [[UIButton alloc]initWithFrame:CGRectMake(200, 80, 100, 100)];
    [self.view addSubview:self.contactImageButton];
    [self.contactImageButton addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_contactImageButton release];
    //头像imageview
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 80, 100, 100)];
    self.headImageView.image = self.headImage;
    [self.view addSubview:self.headImageView];
    [_headImageView release];
    //姓名标签
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60,200, 100, 40)];
    nameLabel.text = @"姓名";
    [self.view addSubview:nameLabel];
    [nameLabel release];
    //姓名框
    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(150, 200, 200, 40)];
    self.nameTextField.layer.borderWidth = 1;
    self.nameTextField.layer.cornerRadius = 5;
    self.nameTextField.text = self.nameString;
    self.nameTextField.delegate = self;
    [self.view addSubview:self.nameTextField];
    self.nameTextField.textAlignment = NSTextAlignmentCenter;
    [_nameTextField release];
    //电话标签
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(60,250, 100, 40)];
    phoneLabel.text = @"电话";
    [self.view addSubview:phoneLabel];
    [phoneLabel release];
    //电话号码框
    self.phoneNumberTextField = [[UITextField alloc]initWithFrame:CGRectMake(150, 250, 200, 40)];
    self.phoneNumberTextField.layer.borderWidth = 1;
    self.phoneNumberTextField.layer.cornerRadius = 5;
    self.phoneNumberTextField.text = self.phoneString;
    self.phoneNumberTextField.delegate = self;
    [self.view addSubview:self.phoneNumberTextField];
      self.phoneNumberTextField.textAlignment = NSTextAlignmentCenter;
    [_phoneNumberTextField release];
    //年龄标签
    UILabel *ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(60,300, 100, 40)];
    ageLabel.text = @"年龄";
    [self.view addSubview:ageLabel];
    [ageLabel release];
    //年龄框
    self.ageTextField = [[UITextField alloc]initWithFrame:CGRectMake(150, 300, 200, 40)];
    self.ageTextField.layer.borderWidth = 1;
    self.ageTextField.layer.cornerRadius = 5;
    self.ageTextField.text = self.ageString;
    self.ageTextField.delegate = self;
      self.ageTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.ageTextField];
    [_ageTextField release];
    //地址标签
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(60,350, 100, 40)];
    addressLabel.text = @"地址";
    [self.view addSubview:addressLabel];
    [addressLabel release];
    //地址框
    self.addressTextField = [[UITextField alloc]initWithFrame:CGRectMake(150, 350, 200, 40)];
    self.addressTextField.layer.borderWidth = 1;
    self.addressTextField.layer.cornerRadius = 5;
    [self.view addSubview:self.addressTextField];
    self.addressTextField.delegate = self;
      self.addressTextField.textAlignment = NSTextAlignmentCenter;
    self.addressTextField.text = self.addressString;
    [_addressTextField release];
    //爱好标签
    UILabel *hobbyLabel = [[UILabel alloc]initWithFrame:CGRectMake(60,400, 100, 40)];
    hobbyLabel.text = @"爱好";
    [self.view addSubview:hobbyLabel];
    [hobbyLabel release];
    //爱好框
    self.hobbyTextField = [[UITextField alloc]initWithFrame:CGRectMake(150, 400, 200, 40)];
    self.hobbyTextField.layer.borderWidth = 1;
    self.hobbyTextField.layer.cornerRadius = 5;
    self.hobbyTextField.text = self.hobbyString;
    self.hobbyTextField.delegate = self;
      self.hobbyTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.hobbyTextField];
    [_hobbyTextField release];
    
    //点击修改完成 按钮
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
    doneButton.frame = CGRectMake(130, 500, 200, 40);
    doneButton.backgroundColor = [UIColor cyanColor];
    doneButton.layer.borderWidth = 1;
    doneButton.layer.cornerRadius = 5;
    doneButton.tintColor = [UIColor blackColor];
    [doneButton setTitle:@"修改完成" forState:UIControlStateNormal];
    [self.view addSubview:doneButton];
    [doneButton addTarget:self action:@selector(secButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    

}
//
- (void)imageButtonAction:(UIButton *)button {
    HeadViewController *headVC = [[HeadViewController alloc]init];
    [self.navigationController pushViewController:headVC animated:YES];
    headVC.delegate = self;
    [headVC release];
   
}

- (void)sendImage:(UIImage *)image  {
    
    self.headImageView.image = image;
    NSLog(@"%@", image);
    
}

// 按钮事件
- (void)secButtonAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate sendName:self.nameTextField.text phone:self.phoneNumberTextField.text address:self.addressTextField.text age:self.ageTextField.text hobby:self.hobbyTextField.text image:self.headImageView.image];
    
    
}

//收起键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_nameTextField release];
    [_phoneNumberTextField release];
    [_addressTextField release];
    [_ageTextField release];
    [_hobbyTextField release];
    [_contactImageButton release];
    [_nameString release];
    [_phoneString release];
    [_addressString release];
    [_hobbyString release];
    [_ageString release];
    [super dealloc];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
