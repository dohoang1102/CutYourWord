//
//  Utils.m
//  CutYourWord
//
//  Created by Brian Lin on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"
#import "DDFileReader.h"
#import "GameParameters.h"

#define number_of_curves 4

@implementation Utils

@synthesize wordList = wordList_;

-(id) init
{
    self = [super init];
    if(self)
    {
        self.wordList =[[NSMutableDictionary alloc] init];
        NSString* path = [[NSBundle mainBundle] pathForResource:@"wordlist" ofType:@"txt"];
        DDFileReader * reader = [[DDFileReader alloc] initWithFilePath:path];
        [reader enumerateLinesUsingBlock:^(NSString * line, BOOL * stop) {
            NSString *trimmedString = [line stringByTrimmingCharactersInSet:
                                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [self.wordList setObject:[NSNumber numberWithInt:1] forKey:trimmedString];
        }];
        [reader release];


        
    }
    return self;
}

-(BOOL) doesWordExists:(NSString *)word
{
    if([self.wordList objectForKey:word]){
        return YES;
    }
    else {
        return NO;
    }
}

-(NSString*) getLetter:(int)num
{
    if(num==0)
    {
        return @"a";
    }
    else if(num==1)
    {
        return @"b";
    }
    else if(num==2)
    {
        return @"c";
    }
    else if(num==3)
    {
        return @"d";
    }
    else if(num==4)
    {
        return @"e";
    }
    else if(num==5)
    {
        return @"f";
    }
    else if(num==6)
    {
        return @"g";
    }
    else if(num==7)
    {
        return @"h";
    }
    else if(num==8)
    {
        return @"i";
    }
    else if(num==9)
    {
        return @"j";
    }
    else if(num==10)
    {
        return @"k";
    }
    else if(num==11)
    {
        return @"l";
    }
    else if(num==12)
    {
        return @"m";
    }
    else if(num==13)
    {
        return @"n";
    }
    else if(num==14)
    {
        return @"o";
    }
    else if(num==15)
    {
        return @"p";
    }
    else if(num==16)
    {
        return @"q";
    }
    else if(num==17)
    {
        return @"r";
    }
    else if(num==18)
    {
        return @"s";
    }
    else if(num==19)
    {
        return @"t";
    }
    else if(num==20)
    {
        return @"u";
    }
    else if(num==21)
    {
        return @"v";
    }
    else if(num==22)
    {
        return @"w";
    }
    else if(num==23)
    {
        return @"x";
    }
    else if(num==24)
    {
        return @"y";
    }
    else if(num==25)
    {
        return @"z";
    }
    
    return @"ERROR";
}

-(NSMutableArray*) generateRandomLetters:(int) amount
{
    NSMutableArray* letters = [[[NSMutableArray alloc] init] autorelease];
    float a =  [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"a"];
    float b = a + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"b"];
    float c = b + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"c"];
    float d = c + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"d"];
    float e = d + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"e"];
    float f = e + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"f"];
    float g = f + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"g"];
    float h = g + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"h"];
    float i = h + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"i"];
    float j = i + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"j"];
    float k = j + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"k"];
    float l = k + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"l"];
    float m = l + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"m"];
    float n = m + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"n"];
    float o = n + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"o"];
    float p = o + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"p"];
    float q = p + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"q"];
    float r = q + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"r"];
    float s = r + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"s"];
    float t = s + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"t"];
    float u = t + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"u"];
    float v = u + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"v"];
    float w = v + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"w"];
    float x = w + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"x"];
    float y = x + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"y"];
    //float z = y + [[GameParameters sharedGameParameters] getSpawnPercentageTimesHundredFor:@"z"];
    
    NSString* randLetter = @"";
    
    for (int x=0; x<amount; x++) {
        int num = arc4random()%10000;
        NSLog(@"num = %d",num);
        if(num < a){
            randLetter = @"a";
        }
        else if(num < b){
            randLetter = @"b";
        }
        else if(num < c){
            randLetter = @"c";
        }
        else if(num < d){
            randLetter = @"d";
        }
        else if(num < e){
            randLetter = @"e";
        }
        else if(num < f){
            randLetter = @"f";
        }
        else if(num < g){
            randLetter = @"g";
        }
        else if(num < h){
            randLetter = @"h";
        }
        else if(num < i){
            randLetter = @"i";
        }
        else if(num < j){
            randLetter = @"j";
        }
        else if(num < k){
            randLetter = @"k";
        }
        else if(num < l){
            randLetter = @"l";
        }
        else if(num < m){
            randLetter = @"m";
        }
        else if(num < n){
            randLetter = @"n";
        }
        else if(num < o){
            randLetter = @"o";
        }
        else if(num < p){
            randLetter = @"p";
        }
        else if(num < q){
            randLetter = @"q";
        }
        else if(num < r){
            randLetter = @"r";
        }
        else if(num < s){
            randLetter = @"s";
        }
        else if(num < t){
            randLetter = @"t";
        }
        else if(num < u){
            randLetter = @"u";
        }
        else if(num < v){
            randLetter = @"v";
        }
        else if(num < w){
            randLetter = @"w";
        }
        else if(num < x){
            randLetter = @"x";
        }
        else if(num < y){
            randLetter = @"y";
        }
        else{
            randLetter = @"z";
        }
        
        [letters addObject:randLetter];
    }
    return letters;
}
-(NSMutableArray*) generateRandomCurves:(int) amount
{
    NSMutableArray* curves = [[[NSMutableArray alloc] init] autorelease];
    for (int x=0; x<amount; x++) {
        int index = arc4random()%[[GameParameters sharedGameParameters] getNumberOfCurves];
        [curves addObject:[NSNumber numberWithInt:index]];
    }
    return curves;
}

-(NSMutableArray*) generateUniformLetters:(int) amount
{
    NSMutableArray* letters = [[[NSMutableArray alloc] init] autorelease];
    for (int x=0; x<amount; x++) {
        int num = arc4random()%26;
        [letters addObject:[self getLetter:num]];
    }
    return letters;
}
-(NSMutableArray*) generateUniformCurves:(int) amount
{
    int index = 0;
    NSMutableArray* curves = [[[NSMutableArray alloc] init] autorelease];
    for (int x=0; x<amount; x++) {
        if(index == number_of_curves)
        {
            index = 0;
        }
        [curves addObject:[NSNumber numberWithInt:index]];
        index++;
    }
    return curves;
}

@end
