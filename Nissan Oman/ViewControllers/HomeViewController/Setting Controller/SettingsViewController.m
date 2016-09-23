//
//  SettingsViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 23/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "SettingsViewController.h"
#import "CustomTableViewCell.h"

@interface SettingsViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation SettingsViewController
{
    CGFloat yCordinate;
     NSMutableArray *dataArr;
    NSArray *imageArray;
    UITableView *tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    dataArr = [[NSMutableArray alloc]init];
    
    NSDictionary *dict1 = @{
                            @"image": @"account_settings.PNG",
                            @"text":   @"ACCOUNT SETTINGS"
                            };
    
    NSDictionary *dict2 = @{
                            @"image": @"notification_preferences.png",
                            @"text":   @"NOTIFICATION PREFERENCES"
                            };
    
    NSDictionary *dict3 = @{
                            @"image": @"language_options.png",
                            @"text":   @"LANGUAGE OPTIONS"
                            };

    
   // imageArray = @[dict1,dict2,dict3];
    [dataArr addObject:dict1];
    [dataArr addObject:dict2];

    [dataArr addObject:dict3];

    [self addTitle];
    [self addTableView];

    // Do any additional setup after loading the view.
}

-(void)addTitle
{
    yCordinate = self.yCordinate + 10;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate, 200, 30)];
    NSString *name = @"SETTINGS";
    label.text = name;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont systemFontOfSize:18.0f];
    [self.view addSubview:label];
    
    yCordinate += label.frame.size.height + 15;
}

-(void)addTableView
{
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, yCordinate,screenWidth - 20, self.view.frame.size.height*.5f) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.center = CGPointMake(screenWidth/2, tableView.center.y);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
}

#pragma Mark tableView Delegaes implementation

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Value rows");
    return dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Index pathn =%li" , indexPath.row);
    static NSString *tableCellIdentifier = @"cellIdentifier";
    CustomTableViewCell *tableCell = [tableView1 dequeueReusableCellWithIdentifier:tableCellIdentifier];
    if(tableCell == nil) {
        tableCell = [[CustomTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:
                     tableCellIdentifier];
    }
    [tableCell configureCell:[dataArr objectAtIndex:indexPath.row] withWidth:tableView.frame.size.width ];
    tableCell.backgroundColor = [UIColor clearColor];
    return tableCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}



-(void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"selected pathn =%li" , indexPath.row);
    [tableView1 deselectRowAtIndexPath:indexPath animated:YES];
    
    
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
