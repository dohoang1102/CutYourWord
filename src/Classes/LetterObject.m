//
//  LetterObject.m
//  CutYourWord
//
//  Created by Brian Lin on 3/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LetterObject.h"
#import "GameParameters.h"

@implementation LetterObject

@synthesize letterSprite = letterSprite_;
@synthesize letter = letter_;
@synthesize points = points_;
@synthesize wordsUsedIn = wordsUsedIn_;
-(void) dealloc
{
    self.letterSprite = nil;
    self.letter = nil;
    self.points = nil;
    [super dealloc];
}

-(id) initWithLetter:(NSString *)l
{
    
    self = [super init];
    if(self)
    {
        if([l isEqualToString:@"a"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"a.png"];
        }
        else if([l isEqualToString:@"b"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"b.png"];
        }
        else if([l isEqualToString:@"c"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"c.png"];
        }
        else if([l isEqualToString:@"d"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"d.png"];
        }
        else if([l isEqualToString:@"e"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"e.png"];
        }
        else if([l isEqualToString:@"f"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"f.png"];
        }
        else if([l isEqualToString:@"g"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"g.png"];
        }
        else if([l isEqualToString:@"h"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"h.png"];
        }
        else if([l isEqualToString:@"i"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"i.png"];
        }
        else if([l isEqualToString:@"j"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"j.png"];
        }
        else if([l isEqualToString:@"k"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"k.png"];
        }
        else if([l isEqualToString:@"l"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"l.png"];
        }
        else if([l isEqualToString:@"m"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"m.png"];
        }
        else if([l isEqualToString:@"n"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"n.png"];
        }
        else if([l isEqualToString:@"o"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"o.png"];
        }
        else if([l isEqualToString:@"p"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"p.png"];
        }
        else if([l isEqualToString:@"q"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"q.png"];
        }
        else if([l isEqualToString:@"r"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"r.png"];
        }
        else if([l isEqualToString:@"s"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"s.png"];
        }
        else if([l isEqualToString:@"t"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"t.png"];
        }
        else if([l isEqualToString:@"u"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"u.png"];
        }
        else if([l isEqualToString:@"v"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"v.png"];
        }
        else if([l isEqualToString:@"w"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"w.png"];
        }
        else if([l isEqualToString:@"x"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"x.png"];
        }
        else if([l isEqualToString:@"y"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"y.png"];
        }
        else if([l isEqualToString:@"z"])
        {
            self.letterSprite = [CCSprite spriteWithFile:@"z.png"];
        }
        self.points = [[GameParameters sharedGameParameters] getPointsFor:l] ;
        self.letter = l;
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:self.points fontName:@"Arial" fontSize:14];
      
        [self addChild:self.letterSprite];
        [self addChild:label];

        label.position = ccp(label.position.x+15,label.position.y-15);

    }
    
    return self;
}

-(BOOL) containsTouchLocation:(UITouch *)touch;
{
    CGPoint tapLocation = [self convertTouchToNodeSpace: touch];
    CGRect spriteRect = self.letterSprite.boundingBox;    
    return CGRectContainsPoint(spriteRect, tapLocation);

}


@end
