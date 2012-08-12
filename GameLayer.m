#import "GameLayer.h"
#import "LetterObject.h"
#import "Utils.h"
#import "SimpleAudioEngine.h"
#import "FRLines.h"
#import "FRCurve.h"
#import "GameParameters.h"
#import "ScoreLabel.h"

#define DEFAULT_TIME 20
#define DEFAULT_WORDS 500
@implementation GameLayer

@synthesize wordUsed = wordsUsed_;
@synthesize scoreValue = scoreValue_;
@synthesize timeLabel = timeLabel_;
@synthesize pitch = pitch_;
@synthesize currentWord = currentWord_;
@synthesize util = util_;
@synthesize timer = timer_;
@synthesize curveLetterPosition = curveLetterPosition_;
@synthesize curves= curves_;
@synthesize letters = letters_;
@synthesize timer2= timer2_;
@synthesize discoveredWord = discoveredWord_;
@synthesize discoveredPts = discoveredPts_;
@synthesize gameOver = gameOver_;
@synthesize score = score_;
@synthesize labelBackground = labelBackground_;
@synthesize labelBackground2 = labelBackground2_;
@synthesize totalTime = totalTime_;

-(NSMutableArray*) currentWord
{
    if(currentWord_ == nil)
    {
        currentWord_ = [[NSMutableArray alloc] init];
    }
    return currentWord_;
}

-(Utils*) util
{
    if(util_ == nil)
    {
        util_ = [[Utils alloc] init];
    }
    return util_;
}

- (id) init{
    
	if((self=[super init])) {
        
        CCLayerColor *background = [[CCLayerColor alloc] initWithColor:ccc4(128,128,128,255)];
        [self addChild:background];
        
        self.wordUsed = [[NSMutableDictionary alloc] init];
        self.pitch = .5;
        isTouchEnabled_ = 1;
        map = CFDictionaryCreateMutable(NULL,0,NULL,NULL);

        self.curves = [self.util generateUniformCurves:DEFAULT_WORDS];
        self.letters = [self.util generateRandomLetters:DEFAULT_WORDS];
        self. curveLetterPosition = 0;
        self.timer = [CCProgressTimer progressWithFile:@"bar.png"];
        self.timer.type = kCCProgressTimerTypeHorizontalBarRL;
        self.timer.percentage = 0;
        
        self.timeLabel =  [CCLabelTTF labelWithString:@"2:00" fontName:@"Arial" fontSize:12];
        [self addChild:self.timeLabel z:7];
        [self.timeLabel setPosition:ccp(160,52)];
        
        [self addChild:self.timer z:6];
        [self.timer setPosition:ccp(160, 52)];
        //[self scheduleUpdate];
        [self schedule:@selector(update:)];
        
        self.timer2 = [CCSprite spriteWithFile:@"bar2.png"];
        [self addChild:self.timer2 z:5];
        [self.timer2 setPosition:ccp(160,52)];
    

        CCLayerColor *discoveredBackground = [[CCLayerColor alloc] initWithColor:ccc4(1,36,59,255) width:[[CCDirector sharedDirector] winSize].width height:50];
        [self addChild:discoveredBackground z:3];
        self.discoveredWord = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:24];
        [self.discoveredWord setPosition:ccp(160,25)];
        [self addChild:self.discoveredWord z:4];
        
        self.discoveredPts = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:24];
        [self.discoveredPts setPosition:ccp(260,25)];
        [self addChild:self.discoveredPts z:4];
        
        CCLayerColor *scoreBackground = [[CCLayerColor alloc] initWithColor:ccc4(1,36,59,255) width:640 height:50];
        [self addChild:scoreBackground z:3];
        [scoreBackground setPosition:ccp(0,[[CCDirector sharedDirector] winSize].height-50)];
        self.score = [ScoreLabel scoreLabelWithFormatString:@"%i" score:0 dimensions:CGSizeMake(640, 50) alignment:UITextAlignmentCenter  fontName:@"Arial" fontSize:24];
        self.scoreValue = 0;
               
        [self.score setPosition:ccp([[CCDirector sharedDirector] winSize].width/2,[[CCDirector sharedDirector] winSize].height-25)];
        [self addChild:self.score z:4];
        
    
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:.35];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Show Your Moves.mp3"];
        
    }
	return self;
}

- (void) dealloc{
    self.currentWord = nil;
    self.util = nil;
    self.timer = nil;
    self.curves = nil;
    self.currentWord = nil;
    CFRelease(map);
    [super dealloc];
}

- (void) ccTouchesBegan:(NSSet *) touches withEvent:(UIEvent *) event{
    [self.currentWord removeAllObjects];
    [self.discoveredWord setString: @""];
    NSLog(@"TOUCH BEGAN");
    NSLog(@"Number of children = %d" ,[[self children] count]);
          
	for (UITouch *touch in touches) {
		CCBlade *w = [CCBlade bladeWithMaximumPoint:50];
  
		w.texture = [[CCTextureCache sharedTextureCache] addImage:@"streak1.png"];
        
        CFDictionaryAddValue(map,touch,w);
        
		[self addChild:w z:100];
		CGPoint pos = [touch locationInView:touch.view];
		pos = [[CCDirector sharedDirector] convertToGL:pos];
		[w push:pos];
	}
}

-(BOOL) isTouchNotInPreviousRects:(UITouch*)touch
{
    for(LetterObject* letObj in self.currentWord)
    {
        CGPoint tapLocation = [self convertTouchToNodeSpace: touch];
        if(CGRectContainsPoint(letObj.letterSprite.boundingBox, tapLocation))
        {
            return NO;
        }
    }
    return YES;
}

- (void) ccTouchesMoved:(NSSet *) touches withEvent:(UIEvent *) event{
    
	for (UITouch *touch in touches) 
    {
        if([self isTouchNotInPreviousRects:touch])
        {
            [self detectLetterAndAddToWord:touch];
        }
		CCBlade *w = (CCBlade *)CFDictionaryGetValue(map, touch);
		CGPoint pos = [touch locationInView:touch.view];
		pos = [[CCDirector sharedDirector] convertToGL:pos];
		[w push:pos];
	}
}

-(NSString *) getWordStringFormat
{
    NSString* word = @"";
    for(LetterObject* letObj in self.currentWord)
    {
        word = [word stringByAppendingString:letObj.letter];
    }
    return word;
}

- (void) ccTouchesEnded:(NSSet *) touches withEvent:(UIEvent *) event{
    
	for (UITouch *touch in touches) {
		CCBlade *w = (CCBlade *)CFDictionaryGetValue(map, touch);
		[w dim:YES];
        CFDictionaryRemoveValue(map,touch);
	}
    NSLog(@"TOUCH ENDED");
    self.pitch = 0.5;
    NSLog(@"FINAL_WORD %@", [self getWordStringFormat]);
    if([self.util doesWordExists:[self getWordStringFormat]])
    {
        //need to check if all letter objs have the same created word if they do, need to not add points and play a new sound. 

        NSLog(@"wordUsed %d ", [self.wordUsed count]);
        if([self.wordUsed objectForKey:self.discoveredWord.string]==nil ){
            NSLog(@"WORD EXISTS!!!!");
        
            [self.wordUsed setObject:@"1" forKey:self.discoveredWord.string];
            //NSLog(@"discovered string = %@", self.discoveredWord.string);
            //NSLog(@"wordUsed dict check %@", [self.wordUsed objectForKey:self.discoveredWord.string]);//[self.wordUsed addObject:self.discoveredWord.string];
            
            int totalWordPoints = 0;
            for (LetterObject* letObj in self.currentWord){
                totalWordPoints = totalWordPoints + [letObj.points intValue];
                letObj.wordsUsedIn+=1;
                
                
                if (letObj.wordsUsedIn > 1) {
                    [self removeChild:letObj cleanup:YES];
                }
                else {
                    CCSequence *action = [CCSequence actions:
                                          [CCEaseInOut actionWithAction:
                                           [CCScaleTo actionWithDuration:.8f scaleX: 0.95f scaleY: 0.95f] rate:1.0f], 
                                          [CCEaseInOut actionWithAction:
                                           [CCScaleTo actionWithDuration:.8f scaleX: 1.05f scaleY: 1.05f] rate:1.0f], 
                                          nil];
                    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:action];
                    [letObj.letterSprite runAction:repeat];
                }
            }
            self.scoreValue = self.scoreValue + totalWordPoints;
            [self.score rollToScore:self.scoreValue];
            
            self.discoveredPts.string = [NSString stringWithFormat:@"%+d",totalWordPoints];
        }
        else {
            //play a discovered before sound
            NSLog(@"discovered before");
        }
    }
    else {
        NSLog(@"DOES NOT EXISTS :(");
        if( [self.currentWord count] >0)
        {
            [[SimpleAudioEngine sharedEngine] playEffect:@"notice.mp3" pitch:1.5 pan:0 gain:1];
        }
    }
   
}

-(void) detectLetterAndAddToWord:(UITouch*)touch;
{
    for (LetterObject* letObj in [self children])
    {
        if([letObj isKindOfClass:[LetterObject class]])
        {
            if ([letObj containsTouchLocation:touch])
            {
                NSLog(@"************TOUCHING ME************");
                if(![self.currentWord containsObject:letObj])
                {
                    
                    NSLog(@"added letter %@",letObj.letter);
                    [self.currentWord addObject:letObj];
                    [self.discoveredWord setString: [[self.discoveredWord.string stringByAppendingString: letObj.letter] uppercaseString]];
                    [[SimpleAudioEngine sharedEngine] setEffectsVolume:1];
              
                    NSLog(@"pitch %f", self.pitch);
                    [[SimpleAudioEngine sharedEngine] playEffect:@"Plopp!.mp3" pitch:self.pitch pan:0 gain:1];
                    if(!(self.pitch >=1.78)){
                        self.pitch = self.pitch + .16;
                    }
                    self.discoveredPts.string = @"";
       
                }
            }
     
        }
    }
}

-(void) onEnter
{
    
    [super onEnter];

}

-(void) addLetter:(NSString *)letter withCurveIndex:(int)curve withDuration:(float)duration
{
    //// curve logic
    NSArray *curvePoints = [[GameParameters sharedGameParameters] getCurveAtIndex:curve];
    FRCurve* frcurve_ = [[FRCurve curveFromType:kFRCurveLagrange order:kFRCurveCubic segments:64] retain];
    //[frcurve_ setWidth:-1];
    [frcurve_ setShowControlPoints:NO];
    [self addChild:frcurve_];
    start_ = [[curvePoints objectAtIndex:0] CGPointValue];
    controlPoint1_ = [[curvePoints objectAtIndex:1] CGPointValue];
    controlPoint2_ = [[curvePoints objectAtIndex:2] CGPointValue];
    end_ = [[curvePoints objectAtIndex:3] CGPointValue];
	[frcurve_ setType:kFRCurveLagrange];
	[frcurve_ setOrder:kFRCurveCubic];
	[frcurve_ setPoint:start_ atIndex:0];
    [frcurve_ setPoint:controlPoint1_ atIndex:1];
	[frcurve_ setPoint:controlPoint2_ atIndex:2];
	[frcurve_ setPoint:end_ atIndex:3];
	[frcurve_ setWidth:0];
	frcurve_.curve->widthFunc = &ccpCurveWidthStandard;
	[frcurve_ invalidate];
    /// adding letter
    
    
    LetterObject *letterObj = [[LetterObject alloc] initWithLetter:letter];
    letterObj.position = start_;
    [self addChild:letterObj z:1];
    
    ccBezierConfig config = (ccBezierConfig){[frcurve_ pointAtIndex:3], [frcurve_ pointAtIndex:1], [frcurve_ pointAtIndex:2]};
   
    CCAction *action = [FRActionLagrangeTo actionWithDuration:duration lagrange:config];
    
    [letterObj runAction:action];
 
}

-(void) startGame
{
    CCFiniteTimeAction* action = [CCSequence actions:
                        [CCCallFunc actionWithTarget:self selector:@selector(addNextLetterWithCurveCallBack)],
                        [CCDelayTime actionWithDuration:3.5],
                        nil];
    
    [self runAction:[CCRepeat actionWithAction:action times:-1]];
}

-(void) addNextLetterWithCurveCallBack
{
    if(self.curveLetterPosition<DEFAULT_WORDS-4)
    {
        for (int x =0; x<4; x++) {
            [self addLetter:[self.letters objectAtIndex:self.curveLetterPosition] withCurveIndex:[[self.curves objectAtIndex:self.curveLetterPosition] intValue] withDuration:DEFAULT_TIME];
            self.curveLetterPosition+=1;
        }
    }
}

-(void)update:(ccTime)dt
{

    self.totalTime += dt;
    int currentTime = (120-self.totalTime);
    self.timeLabel.string = [NSString stringWithFormat:@"%2d:%02d", currentTime/60, currentTime%60];
    self.timer.percentage = (self.totalTime/120)*100;
    if (self.timer.percentage >= 100)
    {
        self.timer.percentage = 0;
  
    }
    
    
}
@end



