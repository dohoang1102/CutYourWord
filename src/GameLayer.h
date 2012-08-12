#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCBlade.h"
#import "Utils.h"
#import "FRCurve.h"
#import "FRLines.h"
#import "FRCurveActions.h"
#import "ScoreLabel.h"

@interface GameLayer : CCLayer {
    CFMutableDictionaryRef map;
    //needs to be in GameState
    NSMutableArray* currentWord_;
    NSMutableArray* curves_;
    NSMutableArray* letters_;
    /////////////////////////////
    int curveLetterPosition_;
    CGPoint start_, end_, controlPoint1_, controlPoint2_;
    Utils* util_;
    CCProgressTimer* timer_;
    CCSprite* timer2_;
    CCLabelTTF* timeLabel_;
    //needs to be in GameState
    ccTime totalTime_;
    ////////////////////
    CCSprite* labelBackground_;
    CCSprite* labelBackground2_;
    CCLabelTTF* discoveredWord_;
    CCLabelTTF* discoveredPts_;
    ScoreLabel* score_;
    //needs to be in GameState
    int scoreValue_;
    CCLabelTTF* gameOver_;
    float pitch_;
    //needs to be in GameState
    NSMutableDictionary *wordsUsed_;
    ////////////////////
}
@property (nonatomic, retain) NSMutableDictionary* wordUsed;
@property (nonatomic, retain) CCSprite* labelBackground2;
@property (nonatomic, retain) CCLabelTTF* discoveredWord;
@property (nonatomic, retain) CCLabelTTF* discoveredPts;
@property (nonatomic, retain) ScoreLabel* score;
@property (nonatomic, retain) CCLabelTTF* gameOver;
@property (nonatomic, retain) CCLabelTTF* timeLabel;
@property (nonatomic, retain) CCSprite* timer2;
@property (nonatomic, retain) CCSprite* labelBackground;
@property (nonatomic, retain) CCProgressTimer* timer;
@property (nonatomic, assign) int curveLetterPosition;
@property (nonatomic, assign) int scoreValue;
@property (nonatomic, assign) float pitch;
@property (nonatomic, assign) ccTime totalTime;
@property (nonatomic, retain) NSMutableArray* curves;
@property (nonatomic, retain) NSMutableArray* letters;
@property (nonatomic, retain) NSMutableArray* currentWord;
@property (nonatomic, retain)  Utils* util;

-(void) detectLetterAndAddToWord:(UITouch*)touch;
-(BOOL) isTouchNotInPreviousRects:(UITouch*)touch;
-(void) addLetter:(NSString *)letter withCurveIndex:(int)curve withDuration:(float)duration;
-(void) startGame;
-(void) addNextLetterWithCurveCallBack;
@end


