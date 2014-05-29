//
//  DetailViewController.h
//  SimpleNetwork
//
//  Created by Joseph Min on 5/28/14.
//  Copyright (c) 2014 MissionData. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *pastryImage;
@property (weak, nonatomic) IBOutlet UILabel *pastryDescription;
@property (weak, nonatomic) IBOutlet UILabel *pastryTitle;
@property (assign, nonatomic) NSInteger cakeId;
@property (assign, nonatomic) NSInteger pieId;
@end