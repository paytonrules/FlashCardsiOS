#import <Foundation/Foundation.h>

#include "CardInfo.h"

CardInfo *createCard(NSString *name, int x, int y)
{
  CardInfo *info = malloc(sizeof(CardInfo));
  info->spriteName = name;
  info->location = CGPointMake(x, y);
  return info;
}