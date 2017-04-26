//
//  XMGWebViewController.m
//  BaiSi
//
//  Created by Yang on 2017/4/25.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import "XMGWebViewController.h"
#import <WebKit/WebKit.h>
@interface XMGWebViewController ()
@property (weak, nonatomic) IBOutlet UIView *wkWebView;
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progressValue;

@end

@implementation XMGWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView * webView = [[WKWebView alloc] init];
    self.webView = webView;
    [self.wkWebView addSubview:webView];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:self.url];
    [webView loadRequest:request];
    //KVO添加观察
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
     [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}
//只要观察的熟悉改变  就会调用
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    self.backItem.enabled = self.webView.canGoBack;
    self.forwardItem.enabled = self.webView.canGoForward;
    self.title = self.webView.title;
    self.progressValue.progress = self.webView.estimatedProgress;
    self.progressValue.hidden = self.webView.estimatedProgress>=1?YES:NO;
}
-(void)viewDidLayoutSubviews{
    self.webView.frame = self.wkWebView.frame;
}
- (IBAction)reload:(id)sender {
    [self.webView reload];
}
- (IBAction)goforward:(id)sender {
    [self.webView goForward];
}
- (IBAction)goback:(id)sender {
    [self.webView goBack];
}
-(void)dealloc{
    //移除监听
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
