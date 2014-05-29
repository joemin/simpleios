//
//  DetailViewController.m
//  SimpleNetwork
//
//  Created by Joseph Min on 5/28/14.
//  Copyright (c) 2014 MissionData. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *sUrl = @"";
    if (self.cakeId != 'null') {
        sUrl = [NSString stringWithFormat:@"%@%d", @"http://localhost:9292/cakes/", self.cakeId];
    }
    else {
        sUrl = [NSString stringWithFormat:@"%@%d", @"http://localhost:9292/pies/", self.pieId];
    }
    NSURL *URL = [NSURL URLWithString: sUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               NSError *jsonParseError;
                               NSDictionary *pastry = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonParseError];
                               
                               self.pastryTitle.text = pastry[@"name"];
                               self.pastryDescription.text = pastry[@"description"];
                               
                               dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
                                   
                                   UIImage *img = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:pastry[@"imageURL"]]]];
                                   
                                   dispatch_async(dispatch_get_main_queue(), ^(void) {
                                       self.pastryImage.image = img;
                                   });
                                   
                               });
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
