//
//  CCWeb.m
//  CCRefreshiOS
//
//  Created by deng you hua on 4/29/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import "CCWeb.h"
#import <CCRefresh.h>

@interface CCWeb () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation CCWeb

- (void) loadingUI {
    __weak UIWebView *webView = self.webView;
    webView.delegate = self;
    
    __weak UIScrollView *scrollView = self.webView.scrollView;
    
    scrollView.CCHeader= [CCRefreshNormalHeader headerWithRefreshingBlock:^{
        [webView reload];
    }];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com/ccworld1000/CCRefresh"]]];
    [self.webView reload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadingUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) webViewDidFinishLoad:(UIWebView *)webView {
    [self.webView.scrollView.CCHeader endRefreshing];
}

@end
