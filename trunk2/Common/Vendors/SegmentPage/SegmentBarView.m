//
//  GuGuSegmentBarView.m
//
//  Created by gugupluto on 14-2-21.
//  http://www.cnblogs.com/gugupluto/
//  Copyright (c) 2014年 gugupluto. All rights reserved.
//

#import "SegmentBarView.h"
#define kButtonTagStart 100
@interface SegmentBarView ()
{
    UIView *lineView;
    NSMutableArray *buttonArray;
    UIButton *currentBtn;
}
@end

@implementation SegmentBarView
@synthesize selectedIndex;
@synthesize clickDelegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame andItems:(NSArray*)titleArray
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        selectedIndex = 0;
        int position = 0;
        buttonArray = [[NSMutableArray alloc]init];
        
        int width=frame.size.width/titleArray.count;
    
        
        for (int i = 0 ; i < titleArray.count; i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
     
            button.backgroundColor = [UIColor clearColor];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
             NSString *title = [titleArray objectAtIndex:i];
            [button setTitle:title forState:UIControlStateNormal];
            
            if (i==0) {
                [button setTitleColor: RGBCOLOR(248, 100, 42) forState:UIControlStateNormal];
                currentBtn=button;
            }
            else
                [button setTitleColor:RGBCOLOR(122,122,122) forState:UIControlStateNormal];
            
            [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
            button.tag = kButtonTagStart+i;

            button.frame = CGRectMake(position, 0, width, frame.size.height);

            [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [buttonArray addObject:button];
            position +=width;
            
        }
        self.contentSize = CGSizeMake(position, 25);
        self.showsHorizontalScrollIndicator = NO;
        
        
        CGRect rc  = [self viewWithTag:selectedIndex+kButtonTagStart].frame;
        lineView = [[UIView alloc]initWithFrame:CGRectMake(rc.origin.x, self.frame.size.height - 2, rc.size.width, 2)];
        lineView.backgroundColor = RGBCOLOR(248, 100, 42);
        [self addSubview:lineView];
    }
    return self;


    
}

-(void)onClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    if (currentBtn) {
        [currentBtn setTitleColor:RGBCOLOR(122,122,122) forState:UIControlStateNormal];
        [btn setTitleColor: RGBCOLOR(248, 100, 42) forState:UIControlStateNormal];
        currentBtn=btn;
    }

    if (selectedIndex != btn.tag - kButtonTagStart)
    {
        [self selectIndex:(int)(btn.tag - kButtonTagStart)];
    }

}

-(void)selectButton:(int)index{
    UIButton *btn;
    if (index <= (buttonArray.count - 1) ) {
        btn = (UIButton *)[self viewWithTag:index + kButtonTagStart];
    }
    else
        btn = (UIButton *)[self viewWithTag:selectedIndex + kButtonTagStart];
    
        if (currentBtn) {
            [currentBtn setTitleColor:RGBCOLOR(122,122,122) forState:UIControlStateNormal];
            [btn setTitleColor: RGBCOLOR(248, 100, 42) forState:UIControlStateNormal];
            currentBtn=btn;
        }
        
        if (selectedIndex != btn.tag - kButtonTagStart)
        {
            [self selectIndex:(int)(btn.tag - kButtonTagStart)];
        }
    
}

-(void)selectIndex:(int)index
{
    if (selectedIndex != index)
    {
        selectedIndex =  index;
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationDuration:0.2];
        CGRect lineRC  = [self viewWithTag:selectedIndex+kButtonTagStart].frame;
        lineView.frame = CGRectMake(lineRC.origin.x, self.frame.size.height - 2, lineRC.size.width, 2);
        [UIView commitAnimations];
        
        if (clickDelegate != nil && [clickDelegate respondsToSelector:@selector(barSelectedIndexChanged:)])
        {
            [clickDelegate barSelectedIndexChanged:selectedIndex];
        }
        
        
        if (lineRC.origin.x - self.contentOffset.x > 320 * 2  / 3)
        {
            int index = selectedIndex;
            if (selectedIndex + 2 < buttonArray.count)
            {
                index = selectedIndex + 2;
            }
            else if (selectedIndex + 1 < buttonArray.count)
            {
                index = selectedIndex + 1;
            }
            CGRect rc = [self viewWithTag:index +kButtonTagStart].frame;
            [self scrollRectToVisible:rc animated:YES];
        }
        else if ( lineRC.origin.x - self.contentOffset.x < 320 / 3)
        {
            int index = selectedIndex;
            if (selectedIndex - 2 >= 0)
            {
                index = selectedIndex - 2;
            }
            else if (selectedIndex - 1 >= 0)
            {
                index = selectedIndex - 1;
            }
            CGRect rc = [self viewWithTag:index +kButtonTagStart].frame;
            [self scrollRectToVisible:rc animated:YES];
        }
        
        
    }

}

-(void)setLineOffsetWithPage:(float)page andRatio:(float)ratio
{
    
 
    CGRect lineRC  = [self viewWithTag:page+kButtonTagStart].frame;
    
    CGRect lineRC2  = [self viewWithTag:page+1+kButtonTagStart].frame;
    
    float width = lineRC2.size.width;
    if (lineRC2.size.width < lineRC.size.width)
    {
        width =  lineRC.size.width - (lineRC.size.width-lineRC2.size.width)*ratio;
        
    }
    else if(lineRC2.size.width > lineRC.size.width)
    {
        width =  lineRC.size.width + (lineRC2.size.width-lineRC.size.width)*ratio;
    }
    float x = lineRC.origin.x + (lineRC2.origin.x - lineRC.origin.x)*ratio;
    
    
    lineView.frame = CGRectMake(x,  self.frame.size.height - 2,width,   2);
    
    
    
}

@end
