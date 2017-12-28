//
//  CIFilter+ColorLUT.h
//  ColorLUT
//
//  Created by d71941 on 7/16/13.
//  Copyright (c) 2013 huangtw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorLUT)

+ (UIImage *)colorCubeInput:(NSString *)ipt color:(NSString *)color dimension:(NSInteger)n;


+ (UIImage *)colorCubeInput:(NSString *)ipt color:(NSString *)color space:(CGColorSpaceRef)space dimension:(NSInteger)n;
    
@end
