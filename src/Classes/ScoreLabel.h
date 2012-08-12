//
//  ScoreLabel.h
//  CutYourWord
//
//  Created by Brian Lin on 4/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "ScoreLabel.h"


@interface ScoreLabel : CCLabelTTF {
    double curScore_;
    BOOL updating_;
    double interval_;
    float pitch_;
    int score;
    NSString * formatString;
    int pointsPerSecond; 
}
@property float pitch;
@property int score;
@property (nonatomic, retain) NSString * formatString;
@property int pointsPerSecond;

+(id) scoreLabelWithFormatString:(NSString*)formatString score:(int)score dimensions:(CGSize)dimensions alignment:(CCTextAlignment)alignment fontName:(NSString*)name fontSize:(CGFloat)size;

-(void) rollToScore:(int)newScore;

-(void) update_;
-(void) setup_:(int)score formatString:(NSString *)formatString;

@end