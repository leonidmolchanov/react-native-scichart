
#import "React/RCTViewManager.h"
#import "RCTBridgeModule.h"
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RCT_EXTERN_MODULE(RNScichart, RCTViewManager)
RCT_EXTERN_METHOD(onData:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(startCapture:(NSString *)module_value:(NSString *)module_label:(nonnull NSNumber *)model_width_value:(nonnull NSNumber *)model_height_value )
RCT_EXTERN_METHOD(stopCapture)
RCT_EXTERN_METHOD(togglePosition)
RCT_EXTERN_METHOD(setModelWidth:(nonnull NSNumber *)model_width_value)
RCT_EXTERN_METHOD(setModelHeight:(nonnull NSNumber *)model_height_value)

@end


@interface RCT_EXTERN_MODULE(ReactNativeEventEmitter, RCTEventEmitter)


- (NSArray<NSString *> *)supportedEvents {
  return @[@"RNScichart"];
}
@end
