
### RAC observe property：

```
      RAC(self, selfIntroduction) = RACObserve(user, userDescription);
```

### RAC observe multiple properties
* If userName and password changed, will call flattenMap block;
* if both userName and password changed, will combine two changes as one, only call flattenMap block once.


[[[RACSignal
combineLatest:@[ [RACObserve(self, userName) ignore:nil],
[RACObserve(self, password) ignore:nil] ]]
flattenMap:^(RACTuple *userNameAndPassword) {
RACTupleUnpack(NSString *userName, NSString *password) = userNameAndPassword;
return [self authenticateUserWithUserName:userName andPassword:password];
}]
deliverOn:RACScheduler.mainThreadScheduler]
subscribeError:^(NSError *error) {
// TODO: Propagate error
}];
```



* If merge RACObserve, any of userName and password changed, will call  flattenMap block.
* If both userName and password changed, will call block twice.

```
[[[RACSignal
           merge:@[RACObserve(self, userName),
                   RACObserve(self, password)]
            flattenMap:^(RACTuple *userNameAndPassword) {
                RACTupleUnpack(NSString *userName, NSString *password) = userNameAndPassword;
                return [self authenticateUserWithUserName:userName andPassword:password];
            }]
            deliverOn:RACScheduler.mainThreadScheduler]
            subscribeError:^(NSError *error) {
                // TODO: Propagate error
            }];
```

