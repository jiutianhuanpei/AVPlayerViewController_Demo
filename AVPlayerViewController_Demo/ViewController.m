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
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

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
    
    
    
    [self createBtn:@"Play" action:@selector(play) y:300];
    [self createBtn:@"Go in Player" action:@selector(goInToPlayerController) y:350];
    
    [self createBtn:@"Choose Location Video" action:@selector(pickerVideo) y:400];
    
}


- (UIButton *)createBtn:(NSString *)title action:(SEL)action y:(CGFloat)y {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    btn.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2., y);
    [self.view addSubview:btn];
    return btn;
}

- (void)play {
    [avView play];
}

- (void)goInToPlayerController {
//    SHBAVController *av = [[SHBAVController alloc] initWithUrl:videoUrl];
//    [self presentViewController:av animated:true completion:nil];

    [self goToPlayerWithUrl:[NSURL URLWithString:videoUrl]];
}

- (void)goToPlayerWithUrl:(NSURL *)url {
    SHBAVController *av = [[SHBAVController alloc] initWithUrl:url];
    [self presentViewController:av animated:true completion:nil];

}

- (void)pickerVideo {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;    // 读取照片库
//    picker.sourceType = UIImagePickerControllerSourceTypeCamera;          // 现录视频
    picker.mediaTypes = @[(NSString *)kUTTypeMovie];
    picker.delegate = self;
    [self presentViewController:picker animated:true completion:nil];
}

#pragma mark - <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    __weak typeof(self) SHB = self;
    [picker dismissViewControllerAnimated:true completion:^{
        if ([info[UIImagePickerControllerMediaType] isEqualToString:(NSString *)kUTTypeMovie]) {
            NSURL *url = info[UIImagePickerControllerMediaURL];
            
            [SHB goToPlayerWithUrl:url];
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
