//
//  GameParameters.m
//  CutYourWord
//
//  Created by Brian Lin on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameParameters.h"

@implementation GameParameters
@synthesize curves = curves_;
@synthesize letterSpawnPercentage = letterSpawnPercentage_;
@synthesize letterPoints = letterPoints_;
- (id)init
{
    self = [super init];
    if (self) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"initialGameParameters" ofType:@"plist"];
        NSDictionary *gameplayDict = [NSDictionary dictionaryWithContentsOfFile:path];
        NSDictionary *gameplayParameters = [gameplayDict valueForKey:@"initialGameParameters"];
        self.curves = [gameplayParameters valueForKey:@"curves"];
        self.letterSpawnPercentage = [gameplayParameters valueForKey:@"letterSpawnPercentage"];
        self.letterPoints = [gameplayParameters valueForKey:@"letterPoints"];

    }
    
    return self;
}
-(float) getSpawnPercentageTimesHundredFor:(NSString *) letter
{
    NSString* percentage = [self.letterSpawnPercentage objectForKey:letter];
    return [percentage floatValue] * 100;
}
-(NSString *) getPointsFor:(NSString *) letter
{
    NSString* percentage = [self.letterPoints objectForKey:letter];
    return percentage;
}

-(NSArray*) getCurveAtIndex:(int)index
{
    NSDictionary* curveAtIndex = [self.curves valueForKey:[NSString stringWithFormat:@"%d",index]];
    
    NSArray *curveItem1 = [[curveAtIndex valueForKey:@"0"] componentsSeparatedByString:@","];
    CGPoint points1 = ccp([[curveItem1 objectAtIndex:0] intValue],[[curveItem1 objectAtIndex:1] intValue]);
    
    NSArray *curveItem2 = [[curveAtIndex valueForKey:@"1"] componentsSeparatedByString:@","];
    CGPoint points2 = ccp([[curveItem2 objectAtIndex:0] intValue],[[curveItem2 objectAtIndex:1] intValue]);
    
    NSArray *curveItem3 = [[curveAtIndex valueForKey:@"2"] componentsSeparatedByString:@","];
    CGPoint points3 = ccp([[curveItem3 objectAtIndex:0] intValue],[[curveItem3 objectAtIndex:1] intValue]);
    
    NSArray *curveItem4 = [[curveAtIndex valueForKey:@"3"] componentsSeparatedByString:@","];
    CGPoint points4 = ccp([[curveItem4 objectAtIndex:0] intValue],[[curveItem4 objectAtIndex:1] intValue]);
    

    return [NSArray arrayWithObjects:[NSValue valueWithCGPoint:points1],[NSValue valueWithCGPoint:points2],[NSValue valueWithCGPoint:points3],[NSValue valueWithCGPoint:points4],nil];
}

-(int) getNumberOfCurves
{
    NSLog(@"num of curves %d",[self.curves count]);
    return [self.curves count];
}

#pragma mark - singleton code
static GameParameters* sharedGameParameters_ = nil;

+(GameParameters*) sharedGameParameters
{
	if (!sharedGameParameters_) 
    {
        sharedGameParameters_ = [[self alloc] init];
	}
    
	return sharedGameParameters_;
}
@end
