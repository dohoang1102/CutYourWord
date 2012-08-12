
#import "cocos2d.h"
#import "GameLayer.h"

@interface GameScene : CCLayer
{
    NSString* label_;
    GameLayer* curentLayer_;
}

@property (nonatomic, retain) GameLayer* currentLayer;


-(void) startGame;
+(id) scene;

@end
