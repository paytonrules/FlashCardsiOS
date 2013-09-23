#import <Foundation/Foundation.h>

@protocol CardLookup <NSObject>

-(CGPoint) locationByName:(NSString *)name;
-(NSArray *) allCards;
@end
