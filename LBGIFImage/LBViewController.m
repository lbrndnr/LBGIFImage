//
//  LBViewController.m
//  LBGIFImage
//
//  Created by Laurin Brandner on 06.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LBViewController.h"
#import "UIImage+GIF.h"

@implementation LBViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIImage* image = [UIImage animatedGIFNamed:@"image"];
    
    [(UIImageView*)self.view setImage:image];
}

@end
