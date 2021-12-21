#import "DisableUIMenuController.h"
#import <Cordova/CDV.h>
#import <WebKit/WebKit.h>
#import <objc/runtime.h>

static BOOL swizzlePerformActionEnabled = NO;

@implementation WKWebView (DisableUIMenuControllerPlugin)

- (BOOL)swizzled_canPerformAction:(SEL)action withSender:(id)sender {
  if (!swizzlePerformActionEnabled) {
        return [self swizzled_canPerformAction:action withSender:sender];
    }

    if ([sender isKindOfClass:[UIMenuController class]]) {
        return NO;
    }
    return [self swizzled_canPerformAction:action withSender:sender];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(canPerformAction:withSender:);
        SEL swizzledSelector = @selector(swizzled_canPerformAction:withSender:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        IMP originalImp = method_getImplementation(originalMethod);
        IMP swizzledImp = method_getImplementation(swizzledMethod);

        class_replaceMethod(class,
                        swizzledSelector,
                        originalImp,
                        method_getTypeEncoding(originalMethod));
                class_replaceMethod(class,
                        originalSelector,
                        swizzledImp,
                        method_getTypeEncoding(swizzledMethod)
                                    );

    });
}

@end

@implementation DisableUIMenuController

- (void)activate:(CDVInvokedUrlCommand*)command {
  swizzlePerformActionEnabled = YES;

  CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  [pluginResult setKeepCallbackAsBool:YES];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)deactivate:(CDVInvokedUrlCommand*)command {
  swizzlePerformActionEnabled = NO;

  CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  [pluginResult setKeepCallbackAsBool:YES];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end