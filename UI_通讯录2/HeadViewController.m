//
//  HeadViewController.m
//  UI_通讯录2
//
//  Created by dllo on 16/3/15.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "HeadViewController.h"




@interface HeadViewController ()
@property (nonatomic, retain) UIImageView *imageView;
@end

@implementation HeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //  NSArray *imageArray =
    self.count = 0;
    self.title = @"头像";
    for (int i = 0; i < 10; i++) {
        for (NSInteger j = 0; j < 3; j++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(j * 150 , 150 * i + 65, 150, 150)];
            button.frame = CGRectMake(j * 150 , 150 * i + 65, 150, 150);
            button.backgroundColor = [UIColor cyanColor];
            [self.view addSubview:button];
            [self.view addSubview:imageView];
            button.tag = 1000 + self.count;
            imageView.tag = 1000 + self.count + 10;
            self.count++;
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"h%ld.jpeg",i * 3 + j + 1]];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [imageView release];
        }
    }
  
}
- (void)buttonAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
    UIImageView *imageView = [self.view viewWithTag:button.tag + 10];
    NSLog(@"%@", imageView);
    [self.delegate sendImage:imageView.image];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
