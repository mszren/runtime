//
//  AlbumImageTileView.h
//  Lvguotou
//
//  Created by 曹亮 on 15/5/25.
//  Copyright (c) 2015年 Lvguotou. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

@protocol AlbumImageTileViewDelegate <NSObject>
- (void) removeImage:(ALAsset *) asset;
@end

@interface AlbumImageTileView : UIView
{
    UIImageView * img;
    UITapGestureRecognizer * _tap;
    
}
@property(nonatomic, assign) id<AlbumImageTileViewDelegate> delegate;
- (void) setViewData:(ALAsset *) asset;
@end
