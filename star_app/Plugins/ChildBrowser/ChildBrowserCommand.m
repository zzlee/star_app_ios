//  Created by Jesse MacFadyen on 10-05-29.
//  Copyright 2010 Nitobi. All rights reserved.
//  Copyright 2012, Randy McMillan

#import "ChildBrowserCommand.h"
#import <Cordova/CDVViewController.h>

@implementation ChildBrowserCommand

@synthesize childBrowser;

-(void) deleteCookies:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options{
    
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *each in [cookieStorage cookies]) {
        
        [cookieStorage  deleteCookie:each];
    }
}

- (void)showWebPage:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options  // args: url
{
    if (self.childBrowser == nil) {
#if __has_feature(objc_arc)
        self.childBrowser = [[ChildBrowserViewController alloc] initWithScale:NO];
#else
        self.childBrowser = [[[ChildBrowserViewController alloc] initWithScale:NO] autorelease];
#endif
        self.childBrowser.delegate = self;
        self.childBrowser.orientationDelegate = self.viewController;
    }

    /* // TODO: Work in progress
     NSString* strOrientations = [ options objectForKey:@"supportedOrientations"];
     NSArray* supportedOrientations = [strOrientations componentsSeparatedByString:@","];
     */

    [self.viewController presentModalViewController:childBrowser animated:YES];

    NSString* url = (NSString*)[arguments objectAtIndex:0];

    [self.childBrowser loadURL:url];
}

- (void)getPage:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
    NSString* url = (NSString*)[arguments objectAtIndex:0];

    [self.childBrowser loadURL:url];
}

- (void)close:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options // args: url
{
    [self.childBrowser closeBrowser];
}

- (void)onClose
{
    [self.webView stringByEvaluatingJavaScriptFromString:@"window.plugins.childBrowser.onClose();"];
}

- (void)onOpenInSafari
{
    [self.webView stringByEvaluatingJavaScriptFromString:@"window.plugins.childBrowser.onOpenExternal();"];
}

- (void)onChildLocationChange:(NSString*)newLoc
{
    NSString* tempLoc = [NSString stringWithFormat:@"%@", newLoc];
    NSString* encUrl = [tempLoc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSString* jsCallback = [NSString stringWithFormat:@"window.plugins.childBrowser.onLocationChange('%@');", encUrl];

    [self.webView stringByEvaluatingJavaScriptFromString:jsCallback];
}


#if !__has_feature(objc_arc)
- (void)dealloc
{
    self.childBrowser = nil;

    [super dealloc];
}
#endif

@end
