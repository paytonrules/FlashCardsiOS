#import <Foundation/Foundation.h>

#include "CardInfo.h"

CardInfo *createCard(NSString *name, NSString *reading, int x, int y)
{
  CardInfo *info = malloc(sizeof(CardInfo));
  info->spriteName = name;
  info->reading = reading;
  info->location = CGPointMake(x, y);
  return info;
}