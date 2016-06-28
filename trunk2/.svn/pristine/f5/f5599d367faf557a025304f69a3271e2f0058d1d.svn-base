//
//  EGOImageView.m
//  EGOImageLoading
//
//  Created by Shaun Harrison on 9/15/09.
//  Copyright (c) 2009-2010 enormego
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "EGOImageView.h"
#import "EGOImageLoader.h"

@implementation EGOImageView
@synthesize imageURL, placeholderImage, delegate,indiActivity;

- (id)initWithPlaceholderImage:(UIImage*)anImage {
	return [self initWithPlaceholderImage:anImage delegate:nil];	
}

- (id)initWithPlaceholderImage:(UIImage*)anImage delegate:(id<EGOImageViewDelegate>)aDelegate {
	if((self = [super initWithImage:anImage])) {
		self.placeholderImage = anImage;
		self.delegate = aDelegate;
        	}
	
	return self;
}

- (void)setImageURL:(NSURL *)aURL {
	if(imageURL) {
		[[EGOImageLoader sharedImageLoader] removeObserver:self forURL:imageURL];
		[imageURL release];
		imageURL = nil;
	}
    if (indiActivity == nil) {
        indiActivity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        CGRect frame = indiActivity.frame;
        frame.origin.x = self.frame.size.width / 2 - frame.size.width / 2;
        frame.origin.y = self.frame.size.height / 2 - frame.size.height / 2;
        indiActivity.frame = frame;
        indiActivity.hidesWhenStopped = YES;
//        [self addSubview:indiActivity];
    }
	
	if(!aURL) {
		self.image = self.placeholderImage;
		imageURL = nil;
        [indiActivity startAnimating];
		return;
	} else {
		imageURL = [aURL retain];
	}

	[[EGOImageLoader sharedImageLoader] removeObserver:self];
	UIImage* anImage = [[EGOImageLoader sharedImageLoader] imageForURL:imageURL shouldLoadWithObserver:self];
	if(anImage) {
		self.image = anImage;
		if([self.delegate respondsToSelector:@selector(imageViewLoadedImage:)]) {
			[self.delegate imageViewLoadedImage:self];
		}
	} else {
		self.image = self.placeholderImage;
        [indiActivity startAnimating];
	}
    
    if([self.delegate respondsToSelector:@selector(imageViewDidTouched:)] && (touchButton == Nil))  {
        self.userInteractionEnabled = YES;
        touchButton = [[UIButton alloc] initWithFrame:self.bounds];
        touchButton.showsTouchWhenHighlighted = YES;
        [touchButton addTarget:self action:@selector(onTapAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:touchButton];
    }
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGRect eclipse = CGRectMake(-2, -2, rect.size.width + 4, rect.size.height + 4);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextAddRect(context, eclipse);
    CGContextStrokePath(context);
}

#pragma mark -
#pragma mark Image loading

- (void)cancelImageLoad {
	[[EGOImageLoader sharedImageLoader] cancelLoadForURL:self.imageURL];
	[[EGOImageLoader sharedImageLoader] removeObserver:self forURL:self.imageURL];
    [indiActivity stopAnimating];
}

- (void)imageLoaderDidLoad:(NSNotification*)notification {
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.imageURL]) return;

	UIImage* anImage = [[notification userInfo] objectForKey:@"image"];
	self.image = anImage;
	[self setNeedsDisplay];
	
	if([self.delegate respondsToSelector:@selector(imageViewLoadedImage:)]) {
		[self.delegate imageViewLoadedImage:self];
	}	
    [indiActivity stopAnimating];
    

}
                                
- (void)onTapAction:(id)sender {
    
    if([self.delegate respondsToSelector:@selector(imageViewDidTouched:)]) {
        
        [self.delegate imageViewDidTouched:self];
	}
}

- (void)imageLoaderDidFailToLoad:(NSNotification*)notification {
	
    if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.imageURL]) return;
	
    if([self.delegate respondsToSelector:@selector(imageViewFailedToLoadImage:error:)]) {
		[self.delegate imageViewFailedToLoadImage:self error:[[notification userInfo] objectForKey:@"error"]];
	}
    [indiActivity stopAnimating];
    
}

#pragma mark -
- (void)dealloc {
	[[EGOImageLoader sharedImageLoader] removeObserver:self];
	self.imageURL = nil;
	self.placeholderImage = nil;
    [indiActivity release];
    [super dealloc];
}

@end
