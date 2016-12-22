//
//  ViewController.m
//  rsaaaa
//
//  Created by XiaDian on 16/5/5.
//  Copyright © 2016年 vdchina. All rights reserved.
//

#import "ViewController.h"
#import "RSAEncryptor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RSAEncryptor *manager=[RSAEncryptor shareManager];
    NSString* restrinBASE64STRING = [manager rsaEncryptString:@"ssss"];
    NSLog(@"Encrypted: %@", restrinBASE64STRING);
    // 请把这段字符串Copy到JAVA这边main()里做测试
   // NSString *deString=[manager rsaDecryptString:restrinBASE64STRING];
   // NSLog(@"解密%@",deString);
    NSString* decryptString = [manager rsaDecryptString: @"d2RdCELC5Xbu7vTnNjEEj8x6UiRzmNGQjfwQA2OVH6qGmTJ5V1mnlyPRpgD3JchT+Rp3bNtSFPxIHqaZKQRLdpkm8gY+yywGgpdiy8VQmtDrkhDkll7GcBXKEI6kFPqmOgcIXhiVLIEJcVa9hk1b5csMP/4Fhl8Hw22OmfkuoL8="];
    NSLog(@"Decrypted: %@", decryptString);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
