
// Import the interfaces
#import "GameScene.h"
#import "GameLayer.h"
#import "LetterObject.h"
#import "Utils.h"

@implementation GameScene

@synthesize currentLayer = curentLayer_;

+(id) scene
{
	CCScene *scene = [CCScene node];
	GameScene *layer = [GameScene node];
	[scene addChild: layer];
    
	return scene;
}

-(id) init
{
	if((self=[super init] )) {
        self.currentLayer = [GameLayer node];
        [self startGame];

	}
	return self;
}

-(void) startGame
{
    [self addChild:self.currentLayer];
    [self.currentLayer startGame];
}

- (void) dealloc
{
	[super dealloc];
}
@end
