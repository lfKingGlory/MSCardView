//
//  ViewController.m
//  navi_test
//
//  Created by msj on 2017/8/15.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "MSCardView.h"

#define MJCREDIT_DOWNLOAD_URL @"http://10.0.116.101:8020/msfcredit/index.html"

@protocol MSWebViewJSExport <JSExport>
- (void)onDownload:(NSString *)downloadUrl;
@end

@interface ViewController ()<UIWebViewDelegate, MSWebViewJSExport>
@property (strong, nonatomic) JSContext *context;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) MSCardView *cardView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubveiws];
}

- (void)addSubveiws {
    
    
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.title = @"MSWebViewJSExport";
//
//    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    self.webView.delegate = self;
//    self.webView.opaque = NO;
//    self.webView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:self.webView];
//
//    NSURL *url = [NSURL URLWithString:MJCREDIT_DOWNLOAD_URL];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
    
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.cardView = [[MSCardView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 180)];
    self.cardView.backgroundColor = [UIColor yellowColor];
    self.cardView.count = 5;
    [self.view addSubview:self.cardView];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    [self.context setObject:self forKeyedSubscript:@"msfDownload"];
    self.context.exceptionHandler = ^(JSContext* context, JSValue* exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%@",error);
}

#pragma mark - MSWebViewJSExport
- (void)onDownload:(NSString *)downloadUrl {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downloadUrl]];
#pragma clang diagnostic pop
}
@end
