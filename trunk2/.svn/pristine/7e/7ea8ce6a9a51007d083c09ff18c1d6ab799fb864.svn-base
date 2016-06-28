//
//  AOTag.m
//  AOTagDemo
//
//  Created by Loïc GRIFFIE on 16/09/13.
//  Copyright (c) 2013 Appsido. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AOTag.h"
#import "TagModel.h"
#define tagFontSize         15.0f
#define tagFontType         @"Helvetica-Light"
#define tagMargin           10.0f
#define tagHeight           25.0f
#define tagCornerRadius     2.0f


@implementation AOTagList

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:YES];
        
        self.tags = [NSMutableArray array];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    int n = 0;
    float x = 10.0f;
    float y = 10.0f;
    
    for (id v in [self subviews])
        if ([v isKindOfClass:[AOTag class]])
            [v removeFromSuperview];
    
    for (AOTag *tag in self.tags)
    {
        if (x + [tag getTagSize].width + tagMargin > self.frame.size.width)
        { n = 0;
            x = 10.0;
            y += [tag getTagSize].height + tagMargin;
        }
        else x += (n ? tagMargin : 0.0f);
        
        [tag setFrame:CGRectMake(x, y, [tag getTagSize].width, [tag getTagSize].height)];
        [self addSubview:tag];
        
        x += [tag getTagSize].width+10.0f;
        
        n++;
    }
    
    CGRect r = [self frame];
    r.size.height = y + tagHeight+10.0f;
    NSLog(@"r.size.height> %f height", r.size.height);
    _tolheight=r.size.height;
    [self setFrame:r];
}

- (AOTag *)generateTagWithLabel:(NSString *)tTitle
{
    AOTag *tag = [[AOTag alloc] initWithFrame:CGRectZero];
    
    [tag setDelegate:self.delegate];
    [tag setTTitle:tTitle];
    [self.tags addObject:tag];
    
    return tag;
}




- (void)addTag:(NSString *)tTitle
withLabelColor:(UIColor *)labelColor
         TagId:(NSInteger )tadid
      tagstyle:(NSInteger)tagstyle

{
    AOTag *tag = [self generateTagWithLabel:(tTitle ? tTitle : @"")];
    
    if (labelColor) [tag setTLabelColor:labelColor];
    
    [tag setTid:tadid];
    [tag setTagstyle:tagstyle];
    [self setNeedsDisplay];
}



- (void)addTags:(NSArray *)tags tagstyle:(NSInteger)tagstyle
{
    for (TagModel *tag in tags){
          NSString *strTagName=[NSString stringWithFormat:@"#%@#", tag.tagsName];
        [self addTag:strTagName withLabelColor:[self getColor:tag.tagsColor] TagId:tag.tagsId tagstyle:tagstyle];
        
    }
}
HEXColor_Method
- (void)removeTag:(AOTag *)tag
{
    [self.tags removeObject:tag];
    
    [self setNeedsDisplay];
}

- (void)removeAllTag
{
    for (id t in [NSArray arrayWithArray:[self tags]])
        [self removeTag:t];
}

@end

@implementation AOTag

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.tBackgroundColor = [UIColor whiteColor];
        self.tLabelColor = [UIColor blackColor];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:YES];
        [self.layer setBorderWidth:0.5f];
        [self.layer setBorderColor:[UIColor grayColor].CGColor];
        [[self layer] setCornerRadius:tagCornerRadius];
        [[self layer] setMasksToBounds:YES];
        
    }
    return self;
}

- (CGSize)getTagSize
{
    CGSize tSize = [self.tTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:tagFontType size:tagFontSize]}];
    
    return CGSizeMake(tagMargin+tSize.width + tagMargin, tagHeight);
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    self.layer.backgroundColor = [self.tBackgroundColor CGColor];
    
    
    
    CGSize tSize = [self.tTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:tagFontType size:tagFontSize]}];
    
    [self.tTitle drawInRect:CGRectMake(tagMargin, ([self getTagSize].height / 2.0f) - (tSize.height / 2.0f), tSize.width, tSize.height)
             withAttributes:@{NSFontAttributeName:[UIFont fontWithName:tagFontType size:tagFontSize], NSForegroundColorAttributeName:self.tLabelColor}];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagSelected:)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [self addGestureRecognizer:recognizer];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagDidAddTag:)])
        [self.delegate performSelector:@selector(tagDidAddTag:) withObject:self];
}

- (void)tagSelected:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagDidSelectTag:)])
        [self.delegate performSelector:@selector(tagDidSelectTag:) withObject:self];
    
    [(AOTagList *)[self superview] removeTag:self];
}





@end


