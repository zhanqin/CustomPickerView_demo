//
//  CustomPickerView.h
//  ZZCustomPickerView
//
//  Created by QQ on 2017/11/21.
//  Copyright © 2017年 QQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomPickerViewDelegate <NSObject>

-(void)didChangedYearToComponent:(int)yearRow;

-(void)didFinishSelectYear:(int)year andWeek:(int)week;

-(void)didCancelClick;

@end

@interface CustomPickerView : UIView

@property(nonatomic,weak) id<CustomPickerViewDelegate> delegate;

-(void)setDataYears:(NSArray *)yearsArray andWeeks:(NSArray *)weeksArray;

-(void)updateWeeksWhenYearChanged:(NSArray *)weeksArray;

-(void)showPickerView;

-(void)dismissPickerView;

@end
