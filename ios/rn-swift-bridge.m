
#import "React/RCTViewManager.h"
#import "RCTBridgeModule.h"
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RCT_EXTERN_MODULE(RNScichart, RCTViewManager)
RCT_EXTERN_METHOD(initData:(NSString *)background_color:(NSString *)fill_color:(NSString *)
                  border_color:(NSString *))
RCT_EXTERN_METHOD(updateData:(NSString *))
RCT_EXTERN_METHOD(updateChartState:(NSString *)state:(BOOL *))
RCT_EXTERN_METHOD(isLineStick:(BOOL *))
RCT_EXTERN_METHOD(isCursorStick:(BOOL *))

@end
@interface RCT_EXTERN_MODULE(ReactNativeEventEmitter, RCTEventEmitter)


- (NSArray<NSString *> *)supportedEvents {
  return @[@"RNScichart"];
}
@end
