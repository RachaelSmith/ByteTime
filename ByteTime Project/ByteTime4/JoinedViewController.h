//
//  JoinedViewController.h
//  ByteTime1
//
//  Created by Rachael Smith on 12/5/13.
//  Copyright (c) 2013 Rachael Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface JoinedViewController : PFQueryTableViewController
@property(nonatomic, retain) UIView *backgroundView;




@end
