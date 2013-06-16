//
//  admin_editTipoProgrammaFrasiViewController.m
//  motivami
//
//  Created by claudio barbera on 16/06/13.
//  Copyright (c) 2013 Riccardo Vieri. All rights reserved.
//

#import "admin_editTipoProgrammaFrasiViewController.h"

@interface admin_editTipoProgrammaFrasiViewController ()
@property (nonatomic, retain) NSMutableArray *frasi;
@end

@implementation admin_editTipoProgrammaFrasiViewController
@synthesize tipoProgrammaSelezionato, frasi;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateProgramDescription:)
                                                 name:@"notif_change_description"
                                               object:nil];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self performFetch];
    frasi = [[NSMutableArray alloc] init];
    
}


-(void)performFetch
{
 
    PFQuery *qFrasi = [PFQuery queryWithClassName:@"Frasi"];
    [qFrasi whereKey:@"tipoProgramma" equalTo:tipoProgrammaSelezionato];
    [qFrasi orderByAscending:@"orderBy"];
    
    [qFrasi findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    
        [frasi addObjectsFromArray: objects];
        
        [self.tableView reloadData];
        
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
        admin_EditFraseLangViewController *vc = [segue destinationViewController];
    
    if ([segue.identifier isEqualToString:@"editFrase"])
    {
        NSInteger index = [[self.tableView indexPathForSelectedRow] row];
        [vc setIndex:index];
        [vc setFraseSelezionata:[frasi objectAtIndex:index]];
    }
    vc.tipoProgrammaSelezionato = tipoProgrammaSelezionato;
    
        vc.delegate = self;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    if (tableView.isEditing)
        return 1;
    else
        return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0)
        return [frasi count];
    else return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0){
    
        static NSString *CellIdentifier = @"fraseCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        UILabel *lblFrase = (UILabel *)[cell viewWithTag:1];
        
        
        PFObject *entry = [frasi objectAtIndex:indexPath.row];
        
        [lblFrase setText:[entry objectForKey:@"descrizione_it"]];
        
        
        
        
        return cell;
        
    }
    else
    {
        static NSString *CellIdentifier = @"nuovaFraseCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        return cell;

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
        return 0;
    else return 22;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==1)return NSLocalizedString(@"New phrase", @"Nuova frase");
    
    
    return @"";
}



#pragma mark - FraseDelegate methods

-(void)didChangeFrase:(int)index andObject:(PFObject *)obj
{
    [frasi removeObjectAtIndex:index];
    [frasi insertObject:obj atIndex:index];
    
    [self.tableView reloadData];
}

-(void)didAddFrase:(PFObject *)frase
{
    [frasi addObject:frase];
    [self.tableView reloadData];
}
- (IBAction)setEditMode:(id)sender {
    
    if(self.editing)
    {
        [super setEditing:NO animated:NO];
        [self.tableView setEditing:NO animated:NO];
        [self.tableView reloadData];
        [self.navigationItem.rightBarButtonItem setTitle:NSLocalizedString(@"Edit", @"Modifica")];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStylePlain];
        [self salvaOrdinamento];
      
    }
    else
    {
        [super setEditing:YES animated:YES];
        [self.tableView setEditing:YES animated:YES];
        [self.tableView reloadData];
        [self.navigationItem.rightBarButtonItem setTitle:NSLocalizedString(@"Done", @"Fatto")];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
        
   
        
    }

}

-(void)salvaOrdinamento
{
    int order=0;
    for (PFObject *pf in frasi) {
        
        [pf setObject:[NSNumber numberWithInt:order] forKey:@"orderBy"];
        [pf saveEventually];
        
        order++;
        
    }
}


-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
    [self.frasi exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    
    
    
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.isEditing;
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PFObject *toDel = [frasi objectAtIndex:indexPath.row];
        [frasi removeObjectAtIndex:indexPath.row];
        [toDel deleteEventually];
        
        [self.tableView reloadData];
    }
}
@end
