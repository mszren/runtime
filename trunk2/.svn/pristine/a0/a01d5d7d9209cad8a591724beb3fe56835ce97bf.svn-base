//
//  TagView.m
//  FamilysHelper
//
//  Created by Owen on 15/6/25.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "TagView.h"

@interface TagView()
{
    UIImageView *_ic_Check;
}
@end


@implementation TagView


-(id)initWithFrame:(CGRect)frame Tags:(NSArray*)taglist{
    self=[super initWithFrame:frame];
    if (self) {
        _tagList=taglist;
        
        _ic_Check=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_check"]];

        NSInteger position=15;
        NSInteger y = 5;
        for (NSInteger i=0;i<_tagList.count;i++) {
            
            TagModel *tag = [_tagList objectAtIndex:i];
            NSString *strTagName=[NSString stringWithFormat:@"#%@#", tag.tagsName];
            CGRect labelRect = [strTagName boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:FONT_SIZE_14 forKey:NSFontAttributeName] context:nil];
            
            UILabel *lblTag=[[UILabel alloc] init];
            lblTag.tag=i;
            lblTag.userInteractionEnabled=YES;
            if (labelRect.size.width + 10 + position > SCREEN_WIDTH) {
                y += 40;
                position = 15;
            }
            lblTag.frame=CGRectMake(position, y, labelRect.size.width+10, 30);
            lblTag.textAlignment=NSTextAlignmentCenter;
            lblTag.layer.borderWidth=1;
            lblTag.layer.borderColor=BGViewGray.CGColor;
            lblTag.text=strTagName;
            lblTag.font=FONT_SIZE_14;
            [lblTag setTextColor:[self getColor:tag.tagsColor]];

            position+=lblTag.frame.size.width+10;
            
            UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
            [lblTag addGestureRecognizer:tapGesture];
            
            [self addSubview:lblTag];
        }

    }
    return self;
}

-(void) clickAction:(UITapGestureRecognizer*)sender{
    
    UILabel *lblTag=(UILabel*)sender.view;
    _selectTag=[_tagList objectAtIndex:lblTag.tag];
    _ic_Check.frame=CGRectMake(lblTag.frame.origin.x+lblTag.frame.size.width-_ic_Check.frame.size.width-3, lblTag.frame.origin.y+8, _ic_Check.frame.size.width, _ic_Check.frame.size.height);
    
    if (_ic_Check.superview==nil)
        [self addSubview:_ic_Check];
    
    if ([_delegate respondsToSelector:@selector(tagViewSelected:)]) {
        
        [_delegate performSelector:@selector(tagViewSelected:) withObject:_selectTag];
    }
 
 
}

HEXColor_Method
@end
