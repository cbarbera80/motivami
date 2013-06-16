//
//  SceltaFrasiViewController.m
//  appMotiv
//
//  Created by claudio barbera on 11/06/13.
//  Copyright (c) 2013 claudio barbera. All rights reserved.
//

#import "SceltaTipoProgrammaViewController.h"

@interface SceltaTipoProgrammaViewController ()
@property (nonatomic, retain) NSMutableArray *tipoProgrammi;

@end

@implementation SceltaTipoProgrammaViewController
@synthesize tipoProgrammi, delegate, programmaSelezionato;


- (void)viewDidLoad
{
    [super viewDidLoad];
    tipoProgrammi = [[NSMutableArray alloc] init];
    [self performFetch];
}


-(void)performFetch
{

    PFQuery *qProgrammi = [PFQuery queryWithClassName:@"TipoProgrammi"];
    
    [qProgrammi findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        for (PFObject *tp in objects) {
            
            NSString   *langCode = [[NSLocale currentLocale] objectForKey: NSLocaleLanguageCode];
            
            TipoProgramma *t = [[TipoProgramma alloc] init];
            t.descrizione =  [tp objectForKey:[NSString stringWithFormat:@"descrizione_%@", langCode]];
            t.titolo = [tp objectForKey:[NSString stringWithFormat:@"titolo_%@", langCode]];
            t.bloccato = [tp objectForKey:@"bloccato"];
            t.parseObjectId = tp.objectId;
            
            
            [tipoProgrammi addObject:t];
        }
        
        [self.tableView reloadData];
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [tipoProgrammi count];
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"tipoProgrammaCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UILabel *lblFrase = (UILabel *)[cell viewWithTag:1];
    
    
    TipoProgramma *entry = [tipoProgrammi objectAtIndex:indexPath.row];
    
    if ([entry.titolo isEqualToString: programmaSelezionato.tipoProgramma.titolo])
    {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else
        [cell setAccessoryType:UITableViewCellAccessoryNone];

    
    [lblFrase setText:entry.titolo];
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TipoProgramma *p = [tipoProgrammi objectAtIndex:indexPath.row];
    
    [delegate didSelectObject:p];
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
