//
//  RootViewController.m
//  UI_通讯录2
//
//  Created by dllo on 16/3/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "RootViewController.h"
#import "SecViewController.h"
#import "AddViewController.h"
#import "ChineseString.h"
@interface RootViewController ()<UITableViewDataSource, UITableViewDelegate, SecViewControllerDelegate, AddViewControllerDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
@property (nonatomic, retain)NSMutableArray *array;
@property (nonatomic, retain)NSMutableArray *nameDict;
@property (nonatomic, strong)NSMutableArray *indexArray;
@property (nonatomic, strong)NSMutableArray *letterArray;
@property (nonatomic, assign)NSInteger contactIndex;
@property (nonatomic, assign)NSInteger contactIndexTwo;
@property (nonatomic, retain)NSIndexPath *indexPath;
@property (nonatomic, retain)UISearchDisplayController *searchDisplayController;
@property (nonatomic, retain)NSArray *searchResultsArray;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //设置左边的按钮为编辑按钮
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //设置标题名
    self.title = @"联系人";
    //创建添加联系人按钮
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNavAction:)] autorelease];
    //创建tableView
    self.view.backgroundColor = [UIColor cyanColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    [_tableView release];
    // 搜索框
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(70, 60, 300, 50)];
    searchBar.backgroundColor = [UIColor cyanColor];
    searchBar.placeholder = @"请输入姓名";
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    [searchBar release];
    // searchDisplayController
    self.searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    self.searchDisplayController.delegate = self;
    self.searchDisplayController.searchResultsDelegate = self;
    self.searchDisplayController.searchResultsDataSource = self;
    //从文件读取联系人数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Student" ofType:@"plist"];
    self.contactArray = [[NSMutableArray alloc]initWithContentsOfFile:path];
    // NSLog(@"%@", self.contactArray);
    [_contactArray release];
    //创建图片数组
    self.array = [NSMutableArray array];
    for (NSInteger i = 0; i < self.contactArray.count; i++) {
        [self.array addObject:[UIImage imageNamed:@"h0.jpeg"]];
    }
    NSLog(@"*********%ld", self.contactArray.count);
    NSLog(@"%ld", self.array.count);
    // 将联系人的姓名和姓名的首字母组成的键值对放到字典中
    // self.nameDict = [NSMutableDictionary dictionary];
    NSMutableArray *stringToSort = [NSMutableArray array];
    for (NSDictionary *dict in self.contactArray) {
        //转变为可变字符串
        NSString *Str = [NSString stringWithString:dict[@"name"]];
        [stringToSort addObject:Str];
    }
    NSLog(@"%@", stringToSort);
    // 将人名首字母添加到数组中
    self.indexArray = [ChineseString IndexArray:stringToSort];
    // 将每个首字母的人组成的数组再填进去成为一个双层数组
    self.letterArray = [ChineseString LetterSortArray:stringToSort];
    NSLog(@"%@", self.indexArray);
    NSLog(@"%@", self.letterArray);
    //设置代理人
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
    //设置分区名
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.indexArray;
}
    //设置上面停留的section名字
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [self.indexArray objectAtIndex:section];
    return key;
}
 //重写系统的编辑按钮的点击方法
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

//    改变row的右侧编辑栏 *******  删除 **** 修改
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:0 title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        self.contactIndexTwo = 0;
        //删除contactArray的数据
        for (NSDictionary *dict in self.contactArray) {
            self.contactIndexTwo++;
            if ([dict[@"name"] isEqualToString:[[self.letterArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]])
            {
                self.contactIndexTwo -= 1;
                NSLog(@"%ld", self.contactIndexTwo);
                [self.contactArray removeObjectAtIndex:self.contactIndexTwo];
                NSLog(@"%@", self.contactArray);
                break;
            }
        }
        NSLog(@"-------%ld", self.contactIndexTwo);
        //删除letterArray的数据
        [[self.letterArray objectAtIndex:indexPath.section] removeObjectAtIndex:indexPath.row];
                if ([self.letterArray[indexPath.section] count] == 0) {
                    [self.letterArray removeObjectAtIndex:indexPath.section];
                }
        //删除indexArray的数据
        [self.indexArray removeObject:self.indexArray[indexPath.section]];
        
                NSLog(@"%@", self.letterArray);
        // 删除头像的数据
        [self.array removeObjectAtIndex:self.contactIndexTwo];
        [self.tableView reloadData];
        
    }];
    
    UITableViewRowAction *reviseAction = [UITableViewRowAction rowActionWithStyle:0 title:@"修改" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //遍历数组, 找到对应人名的下标,从而找到他们的电话号
        self.contactIndexTwo = 0;
        for (NSDictionary *dict in self.contactArray) {
            self.contactIndexTwo++;
            if ([dict[@"name"] isEqualToString:[[self.letterArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]])
            {
                self.contactIndexTwo -= 1;
                NSLog(@"%ld", self.contactIndexTwo);
                break;
            }
        }
        NSLog(@"xxxxxxxx%ld", self.contactIndexTwo);
        SecViewController *secVC = [[SecViewController alloc]init];
        [self.navigationController pushViewController:secVC animated:YES];
        secVC.ageString = self.contactArray[self.contactIndexTwo][@"age"];
        secVC.hobbyString = self.contactArray[self.contactIndexTwo][@"hobby"];
        secVC.nameString = self.contactArray[self.contactIndexTwo][@"name"];
        secVC.addressString = self.contactArray[self.contactIndexTwo][@"address"];
        secVC.phoneString = self.contactArray[self.contactIndexTwo][@"phone"];
        secVC.headImage = self.array[self.contactIndexTwo];
        secVC.delegate = self;
        secVC.index = indexPath.row;
        
        [secVC release];
        
        
        
    }];
    reviseAction.backgroundColor = [UIColor greenColor];
    
    return @[reviseAction, deleteAction];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}
     //tableView的cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    //遍历数组, 找到对应人名的下标,从而找到他们的电话号
    self.contactIndexTwo = 0;
    for (NSDictionary *dict in self.contactArray) {
        self.contactIndexTwo++;
        if ([dict[@"name"] isEqualToString:[[self.letterArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]])
        {
            self.contactIndexTwo -= 1;
            NSLog(@"%ld", self.contactIndexTwo);
            break;
        }
    }
    NSLog(@"xxxxxxxx%ld", self.contactIndexTwo);
    SecViewController *secVC = [[SecViewController alloc]init];
    [self.navigationController pushViewController:secVC animated:YES];
    secVC.ageString = self.contactArray[self.contactIndexTwo][@"age"];
    secVC.hobbyString = self.contactArray[self.contactIndexTwo][@"hobby"];
    secVC.nameString = self.contactArray[self.contactIndexTwo][@"name"];
    secVC.addressString = self.contactArray[self.contactIndexTwo][@"address"];
    secVC.phoneString = self.contactArray[self.contactIndexTwo][@"phone"];
    secVC.headImage = self.array[self.contactIndexTwo];
    secVC.delegate = self;
    [secVC release];
  
}
- (void)sendName:(NSString *)string phone:(NSString *)phone address:(NSString *)address age:(NSString *)age hobby:(NSString *)hobby image:(UIImage *)image{
    self.contactArray[self.contactIndexTwo][@"name"] = string;
    self.contactArray[self.contactIndexTwo][@"phone"] = phone;
    self.contactArray[self.contactIndexTwo][@"address"] = address;
    self.contactArray[self.contactIndexTwo][@"hobby"] = hobby;
    self.contactArray[self.contactIndexTwo][@"age"] = age;
    self.array[self.contactIndexTwo] = image;
    [self reloadData];
    [self.tableView reloadData];
}
- (void)twosendName:(NSString *)string phone:(NSString *)phone address:(NSString *)address age:(NSString *)age hobby:(NSString *)hobby image:(UIImage *)image {
    NSLog(@"%@%@", string, age);
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:string, @"name", phone, @"phone", age, @"age", hobby, @"hobby", address, @"address", nil].mutableCopy;
    [self.array addObject:image];
    [self.contactArray addObject:dict];
    //重新加载修正之后的数据
    [self reloadData];
    [self.tableView reloadData];
    [dict release];
    NSLog(@"%@", dict);
  
}
 //重新加载修正之后的数据的方法
- (void) reloadData {
    NSMutableArray *stringToSort = [NSMutableArray array];
    for (NSDictionary *dict in self.contactArray) {
    //转变为可变字符串
        NSString *Str = [NSString stringWithString:dict[@"name"]];
        [stringToSort addObject:Str];
    }
    NSLog(@"%@", stringToSort);
// 将人名首字母添加到数组中
    self.indexArray = [ChineseString IndexArray:stringToSort];
// 将每个首字母的人组成的数组再填进去成为一个双层数组
    self.letterArray = [ChineseString LetterSortArray:stringToSort];
    NSLog(@"%@", self.indexArray);
    NSLog(@"%@", self.letterArray);
    
}
//  右上角添加按钮点击时触发事件
- (void)addNavAction:(UIBarButtonItem *)barButtonItem {
    AddViewController *addVC = [[AddViewController alloc]init];
    [self.navigationController pushViewController:addVC animated:YES];
    addVC.delegate = self;
    [addVC release];
    
    
}
//TableView的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
// TableView的分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.indexArray.count;
    ;
}
// 返回TableView每个区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.letterArray objectAtIndex:section] count];
}

// 创建cell的方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuse = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse] autorelease];
        
    }
    cell.textLabel.text = [[self.letterArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    self.contactIndex = 0;
    //遍历数组, 找到对应人名的下标,从而找到他们的电话号
    for (NSDictionary *dict in self.contactArray) {
        self.contactIndex++;
        if ([dict[@"name"] isEqualToString:cell.textLabel.text]) {
            self.contactIndex -= 1;
            NSLog(@"%ld", self.contactIndex);
            break;
        }
    }
    cell.detailTextLabel.text = self.contactArray[self.contactIndex][@"phone"];
    cell.imageView.image = self.array[self.contactIndex];
    NSLog(@"%@", self.array);
    return cell;
}
- (void)dealloc {
    [_contactArray release];
    [super dealloc];
}

/**   搜索按钮的协议方法    */
#pragma  mark -- TODO
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
