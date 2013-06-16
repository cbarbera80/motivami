//
//  admin_editTipoProgrammaViewController.m
//  motivami
//
//  Created by claudio barbera on 16/06/13.
//  Copyright (c) 2013 Riccardo Vieri. All rights reserved.
//

#import "admin_editTipoProgrammaViewController.h"

@interface admin_editTipoProgrammaViewController ()
@end

@implementation admin_editTipoProgrammaViewController
@synthesize tipoProgrammaSelezionato, delegate, tableIndex;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateProgramTitle:)
                                                 name:@"notif_change_title"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateProgramDescription:)
                                                 name:@"notif_change_description"
                                               object:nil];

    
    if (tipoProgrammaSelezionato== nil){
    
        tipoProgrammaSelezionato = [PFObject objectWithClassName:@"TipoProgrammi"];
        /*
        [lblDescrizione setText:[tipoProgrammaSelezionato objectForKey:@"descrizione_it"]];
        [lblTitolo setText:[tipoProgrammaSelezionato objectForKey:@"titolo_it"]];
        [switchBloccato setOn:[[tipoProgrammaSelezionato objectForKey:@"bloccato"] boolValue]];*/
    }
}

-(void)updateProgramDescription:(NSNotification *)notification{
    
    [self.tableView reloadData];
}

-(void)updateProgramTitle:(NSNotification *)notification{
    
    [self.tableView reloadData];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"editTitle"])
    {
        admin_editTitoloViewController *vc = [segue destinationViewController];
        [vc setTipoProgrammaSelezionato:tipoProgrammaSelezionato];
    }
    else if ([segue.identifier isEqualToString:@"editDescription"])
    {
        admin_editDescrizioneViewController *vc = [segue destinationViewController];
        [vc setTipoProgrammaSelezionato:tipoProgrammaSelezionato];
    }
    else if ([segue.identifier isEqualToString:@"editFrasi"])
    {
        admin_editTipoProgrammaFrasiViewController *vc = [segue destinationViewController];
        [vc setTipoProgrammaSelezionato:tipoProgrammaSelezionato];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController) {
      

        [tipoProgrammaSelezionato saveEventually];
        
        if (tipoProgrammaSelezionato.objectId != nil )
            [self.delegate didChangeTipoProgrammaWithIndex:tableIndex andObject:tipoProgrammaSelezionato];
        else
            [self.delegate didAddTipoProgramma:tipoProgrammaSelezionato];
    }
}

- (IBAction)changeLocked:(id)sender {
    
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([[tipoProgrammaSelezionato objectForKey:@"bloccato"] boolValue])
    {
        return 3;
    }
    else
    {
        return 2;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
        return 2;
    else
        return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            static NSString *CellIdentifier = @"titoloCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            UILabel *lblTitle = (UILabel *)[cell viewWithTag:1];
            lblTitle.text = [tipoProgrammaSelezionato objectForKey:@"titolo_it"];
            
            return cell;
            
        }
        else
        {
            
            static NSString *CellIdentifier = @"descrizioneCell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            UILabel *lblDescrizione = (UILabel *)[cell viewWithTag:1];
            lblDescrizione.text = [tipoProgrammaSelezionato objectForKey:@"descrizione_it"];
            
            return cell;

        }
    }
    else if (indexPath.section==1)
    {
        static NSString *CellIdentifier = @"bloccatoCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        UISwitch *sw = (UISwitch *)[cell viewWithTag:1];
        [sw setOn:[[tipoProgrammaSelezionato objectForKey:@"bloccato"] boolValue]];
        [sw addTarget:self action:@selector(changeStatus:) forControlEvents:UIControlEventValueChanged];
        
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"frasiCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
    return cell;
    
    }
}

-(void)changeStatus:(id)sender
{
    UISwitch *sw = (UISwitch *)sender;
    
    [tipoProgrammaSelezionato setObject:[NSNumber numberWithBool:sw.on] forKey:@"bloccato"];
    [self.tableView reloadData];
    
}
@end
