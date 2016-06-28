//
//  CommonFunctions.h
//  Dolphin
//
//  Created by wang fengquan on 3/16/11.
//  Copyright 2011 baina. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ALERT_VIEW_CANCEL_BUTTON_INDEX  1

#define fequal(a,b) (fabs((a) - (b)) < FLT_EPSILON)
#define fequalzero(a) (fabs(a) < FLT_EPSILON)

/*
 webView:didFailLoadWithError: error code
 -1000 - Bad Url
 -1001 - Request timed out
 -1003 - Cannot find host
 -1004 - Cannot connect to host
 -1005 - Network connection lost
 -1006 - NSLookupFailed
 */
#define CONNECTION_ERROR_BAD_URL       -1000
#define CONNECTION_ERROR_TIME_OUT      -1001
#define CONNECTION_ERROR_CANNOT_FIND_HOST  -1003
#define CONNECTION_ERROR_CANNOT_CONNECT_HOST  -1004
#define CONNECTION_ERROR_NETWORK_CONNECTION_LOST   -1005
#define CONNECTION_ERROR_NSLOOKUPFAILED      -1006

@interface CommonFunctions : NSObject 
{
}

#pragma mark Mail operations
+(void)sendEmailTo:(NSString*)to withSubject:(NSString*)subject withBody:(NSString*)body;

#pragma mark File operations
+ (NSString*)getTempFilePath:(NSString*)name;
+ (NSString*)getDocumentsFilePath:(NSString*)name;
+ (NSString*)getLibraryFilePath:(NSString*)name;
+ (BOOL)fileExistsAtDocumentsPath:(NSString*)name;
+ (BOOL)fileExistsAtLibraryPath:(NSString*)name;
+ (BOOL)fileExistsAtFullPath:(NSString*)name;
+ (void)createFolderAtDocumentsPathIfNotExist:(NSString *)folderName;
+ (void)createFileAtDocumentsPath:(NSString *)fileString;
+ (void)deleteFileAtFullPath:(NSString *)fileString;
+ (void)deleteFileAtDocumentsPath:(NSString *)fileString;
+ (void)deleteFileAtLibraryPath:(NSString *)fileString;
+ (void)moveFileAtDocumentsPath:(NSString *)oldFileString toNewDocumentsPath:(NSString *)newFileString;
+ (void)moveFileAtFullPath:(NSString *)oldFileString toNewFullPath:(NSString *)newFileString;
+ (NSString*)getUniqueFileName:(NSString *)folderName fileName:(NSString *)fileName fileExtend:(NSString *)fileExtend;
+ (NSArray*)getFileNameAndExtend:(NSString *)fileNameString;
+ (NSString*)getFullName:(NSString*)fileName extend:(NSString*)fileExtend;
+ (void)alertFileExists;
+ (void)alertFileNameEmpty;
//+ (BOOL)isNetworkAvailable;
+ (long long)convertSecondToMillisecond:(NSTimeInterval)second;

+ (NSString*)stringWithContentOfResource:(NSString*)resource ofType:(NSString*)type;

+ (NSString*)trackStringOfUrl:(NSURL*)url;

//Present Modal ViewController.
+ (UINavigationController*)presentViewControllerWithNavigation:(UIViewController*)viewController inParent:(UIViewController*)parentViewController;

+ (UINavigationController*)presentViewControllerWithNavigation:(UIViewController*)viewController 
                                                          size:(CGSize)size inParent:(UIViewController*)rootViewController;

#pragma mark UI related
// As dismissPovper sometimes doesn't trigger the delegate.
+ (void)dismissPopoverViewCallDelete:(UIPopoverController*)popover;

+ (UITableViewCell*)findParentCell:(UIView*)subView;

//debug
+(void)showViewFrame:(UIView *)view tipSring:(NSString *)tipString;

//Create UI Control

+(UIButton*)createButtonWith:(NSString*)title imageName:(NSString *)imageName highlightedImage:(NSString*)highlightedImage
                      target:(id)target action:(SEL)action;

+ (UIButton *)createButton:(NSString *)title target:(id)target action:(SEL)action;
+ (UIButton*)createButtonWithImageName:(NSString *)imageName highlightedImage:(NSString*)highlightedImage disabledImage:(NSString*)disabledImage target:(id)target action:(SEL)action;
+ (UIButton *)createButtonWithImageName:(NSString *)imageName highlightedImage:(NSString*)highlightedImage target:(id)target action:(SEL)action;
+ (UIButton *)createButtonWithImageName:(NSString *)imageName disabledImage:(NSString*)disabledImage target:(id)target action:(SEL)action;
+ (UIButton *)createButtonWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;
+ (UIButton *)createButtonWithImageName:(NSString *)imageName target:(id)target action:(SEL)action imageInset:(UIEdgeInsets)insets;
+ (UIButton *)createButtonWithImageName:(NSString *)imageName target:(id)target action:(SEL)action leftCapWidth:(float)leftCapWidth topCapHeight:(float)topCapHeight;
+ (UIButton *)createButton:(NSString *)title buttonType:(UIButtonType)buttonType target:(id)target action:(SEL)action;
+ (UIButton *)createButton:(NSString *)title WithImageName:(NSString *)imageName highlightedImage:(NSString*)highlightedImage target:(id)target action:(SEL)action leftCapWidth:(float)leftCapWidth topCapHeight:(float)topCapHeight;

+(UITextField*)createNormalTextField;
+(UITextField*)createUrlTextField;
+(UITextField*)createUrlTextFieldWithFrame:(CGRect)frame;

+ (void)addUIActivityIndicatorView:(UIView *)viewContainer withSize:(CGSize)size;
+ (void)addUIActivityIndicatorView:(UIView *)viewContainer;
+ (void)removeUIActivityIndicatorView:(UIView *)viewContainer;

+ (void)alertError:(NSString*)title message:(NSString*)message;
+ (void)alertConform:(NSString*)title message:(NSString*)message delegate:(id)delegate;
+ (void)alertConform:(NSString*)title message:(NSString*)message buttonText:(NSString *)buttonText delegate:(id)delegate;
+ (void)alertConform:(NSString*)title message:(NSString*)message buttonText:(NSString *)buttonText delegate:(id)delegate tag:(NSInteger)tag;

+ (UIAlertView *)alertError:(NSString*)title message:(NSString*)message delegate:(id)delegate;

#pragma mark Group table
+ (BOOL)isInToday:(NSDate *)otherDate;
+ (BOOL)isInYesterday:(NSDate *)otherDate;
+ (BOOL)isInSevenDays:(NSDate *)otherDate;
+ (BOOL)isInSameMonth:(NSDate *)firstDate secondDate:(NSDate *)secondDate;

#pragma mark String related
+(BOOL)isNullOrUndefined:(NSString*)str;
+(BOOL)isNullOrEmpty:(NSString*)str;
+(BOOL)isEmptyAfterTrim:(NSString *)str;
+(NSString*)nullToEmpty:(NSString *)src;
+(NSString*)getSubStringof:(NSString*)string maxLength:(int)maxLength;

+(void)copyToClipboard:(NSString*)str;

//+ (BOOL)isValidUrl:(NSString*)str;

// Extract the first Url contained in the given text.
+ (NSString*)extractUrl:(NSString*)text;

+ (NSString *)URLStringWithHTTP:(NSString *)urlString;

// Get site favorite icon of given url.
+ (NSString*)getFavIconFromUrl:(NSString*)url;

+ (NSString *)replaceBadCharOfFileName:(NSString *)filename;

+ (NSString*)stringWithUUID;

+ (BOOL)isCNPhoneNumber:(NSString *)num;
+ (BOOL)isENPhoneNum:(NSString*)num;
+ (BOOL)isPhoneNum:(NSString*)num;

// Make sure that String is not nil,
// Convert it to @"" if it's nil.
+(void)ensureString:(NSString**)str;

+ (NSString*)boolToString:(BOOL)value;

//For stringToBool when string is nil, return NO
+(BOOL)stringToBool:(NSString*)value;


#pragma mark Positions
+(CGPoint)getCenter:(CGRect)rect;

#pragma mark Others
+ (UIColor *)colorFromInt:(long)intColor;

+ (long)intFromColor:(UIColor *)color;

+ (UIImage *)imageFromColor:(UIColor *)color;

+ (NSInteger)getNumberInBundle:(NSInteger)currentNumber minNumber:(NSInteger)min maxNumber:(NSInteger)max;

+(NSMutableArray*)append:(NSArray*)array1 with:(NSArray*)array2;

+(BOOL)isDataNullOrEmpty:(NSData *)data;

+(BOOL)isArrayNullOrEmpty:(NSArray *)array;

+(NSArray *)checkArray:(NSObject *)arrayObject;

// Get a random number between min and max (min included but max excluded).
+(int)getRandomBetween:(int)min max:(int)max;

+(UIImage*)imageFromView:(UIView*)view withHighQuality:(BOOL)highQuality;

+(UIImage*)imageFromView:(UIView*)view withBounds:(CGRect)bounds withHighQuality:(BOOL)highQuality;

+(BOOL)areRect:(CGRect)aRect equalToRect:(CGRect)anotherRect;

+(BOOL)areRect:(CGRect)aRect equalToRect:(CGRect)anotherRect withPrecision:(float)precision;

+ (BOOL)areSize:(CGSize)size1 equal:(CGSize)size2;

+(BOOL)arePoint:(CGPoint)aPoint equalToPoint:(CGPoint)anotherPoint withPrecision:(float)precision;

+(BOOL)isPoint:(CGPoint)point inRect:(CGRect)rect withExtendedSize:(CGSize)size;

+(BOOL)CFRangeContainsRange:(CFRange)aRange anotherRange:(CFRange)anotherRange;

+(UIView*)hittestWithDescendantView:(UIView*)descendant point:(CGPoint)point rawHitView:(UIView*)rawHitView enlargedSize:(float)size viewToEnlarge:(UIView*)viewToEnlarge;

+(UIView*)hittestWithDescendantView:(UIView*)descendant point:(CGPoint)point rawHitView:(UIView*)rawHitView enlargedSize:(float)size viewsToEnlarge:(NSArray*)viewsToEnlarge;

+(NSString*)formatTime:(NSDate*)time;
//MM/dd/yyyy HH:mm a
+(NSString*)formatTimeHasYear:(NSDate*)time;

/*
 *1.(0~60)m ----> n minutes ago.
 *2.(1~24)h ----> n hours ago.
 *3.(1~7)d  ----> n days ago.
 *4.(7~n)d  ----> //MM/dd/yyyy HH:mm a
 */
+(NSString*)formatWebzineTime:(NSDate*)time;

+(CGRect)getImageViewContentRect:(UIImageView*)imageView;

+(UIImage *)getResizableImageWithCapInsets:(UIEdgeInsets)capInsets forImage:(UIImage *)image;

+(CGSize)textSizeOfLabel:(UILabel*)label;

+(CGSize)textSizeOfLabel:(UILabel*)label maxWidth:(CGFloat)maxWidth;

+(CGSize)textSizeOfLabel:(UILabel*)label maxSize:(CGSize)maxSize;

+ (BOOL)isNullOrEmptyArray:(NSArray *)array;


#pragma mark Network

typedef enum
{
    NETWORK_NONE,
    NETWORK_3G,
    NETWORK_WIFI
}NETWORK_TYPE;

+ (NETWORK_TYPE)networkType;

#pragma mark caculate time interval
+ (void)startRegisterTime;

+ (void)printTimeInterval:(NSString *)tagName;


@end
