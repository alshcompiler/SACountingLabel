//
//  SACountingLabel.h
//  Virtuocity
//
//  Created by Mostafa Karam on 1/22/17.
//  Copyright © 2017 Mostafa Karam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SACountingLabel : UILabel

typedef enum {
    linear,
    easeIn,
    easeOut,
    easeInOut
} AnimationType;

typedef enum {
    Int,
    Float,
    Custom
} CountingType;

@property float kCounterRate,start,end;
@property enum CountingType;
@property (strong,nonatomic) NSTimer* timer;
@property  NSTimeInterval progress;
@property  NSTimeInterval lastUpdate;
@property  NSTimeInterval duration;
@property (strong,nonatomic)NSString* format;
@property  AnimationType animationType;
@property  CountingType countingType;
- (float)currentValue;
-(void) countFrom : (float)fromValue to : (float) toValue withDuration : (CFTimeInterval) duration andAnimationType : (AnimationType) aType andCountingType : (CountingType) cType;


@end
