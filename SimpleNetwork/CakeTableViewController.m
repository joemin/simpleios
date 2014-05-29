#import "CakeTableViewController.h"
#import "DetailViewController.h"

@interface CakeTableViewController ()

@end

@implementation CakeTableViewController
{
    NSMutableArray *pastryList;
    NSMutableArray *cakeList;
    NSMutableArray *pieList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(pastryList == nil)
    {
        pastryList = [[NSMutableArray alloc] init];
        cakeList = [[NSMutableArray alloc] init];
        pieList = [[NSMutableArray alloc] init];
    }
    else
    {
        [pastryList removeAllObjects];
        [cakeList removeAllObjects];
        [pieList removeAllObjects];
    }
    
    // todo Customize this url
    NSURL *URL = [NSURL URLWithString:@"http://localhost:9292/pastries.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               NSError *jsonParseError;
                               NSDictionary *cakeData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonParseError][@"Cakes"];
                               NSDictionary *pieData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonParseError][@"Pies"];

                               //NSLog(@"%@",cakeData);
                               for (NSDictionary* d in cakeData) {
                                   [pastryList addObject:(d)];
                                   [cakeList addObject:(d)];
                               }

                               for (NSDictionary* d in pieData) {
                                   [pastryList addObject:(d)];
                                   [pieList addObject:(d)];
                               }
                               
                               [self.tableView reloadData];
                               
                           }];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *destViewController = segue.destinationViewController;
        NSInteger *id;
        
        //Less than the number of objects in cakeList? It's a cake
        if (indexPath.row < [cakeList count]) {
            destViewController.cakeId = (NSInteger) [pastryList[indexPath.row][@"id"] intValue];
            destViewController.pieId = 'null';
        }
        else {
            id = (id - [cakeList count]);
            destViewController.cakeId = 'null';
            destViewController.pieId = (NSInteger) [pastryList[indexPath.row][@"id"] intValue];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return pastryList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CakeListCell" forIndexPath:indexPath];
    NSString *s = [NSString stringWithFormat: @"%@. %@", pastryList[indexPath.row][@"id"],(pastryList[indexPath.row][@"name"])];
    cell.textLabel.text = s;
    
    return cell;
}

@end
