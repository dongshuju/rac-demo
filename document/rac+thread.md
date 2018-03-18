
#### Delivering Signal on main thread

```
// Way 1:
RACSignal *zoomSignal = [RACObserve(self, zoom) distinctUntilChanged];
RAC(self, rulerView.tickFrequency) = [[zoomSignal map:^NSNumber *(NSNumber *zoom) {
return @(4.f * zoom.floatValue);
}] deliverOn:[RACScheduler mainThreadScheduler]];

// Way 2:
Signal *zoomSignal = [RACObserve(self, zoom) distinctUntilChanged];
RAC(self, rulerView.tickFrequency) = [[zoomSignal map:^NSNumber *(NSNumber *zoom) {
return @(4.f * zoom.floatValue);
}] deliverOnMainThread];

```




