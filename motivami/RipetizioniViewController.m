//
//  RipetizioniViewController.m
//  appMotiv
//
//  Created by claudio barbera on 12/06/13.
//  Copyright (c) 2013 claudio barbera. All rights reserved.
//

#import "RipetizioniViewController.h"
#import "Ripetizione.h"

@interface RipetizioniViewController ()
@property (nonatomic, strong) NSArray *ripetizioni;
@property (nonatomic, strong) Ripetizione *selectedRipetizione;
@end

@implementation RipetizioniViewController
@synthesize ripetizioni, selectedRipetizione, delegate, programmaSelezionato;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Ripetizione *r30minuti = [[Ripetizione alloc] initWithDescrizione:NSLocalizedString(@"30 minutes", @"30 minuti") andIntervalloTemporale:[NSNumber numberWithInt:30]];
    Ripetizione *r1ora = [[Ripetizione alloc] initWithDescrizione:NSLocalizedString(@"1 hour", @"1 ora") andIntervalloTemporale:[NSNumber numberWithInt:60]];
    Ripetizione *r2ora = [[Ripetizione alloc] initWithDescrizione:NSLocalizedString(@"2 hours", @"2 ore") andIntervalloTemporale:[NSNumber numberWithInt: 60 * 2]];
    Ripetizione *r4ora = [[Ripetizione alloc] initWithDescrizione:NSLocalizedString(@"4 hours", @"4 ore") andIntervalloTemporale:[NSNumber numberWithInt:60 * 4]];
    Ripetizione *r8ora = [[Ripetizione alloc] initWithDescrizione:NSLocalizedString(@"8 hours", @"8 ore") andIntervalloTemporale:[NSNumber numberWithInt:60 * 8]];
    
    ripetizioni = @[
                        r30minuti, r1ora, r2ora, r4ora, r8ora
                    ];
    
    
   

    
    [self.tableView reloadData];
	// Do any additional setup after loading the view.
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ripetizioni.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ripetizioneCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UILabel *lblFrase = (UILabel *)[cell viewWithTag:1];
    
    Ripetizione *entry = [ripetizioni objectAtIndex:indexPath.row];
   
    NSNumber *i = entry.intervalloTemporale;
   
    if ([programmaSelezionato.ripetizione.intervalloTemporale intValue] == [i intValue]){
    
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    
       
    [lblFrase setText:entry.descrizione];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Ripetizione *selRip = [ripetizioni objectAtIndex:indexPath.row];
    
    [delegate didSelectObject:selRip];
    
    [self.navigationController popViewControllerAnimated:YES];

}
@end
