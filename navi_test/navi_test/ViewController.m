//
//  ViewController.m
//  navi_test
//
//  Created by msj on 2017/8/15.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"

#define MJCREDIT_DOWNLOAD_URL @"http://10.0.116.101:8020/msfcredit/index.html"

@protocol MSWebViewJSExport <JSExport>
// 无参数或者一个参数使用下面的方法
- (void)onDownload:(NSString *)downloadUrl;

/*
     多参数使用下面的方法  (参数顺序要对应上)
     onDownload  为 js 方法名
     - (void)onDownload:(NSString *)downloadUrl   为  OC 方法
 */
//JSExportAs(onDownload, - (void)onDownload:(NSString *)downloadUrl);
@end

@interface ViewController ()<UIWebViewDelegate, MSWebViewJSExport>
@property (strong, nonatomic) JSContext *context;
@property (strong, nonatomic) UIWebView *webView;
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
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 60)];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTitle:@"MSCardView1" forState:UIControlStateNormal];
    btn1.tag = 1000;
    [self.view addSubview:btn1];
    [btn1 addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btn1.frame)+30, self.view.bounds.size.width, 60)];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"MSCardView2" forState:UIControlStateNormal];
    btn2.tag = 1001;
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btn2.frame)+30, self.view.bounds.size.width, 60)];
    btn3.backgroundColor = [UIColor redColor];
    [btn3 setTitle:@"MSCardView3" forState:UIControlStateNormal];
    btn3.tag = 1002;
    [self.view addSubview:btn3];
    [btn3 addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tap:(UIButton *)btn {
    if (btn.tag == 1000) {
        ViewController1 *v1 = [ViewController1 new];
        [self.navigationController pushViewController:v1 animated:YES];
    } else if (btn.tag == 1001) {
        ViewController2 *v2 = [ViewController2 new];
        [self.navigationController pushViewController:v2 animated:YES];
    } else if (btn.tag == 1002) {
        ViewController3 *v3 = [ViewController3 new];
        [self.navigationController pushViewController:v3 animated:YES];
    } else {
        
    }
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
