//
//  MusicPlayViewController.m
//  LoveLife
//
//  Created by qianfeng on 16/1/5.
//  Copyright © 2016年 yangyang. All rights reserved.
//

#import "MusicPlayViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface MusicPlayViewController ()<AVAudioPlayerDelegate>
{
    //指示条
    UISlider *slider;
    AVAudioPlayer *_player;
    NSTimer *timer;
}

@end

@implementation MusicPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@""]];
    [self creatUI];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(sliderchanged) userInfo:nil repeats:YES];
    //设置后台播放模式
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    //进入后台保持活跃
    [audioSession setActive:YES error:nil];
    
    //拔出耳机暂停播放，通过观察者监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(isHasMoved:) name:AVAudioSessionRouteChangeNotification object:nil];
    
}
#pragma mark_监听耳机是否拔出
- (void)isHasMoved:(NSNotification *)info
{
    NSDictionary *dic = info.userInfo;
    int changeReason= [dic[AVAudioSessionRouteChangeReasonKey] intValue];
    if (changeReason==AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
        AVAudioSessionRouteDescription *routeDescription=dic[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription *portDescription= [routeDescription.outputs firstObject];
        //原设备为耳机则暂停
        if ([portDescription.portType isEqualToString:@"Headphones"]) {
            if ([_player isPlaying])
            {
                [_player pause];
                timer.fireDate=[NSDate distantFuture];
            }
        }
    }

}

- (void)creatUI
{
    //返回按钮
    UIButton *backbutton = [FactoryUI createButtonWithFrame:CGRectMake(10, 10, 30, 3) title:nil titleColor:nil imageName:nil backgroundImageName:nil target:nil selector:@selector(fanhui)];
    [self.view addSubview:backbutton];
    //标题
    UILabel *titlelable = [FactoryUI createLabelWithFrame:CGRectMake(0, 40, SCREEN_W-20, 30) text:nil textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:16]];
    titlelable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titlelable];
    //图片
    UIImageView *imageview = [FactoryUI createImageViewWithFrame:CGRectMake(10, CGRectGetMaxY(titlelable.frame)+5, 200, 200) imageName:nil];
    [imageview sd_setImageWithURL:[NSURL URLWithString:@""]];
    [self.view addSubview:imageview];
    slider = [[UISlider alloc]initWithFrame:CGRectMake(10, imageview.frame.size.width+10, SCREEN_W-20, 20)];
    [slider setValue:0.0];
    slider.backgroundColor = [UIColor whiteColor];
    slider.tintColor = [UIColor greenColor];
    [slider addTarget:self action:@selector(changeOption) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    //创建按钮
    NSArray *arr = @[@"上一首",@"开始",@"下一首"];
}
#pragma mark - 定时器监测slider的value
- (void)sliderchanged
{
    slider.value = _player.currentTime / _player.duration;
}
- (void)changeOption
{
    _player.currentTime = _player.duration * slider.value;
}
//创建音乐播放器
- (void)creatPlay
{
    //nsurl创建,播放本地的音频URL
    //_player = [AVAudioPlayer alloc]initWithContentsOfURL:<#(nonnull NSURL *)#> error:<#(NSError * _Nullable __autoreleasing * _Nullable)#>
    
    //用NSData创建
    _player = [[AVAudioPlayer alloc]initWithData:[NSData dataWithContentsOfFile:[NSURL URLWithString:@""]] error:nil];
    _player.delegate = self;
    _player.volume = 0.5;//0~1之间
    //设置当前播放的进度
    _player.currentTime = 0;
    //设置循环的次数
    _player.numberOfLoops = -1;//负数表示为无线循环播放，0表示只播放一次，正数是几就播放几次；
    //只读属性
    //_player.isPlaying = YES;//表示是否正在播放
    //_player.numberOfChannels 表示声道数
    //_player.duration  表示持续时间
    
    //暂停播放
    [_player pause];
    
    //预播放，将播放资源添加到播放器中，播放器分配自己的播放队列
    [_player prepareToPlay];
    
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"对音频文件解码错误");
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag) {
        //说明音频文件是正常播放
    }else{
        //音频文件虽然播放完毕，但是数据解吗错误
    }
}
//ios8之后废弃掉
//开始被中断的,如来电等
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    
}
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player
{
    
}
- (void)fanhui
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
