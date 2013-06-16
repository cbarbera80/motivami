//
//  UsersViewController.m
//  OrderList
//
//  Created by claudio barbera on 10/04/13.
//  Copyright (c) 2013 claudio barbera. All rights reserved.
//

#import "UsersViewController.h"



@implementation UsersViewController
@synthesize users;

- (void)viewDidLoad
{
    [super viewDidLoad];
    users = [[NSMutableArray alloc] init];
    
       
    MBProgressHUD *hudd = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudd.mode = MBProgressHUDModeIndeterminate;
    hudd.labelText = NSLocalizedString(@"Loading message", @"Caricamento in corso");
    
    PFQuery *query = [PFUser query];
    [query includeKey:@"ruolo"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (error == nil){
            [users addObjectsFromArray:objects];
            [self.tableView reloadData];
            [hudd hide:YES];
        }
        else
        {
            [UIAlertView showWithError:error];
            [hudd hide:YES];
        }
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RegisterUserViewController *vc = [segue destinationViewController];
    vc.delegate = self;
    
    
    if ([segue.identifier isEqualToString:@"user"])
    {
        NSInteger index = [self.tableView indexPathForSelectedRow].row;
        vc.selectedUser = [users objectAtIndex:index];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"userCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    PFUser *user = [users objectAtIndex:indexPath.row];
    UILabel *lblUsername = (UILabel *)[cell viewWithTag:1];
    
    [lblUsername setText:user.username];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"list-item.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
   
    
    return cell;
}



#pragma mark -  User delegate

-(void)didAddUser:(PFUser *)user{

    [users addObject:user];
    [self.tableView reloadData];
}

-(void)didUpdateUser:(PFUser *)user{
    
    [self.tableView reloadData];
}
@end
