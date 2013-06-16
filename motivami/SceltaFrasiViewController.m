//
//  SceltaFrasiViewController.m
//  appMotiv
//
//  Created by claudio barbera on 11/06/13.
//  Copyright (c) 2013 claudio barbera. All rights reserved.
//

#import "SceltaFrasiViewController.h"
#import "AppDelegate.h"
#import "Frase.h"
#import "TaskCell.h"
#import "AppDelegate.h"

@interface SceltaFrasiViewController ()
@property (nonatomic, retain) NSMutableArray *frasi;
@end

@implementation SceltaFrasiViewController
@synthesize frasi, programmaSelezionato;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self performFetch];
    frasi = [[NSMutableArray alloc] init];
    
}


-(void)performFetch
{

    PFQuery *programmaQuery = [PFQuery queryWithClassName:@"TipoProgrammi"];
    [programmaQuery whereKey:@"objectId" equalTo:programmaSelezionato.tipoProgramma.parseObjectId];
     
    PFQuery *qFrasi = [PFQuery queryWithClassName:@"Frasi"];
    
    if ([programmaSelezionato.tipoProgramma.bloccato boolValue])
        [qFrasi whereKey:@"tipoProgramma" matchesQuery:programmaQuery];
    
    [qFrasi findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        for (PFObject *fp in objects) {
            
            Frase *f = [[Frase alloc] initWithDescrizione:[fp objectForKey:@"descrizione"]];
            [frasi addObject:f];
        }
        
        [self.tableView reloadData];
        
    }];}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [frasi count];
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"fraseCell";
    
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UILabel *lblFrase = (UILabel *)[cell viewWithTag:1];
    
    
    Frase *entry = [frasi objectAtIndex:indexPath.row];
    
    
    NSLog(@"%@", entry);
    
    
    if (![programmaSelezionato.tipoProgramma.bloccato boolValue])
    {
        if ([self checkIfObjectIsContained:entry])
            cell.checkbox.checked = true;
        else
            cell.checkbox.checked= false;
        
        [cell.checkbox setFrame:CGRectMake(275, 7, 40, 40)];
        
         __block typeof(cell) me = cell;
        
        [cell.checkbox setStateChangedBlock:^(SSCheckBoxView *v) {
            
            if (me.checkbox.checked)
            {
                [programmaSelezionato.frasiLibere addObject:entry];
            }
            else
                [programmaSelezionato.frasiLibere removeObject:entry];
        }];
        
    }
    else
    {
        [cell.checkbox setHidden:YES];
    }
     
 
    [lblFrase setText:entry.descrizione];
    
    
    
    return cell;
}


-(BOOL)checkIfObjectIsContained:(Frase *)f
{
    for (Frase *fl in programmaSelezionato.frasiLibere) {
        
        if ([fl.descrizione isEqualToString:f.descrizione]){
            return YES;
            break;
        }
        
    }
    
    return NO;
}

@end
