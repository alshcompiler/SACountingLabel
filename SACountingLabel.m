//
//  SACountingLabel.m
//  Virtuocity
//
//  Created by Mostafa Karam on 1/22/17.
//  Copyright © 2017 Mostafa Karam. All rights reserved.
//

#import "SACountingLabel.h"

@implementation SACountingLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(float) currentValue {
    if (_progress >= _duration) {
        return _end;
    }
    float percent = (float)(_progress / _duration);
    float update = [self updateCounter:percent];
    return _start + (update * (_end - _start));
}


-(float) updateCounter : (float) t {
    _kCounterRate = 3.0;
    switch (_animationType) {
    case linear:
            return t;
    case easeIn:
            return powf(t, _kCounterRate);
    case easeOut:
            return 1.0 - powf((1.0 - t), _kCounterRate);
    case easeInOut: {
        float sign = 1.0;
        int r = (int)_kCounterRate;
        if (r % 2 == 0) {
            sign = -1.0;
        }
        t *= 2;
        if (t < 1) {
            return 0.5 * powf(t, _kCounterRate);
        } else {
            return (float)(sign * 0.5) * (powf(t-2, _kCounterRate) + (float)(sign * 2));
        }
    }
        
        
    }
}
-(void) countFrom : (float)fromValue to : (float) toValue withDuration : (NSTimeInterval) duration andAnimationType : (AnimationType) aType andCountingType : (CountingType) cType {
    // Set values
    self.start = fromValue;
    self.end = toValue;
    self.duration = duration;
    self.countingType = cType;
    self.animationType = aType;
    self.progress = 0.0;
    self.lastUpdate = [NSDate timeIntervalSinceReferenceDate];
    
    // Invalidate and nullify timer
    [self killTimer];
    
    // Handle no animation
    if (duration == 0.0) {
        [self updateText : toValue];
        return;
    }
    
    // Create timer
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateValue) userInfo:nil repeats:true];
}


-(void) updateText : (float)value {
    switch (_countingType) {
        case Int: {
            self.text = [NSString stringWithFormat:@"%d",(int)value];
            return;
        }
        case Float: {
            self.text = [NSString stringWithFormat:@"%.2f",value];
            return;
        }
        case Custom:
            if (_format.length > 0) {
                self.text = [NSString stringWithFormat:@"%@%f",_format,value];
            } else {
                self.text = [NSString stringWithFormat:@"%.2f",value];
            }
                return;
        }
}

-(void) updateValue {
    
    // Update the progress
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    _progress = _progress + (now - _lastUpdate);
    _lastUpdate = now;
    
    // End when timer is up
    if (_progress >= _duration) {
        [self killTimer];
        _progress = _duration;
    }
    [self updateText: [self currentValue]];
}

-(void) killTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
