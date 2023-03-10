// Autogenerated from Pigeon (v9.0.5), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import "pigeon.h"
#import <Flutter/Flutter.h>

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSArray *wrapResult(id result, FlutterError *error) {
  if (error) {
    return @[
      error.code ?: [NSNull null], error.message ?: [NSNull null], error.details ?: [NSNull null]
    ];
  }
  return @[ result ?: [NSNull null] ];
}
static id GetNullableObjectAtIndex(NSArray *array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}

@interface Message ()
+ (Message *)fromList:(NSArray *)list;
+ (nullable Message *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@implementation Message
+ (instancetype)makeWithType:(nullable NSNumber *)type
    message:(nullable NSString *)message {
  Message* pigeonResult = [[Message alloc] init];
  pigeonResult.type = type;
  pigeonResult.message = message;
  return pigeonResult;
}
+ (Message *)fromList:(NSArray *)list {
  Message *pigeonResult = [[Message alloc] init];
  pigeonResult.type = GetNullableObjectAtIndex(list, 0);
  pigeonResult.message = GetNullableObjectAtIndex(list, 1);
  return pigeonResult;
}
+ (nullable Message *)nullableFromList:(NSArray *)list {
  return (list) ? [Message fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    (self.type ?: [NSNull null]),
    (self.message ?: [NSNull null]),
  ];
}
@end

@interface ApiCodecReader : FlutterStandardReader
@end
@implementation ApiCodecReader
- (nullable id)readValueOfType:(UInt8)type {
  switch (type) {
    case 128: 
      return [Message fromList:[self readValue]];
    default:
      return [super readValueOfType:type];
  }
}
@end

@interface ApiCodecWriter : FlutterStandardWriter
@end
@implementation ApiCodecWriter
- (void)writeValue:(id)value {
  if ([value isKindOfClass:[Message class]]) {
    [self writeByte:128];
    [self writeValue:[value toList]];
  } else {
    [super writeValue:value];
  }
}
@end

@interface ApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation ApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[ApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[ApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *ApiGetCodec() {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  static dispatch_once_t sPred = 0;
  dispatch_once(&sPred, ^{
    ApiCodecReaderWriter *readerWriter = [[ApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}

void ApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<Api> *api) {
  /// 无需传参
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.Api.doSomethingNoParam"
        binaryMessenger:binaryMessenger
        codec:ApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(doSomethingNoParamWithError:)], @"Api api (%@) doesn't respond to @selector(doSomethingNoParamWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        [api doSomethingNoParamWithError:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  /// 传递参数
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.Api.doSomethingWithParam"
        binaryMessenger:binaryMessenger
        codec:ApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(doSomethingWithParamMsg:error:)], @"Api api (%@) doesn't respond to @selector(doSomethingWithParamMsg:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        Message *arg_msg = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api doSomethingWithParamMsg:arg_msg error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
@interface NativeApiCodecReader : FlutterStandardReader
@end
@implementation NativeApiCodecReader
- (nullable id)readValueOfType:(UInt8)type {
  switch (type) {
    case 128: 
      return [Message fromList:[self readValue]];
    default:
      return [super readValueOfType:type];
  }
}
@end

@interface NativeApiCodecWriter : FlutterStandardWriter
@end
@implementation NativeApiCodecWriter
- (void)writeValue:(id)value {
  if ([value isKindOfClass:[Message class]]) {
    [self writeByte:128];
    [self writeValue:[value toList]];
  } else {
    [super writeValue:value];
  }
}
@end

@interface NativeApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation NativeApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[NativeApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[NativeApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *NativeApiGetCodec() {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  static dispatch_once_t sPred = 0;
  dispatch_once(&sPred, ^{
    NativeApiCodecReaderWriter *readerWriter = [[NativeApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}

@interface NativeApi ()
@property(nonatomic, strong) NSObject<FlutterBinaryMessenger> *binaryMessenger;
@end

@implementation NativeApi

- (instancetype)initWithBinaryMessenger:(NSObject<FlutterBinaryMessenger> *)binaryMessenger {
  self = [super init];
  if (self) {
    _binaryMessenger = binaryMessenger;
  }
  return self;
}
- (void)doSomethingResultMsgResult:(Message *)arg_msgResult completion:(void (^)(FlutterError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.NativeApi.doSomethingResult"
      binaryMessenger:self.binaryMessenger
      codec:NativeApiGetCodec()];
  [channel sendMessage:@[arg_msgResult ?: [NSNull null]] reply:^(id reply) {
    completion(nil);
  }];
}
@end

