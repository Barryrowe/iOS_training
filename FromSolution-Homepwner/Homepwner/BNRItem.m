//
//  BNRItem.m
//  Homepwner
//
//  Created by Admin on 3/7/13.
//
//

#import "BNRItem.h"


@implementation BNRItem

@dynamic itemName;
@dynamic serialNumber;
@dynamic valueInDollars;
@dynamic dateCreated;
@dynamic imageKey;
@dynamic thumbnailData;
@dynamic thumbnail;
@dynamic orderingValue;
@dynamic assetType;

//
//NSManageObject Implementation
//
- (void) awakeFromFetch{
    [super awakeFromFetch];
    
    UIImage *tn = [UIImage imageWithData:[self thumbnailData]];
    [self setPrimitiveValue:tn forKey:@"thumbnail"];
}

- (void) awakeFromInsert{
    [super awakeFromInsert];
    NSTimeInterval t = [[NSDate date] timeIntervalSinceReferenceDate];
    [self setDateCreated:t];
}
//-----

//
//Custom Implementation
//
- (void) setThumbnailDataFromImage:(UIImage *)image{
    CGSize origImageSize = [image size];
    
    // The rectangle of the thumbnail
    CGRect newRect = CGRectMake(0, 0, 40, 40);
    
    // Figure out a scaling ratio to make sure we maintain the same aspect ratio
    float ratio = MAX(newRect.size.width / origImageSize.width,
                      newRect.size.height / origImageSize.height);
    
    // Create a transparent bitmap context with a scaling factor
    // equal to that of the screen
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    
    // Create a path that is a rounded rectangle
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect
                                                    cornerRadius:5.0];
    // Make all subsequent drawing clip to this rounded rectangle
    [path addClip];
    
    // Center the image in the thumbnail rectangle
    CGRect projectRect;
    projectRect.size.width = ratio * origImageSize.width;
    projectRect.size.height = ratio *origImageSize.height;
    projectRect.origin.x    = (newRect.size.width - projectRect.size.width) /2.0;
    projectRect.origin.y    = (newRect.size.height - projectRect.size.height) /2.0;
    
    // Draw our image on it
    [image drawInRect:projectRect];
    
    // Get The image from image context and keep that shit as a thumbnail
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    [self setThumbnail:smallImage];
    
    // Set the PNG Representation of the image and set it in the archive
    NSData *data = UIImagePNGRepresentation(smallImage);
    [self setThumbnailData:data];
    
    // Dump those resources!
    UIGraphicsEndImageContext();
}
//-----

@end
