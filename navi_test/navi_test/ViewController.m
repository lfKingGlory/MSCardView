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
#import "MSCardView1.h"
#import "MSCardView2.h"

#define MJCREDIT_DOWNLOAD_URL @"http://10.0.116.101:8020/msfcredit/index.html"

__weak NSString *string_weak = nil;

@protocol MSWebViewJSExport <JSExport>
- (void)onDownload:(NSString *)downloadUrl;
@end

@interface ViewController ()<UIWebViewDelegate, MSWebViewJSExport>
@property (strong, nonatomic) JSContext *context;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) MSCardView1 *cardView;
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
    
//    UICollectionView;
//    UICollectionViewFlowLayout;
//    UICollectionViewLayout;
//    UICollectionViewTransitionLayout;
//
//    UITableView;
//
//    CATransaction;
    
    NSString *str = [NSString stringWithFormat:@"liufei"];
    string_weak = str;
    NSLog(@"%@",string_weak);
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.cardView = [[MSCardView1 alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 180)];
//    self.cardView.datas = @[@1, @2, @3, @4, @5, @6, @7, @8, @9];
//    [self.view addSubview:self.cardView];
//
//    MSCardView *c = [[MSCardView alloc] initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, 180)];
//    c.count = 8;
//    [self.view addSubview:c];
    
    MSCardView2 *c = [[MSCardView2 alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    [self.view addSubview:c];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@",string_weak);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    NSLog(@"%@",string_weak);
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
