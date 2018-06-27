//
//  RACBaseUseViewController.m
//  RAC
//
//  Created by shujucn on 11/03/2018.
//  Copyright © 2018 shuju. All rights reserved.
//

#import "RACBaseUseViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>


@interface RACBaseUseViewController ()

@end

@implementation RACBaseUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    [self creatSignal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatSignal {
  RACSignal *signal = [[[[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"hello 123456"];
        [subscriber sendCompleted];
        return nil;
    }] map:^id _Nullable(id  _Nullable value) {
      NSLog(@"--- map01 %@", value);
      return @"map value 001";
    }] map:^id _Nullable(id  _Nullable value) {
      NSLog(@"--- map02 %@", value);
      return @"map value 002";
    }] flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
      NSLog(@"--- flatten01 map %@", value);
      return [[RACSignal return:@"flatten map01 new value"] logCompleted];
    }] flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
      NSLog(@"--- flatten02 map %@", value);
      return [[RACSignal return:@"flatten map02 new value"] logCompleted];
    }];
  
  
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"--- RACBase: %@", x);
      NSLog(@"%@", signal.description);
    } completed:^{
        NSLog(@"--- RACBase: complete");
    }];
  
    //创建热信号
    RACSubject *subject = [RACSubject subject];
    [subject sendNext:@"Signal 1"];    //立即发送1
    NSLog(@"---Signal 1 sended");

    [[RACScheduler mainThreadScheduler] afterDelay:0.5 schedule:^{
        [subject sendNext:@"Signal 2"];      //0.5秒后发送2
        NSLog(@"---Signal 2 sended");
    }];
    [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
        [subject sendNext:@"Signal 3"];     //2秒后发送3
        NSLog(@"---Signal 3 sended");
    }];
    [[RACScheduler mainThreadScheduler] afterDelay:0.1 schedule:^{
        [subject subscribeNext:^(id x) {
            NSLog(@"subject1接收到了%@",x);    //0.1秒后subject1订阅了
        }];
    }];
    [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
        [subject subscribeNext:^(id x) {
            NSLog(@"subject2接收到了%@",x);        //1秒后subject2订阅了
        }];
    }];
}


-(void)mapFlattenMap {
  RACSignal *signal = [[[[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
    [subscriber sendNext:@"hello 123456"];
    [subscriber sendCompleted];
    return nil;
  }] map:^id _Nullable(id  _Nullable value) {
    NSLog(@"--- map01 %@", value);
    return @"map value 001";
  }] map:^id _Nullable(id  _Nullable value) {
    NSLog(@"--- map02 %@", value);
    return @"map value 002";
  }] flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
    NSLog(@"--- flatten01 map %@", value);
    return [[RACSignal return:@"flatten map01 new value"] logCompleted];
  }] flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
    NSLog(@"--- flatten02 map %@", value);
    return [[RACSignal return:@"flatten map02 new value"] logCompleted];
  }];
  
  
  [signal subscribeNext:^(id  _Nullable x) {
    NSLog(@"--- RACBase: %@", x);
    NSLog(@"%@", signal.description);
  } completed:^{
    NSLog(@"--- RACBase: complete");
  }];
}


@end
