//
//  GameParameters.h
//  CutYourWord
//
//  Created by Brian Lin on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameParameters : NSObject{
    NSDictionary *curves_;
    NSDictionary *letterSpawnPercentage_;
    NSDictionary * letterPoints_;
    
}

@property (nonatomic, retain) NSDictionary * curves;
@property (nonatomic, retain) NSDictionary * letterSpawnPercentage;
@property (nonatomic, retain) NSDictionary *  letterPoints;
-(NSArray*) getCurveAtIndex:(int) index;
-(float) getSpawnPercentageTimesHundredFor:(NSString *) letter;
-(NSString *) getPointsFor:(NSString *) letter;
-(int) getNumberOfCurves;

+(GameParameters *)sharedGameParameters;

@end
