//
//  SHBAVController.m
//  AVPlayerViewController_Demo
//
//  Created by 沈红榜 on 15/12/22.
//  Copyright © 2015年 沈红榜. All rights reserved.
//

#import "SHBAVController.h"

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>



@interface SHBAVController ()<AVPlayerViewControllerDelegate>

@end

@implementation SHBAVController {
    AVPlayerViewController      *_playerController;
    
    
    
    AVPlayer                    *_player;
    AVAudioSession              *_session;
    NSURL                    *_url;
}

- (id)initWithUrl:(NSURL *)url {
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _session = [AVAudioSession sharedInstance];
    [_session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:_url];
    
    _player = [AVPlayer playerWithPlayerItem:item];
    _playerController = [[AVPlayerViewController alloc] init];
    _playerController.player = _player;
    _playerController.videoGravity = AVLayerVideoGravityResizeAspect;
    _playerController.delegate = self;
    _playerController.allowsPictureInPicturePlayback = true;    //画中画，iPad可用
    _playerController.showsPlaybackControls = true;
    
    [self addChildViewController:_playerController];
    _playerController.view.translatesAutoresizingMaskIntoConstraints = true;    //AVPlayerViewController 内部可能是用约束写的，这句可以禁用自动约束，消除报错
    _playerController.view.frame = self.view.bounds;
    [self.view addSubview:_playerController.view];
    
    [_playerController.player play];    //自动播放
}


#pragma mark - AVPlayerViewControllerDelegate
- (void)playerViewControllerWillStartPictureInPicture:(AVPlayerViewController *)playerViewController {
    NSLog(@"%s", __FUNCTION__);
}

- (void)playerViewControllerDidStartPictureInPicture:(AVPlayerViewController *)playerViewController {
    NSLog(@"%s", __FUNCTION__);
}

- (void)playerViewController:(AVPlayerViewController *)playerViewController failedToStartPictureInPictureWithError:(NSError *)error {
    NSLog(@"%s", __FUNCTION__);
}

- (void)playerViewControllerWillStopPictureInPicture:(AVPlayerViewController *)playerViewController {
    NSLog(@"%s", __FUNCTION__);
}

- (void)playerViewControllerDidStopPictureInPicture:(AVPlayerViewController *)playerViewController {
    NSLog(@"%s", __FUNCTION__);
}

- (BOOL)playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart:(AVPlayerViewController *)playerViewController {
    NSLog(@"%s", __FUNCTION__);
    return true;
}

- (void)playerViewController:(AVPlayerViewController *)playerViewController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL))completionHandler {
    NSLog(@"%s", __FUNCTION__);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
