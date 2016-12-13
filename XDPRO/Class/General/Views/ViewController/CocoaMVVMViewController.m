//
//  CocoaMVVMViewController.m
//  XDiOSPRO
//
//  Created by XiaDian on 2016/11/25.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "CocoaMVVMViewController.h"
#import <WebKit/WebKit.h>
@interface CocoaMVVMViewController ()
@property(nonatomic,strong)UIButton *lefBtn;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)WKWebView *textField;
@end
@implementation CocoaMVVMViewController
- (void)viewDidLoad {
    [super viewDidLoad];
  //  [self test];
 //     [self test1];
 //   [self racSignalPass];
 //   [self racSignalOther];
    [self uppercaseString];
}
//uppercaseString use map
- (void)uppercaseString {
    
 //   RACSequence *sequence = [@[@"you", @"are", @"beautiful"] rac_sequence];
    
  //  RACSignal *signal =  sequence.signal;
    RACSignal *signal =[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"you"];
        [subscriber sendCompleted];
        return nil;
    }];
    RACSignal *capitalizedSignal = [signal map:^id(NSString * value) {
        return [value capitalizedString];
    }];
    [signal subscribeNext:^(NSString * x) {
        NSLog(@"signal --- %@", x);
    }];
    [capitalizedSignal subscribeNext:^(NSString * x) {
        NSLog(@"capitalizedSignal --- %@", x);
    }];
}
-(void)test{
    RACSignal *requestHot = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW,(int64_t)(1 * NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), ^{
                 [subscriber sendNext:@"获取最热商品"];
        });
        return nil;
    }];
    RACSignal *requestNew = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW,(int64_t)(5* NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"获取最新商品"];
        });
            return nil;
    }];
    [self rac_liftSelector:@selector(updateUI:data2:) withSignalsFromArray:@[requestHot,requestNew]];
}
// 只要两个请求都请求完成的时候才会调用
- (void)updateUI:(NSString *)data1 data2:(NSString *)data2
{
    NSLog(@"%@ %@",data1,data2);
}

-(void)test1{
        //信号过滤可以参考上面UIButton引用RAC的实例
        [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@(19)];
            [subscriber sendNext:@(12)];
            [subscriber sendNext:@(20)];
            [subscriber sendCompleted];
            
            return nil;
        }] filter:^BOOL(NSNumber *value) {
            
            if (value.integerValue < 18) {
                //18禁
                NSLog(@"RAC信号过滤------FBI Warning~");
            }
            return NO;
        }]
         subscribeNext:^(id x) {
             NSLog(@"RAC信号过滤------年龄：%@",x);
         }];
}
- (void)racSignalPass {
    [[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"老板向我扔过来一个Star"];
        return nil;
    }] flattenMap:^RACStream *(NSString *value) {
        NSLog(@"RAC信号传递------%@",value);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"我向老板扔回一块板砖"];
            return nil;
        }];
    }] flattenMap:^RACStream *(NSString *value) {
        NSLog(@"RAC信号传递------%@",value);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"我跟老板正面刚~,结果可想而知"];
            return nil;
        }];
    }] subscribeNext:^(id x) {
        NSLog(@"RAC信号传递------%@",x);
    }];
}
- (void)racSignalOther {
    //延迟
//    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [subscriber sendNext:@"RAC信号延迟-----等等我~等等我2秒"];
//        [subscriber sendCompleted];
//        return nil;
//    }] delay:2.0] subscribeNext:^(id x) {
//        NSLog(@"RAC信号延迟-----终于等到你~");
//    }];
    
    //定时任务，可以代替NSTimer,可以看到`RACScheduler`使用GCD实现的秒数
//    [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
//        NSLog(@"每小时吃一次药，不要放弃治疗");
//    }];

    
    //设置超时时间
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"hh"];
            [subscriber sendCompleted];
            return nil;
        }] delay:4] subscribeNext:^(id x) {
            NSLog(@"RAC设置超时时间------请求到数据:%@",x);
            [subscriber sendNext:[@"RAC设置超时时间------请求到数据:" stringByAppendingString:x]];
            [subscriber sendCompleted];
        }];

        return nil;
    }] timeout:3 onScheduler:[RACScheduler mainThreadScheduler]]
     subscribeNext:^(id x) {
         //在timeout规定时间之内接受到信号，才会执行订阅者的block
         //这这里3秒之内没有接受到信号，所有该次订阅已失效
         NSLog(@"请求到的数据:%@",x);
     }];
//
//    //设置retry次数，这部分可以和网络请求一起用
//    __block int retry_idx = 0;
//    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        if (retry_idx < 3) {
//            retry_idx++;
//            [subscriber sendError:nil];
//        }else {
//            [subscriber sendNext:@"success!"];
//            [subscriber sendCompleted];
//        }
//        return nil;
//    }] retry:3] subscribeNext:^(id x) {
//        NSLog(@"请求:%@",x);
//    }];
//    
//    //节流阀,throttle秒内只能通过1个消息
//    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [subscriber sendNext:@"6"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [subscriber sendNext:@"66"];
//        });
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [subscriber sendNext:@"666"];
//            [subscriber sendCompleted];
//        });
//        
//        return nil;
//    }] throttle:2] subscribeNext:^(id x) {
//        //throttle: N   N秒之内只能通过一个消息，所以@"66"是不会被发出的
//        NSLog(@"RAC_throttle------result = %@",x);
//    }];
//    
//    //条件控制
//    /**
//     解释：`takeUntil:(RACSignal *)signalTrigger` 只有当`signalTrigger`这个signal发出消息才会停止
//     */
//    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
//            //每秒发一个消息
//            [subscriber sendNext:@"RAC_Condition------吃饭中~"];
//        }];
//        return nil;
//    }] takeUntil:[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        //延迟3S发送一个消息，才会让前面的信号停止
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSLog(@"RAC_Condition------吃饱了~");
//            [subscriber sendNext:@"吃饱了"];
//        });
//        return nil;
//    }]] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
}
@end
