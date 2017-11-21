//
//  CustomPickerView.m
//  ZZCustomPickerView
//
//  Created by QQ on 2017/11/21.
//  Copyright © 2017年 QQ. All rights reserved.
//
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#import "CustomPickerView.h"

@interface CustomPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong) UIPickerView * pickerView;

@property(nonatomic,strong) NSArray * yearsArray;

@property(nonatomic,strong) NSArray * weeksArray;

//所选的年份所在的行
@property(nonatomic,assign) int selectYearRow;

//所选的周所在的行
@property(nonatomic,assign) int selectWeekRow;

@end

@implementation CustomPickerView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, SCREEN_HEIGHT - 300, SCREEN_WIDTH, 300);
        self.backgroundColor = [UIColor whiteColor];
        
        UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(0, 0, 60, 40);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:cancelButton];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0 - 60, 0, 120, 40)];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.text = @"选择地区";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        
        UIButton * doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        doneButton.frame = CGRectMake(SCREEN_WIDTH - 80,0, 60, 40);
        [doneButton setTitle:@"确定" forState:UIControlStateNormal];
        [doneButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        doneButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:doneButton];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [self addSubview:lineView];
        
        [self addSubview:self.pickerView];
    }
    return self;
}

-(UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50,SCREEN_WIDTH , 250)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

#pragma mark -- pickerView delegate

//一共多少列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

//第component列有多少行
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return _yearsArray.count;
    }
    return _weeksArray.count;
}

//  第component列的宽度是多少
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component == 0) {
        return SCREEN_WIDTH/3.0;
    }
    return SCREEN_WIDTH/3.0*2;
}
//  第component列的行高是多少
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

// 返回第component列第row行的内容（标题）
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return _yearsArray[row];
    }
    return self.weeksArray[row];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        }
    }
    /*重新定义row 的UILabel*/
    UILabel *pickerLabel = (UILabel*)view;
    
    if (!pickerLabel){
        
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        [pickerLabel setTextColor:[UIColor blackColor]];
        //pickerLabel.adjustsFontSizeToFitWidth = YES;
        //[pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:16.0f]];
        // [pickerLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    }
    if (component == 0) {
        pickerLabel.textAlignment = NSTextAlignmentRight;
        pickerLabel.frame = CGRectMake(20, 0, self.frame.size.width/3.0 - 40, 40);
        pickerLabel.text = _yearsArray[row];
    }else{
        pickerLabel.textAlignment = NSTextAlignmentLeft;
        pickerLabel.frame = CGRectMake(0, 0, self.frame.size.width/3.0*2 - 20, 40);
        pickerLabel.text = _weeksArray[row];
    }
    return pickerLabel;
}


// 选中第component第row的时候调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        //选择年份时
        _selectYearRow = (int)row;
        if (self.delegate && [self.delegate respondsToSelector:@selector(didChangedYearToComponent:)]) {
            [self.delegate didChangedYearToComponent:(int)row];
        }
    }else if (component == 1){
        //选择第几周
        _selectWeekRow = (int)row;
    }
    
}

-(void)setDataYears:(NSArray *)yearsArray andWeeks:(NSArray *)weeksArray{
    _yearsArray = yearsArray;
    _weeksArray = weeksArray;
    [self.pickerView reloadAllComponents];
}

-(void)updateWeeksWhenYearChanged:(NSArray *)weeksArray{
    _weeksArray = weeksArray;
    [self.pickerView reloadComponent:1];
    [_pickerView selectRow:0 inComponent:1 animated:YES];
    _selectWeekRow = 0;
}

-(void)cancelButtonClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didCancelClick)]) {
        [self.delegate didCancelClick];
    }
    [self dismissPickerView];
}

-(void)doneButtonClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishSelectYear:andWeek:)]) {
        [self.delegate didFinishSelectYear:_selectYearRow andWeek:_selectWeekRow];
    }
}

-(void)showPickerView{
    _selectYearRow = 0;
    _selectWeekRow = 0;
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
}

-(void)dismissPickerView{
    [self.pickerView selectRow:0 inComponent:0 animated:NO];
    [self.pickerView selectRow:0 inComponent:1 animated:NO];
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
