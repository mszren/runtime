//
//  HouseSearchListView.m
//  BeruiHouse
//
//  Created by Ting on 16/4/28.
//  Copyright © 2016年 wangyueyun. All rights reserved.
//

#import "TTSearchListView.h"

#define kTextSelectColor [UIColor colorWithRed:255/255.0 green:185/255.0 blue:80/255.0 alpha:1]
#define kTextColor [UIColor darkGrayColor]
#define kCellBgColor [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]

@interface TTSearchListView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *leftTableView;   // 一级列表
@property (nonatomic, strong) UITableView *rightTableView;  // 二级列表

@property (nonatomic, assign)  NSInteger leftTableSelectedRow;
@property (nonatomic, assign)  NSInteger rightTableSelectedRow;

@property (nonatomic, assign) BOOL singleTable;



@end

@implementation TTSearchListView

#pragma mark - init method

- (void)reloadData{
    
    self.leftTableSelectedRow = 0;
    self.rightTableSelectedRow = 0;
    
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}

- (instancetype)initWithHeight:(CGFloat)height singleTable:(BOOL )singleTable{
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self = [self initWithFrame:CGRectMake(0, 0, screenSize.width, height)];
    if (self) {
        
        self.leftTableSelectedRow = 0;
        self.rightTableSelectedRow = 0;
        self.clipsToBounds = YES;
        self.singleTable = singleTable;
        
        //lefttableView init 初始化左侧的tableView
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, height) style:UITableViewStylePlain];
        _leftTableView.rowHeight = 44.0f;
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
        _leftTableView.separatorColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1];
        _leftTableView.separatorInset = UIEdgeInsetsZero;
        [self addSubview:_leftTableView];
        
        //righttableView init
        if (!singleTable) {
            _leftTableView.frame = CGRectMake(0, 0, self.frame.size.width/2, height);
            
            _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.size.width/2, 0 , self.frame.size.width/2, height) style:UITableViewStylePlain];
            _rightTableView.rowHeight = 44.0f;
            _rightTableView.dataSource = self;
            _rightTableView.delegate = self;
            _rightTableView.separatorColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1];
            _rightTableView.separatorInset = UIEdgeInsetsZero;
            [self addSubview:_rightTableView];
        }
    }
    return self;
}

- (void)setDataSource:(id<TTSearchListViewDataSource>)dataSource {
    if (_dataSource == dataSource) {
        return;
    }
    _dataSource = dataSource;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSAssert(_dataSource != nil, @"menu's dataSource shouldn't be nil");
    
    if (_leftTableView == tableView) {
        
        if ([self.dataSource respondsToSelector:@selector(numberOfRow:)]) {
            return [self.dataSource numberOfRow:self];
        } else {
            NSAssert(0 == 1, @"required method of dataSource protocol should be implemented");
            return 0;
        }
    } else {
        if ([self.dataSource respondsToSelector:@selector(numberOfItem:row:)]) {
            return [self.dataSource numberOfItem:self row:self.leftTableSelectedRow];
        } else {
            NSAssert(0 == 1, @"required method of dataSource protocol should be implemented");
            return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"HouseSearchListViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UIView *bg = [[UIView alloc]init];
        
        if (self.singleTable) {
            bg.backgroundColor = kCellBgColor;
        }else {
            bg.backgroundColor = [UIColor whiteColor];
        }
        
        
        cell.selectedBackgroundView = bg;
        cell.textLabel.highlightedTextColor = kTextSelectColor;
        cell.textLabel.textColor = kTextColor;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    }
    NSAssert(_dataSource != nil, @"menu's datasource shouldn't be nil");
    
    if (tableView == _leftTableView) {
        
        if ([self.dataSource respondsToSelector:@selector(menu:titleOfRow:)]) {
            cell.textLabel.text = [self.dataSource menu:self titleOfRow:indexPath.row];
        } else {
            NSAssert(0 == 1, @"dataSource method needs to be implemented");
        }
        
        if (self.leftTableSelectedRow == indexPath.row) {
            [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
        
        if (self.singleTable) {
            cell.backgroundColor = [UIColor whiteColor];
        }else {
            cell.backgroundColor = kCellBgColor;
        }
        
    } else {
        
        if ([self.dataSource respondsToSelector:@selector(menu:titleOfItem:row:)]) {
            cell.textLabel.text = [self.dataSource menu:self titleOfItem:indexPath.row row:self.leftTableSelectedRow];
        } else {
            NSAssert(0 == 1, @"dataSource method needs to be implemented");
        }
        
        if (self.rightTableSelectedRow == indexPath.row) {
            [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryView = nil;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_leftTableView == tableView) {
        
        self.leftTableSelectedRow = indexPath.row;
        self.rightTableSelectedRow = 0;
        [self.leftTableView reloadData];
        
        if (self.singleTable && [self.delegate respondsToSelector:@selector(menu:didSelectRowAtItem:row:)]) {
            [self.delegate menu:self didSelectRowAtItem:0 row:self.leftTableSelectedRow];
        }
        
    } else {
        
        self.rightTableSelectedRow = indexPath.row;
        
        if ([self.delegate respondsToSelector:@selector(menu:didSelectRowAtItem:row:)]) {
            [self.delegate menu:self didSelectRowAtItem:self.rightTableSelectedRow row:self.leftTableSelectedRow];
        }
    }
    
    [self.rightTableView reloadData];
}
 

@end
