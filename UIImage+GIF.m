//
//  UIImage+GIF.m
//  LBGIFImage
//
//  Created by Laurin Brandner on 06.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIImage+GIF.h"
#import "ImageIO/ImageIO.h"

@implementation UIImage (GIF)

+(UIImage*)animatedGIFNamed:(NSString *)name {
    NSUInteger scale = [UIScreen mainScreen].scale;
    
    if (scale > 1) {
        NSString* retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        
        NSData* data = [NSData dataWithContentsOfFile:retinaPath];
        
        if (data) {
            return [UIImage animatedGIFWithData:data];
        }
        
        NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [UIImage animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
    }
    else {
        NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        NSData* data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [UIImage animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
    }    
}

+(UIImage*)animatedGIFWithData:(NSData *)data {
    CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)data, NULL);
    
    NSDictionary* properties = (NSDictionary*)CGImageSourceCopyProperties(source, NULL);
    NSDictionary* gifProperties = [properties objectForKey:(NSString*)kCGImagePropertyGIFDictionary];
    [properties release];
    
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray* images = [NSMutableArray array];
    
    for (size_t i = 0; i < count; i++) {
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
        
        [images addObject:[UIImage imageWithCGImage:image]];
        
        CGImageRelease(image);
    }
    
    NSTimeInterval duration = [[gifProperties objectForKey:(NSString*)kCGImagePropertyGIFDelayTime] doubleValue];
    if (!duration) {
        duration = (1.0f/10.0f)*count;
    }
    
    CFRelease(source);
    
    return [UIImage animatedImageWithImages:images duration:duration];
}

-(UIImage*)animatedImageByScalingAndCroppingToSize:(CGSize)size {
    if (CGSizeEqualToSize(self.size, size) || CGSizeEqualToSize(size, CGSizeZero)) {
        return self;
    }
    
    CGSize scaledSize = size;
	CGPoint thumbnailPoint = CGPointZero;
    
    CGFloat widthFactor = size.width / self.size.width;
    CGFloat heightFactor = size.height / self.size.height;
    CGFloat scaleFactor = (widthFactor > heightFactor) ? widthFactor : heightFactor;
    scaledSize.width = self.size.width * scaleFactor;
    scaledSize.height = self.size.height * scaleFactor;
    if (widthFactor > heightFactor) {
        thumbnailPoint.y = (size.height - scaledSize.height) * 0.5; 
    } else if (widthFactor < heightFactor) {
        thumbnailPoint.x = (size.width - scaledSize.width) * 0.5;
    }
    
    NSMutableArray* scaledImages = [NSMutableArray array];
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0); 
    
    for (UIImage* image in self.images) {
        [image drawInRect:CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledSize.width, scaledSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        [scaledImages addObject:newImage];
    }
    
    UIGraphicsEndImageContext();
	
	return [UIImage animatedImageWithImages:scaledImages duration:self.duration];
}

@end
