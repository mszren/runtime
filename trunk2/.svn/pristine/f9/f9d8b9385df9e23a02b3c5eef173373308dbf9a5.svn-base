//
//  AddFriendsController.m
//  FamilysHelper
//
//  Created by 曹亮 on 15/3/19.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//


#import "JMStaticContentTableViewSection.h"
#import "JMStaticContentTableViewCell.h"
#import "JMStaticContentTableViewBlocks.h"

#import "AddFriendsController.h"
#import "AddFriendsByPhoneController.h"
#import "AddFriendsByAdrressBookController.h"

@interface AddFriendsController()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation AddFriendsController


#pragma mark
#pragma mark -- init
- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeWhiteBackgroudView:@"添加好友"];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 20)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.backgroundView = nil;
    [self.view addSubview:tableView];
    
    [self initializeTableView];
    [tableView reloadData];
}




#pragma mark -
#pragma mark Private Method
- (void)showSearchPhoneController{
    AddFriendsByPhoneController * controller = [[AddFriendsByPhoneController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)showSearchAddressBookController{
    AddFriendsByAdrressBookController * controller = [[AddFriendsByAdrressBookController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)initializeTableView{
    [self removeAllSections];
    __unsafe_unretained AddFriendsController * BlockController = self;
    
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"personManageCell1";
            staticContentCell.cellHeight = TableChatHomeCellHeight;
            
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 220, 40)];
            lab.text = @"通过手机号";
            lab.textColor = [UIColor darkGrayColor];
            lab.highlightedTextColor = [UIColor darkGrayColor];
            lab.font = FONT_SIZE(15);
            lab.backgroundColor = [UIColor clearColor];
            [cell addSubview:lab];
            
            UIImageView * img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"addFriendIcon1.png"]];
            img.frame = CGRectMake(TableLeftSpaceWidth, 15, 35, 35);
            [cell addSubview:img];
            
            UIImageView * line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unityline.png"]];
            line.frame = CGRectMake(TableLeftSpaceWidth, TableChatHomeCellHeight-1, SCREEN_WIDTH, 1);
            [cell addSubview:line];
            
            cell.backgroundColor= [UIColor clearColor];
        }whenSelected:^(NSIndexPath * indexpath){
            [BlockController showSearchPhoneController];
        }];
        
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"personManageCell2";
            staticContentCell.cellHeight = TableChatHomeCellHeight;
            
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 220, 40)];
            lab.text = @"通过手机通讯录添加";
            lab.textColor = [UIColor darkGrayColor];
            lab.highlightedTextColor = [UIColor darkGrayColor];
            lab.font = FONT_SIZE(15);
            lab.backgroundColor = [UIColor clearColor];
            [cell addSubview:lab];
            
            UIImageView * img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"addFriendIcon2.png"]];
            img.frame = CGRectMake(TableLeftSpaceWidth, 15, 35, 35);
            [cell addSubview:img];
            
            UIImageView * line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unityline.png"]];
            line.frame = CGRectMake(TableLeftSpaceWidth, TableChatHomeCellHeight-1, SCREEN_WIDTH, 1);
            [cell addSubview:line];
            
            cell.backgroundColor= [UIColor clearColor];
        }whenSelected:^(NSIndexPath * indexpath){
            [BlockController showSearchAddressBookController];
        }];
    }];
    
}



#pragma mark -
#pragma mark Static Content
- (void) removeAllSections {
    if(staticContentSections) {
        staticContentSections = nil;
        staticContentSections = [NSArray array];
    }
}
- (void) addSection:(JMStaticContentTableViewControllerAddSectionBlock)b {
    if(!staticContentSections) staticContentSections = [NSArray array];
    
    JMStaticContentTableViewSection *section = [[JMStaticContentTableViewSection alloc] init];
    section.tableView = tableView;
    
    b(section, [staticContentSections count] + 1);
    
    staticContentSections = [staticContentSections arrayByAddingObject:section];
}

#pragma mark -
#pragma mark UITableViewDataSource Method
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return staticContentSections.count;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    JMStaticContentTableViewSection *sectionContent = [staticContentSections objectAtIndex:section];
    return sectionContent.staticContentCells.count;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMStaticContentTableViewSection *sectionContent = [staticContentSections objectAtIndex:indexPath.section];
    JMStaticContentTableViewCell *cellContent = [sectionContent.staticContentCells objectAtIndex:indexPath.row];
    
    return cellContent.cellHeight;
}
- (UITableViewCell *) tableView:(UITableView *)ltableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMStaticContentTableViewSection *sectionContent = [staticContentSections objectAtIndex:indexPath.section];
    JMStaticContentTableViewCell *cellContent = [sectionContent.staticContentCells objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [ltableView dequeueReusableCellWithIdentifier:cellContent.reuseIdentifier];
    if (cell == nil) {
        cell = [[[cellContent tableViewCellSubclass] alloc] initWithStyle:cellContent.cellStyle reuseIdentifier:cellContent.reuseIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    cell.imageView.image = nil;
    cell.accessoryView = nil;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cellContent.configureBlock(nil, cell, indexPath);
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * lview = [[UIView alloc] init];
    //    lview.backgroundColor = TableViewColor;
    return lview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0f;
}

#pragma mark - Table view delegate
- (void) tableView:(UITableView *)ltableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(!ltableView.editing && !tableView.allowsMultipleSelection) [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(ltableView.editing && !tableView.allowsMultipleSelectionDuringEditing) [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JMStaticContentTableViewSection *sectionContent = [staticContentSections objectAtIndex:indexPath.section];
    JMStaticContentTableViewCell *cellContent = [sectionContent.staticContentCells objectAtIndex:indexPath.row];
    
    if(cellContent.whenSelectedBlock) {
        cellContent.whenSelectedBlock(indexPath);
    }
}
- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.view endEditing:YES];
}


@end

