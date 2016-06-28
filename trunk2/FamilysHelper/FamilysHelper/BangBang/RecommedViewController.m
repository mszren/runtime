//
//  RecommedViewController.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/5/22.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "RecommedViewController.h"

@interface RecommedViewController ()<UIScrollViewDelegate>

@end

@implementation RecommedViewController{
    UIImageView *_imageview;//创建图片
    UIButton *_backButton;//返回按钮
    UIButton *_oldbutton;
    UIButton *_button;
    UILabel *_oldlabel;
    UILabel *_label;
    UIScrollView *_scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor=[UIColor whiteColor];
    [self customUI];
    _oldbutton=(UIButton *)[self.view viewWithTag:200];
    _oldbutton.selected=YES;
    
    _oldlabel=(UILabel *)[self.view viewWithTag:300];
    _oldlabel.backgroundColor=RedColor1;
}

-(void)customUI{
    
    //创建滑动板块
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/12+SCREEN_HEIGHT-380, SCREEN_WIDTH, SCREEN_HEIGHT-TabBarHeight)];
    _scrollView.delegate=self;
    _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH*3, SCREEN_HEIGHT-TabBarHeight);
    _scrollView.pagingEnabled=YES;
    _scrollView.bounces=NO;
    _scrollView.backgroundColor=RedColor1;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_scrollView];
    
    //添加视图
    NSArray *controllerViews=@[@"InteractionViewController",@"GoodsViewController",@"MemmberViewController"];
    for (NSInteger i=0; i<controllerViews.count; i++) {
        NSString *classname=controllerViews[i];
        Class classView=NSClassFromString(classname);
        UIViewController *controller=[[classView alloc]init];
        controller.view.frame=CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TabBarHeight);
        [_scrollView addSubview:controller.view];
        [self addChildViewController:controller];
    }
    
    //返回按钮
    _backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame=CGRectMake(10, 25, 30,30);
    [_backButton setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    _backButton.tag=100;
    [_backButton addTarget:self  action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    
    NSArray *name=@[@"互动",@"商品",@"成员"];
    float lwidth = SCREEN_WIDTH/3.0;
    for (NSInteger i=0; i<3; i++) {
        _button=[UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame=CGRectMake(lwidth*i,SCREEN_HEIGHT/12+SCREEN_HEIGHT-420, lwidth, TabBarHeight);
        _button.tag=200+i;
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button setTitleColor:RedColor1 forState:UIControlStateSelected];
        [_button setTitle:name[i] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        _label=[[UILabel alloc]initWithFrame:CGRectMake(lwidth*i, SCREEN_HEIGHT/12+SCREEN_HEIGHT-383, lwidth, 2)];
        _label.tag=300+i;
        _label.backgroundColor=[UIColor whiteColor];
        
        [self.view addSubview:_button];
        [self.view addSubview:_label];
    }
    
 
}

-(void)onBtn:(UIButton *)sender{
    if (sender.tag==100) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }else{
        CGPoint setoff=_scrollView.contentOffset;
        setoff.x=(sender.tag-200)*SCREEN_WIDTH;
        _scrollView.contentOffset=setoff;
        
        _oldlabel.backgroundColor=[UIColor whiteColor];
        _label=(UILabel *)[self.view viewWithTag:sender.tag+100];
        _label.backgroundColor=RedColor1;
        _oldlabel=_label;
        
        //转化按钮状态
        _button=(UIButton *)[self.view viewWithTag:sender.tag];
        _button.selected=!_button.selected;
         _oldbutton.selected=!_oldbutton.selected;
        _oldbutton=_button;
    }
    
}

//滑动减速时调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat setoff=_scrollView.contentOffset.x/SCREEN_WIDTH;
    _oldlabel.backgroundColor=[UIColor whiteColor];
    _label=(UILabel *)[self.view viewWithTag:300+setoff];
    _label.backgroundColor=RedColor1;
    _oldlabel=_label;
    
    _button=(UIButton *)[self.view viewWithTag:200+setoff];
    _button.selected=!_button.selected;
    _oldbutton.selected=!_button.selected;
    _oldbutton=_button;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
