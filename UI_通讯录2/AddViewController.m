//
//  AddViewController.m
//  UI_通讯录2
//
//  Created by dllo on 16/3/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()<UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"添加联系人";
    self.view.backgroundColor = [UIColor whiteColor];
    //头像标签
    UILabel *contactImageLabel = [[UILabel alloc]initWithFrame:CGRectMake(60,120, 100, 40)];
    contactImageLabel.text = @"头像";
    [self.view addSubview:contactImageLabel];
    [contactImageLabel release];
    //头像
    self.contactImageButton = [[UIButton alloc]initWithFrame:CGRectMake(200, 80, 100, 100)];
    [self.view addSubview:self.contactImageButton];
    self.contactImageButton.layer.borderWidth = 1;
    [_contactImageButton release];
    [self.contactImageButton addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    // 头像imageView
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 80, 100, 100)];
    
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
    self.nameTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.nameTextField];
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
    self.phoneNumberTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.phoneNumberTextField];
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
    self.addressTextField.textAlignment = NSTextAlignmentCenter;
    self.addressTextField.text = self.addressString;
    self.addressTextField.delegate = self;
    self.addressTextField.delegate = self;
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
    self.hobbyTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.hobbyTextField];
    self.hobbyTextField.delegate = self;
    [_hobbyTextField release];
    
    //点击修改完成 按钮
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
    doneButton.frame = CGRectMake(130, 500, 200, 40);
    doneButton.backgroundColor = [UIColor cyanColor];
    doneButton.layer.borderWidth = 1;
    doneButton.layer.cornerRadius = 5;
    doneButton.tintColor = [UIColor blackColor];
    [doneButton setTitle:@"添加完成" forState:UIControlStateNormal];
    [self.view addSubview:doneButton];
    [doneButton addTarget:self action:@selector(doneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
  
}
- (void)imageButtonAction:(UIButton *)button {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相册中选择照片" otherButtonTitles:nil];
    sheet.delegate = self;
    [sheet showInView:self.view];
    [sheet release];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
     picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
       
    }];
    [picker release];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo {
   [picker dismissViewControllerAnimated:YES completion:^{
       self.headImageView.image = image;
   
   }];
}
- (void)doneButtonAction:(UIButton *)button {
    // 判断姓名框和头像是否为空
    if (self.headImageView.image != nil && ![self.nameTextField.text isEqualToString:@""]) {
    // 传值 和 设置代理人
    self.nameString = self.nameTextField.text;
    self.ageString = self.ageTextField.text;
    self.phoneString = self.phoneNumberTextField.text;
    self.hobbyString = self.hobbyTextField.text;
    self.addressString = self.addressTextField.text;
    [self.delegate twosendName:self.nameString phone:self.phoneString address:self.addressString age:self.ageString hobby:self.hobbyString image:self.headImageView.image];
    [self.navigationController popViewControllerAnimated:YES];
    }
    if (self.headImageView.image == nil) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请选择照片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }
    if ([self.nameTextField.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请填写姓名" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
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
