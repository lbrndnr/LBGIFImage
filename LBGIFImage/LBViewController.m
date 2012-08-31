//
//  LBViewController.m
//  LBGIFImage
//
//  Created by Laurin Brandner on 06.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LBViewController.h"
#import "UIImage+GIF.h"
#include <mach/mach_time.h>

static uint64_t startTime;

void startRec(void);
void startRec() {
    startTime = mach_absolute_time();
}

uint64_t stopRec(BOOL log);
uint64_t stopRec(BOOL log) {
    uint64_t endTime = mach_absolute_time();
    
    uint64_t elapsedTime = endTime - startTime;
    if (log) {
        NSLog(@"Recorded Time:%llu", elapsedTime);
    }
    return elapsedTime;
}


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
	
    startRec();
    UIImage* image = [UIImage animatedGIFNamed:@"loading"];
    stopRec(YES);
    
    [(UIImageView*)self.view setImage:image];
}

@end
