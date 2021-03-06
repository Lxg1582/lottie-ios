//
//  LAMaskLayer.m
//  LottieAnimator
//
//  Created by brandon_withrow on 7/22/16.
//  Copyright © 2016 Brandon Withrow. All rights reserved.
//

#import "LAMaskLayer.h"
#import "CAAnimationGroup+LAAnimatableGroup.h"

@implementation LAMaskLayer {
  LAComposition *_composition;
  NSArray *_maskLayers;
}

- (instancetype)initWithMasks:(NSArray<LAMask *> *)masks inComposition:(LAComposition *)comp {
  self = [super initWithDuration:comp.timeDuration];
  if (self) {
    _masks = masks;
    _composition = comp;
    [self _setupViewFromModel];
  }
  return self;
}

- (void)_setupViewFromModel {
  NSMutableArray *maskLayers = [NSMutableArray array];
  
  for (LAMask *mask in _masks) {
    CAShapeLayer *maskLayer = [CAShapeLayer new];
    maskLayer.path = mask.maskPath.initialShape.CGPath;
    maskLayer.fillColor = [UIColor whiteColor].CGColor;
    maskLayer.opacity = mask.opacity.initialValue.floatValue;
    [self addSublayer:maskLayer];
    CAAnimationGroup *animGroup = [CAAnimationGroup animationGroupForAnimatablePropertiesWithKeyPaths:@{@"opacity" : mask.opacity,
                                                                                                        @"path" : mask.maskPath}];
    if (animGroup) {
      [maskLayer addAnimation:animGroup forKey:@""];
    }
    [maskLayers addObject:maskLayer];
  }
  _maskLayers = maskLayers;
}

@end
