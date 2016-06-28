//
//  DeviceUtils.h
//  Dolphin
//
//  Created by Jim Huang on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/* For iPad also import SIM related library, because until now we cannot import library when runtime*/
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

#define DATA_VERSION_KEY                         @"DateVersion"
#define DATA_VERSION_CODE_LENGTH                 6

#define IsAtLeastiOSVersion(X) ([[[UIDevice currentDevice] systemVersion] compare:X options:NSNumericSearch] != NSOrderedAscending)

#define STATUS_BAR_HEIGHT 20

#if defined(__IPHONE_7_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0

#define CONTENT_TOP_MARGIN (IsAtLeastiOSVersion(@"7.0")? STATUS_BAR_HEIGHT: 0)

#else

#define CONTENT_TOP_MARGIN 0

#endif

@interface DeviceUtils : NSObject {
    
}

+(BOOL)isPad;
+(BOOL)isIPad1;
+(BOOL)isIPadMini;
+(BOOL)isIPad2AndMini;
+(BOOL)isIPhone5;

+ (BOOL)isLandscape;


// Return whethe the machine is iPad1, iPad2, iPhone 4, iPhone 4S etc.
+(NSString*)machineType;

+(NSString *)deviceName;
+ (CGFloat)getKeyboardHeight:(CGRect)keyboardFrame;

+(NSString *)deviceLocale;
+ (NSString*)getPreferredLanguage;
+(NSString *)deviceOSVersion;//Have cache, better performace
+(NSMutableDictionary *)deviceMetadata;
+(NSMutableDictionary *)deviceActiveUserTrackMetadata:(BOOL)isNewUser;
+(NSDictionary *)carrierMetadata;//Carrier, No SIM card no this
+(NSString *)appVersionString;
+(NSString*)appBuildString;
+(NSString *)appVersionCodeString;
+(NSString *)packageNameString;
+(NSString *)marketNameString;
+(NSString *)productNameString;
+(NSInteger)appVersion;
+(NSInteger)dataVersion;
+(void)setDataVersion:(NSInteger)newVersion;
+(NSString *)uniqueAppId;//Unique app in one device
//+(NSString *)udidMD5;//Unique device
+(NSString *)udidMD5;
+(NSString*)getCurrentIP;
+(UIInterfaceOrientation)deviceOrientationToInterfaceOrientation:(UIDeviceOrientation)deviceOrientation;
+(NSString *)name;


// Get the available free memory via vm_statistics
+(unsigned int)getFreeMemory;

@end
