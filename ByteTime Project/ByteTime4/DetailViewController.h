//
//  DetailViewController.h
//  ByteTime4
//
//  Created by Anna Zhong on 12/7/13.
//  Copyright (c) 2013 Anna Zhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
