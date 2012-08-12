//
//  Utils.h
//  CutYourWord
//
//  Created by Brian Lin on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject
{
    NSMutableDictionary* wordList_;
}

@property (nonatomic, retain) NSMutableDictionary* wordList;

-(id) init;

-(BOOL) doesWordExists:(NSString*) word;
-(NSMutableArray*) generateRandomLetters:(int) amount;
-(NSMutableArray*) generateRandomCurves:(int) amount;
-(NSMutableArray*) generateUniformLetters:(int) amount;
-(NSMutableArray*) generateUniformCurves:(int) amount;
-(NSString*) getLetter:(int)num;
@end
