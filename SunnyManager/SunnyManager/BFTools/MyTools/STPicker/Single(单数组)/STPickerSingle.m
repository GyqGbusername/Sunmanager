//
//  STPickerSingle.m
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/16.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import "STPickerSingle.h"
#import "TableModel.h"

@interface STPickerSingle()<UIPickerViewDataSource, UIPickerViewDelegate>
/** 1.选中的字符串 */
@property (nonatomic, strong, nullable)NSString *selectedTitle;
@property (nonatomic, strong) TableModel *selectedModel;

@end

@implementation STPickerSingle

#pragma mark - --- init 视图初始化 ---
- (void)setupUI
{
    [super setupUI];

    _titleUnit = @"";
    _arrayData = @[].mutableCopy;
    _heightPickerComponent = 44;
    _widthPickerComponent = 80;

    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
}

#pragma mark - --- delegate 视图委托 ---

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return 1;
    }else if (component == 1){
        return self.arrayData.count;
    }else {
        return 1;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.heightPickerComponent;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    if (component == 0) {
        return (self.width-self.widthPickerComponent)/2;
    }else if (component == 1){
        return self.widthPickerComponent;
    }else {
        return (self.width-self.widthPickerComponent)/2;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectedModel = self.arrayData[row];
    
    self.selectedTitle = _selectedModel.tablenumname;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    
    if (component == 0) {
        return nil;
    }else if (component == 1){
        UILabel *label = [[UILabel alloc] init];
        _selectedModel = self.arrayData[row];

        [label setText:_selectedModel.tablenumname];
        [label setTextAlignment:NSTextAlignmentCenter];
        return label;
    }else {
        UILabel *label = [[UILabel alloc] init];
        [label setText:self.titleUnit];
        [label setTextAlignment:NSTextAlignmentLeft];
        return label;
    }
}
#pragma mark - --- event response 事件相应 ---

- (void)selectedOk
{
    [self.delegate pickerSingle:self selectedTitle:self.selectedModel];
    [super selectedOk];
}

#pragma mark - --- private methods 私有方法 ---

#pragma mark - --- setters 属性 ---

- (void)setArrayData:(NSMutableArray *)arrayData
{
    _arrayData = arrayData;
    TableModel *model = arrayData.firstObject;
    _selectedTitle = model.tablenumname;
    [self.pickerView reloadAllComponents];
}

- (void)setTitleUnit:(NSString *)titleUnit
{
    _titleUnit = titleUnit;
    [self.pickerView reloadAllComponents];
}

#pragma mark - --- getters 属性 ---
@end

