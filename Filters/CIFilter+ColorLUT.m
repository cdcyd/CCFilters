//
//  CIFilter+ColorLUT.m
//  ColorLUT
//
//  Created by d71941 on 7/16/13.
//  Copyright (c) 2013 huangtw. All rights reserved.
//

// 博客 http://huangtw-blog.logdown.com/posts/176980-ios-quickly-made-using-a-cicolorcube-filter
// GitHub https://github.com/huangtw/ColorLUT

#import "CIFilter+ColorLUT.h"
#import <CoreImage/CoreImage.h>
#import <OpenGLES/EAGL.h>

@implementation UIImage (ColorLUT)

+ (UIImage *)colorCubeInput:(NSString *)ipt color:(NSString *)color dimension:(NSInteger)n{
    return [self colorCubeInput:ipt color:color space:nil dimension:n];
}

+ (UIImage *)colorCubeInput:(NSString *)ipt color:(NSString *)color space:(CGColorSpaceRef)space dimension:(NSInteger)n {
    UIImage *image = [UIImage imageNamed:color];

    int width = (int)CGImageGetWidth(image.CGImage);
    int height = (int)CGImageGetHeight(image.CGImage);
    int rowNum = height / n;
    int columnNum = width / n;

    if ((width % n != 0) || (height % n != 0) || (rowNum * columnNum != n)){
        return nil;
    }

    unsigned char *bitmap = [self createRGBABitmapFromImage:image.CGImage];

    if (bitmap == NULL){
        return nil;
    }

    int size = (int)(n * n * n * sizeof(float) * 4);
    float *data = malloc(size);
    int bitmapOffest = 0;
    int z = 0;
    for (int row = 0; row <  rowNum; row++)
    {
        for (int y = 0; y < n; y++)
        {
            int tmp = z;
            for (int col = 0; col < columnNum; col++)
            {
                for (int x = 0; x < n; x++) {
                    float r = (unsigned int)bitmap[bitmapOffest];
                    float g = (unsigned int)bitmap[bitmapOffest + 1];
                    float b = (unsigned int)bitmap[bitmapOffest + 2];
                    float a = (unsigned int)bitmap[bitmapOffest + 3];

                    int dataOffset = (int)(z*n*n + y*n + x) * 4;

                    data[dataOffset] = r / 255.0;
                    data[dataOffset + 1] = g / 255.0;
                    data[dataOffset + 2] = b / 255.0;
                    data[dataOffset + 3] = a / 255.0;

                    bitmapOffest += 4;
                }
                z++;
            }
            z = tmp;
        }
        z += columnNum;
    }
    free(bitmap);

    UIImage *input = [UIImage imageNamed:ipt];
    CIImage *inputImage = [[CIImage alloc] initWithImage: input];

    CIFilter *filter = [CIFilter filterWithName:space ? @"CIColorCubeWithColorSpace" : @"CIColorCube"];
    [filter setValue:[NSData dataWithBytesNoCopy:data length:size freeWhenDone:YES] forKey:@"inputCubeData"];
    [filter setValue:[NSNumber numberWithInteger:n] forKey:@"inputCubeDimension"];
    [filter setValue:inputImage forKey:@"inputImage"];

    if (space) {
        [filter setValue:(__bridge id _Nullable)(space) forKey:@"inputColorSpace"];
    }

    CIImage *outputImage = [filter outputImage];
    CIContext *context = [CIContext contextWithOptions:nil];
    return [UIImage imageWithCGImage:[context createCGImage:outputImage fromRect:outputImage.extent]];
}

+ (unsigned char *)createRGBABitmapFromImage:(CGImageRef)image{
    CGContextRef context = NULL;
    CGColorSpaceRef colorSpace;
    unsigned char *bitmap;
    int bitmapSize;
    int bytesPerRow;
    
    size_t width = CGImageGetWidth(image);
    size_t height = CGImageGetHeight(image);
    
    bytesPerRow   = (int)(width * 4);
    bitmapSize    = (int)(bytesPerRow * height);
    
    bitmap = malloc( bitmapSize );
    if (bitmap == NULL) {
        return NULL;
    }
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL) {
        free(bitmap);
        return NULL;
    }
    
    context = CGBitmapContextCreate (bitmap,
                                     width,
                                     height,
                                     8,
                                     bytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease( colorSpace );
    
    if (context == NULL) {
        free (bitmap);
    }
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
    CGContextRelease(context);
    return bitmap;
}

@end
