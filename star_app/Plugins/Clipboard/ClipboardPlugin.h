//
//  ClipboardPlugin.h
//  Clipboard plugin for PhoneGap
//
//  Copyright 2010 Michel Weimerskirch.
//  Ported to Phonegap 2.0.0 2013 Jacob Robbins.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface ClipboardPlugin : CDVPlugin

-(void)setText:(CDVInvokedUrlCommand*)command;

-(void)getText:(CDVInvokedUrlCommand*)command;

@end