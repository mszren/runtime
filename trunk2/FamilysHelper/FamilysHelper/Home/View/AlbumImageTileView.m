//
//  AlbumImageTileView.m
//  Lvguotou
//
//  Created by 曹亮 on 15/5/25.
//  Copyright (c) 2015年 Lvguotou. All rights reserved.
//

#import "AlbumImageTileView.h"


@interface AlbumImageTileView(){
    ALAsset* _asset;
}
@end

@implementation AlbumImageTileView


- (id) init{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

- (void) setViewData:(ALAsset *) asset{
    _asset=asset;
    UIImage * tempImg = [UIImage imageWithCGImage:_asset.defaultRepresentation.fullScreenImage];
    img = [[UIImageView alloc] initWithImage:tempImg];
    img.frame=CGRectMake(0, 0, 78, 78);
    img.userInteractionEnabled = YES;
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    UIImageView *delImg=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_delete"]];
    delImg.center=CGPointMake(img.frame.origin.x+img.frame.size.width, img.frame.origin.y);
    [img addSubview:delImg];
    [self addSubview:img];
 
    [self addGestureRecognizer:_tap];
}

- (void)tapAction:(id) sender{
    if ([self.delegate respondsToSelector:@selector(removeImage:)]) {
        [self.delegate removeImage:_asset];
    }
}

@end

