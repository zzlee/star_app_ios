//
//  ClipboardPlugin.m
//  Clipboard plugin for PhoneGap
//
//  Copyright 2010 Michel Weimerskirch.
//  Ported to Phonegap 2.0.0 2013 Jacob Robbins.
//

#import "ClipboardPlugin.h"
#import <Cordova/CDV.h>


@implementation ClipboardPlugin

-(void)setText:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = nil;
	UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
	NSString     *text       = [command.arguments objectAtIndex:0];
    
    [pasteboard setValue:text forPasteboardType:@"public.text"];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void)getText:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = nil;
	UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
	NSString *text = [pasteboard valueForPasteboardType:@"public.text"];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:text];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

@end