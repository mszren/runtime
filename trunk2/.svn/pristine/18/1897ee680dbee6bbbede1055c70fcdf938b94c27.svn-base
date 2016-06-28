//
//  GuGuLandscapeTableView.m
//
//  Created by gugupluto on 14-2-21.
//  http://www.cnblogs.com/gugupluto/
//  Copyright (c) 2014年 gugupluto. All rights reserved.
//

#import "LandscapeTableView.h"

@implementation LandscapeTableView
@synthesize cellDataSource;
@synthesize swipeDelegate;
- (id)initWithFrame:(CGRect)frame Array:(NSArray*)array
{
    self = [super init];
    if (self)
    {
        self.frame = frame;
  
        self.backgroundColor = [UIColor clearColor];
        tableView = [[UITableView alloc]initWithFrame:self.bounds];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollsToTop = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.transform = CGAffineTransformMakeRotation(-M_PI/2);
        tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        tableView.showsVerticalScrollIndicator = NO;
        tableView.pagingEnabled = YES;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.bounces =YES;
        [self addSubview:tableView];
         self.cellDataSource = array;
        
    }
    return self;
}




- (void)reloadTableWithArray:(NSArray*)array
{
    if (array && array.count >0)
    {
        self.cellDataSource = array;
        [tableView reloadData];
    }
}
#pragma mark Table view methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_WIDTH;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowCount = self.cellDataSource.count;
    
    return rowCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ViewCell";
    
    UITableViewCell *cell = nil;
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
        cell.contentView.backgroundColor=[UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        UIViewController *vc = [cellDataSource objectAtIndex:[indexPath row]];
        vc.view.frame = cell.bounds;
        [cell.contentView addSubview:  vc.view];
    }
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.swipeDelegate != nil && [self.swipeDelegate respondsToSelector:@selector(contentSelectedIndexChanged:)])
    {
        int index = tableView.contentOffset.y / self.frame.size.width;
        [self.swipeDelegate contentSelectedIndexChanged:index];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint pt =   tableView.contentOffset;
    [self.swipeDelegate scrollOffsetChanged:pt];
}

-(void)selectIndex:(int)index
{
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
}

-(void)selectIndex:(int)index withAnimated:(BOOL) animated{
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:animated];
}
@end
