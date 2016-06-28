//
//  DeviceUtils.m
//  Dolphin
//
//  Created by Jim Huang on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DeviceUtils.h"
#import "UIDevice+IdentifierAddition.h"
/* For iPad also import SIM related library, because until now we cannot import library when runtime*/
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <sys/sysctl.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "CommonFunctions.h"
#import "NSString+URLEncoding.h"
#import "NSStringAdditional.h"
#import "NSObject+Method.h"
#import "NSString+APIEncoding.h"
#import <AdSupport/AdSupport.h>
#import <mach/mach.h>
#import <mach/mach_host.h>

#define GUID_KEY                       @"GUID"
#define BUNDLE_VERSION_CODE_KEY        @"Bundle version code"
#define MARKET_NAME_KEY                @"Market Name"


@implementation DeviceUtils


+(BOOL)isPad
{
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#else
    return NO;
#endif
}

+(BOOL)isIPad1
{
    return [[DeviceUtils machineType] isEqualToString:@"iPad1,1"];
}

+(BOOL)isIPadMini
{
    NSString *machineType = [[self class] machineType];
    return [machineType isEqualToString:@"iPad2,5"] || [machineType isEqualToString:@"iPad2,6"] || [machineType isEqualToString:@"iPad2,7"];
}

+(BOOL)isIPad2AndMini
{
    NSString *machineType = [[self class] machineType];
    NSRange range = [machineType rangeOfString:@"iPad2,"];
    if (range.location != NSNotFound) {
        return YES;
    } else {
        return NO;
    }
}

+(BOOL)isIPhone5
{
    return [[DeviceUtils machineType] isEqualToString:@"iPhone 5"];
}

+ (BOOL)isLandscape
{
    return UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]);
    
    //    return UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]);
}

+(NSString*)machineType
{
    static NSString *platform = nil;
    if (nil == platform)
    {
        size_t size;  
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);  
        char *machine = malloc(size);
        memset(machine, 0, size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);  
        platform = [[NSString stringWithCString:machine encoding:NSUTF8StringEncoding] copy];
        free(machine);                
    }
    
    // For iphone it's a litter strange, @"iPhone3,x" is for iPhone4, @"iPhone4,1" is for iPhone4S.
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform hasPrefix:@"iPhone3"]) return @"iPhone 4";     // @"iPhone3,1" for @"iPhone 4", @"iPhone3,3" for @"Verizon iPhone 4".
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform hasPrefix:@"iPhone5"] || [platform hasPrefix:@"iPod5"]) return @"iPhone 5"; //iPhone 5 GSM - iPhone5,1 iPhone 5 CDMA - iPhone5,2 iPod 5 - iPod5,1
    
    return platform; 
}

+(NSString *)deviceName
{
    return [DeviceUtils isPad]? @"iPad" : @"iPhone";
}

+ (CGFloat)getKeyboardHeight:(CGRect)keyboardFrame
{    
    CGFloat height = 0.0f;
    BOOL isLandScape = UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]);
    if(isLandScape)
    {
        height = keyboardFrame.size.width;
    }
    else
    {
        height = keyboardFrame.size.height;
    }

    if(height < 1.0f)
    {
        // Bug fix:13079 & 13082. On old devices sometimes the keyboardFrame doesn't has value.
        if([DeviceUtils isPad])
        {
            height = isLandScape ? 352 : 264;
        }
        else
        {
            height = isLandScape ? 162 : 216;
        }
    }
    
    // DebugLog(@"Keyboard height: %f", height);
    return height;
}

+(NSString *)deviceLocale
{
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *currentLocaleString = [currentLocale localeIdentifier];
    
    return currentLocaleString;
}

//精确获取语言信息
+ (NSString*)getPreferredLanguage
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    NSLog(@"Preferred Language:%@", preferredLang);
    return preferredLang;
}

+(NSString *)deviceOSVersion
{
    static NSString *systemVersion;
    
    if (systemVersion == nil)
    {
        UIDevice *device = [UIDevice currentDevice];
        //get systemVersion need 143ms, so cache it
        systemVersion = [[device systemVersion] retain];
    }
    
    return systemVersion;
}

//Will been url encoded
+(NSMutableDictionary *)deviceMetadata
{
    NSMutableDictionary *metadata = [[NSMutableDictionary alloc] init];
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGSize size = screen.size;
    NSString *productName = [DeviceUtils productNameString];
    NSString *productVersion = [DeviceUtils appVersionString];    
    [metadata setValue:[[DeviceUtils deviceName] URLEncodedStringPlusForSpace] forKey:@"d"];
    
    NSString* machineType = [DeviceUtils machineType]; // Track more detail device model info. e.g. iphone 3G/4G, iPad1/iPad2.
    [metadata setValue:[machineType URLEncodedStringPlusForSpace] forKey:@"m"];
    
    [metadata setValue:[[DeviceUtils udidMD5] URLEncodedStringPlusForSpace] forKey:@"u"];
    [metadata setValue:[[DeviceUtils deviceLocale] URLEncodedStringPlusForSpace] forKey:@"l"];
    [metadata setValue:[[NSString stringWithFormat:@"%d", (int)size.width] URLEncodedStringPlusForSpace] forKey:@"w"];
    [metadata setValue:[[NSString stringWithFormat:@"%d", (int)size.height] URLEncodedStringPlusForSpace] forKey:@"h"];
    [metadata setValue:[productName URLEncodedStringPlusForSpace]forKey:@"p"];
    [metadata setValue:[productVersion URLEncodedStringPlusForSpace]forKey:@"v"];
    [metadata autorelease];
    return metadata;
}

+ (id)userDefaultValueForKey:(NSString *)key
{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    return [userInfo valueForKey:key];
}

+ (void)saveUserDefaultValue:(id)value forKey:(NSString *)key
{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setValue:value forKey:key];
    [userInfo synchronize];
}

+ (NSString *)uniqueAppId
{
    NSString *guidStr = [DeviceUtils userDefaultValueForKey:GUID_KEY];
    if (nil == guidStr)
    {
        CFUUIDRef uid = CFUUIDCreate(NULL);
        CFStringRef uidStr = CFUUIDCreateString(NULL, uid);
        guidStr = [[[NSString alloc] initWithString:(NSString *)uidStr] autorelease];
        [DeviceUtils saveUserDefaultValue:guidStr forKey:GUID_KEY];
        CFRelease(uidStr);
        CFRelease(uid);
    }
    return guidStr;
}

+ (NSString*)getCurrentIP
{
//    NSString* ip = nil;
//    NSURL *url = [NSURL URLWithString:@"http://automation.whatismyip.com/n09230945.asp"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    request.timeoutInterval = 2.0;
//    [request setHTTPMethod:@"GET"];
//    NSData *returnDate = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    ip = [[[NSString alloc] initWithData:returnDate encoding:NSUTF8StringEncoding] autorelease];
//    return ip;
    
//    NSString *address = @"error";
//    struct ifaddrs *interfaces = NULL;
//    struct ifaddrs *temp_addr = NULL;
//    int success = 0;
//    
//    // retrieve the current interfaces - returns 0 on success
//    success = getifaddrs(&interfaces);
//    if (success == 0)
//    {
//        // Loop through linked list of interfaces
//        temp_addr = interfaces;
//        while(temp_addr != NULL)
//        {
//            if(temp_addr->ifa_addr->sa_family == AF_INET)
//            {
//                // Check if interface is en0 which is the wifi connection on the iPhone
//                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
//                {
//                    // Get NSString from C String
//                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
//                }
//            }
//            
//            temp_addr = temp_addr->ifa_next;
//        }
//    }
//    
//    // Free memory
//    freeifaddrs(interfaces);
//    
//    return address;
    
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    NSString *wifiAddress = nil;
    NSString *cellAddress = nil;
    
    // retrieve the current interfaces - returns 0 on success
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            sa_family_t sa_type = temp_addr->ifa_addr->sa_family;
            if(sa_type == AF_INET || sa_type == AF_INET6) {
                NSString *name = [NSString stringWithUTF8String:temp_addr->ifa_name];
                NSString *addr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]; // pdp_ip0
                //DebugLog(@"NAME: \"%@\" addr: %@", name, addr); // see for yourself
                if([name isEqualToString:@"en0"]) {
                    // Interface is the wifi connection on the iPhone
                    wifiAddress = addr;
                } else
                    if([name isEqualToString:@"pdp_ip0"]) {
                        // Interface is the cell connection on the iPhone
                        cellAddress = addr;
                    }
            }
            temp_addr = temp_addr->ifa_next;
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    NSString *addr = wifiAddress ? wifiAddress : cellAddress;
    return addr ? addr : @"0.0.0.0";
}

//when modify code here,search "//because we can't get this value alwayes,so make sure this,so we do"
+ (NSString*)udidMD5
{
    NSString *adId;

    if ([[DeviceUtils deviceOSVersion] floatValue] >= 7.0) {
        adId = [[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] md5];
    }else{
        adId = [[[UIDevice currentDevice] uniqueGlobalDeviceIdentifier] md5];
    }
    
    return adId;
}

+ (NSString *)appVersionCodeString
{
    return [NSString stringWithFormat:@"%ld", [DeviceUtils appVersion]];
    //Here can transform version code.
}

+ (NSString *)appVersionString
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
}

+(NSString*)appBuildString
{
    NSString* ret = nil;
#ifdef BUILD_NUMBER
    /*
     * Use 2 steps to fetch value, not clear why
     * See:http://stackoverflow.com/questions/3261763/accessing-the-value-of-a-preprocessor-macro-definition
     */
#define MACRO_NAME(f)   #f
#define MACRO_VALUE(f)  MACRO_NAME(f)
    ret = [NSString stringWithFormat:@"%s", MACRO_VALUE(BUILD_NUMBER)];
#else
    ret = @"";
#endif
    return ret;
}

+ (NSString *)packageNameString
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleIdentifierKey];
}

+ (NSString *)marketNameString
{
    return [[[NSBundle mainBundle] objectForInfoDictionaryKey:MARKET_NAME_KEY] stringByReplacingOccurrencesOfString:@" " withString:@""];//Spilt blank
}

+ (NSString *)productNameString
{
    NSString *packageName = [DeviceUtils packageNameString];
    NSString *marketName = [DeviceUtils marketNameString];

    if (![CommonFunctions isNullOrEmpty:marketName])
    {
        return [NSString stringWithFormat:@"%@.%@", packageName, marketName];
    }
    else
    {
        return packageName;
    }
}

+ (NSInteger)appVersion
{
    NSString *appVersion = [DeviceUtils appVersionString];//Example: 1.1 or 1.0.1
    NSInteger appVersionInteger = 0;
    NSArray *numbersArray = [appVersion componentsSeparatedByString:@"."];
    NSInteger versionCodeLength = DATA_VERSION_CODE_LENGTH;
    NSInteger numbersArrayLength = [numbersArray count];
    
    for (NSInteger i = 0; (i < versionCodeLength) && (i < numbersArrayLength); i++)
    {
        NSString *bit = [numbersArray objectAtIndex:i];
        appVersionInteger += [bit integerValue] * (pow(10, (versionCodeLength - i)));
    }
    
    return appVersionInteger;//Example: 1100000
}

+ (NSInteger)dataVersion
{
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    NSInteger dataVersion = [info integerForKey:DATA_VERSION_KEY];//No key'value, will return 0
    return dataVersion;
}

+ (void)setDataVersion:(NSInteger)newVersion
{
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    [info setInteger:newVersion forKey:DATA_VERSION_KEY];
    [info synchronize];
}

+ (NSDictionary *)carrierMetadata//Carrier, No SIM card no this
{
    NSDictionary *metadata = [[[NSMutableDictionary alloc] init] autorelease];
        
    CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netinfo subscriberCellularProvider];
    [metadata setValue:[[carrier mobileCountryCode] URLEncodedStringPlusForSpace] forKey:@"cou"];//Country
    //http://en.wikipedia.org/wiki/List_of_mobile_country_codes
    [metadata setValue:[[carrier mobileNetworkCode] URLEncodedStringPlusForSpace] forKey:@"pnt"];//Network Type
    //http://en.wikipedia.org/wiki/Mobile_Network_Code
    [metadata setValue:[[carrier carrierName] URLEncodedStringPlusForSpace] forKey:@"car"];//Carrier Name
    [netinfo release];
    return metadata;
}

//Will been url encoded
+(NSMutableDictionary *)deviceActiveUserTrackMetadata:(BOOL)isNewUser
{
    NSMutableDictionary *metadata = [[[NSMutableDictionary alloc] init] autorelease];
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGSize size = screen.size;
    UIDevice *device = [UIDevice currentDevice];
    NSString *productName = [DeviceUtils productNameString];
    NSString *productVersion = [DeviceUtils appVersionString];
    
    [metadata setValue:[[DeviceUtils uniqueAppId] URLEncodedStringPlusForSpace] forKey:@"cg"];//Client GUID
    [metadata setValue:[[DeviceUtils udidMD5] URLEncodedStringPlusForSpace] forKey:@"did"];//Device Id
    [metadata setValue:[productName URLEncodedStringPlusForSpace] forKey:@"pn"];//Product Number
    [metadata setValue:[productVersion URLEncodedStringPlusForSpace] forKey:@"avn"];//Version Number
    [metadata setValue:[(isNewUser? @"1": @"0") URLEncodedStringPlusForSpace] forKey:@"inu"];//Is New user
    [metadata setValue:[[DeviceUtils appVersionCodeString] URLEncodedStringPlusForSpace] forKey:@"vn"];//Version Code
    [metadata setValue:[[DeviceUtils deviceName] URLEncodedStringPlusForSpace] forKey:@"pt"];//Phone type
    [metadata setValue:[@"Foxconn" URLEncodedStringPlusForSpace] forKey:@"pro"];//Product Manufacturer
    [metadata setValue:[[device systemVersion] URLEncodedStringPlusForSpace] forKey:@"ve"];//System Version
    [metadata setValue:[[device systemName] URLEncodedStringPlusForSpace] forKey:@"bo"];//Board
    [metadata setValue:[[NSString stringWithFormat:@"%d", (int)size.width] URLEncodedStringPlusForSpace] forKey:@"w"];//Display Width
    [metadata setValue:[[NSString stringWithFormat:@"%d", (int)size.height] URLEncodedStringPlusForSpace] forKey:@"h"];//Display Height
    [metadata setValue:[@"Apple" URLEncodedStringPlusForSpace] forKey:@"br"];//Brand
    
    NSString* machineType = [DeviceUtils machineType]; // Track more detail device model info. e.g. iphone 3G/4G, iPad1/iPad2.
    [metadata setValue:[machineType URLEncodedStringPlusForSpace] forKey:@"mo"];//Model
    [metadata setValue:[DeviceUtils deviceLocale] forKey:@"l"];//locale
    
    [metadata addEntriesFromDictionary:[DeviceUtils carrierMetadata]];

    return metadata;
}

+(UIInterfaceOrientation)deviceOrientationToInterfaceOrientation:(UIDeviceOrientation)deviceOrientation
{
    if(UIDeviceOrientationIsLandscape(deviceOrientation) || UIDeviceOrientationIsPortrait(deviceOrientation))
    {
        return (UIInterfaceOrientation)deviceOrientation;
    }
    else
    {
        return UIInterfaceOrientationPortrait;
    }
}

+(NSString *)name {
    return [UIDevice currentDevice].name;
}



+(unsigned int)getFreeMemory
{
    mach_port_t host_port;
    mach_msg_type_number_t host_size;
    vm_size_t pagesize;
    
    host_port = mach_host_self();
    host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    host_page_size(host_port, &pagesize);        
    
    vm_statistics_data_t vm_stat;
    
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS)
    {
        DebugLog(@"Failed to fetch vm statistics");
        
        return INT32_MAX;
    }
    
    natural_t mem_free = vm_stat.free_count * (unsigned int)pagesize;
    
    return mem_free;
}

@end
