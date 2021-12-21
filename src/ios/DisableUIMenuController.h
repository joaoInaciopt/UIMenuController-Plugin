#import <Cordova/CDV.h>

@interface DisableUIMenuController: CDVPlugin

- (void)activate:(CDVInvokedUrlCommand*)command;
- (void)deactivate:(CDVInvokedUrlCommand*)command;

@end