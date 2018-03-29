//
//  CityPickerView.m
//  proviceByCity
//
//  Created by fuwu on 2018/3/28.
//  Copyright © 2018年 符武. All rights reserved.
//

#import "CityPickerView.h"
#import "ZSAnalysisClass.h"
#import "CityNameModels.h"

@interface CityPickerView () <UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIView *configuerView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIPickerView *pickView;


@property (nonatomic, strong) CityNameModels *sourceModles;
@property (nonatomic, strong) NSArray *provinceArray;
@property (nonatomic, strong) NSArray *cityArray;
@property (nonatomic, strong) NSArray *pleaceArray;


@property (nonatomic, strong) NSString *resultStr;


@property (nonatomic, strong) NSString *proviceName;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *pleaceName;


@end

@implementation CityPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self getDataSource];
        [self setUIConfiguer];
    }
    return self;
}
- (void)setUIConfiguer {
    
    _configuerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 260)];
    _configuerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_configuerView];
    
    
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _cancelBtn.frame = CGRectMake(0, 0, 60, 40);
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    _cancelBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_cancelBtn  addTarget:self action:@selector(calcelAction:) forControlEvents:UIControlEventTouchUpInside];
    [_configuerView addSubview:_cancelBtn];
    
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _sureBtn.frame = CGRectMake(self.frame.size.width - 60, 0, 60, 40);
    [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    _sureBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [_sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [_configuerView addSubview:_sureBtn];
    
    UIView *colorV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_cancelBtn.frame), self.frame.size.width, 1)];
    colorV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [_configuerView addSubview:colorV];
    
    
    _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(colorV.frame), self.frame.size.width, 219)];
    _pickView.delegate = self;
    _pickView.dataSource = self;
    [_configuerView addSubview:_pickView];
    
    
}


#pragma mark -pickViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger result = 0;
    if (component == 0) {
        result = self.provinceArray.count;
    }
    else if (component == 1) {
        result = self.cityArray.count;
    }
    else if (component == 2)
    {
        result = self.pleaceArray.count;
    }
    return result;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *labels = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (self.frame.size.width - 30) / 3, 40)];
    labels.textAlignment=NSTextAlignmentCenter;
    labels.font=[UIFont systemFontOfSize:14];
    labels.text=[self pickerView:pickerView titleForRow:row forComponent:component]; // 数据源
    return labels;
    
  
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *titles = @"";
    if (component == 0) {
        province *p = self.provinceArray[row];
        titles = p.name;
    }
    else if (component == 1) {
        city *c = self.cityArray[row];
        titles = c.name;
        
    }
    else if (component == 2) {
        district *d = self.pleaceArray[row];
        titles = d.name;
    }
    return titles;

    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        
        province *p = self.provinceArray[row];
        self.cityArray = p.city;
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        
        city *c =  self.cityArray.firstObject;
        self.pleaceArray = c.district;
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    }
    else if (component == 1) {
        
        city *c = self.cityArray[row];
        self.pleaceArray = c.district;
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    }
    else if (component == 2) {
        
    }
    
    [self choosePickViewResultRow:row inComponet:component];
    
}
- (void)choosePickViewResultRow:(NSInteger)row inComponet:(NSInteger)inComponet {
    if (inComponet == 0) {
        province *ps = self.provinceArray[row];
        city *cs = ps.city.firstObject;
        district *ds = cs.district.firstObject;
        
        self.proviceName = ps.name;
        self.cityName = cs.name;
        self.pleaceName = ds.name;
        
    }
    else if (inComponet == 1) {
        city *cs = self.cityArray[row];
        district *ds = cs.district.firstObject;
        self.cityName = cs.name;
        self.pleaceName = ds.name;
    }
    else if (inComponet == 2) {
        district  *ds = self.pleaceArray[row];
        self.pleaceName = ds.name;
    }
    
    _resultStr = [NSString stringWithFormat:@"%@-%@-%@",_proviceName,_cityName,_pleaceName];
    
}


#pragma mark - 获取数据源
- (void)getDataSource {
  
    //获取总资源
    self.sourceModles = [self getModelsSource];
    //省份数组
    self.provinceArray = self.sourceModles.province;
   
    //取出市数组(一个省所有城市)
    province *shiModel = self.sourceModles.province.firstObject;
    self.cityArray = shiModel.city;
    
    //取出地区数组
    city *diquModel = shiModel.city.firstObject;
    self.pleaceArray = diquModel.district;
    
    district *xianModel = diquModel.district.firstObject;
    
    
    //第一次显示的结果
    self.proviceName = shiModel.name;
    self.cityName = diquModel.name;
    self.pleaceName = xianModel.name;
    _resultStr = [NSString stringWithFormat:@"%@-%@-%@",_proviceName,_cityName,_pleaceName];

    
}

//获取模型
- (CityNameModels *)getModelsSource {
    //获取文件路径
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"province_data" ofType:@"json"];
    //将文件数据化
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:jsonPath];
    //转化成字典模型
    ZSAnalysisClass *AnalysisClass = [[ZSAnalysisClass alloc] parsingWithData:jsonData modelClassName:@"CityNameModels"];
    CityNameModels *cityModels = (CityNameModels *)AnalysisClass.paresData;
    
    return cityModels;
}

- (void)sureAction:(UIButton *)sender {
    NSLog(@"=====%@",_resultStr);
     
    [self dismiss];
}
- (void)calcelAction:(UIButton *)sender {
    [self dismiss];
}
- (void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        
        self.configuerView.frame = CGRectMake(0, self.frame.size.height - 260, self.frame.size.width, 260);
        
    }];
    
}
- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.configuerView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 260);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}



@end
