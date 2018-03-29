//
//  CityNameModels.h
//  proviceByCity
//
//  Created by fuwu on 2018/3/28.
//  Copyright © 2018年 符武. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityNameModels : NSObject

@property (nonatomic, retain) NSArray *province;


@end

//省份
@interface province : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *city;

@end

//城市
@interface city : NSObject

@property (nonatomic, strong) NSArray *district;
@property (nonatomic, strong) NSString *name;

@end

//地区
@interface district :  NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *zipcode;

@end






