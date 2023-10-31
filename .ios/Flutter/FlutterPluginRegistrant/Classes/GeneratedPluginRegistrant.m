//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_boost/FlutterBoostPlugin.h>)
#import <flutter_boost/FlutterBoostPlugin.h>
#else
@import flutter_boost;
#endif

#if __has_include(<flutter_timezone/FlutterTimezonePlugin.h>)
#import <flutter_timezone/FlutterTimezonePlugin.h>
#else
@import flutter_timezone;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterBoostPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterBoostPlugin"]];
  [FlutterTimezonePlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterTimezonePlugin"]];
}

@end
