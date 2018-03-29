//
//  ViewController.m
//  proviceByCity
//
//  Created by fuwu on 2018/3/28.
//  Copyright © 2018年 符武. All rights reserved.
//

#import "ViewController.h"
#import "CityPickerView.h"
#define ScreenWith [UIScreen mainScreen].bounds.size.width
#define ScreenHight  [UIScreen mainScreen].bounds.size.height


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *cityBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cityBtn.frame = CGRectMake( ScreenWith / 2 - 50,ScreenHight / 2 - 50, 100, 100);
    [cityBtn setTitle:@"点击选择" forState:UIControlStateNormal];
    cityBtn.backgroundColor = [UIColor cyanColor];
    [cityBtn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cityBtn];
    
}
- (void)chooseBtn:(UIButton *)sender {

    
    CityPickerView *pickV = [[CityPickerView alloc] initWithFrame:self.view.bounds];
    [pickV show];
   // [self.view addSubview:pickV];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
