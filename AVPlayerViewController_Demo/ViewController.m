//
//  ViewController.m
//  AVPlayerViewController_Demo
//
//  Created by 沈红榜 on 15/12/22.
//  Copyright © 2015年 沈红榜. All rights reserved.
//

#import "ViewController.h"
#import "SHBAVController.h"
#import "SHBAVPlayerView.h"

@interface ViewController ()

@end

static NSString *videoUrl = @"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";

@implementation ViewController {
    SHBAVPlayerView     *avView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    avView = [[SHBAVPlayerView alloc] initWithFrame:CGRectMake(30, 100, 250, 150) url:videoUrl];
    [self.view addSubview:avView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"Go in Player" forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.center = self.view.center;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(goInToPlayerController) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:@"play" forState:UIControlStateNormal];
    [btn1 sizeToFit];
    btn1.center = CGPointMake(30, 200);
    [self.view addSubview:btn1];
    [btn1 addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
}

- (void)play {
    [avView play];
}

- (void)goInToPlayerController {
    SHBAVController *av = [[SHBAVController alloc] initWithUrl:videoUrl];
    [self presentViewController:av animated:true completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
