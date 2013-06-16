//
//  admin_tipoProgrammaViewController.m
//  motivami
//
//  Created by claudio barbera on 16/06/13.
//  Copyright (c) 2013 Riccardo Vieri. All rights reserved.
//

#import "admin_tipoProgrammaViewController.h"

@interface admin_tipoProgrammaViewController ()
@property (nonatomic, strong) NSMutableArray *programmi;
@end

@implementation admin_tipoProgrammaViewController
@synthesize programmi;

- (void)viewDidLoad
{
    [super viewDidLoad];

    programmi = [[NSMutableArray alloc] init];
    
    [self performFetch];

}



-(void)performFetch
{
    MBProgressHUD *hudd = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudd.mode = MBProgressHUDModeIndeterminate;
    hudd.labelText = NSLocalizedString(@"Loading message", @"Caricamento in corso..");

    
    PFQuery *qProgrammi = [PFQuery queryWithClassName:@"TipoProgrammi"];
    
    [qProgrammi findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        [hudd setHidden:YES];
        [programmi  addObjectsFromArray:objects];
        
        [self.tableView reloadData];
        
    }];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    admin_editTipoProgrammaViewController *vc = [segue destinationViewController];
    
    if([segue.identifier isEqualToString:@"editProgramType"])
    {
        NSInteger index = [[self.tableView indexPathForSelectedRow] row];
        [vc setTipoProgrammaSelezionato:[programmi objectAtIndex:index]];
        [vc setTableIndex:index];
        
    }
    
    [vc setDelegate:self];
}
#pragma mark - UITableViewDatasource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return programmi.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"tipoProgrammaCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    PFObject *tipoProgramma = [programmi objectAtIndex:indexPath.row];
    
    UILabel *lblFrase = (UILabel *)[cell viewWithTag:1];
    UILabel *lblDescription = (UILabel *)[cell viewWithTag:2];

    [lblFrase setText:[tipoProgramma objectForKey:@"titolo_it"]];
    [lblDescription setText:[tipoProgramma objectForKey:@"descrizione_it"]];
    
    return cell;
    
}

-(void)didChangeTipoProgrammaWithIndex:(NSInteger)index andObject:(PFObject *)obj
{
    [programmi removeObjectAtIndex:index];
    [programmi insertObject:obj atIndex:index];
    
    [self.tableView reloadData];
}

-(void)didAddTipoProgramma:(PFObject *)tipoProgramma
{
    [programmi addObject:tipoProgramma];
    [self.tableView reloadData];
}

@end
