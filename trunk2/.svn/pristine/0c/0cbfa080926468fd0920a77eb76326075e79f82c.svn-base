//
//  PublishAlbumTopView.h
//  Lvguotou
//
//  Created by 曹亮 on 15/5/25.
//  Copyright (c) 2015年 Lvguotou. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

@protocol PublishAlbumTopViewDelegate <NSObject>
- (void)showPickImgs:(NSMutableArray *) dataList;
@end

@interface PublishAlbumTopView : UIView
@property (nonatomic,assign) NSInteger imageMaxCount;
@property (nonatomic,strong)     NSMutableArray * dataList;
@property(nonatomic, assign) id<PublishAlbumTopViewDelegate> delegate;
- (void) setViewDefault;
- (void) removeImage:(ALAsset *) asset;
- (void) addImgUrls:(NSArray *) array;
@end
