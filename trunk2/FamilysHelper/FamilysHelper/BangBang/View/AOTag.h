//
//  AOTag.h
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

#import <UIKit/UIKit.h>


@class AOTag;

@protocol AOTagDelegate <NSObject>

@optional


- (void)tagDidAddTag:(AOTag *)tag;
- (void)tagDidSelectTag:(AOTag *)tag;

@end

@interface AOTagList : UIView

@property (nonatomic, weak) id <AOTagDelegate> delegate;
@property (nonatomic, assign) NSInteger tolheight;
@property (nonatomic, strong) NSMutableArray *tags;



/**
 * Create a new tag object with custom colors
 *
 * @param tTitle the NSString tag label
 * @param tImage the NSString tag image named
 * @param labelColor the UIColor tag label color. Default color is [UIColor whiteColor]
 * @param backgroundColor the UIColor tag background color. Default color is [UIColor colorWithRed:0.204 green:0.588 blue:0.855 alpha:1.000]
 * @param closeColor the UIColor tag close button color. Default color is [UIColor colorWithRed:0.710 green:0.867 blue:0.953 alpha:1.000]
 */
- (void)addTag:(NSString *)tTitle withLabelColor:(UIColor *)labelColor TagId:(NSInteger )tadid tagstyle:(NSInteger)tagstyle;


/**************************
 * Common methods for tags
 **************************/

/**
 * Create a new tags object and add them to the tag list view.
 *
 * @param tags the NSArray tag list to be added. The given tag must be of NSDictionary type (ie. @{@"title": @"Tyrion", @"image": @"tyrion.jpg"})
 */
- (void)addTags:(NSArray *)tags tagstyle:(NSInteger)tagstyle;

/**
 * Remove the given tag from the tag list view
 *
 * @param tag the AOTag instance to be removed
 */
- (void)removeTag:(AOTag *)tag;

/**
 * Remove all tags object
 */
- (void)removeAllTag;

@end

@interface AOTag : UIView

@property (nonatomic, weak) id <AOTagDelegate> delegate;

@property (nonatomic, strong) UIColor *tLabelColor;
@property (nonatomic, strong) UIColor *tBackgroundColor;
@property (nonatomic, assign) NSInteger tagstyle;
@property (nonatomic, assign) NSInteger tid;
@property (nonatomic, copy) NSString *tTitle;


/**
 * Return a tag object size
 *
 * @return return a tag object CGSize size
 */
- (CGSize)getTagSize;

@end

