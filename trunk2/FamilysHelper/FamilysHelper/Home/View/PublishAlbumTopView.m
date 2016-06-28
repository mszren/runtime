//
//  PublishAlbumTopView.m
//  Lvguotou
//
//  Created by 曹亮 on 15/5/25.
//  Copyright (c) 2015年 Lvguotou. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PublishAlbumTopView.h"

#import "AlbumImageTileView.h"

#import <AssetsLibrary/AssetsLibrary.h>

#define ImageMaxCount 3
@interface PublishAlbumTopView () <AlbumImageTileViewDelegate> {

    UIImageView* _btn_add;
}
@end

@implementation PublishAlbumTopView
@synthesize dataList = _dataList;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dataList = [[NSMutableArray alloc] initWithCapacity:0];
        _imageMaxCount = 0;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setViewDefault
{
    _btn_add = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_publish"]];
    _btn_add.userInteractionEnabled = YES;
    _btn_add.frame = CGRectMake(20, 20, _btn_add.frame.size.width, _btn_add.frame.size.height);
    [self addSubview:_btn_add];
    UITapGestureRecognizer* _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_btn_add addGestureRecognizer:_tap];
}
- (void)tapAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(showPickImgs:)]) {
        [self.delegate showPickImgs:_dataList];
    }
}

- (void)addImgUrls:(NSArray*)array
{
    [_dataList addObjectsFromArray:array];
    [self initView];
}

- (void)initView
{
    NSArray* subView = self.subviews;
    for (int i = 0; i < subView.count; i++) {
        UIView* t = [subView objectAtIndex:i];
        if ([t isKindOfClass:[AlbumImageTileView class]]) {
            [t removeFromSuperview];
        }
    }

    int num = _dataList.count;
    float width = 20.0f;
    for (int i = 0; i < num; i++) {
        AlbumImageTileView* tile = [[AlbumImageTileView alloc] initWithFrame:CGRectMake(width, 20, PublishImageTileWidth, PublishImageTileHeight)];
        tile.delegate = self;
        ALAsset* asset = (ALAsset*)[_dataList objectAtIndex:i];
        [tile setViewData:asset];
        [self addSubview:tile];
        width += PublishImageTileWidth + 20;
    }

    NSInteger imageCount = _imageMaxCount == 0 ? ImageMaxCount : _imageMaxCount;
    if (_dataList.count < imageCount) {
        _btn_add.frame = CGRectMake(width, 20, _btn_add.frame.size.width, _btn_add.frame.size.height);
        if (_btn_add.superview == nil)
            [self addSubview:_btn_add];
    }
    else if (_btn_add.superview != nil)
        [_btn_add removeFromSuperview];
}
#pragma mark -
#pragma mark AlbumImageTileViewDelegate
- (void)removeImage:(ALAsset*)asset
{
    [_dataList removeObject:asset];
    [self initView];
}

@end
