#import "PerfectVolumeControlPlugin.h"
#if __has_include(<perfect_volume_control/perfect_volume_control-Swift.h>)
#import <perfect_volume_control/perfect_volume_control-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "perfect_volume_control-Swift.h"
#endif

@implementation PerfectVolumeControlPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPerfectVolumeControlPlugin registerWithRegistrar:registrar];
}
@end
