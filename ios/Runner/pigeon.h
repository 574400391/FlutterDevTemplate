// Autogenerated from Pigeon (v9.0.5), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import <Foundation/Foundation.h>

@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

@class Message;

@interface Message : NSObject
+ (instancetype)makeWithType:(nullable NSNumber *)type
    message:(nullable NSString *)message;
@property(nonatomic, strong, nullable) NSNumber * type;
@property(nonatomic, copy, nullable) NSString * message;
@end

/// The codec used by Api.
NSObject<FlutterMessageCodec> *ApiGetCodec(void);

/// Flutter -> Native(Android/iOS)
@protocol Api
/// 无需传参
- (void)doSomethingNoParamWithError:(FlutterError *_Nullable *_Nonnull)error;
/// 传递参数
- (void)doSomethingWithParamMsg:(Message *)msg error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void ApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<Api> *_Nullable api);

/// The codec used by NativeApi.
NSObject<FlutterMessageCodec> *NativeApiGetCodec(void);

/// Native(Android/iOS) -> Flutter
@interface NativeApi : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
/// native异步完成任务后发送结果给flutter层
- (void)doSomethingResultMsgResult:(Message *)msgResult completion:(void (^)(FlutterError *_Nullable))completion;
@end

NS_ASSUME_NONNULL_END
