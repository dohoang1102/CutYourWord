//
//  LetterObject.h
//  CutYourWord
//
//  Created by Brian Lin on 3/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LetterObject : CCNode {
    CCSprite* letterSprite_;
    NSString* letter_;
    NSString* points_;
    int wordsUsedIn_;
}
@property int wordsUsedIn;
@property (nonatomic, retain) NSString* points;
@property (nonatomic, retain) NSString* letter;
@property (nonatomic, retain) CCSprite* letterSprite;

-(id) initWithLetter:(NSString*)l;
-(BOOL) containsTouchLocation:(UITouch *)touch;

@end
