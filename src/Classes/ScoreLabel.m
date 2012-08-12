//
//  ScoreLabel.m
//  CutYourWord
//
//  Created by Brian Lin on 4/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ScoreLabel.h"
#import "SimpleAudioEngine.h"

@implementation ScoreLabel

@synthesize score, formatString, pointsPerSecond;
@synthesize  pitch = pitch_;

+(id) scoreLabelWithFormatString:(NSString*)formatString score:(int)score dimensions:(CGSize)dimensions alignment:(CCTextAlignment)alignment fontName:(NSString*)name fontSize:(CGFloat)size {
    ScoreLabel * l;
    if ( (l=[[[super alloc] initWithString:[NSString stringWithFormat:formatString, score] dimensions:dimensions alignment:alignment fontName:name fontSize:size] autorelease]) ) {
        [l setup_:score formatString:formatString];
    }
    return l;
}

-(void) setup_:(int)score formatString:(NSString*)formatString {
    
    self.score = score;
    self.formatString = formatString;
    self.pointsPerSecond = 100;
    self.pitch = .5;
    curScore_ = score;
    interval_ = 0.05;
    updating_ = FALSE;
}

-(void) rollToScore:(int)newScore {
    self.score = newScore;
    if (!updating_) {
        updating_ = TRUE;
        [self schedule:@selector(update_:) interval:interval_];
    }
}

-(void) update_:(ccTime)dt {
    int direction = 1; 
    if (self.score < curScore_) {
        direction = -1;
    }
    double pointChange = self.pointsPerSecond * direction * dt;
    curScore_ += pointChange;
    
    if (direction == -1 && curScore_ < self.score) {
        curScore_ = self.score;
    } else if (direction == 1 && curScore_ > self.score) {
        curScore_ = self.score;
    }
    
    [self setString:[NSString stringWithFormat:self.formatString, (int)curScore_]];
    
    if (self.score == curScore_) {
        [self unschedule:@selector(update_:)];
        updating_ = FALSE;
        self.pitch = .5;
    }
    else
    {
        if(self.pitch < 1.5)
        {
            [[SimpleAudioEngine sharedEngine] playEffect:@"ding.wav" pitch:self.pitch pan:0 gain:1];
            self.pitch = self.pitch + .1;
        }
        
    }
}



-(void) dealloc {
    if (updating_) {
        [self unschedule:@selector(update_:)];
    }
    
    [self.formatString release];
    
    [super dealloc];
}

@end