//
//  ViewController.m
//  ZZCustomPickerView
//
//  Created by QQ on 2017/11/21.
//  Copyright © 2017年 QQ. All rights reserved.
//

#import "ViewController.h"
#import "CustomPickerView.h"

@interface ViewController ()

@property(nonatomic,strong)CustomPickerView * pickerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(200, 100, 80, 40);
    [cancelButton setTitle:@"点击弹出" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:cancelButton];
    [cancelButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)click{
    _pickerView = [[CustomPickerView alloc] init];
    NSArray * positionArray = @[@"友鲸园区",@"阿里中心.深圳",@"蜂巢测试",@"阿里中心.上海"];
    NSArray * companyArray = @[@"友鲸网络科技有限公司",@"阿里巴巴（中国）有限公司",@"蜂巢科技有限公司",@"阿里巴巴（中国）有限公司"];
    [_pickerView setDataYears:positionArray andWeeks:companyArray];
    [_pickerView showPickerView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
