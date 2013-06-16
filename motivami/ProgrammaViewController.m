//
//  ProgrammaViewController.m
//  appMotiv
//
//  Created by claudio barbera on 12/06/13.
//  Copyright (c) 2013 claudio barbera. All rights reserved.
//

#import "ProgrammaViewController.h"
#import "Frase.h"

@interface ProgrammaViewController ()

@end

@implementation ProgrammaViewController
@synthesize  delegate, programma;


- (void)viewDidLoad
{
    [super viewDidLoad];
	    
    programma = [self controllaSelezioneProgramma];
    
    if (programma==nil)
    {
        programma = [[Programma alloc] init];
        programma.ripetizione = [[Ripetizione alloc] initWithDescrizione:NSLocalizedString(@"1 hour", @"1 ora") andIntervalloTemporale:[NSNumber numberWithInt:60]];
        programma.frasiLibere = [[NSMutableArray alloc] init];
    }
}

-(Programma *)controllaSelezioneProgramma
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [defaults objectForKey:@"programmaSelezionato"];
    Programma *prog = (Programma *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
    
    return prog;
}


//intercetto il pulsante back. Eseguo le operazioni di salvataggio del programma
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController) {
        
        //programma.attivo = [NSNumber numberWithBool:swichAttivo.on];
               
        NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:programma];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:myEncodedObject forKey:@"programmaSelezionato"];
        [defaults synchronize];
        
         [delegate didChangeProgram:programma];
        
        [self generaProgramma];
       
    }
}

-(void)didSelectObject:(id)object
{
    
    if ([object isKindOfClass:[Ripetizione class]])
    {
        Ripetizione *r = (Ripetizione *)object;
        //lblRipetizione.text = r.descrizione;
        programma.ripetizione = r;
    }
    else if ([object isKindOfClass:[TipoProgramma class]])
    {
        TipoProgramma *t = (TipoProgramma *)object;
        programma.tipoProgramma = t;
       // lblTitoloProgramma.text = t.titolo;
    }
    
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"impostaRipetizione"])
    {
        RipetizioniViewController *vc = [segue destinationViewController];
        vc.delegate = self;
        vc.programmaSelezionato = programma;
    }
    else if ([segue.identifier isEqualToString:@"impostaProgramma"])
    {
        SceltaTipoProgrammaViewController *vc = [segue destinationViewController];
        vc.delegate = self;
        vc.programmaSelezionato = programma;
    }
    else if ([segue.identifier isEqualToString:@"selezionaFrasi"])
    {
        SceltaFrasiViewController *vc = [segue destinationViewController];
        vc.programmaSelezionato = programma;
    }
}


-(void)generaProgramma
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    if (programma.attivo)
    {
        
        if (programma.ripetizione == nil)
        {
            [UIAlertView showAlertViewWithTitle:NSLocalizedString(@"error", @"error")
                                        message:NSLocalizedString(@"Select a program", @"Messaggio di avviso programma non selezionato")
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil
                                  showTextField:NO
                                      onDismiss:nil
                                       onCancel:nil];
            return;

        }
        
    
        
        if ([programma.tipoProgramma.bloccato boolValue])
        {
            //è un programma preimpostato, recupero le frasi
            
            PFQuery *programmaQuery = [PFQuery queryWithClassName:@"TipoProgrammi"];
            [programmaQuery whereKey:@"objectId" equalTo:programma.tipoProgramma.parseObjectId];
            
            PFQuery *qFrasi = [PFQuery queryWithClassName:@"Frasi"];
           [qFrasi whereKey:@"tipoProgramma" matchesQuery:programmaQuery];
            
            
            [qFrasi findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                
                int i=0;
                
                for (PFObject *fp in objects) {
                    
                    int timeInterval = (i + 1) * [programma.ripetizione.intervalloTemporale intValue];
                    
                    [[MKLocalNotificationsScheduler sharedInstance] scheduleNotificationOn:[NSDate dateWithTimeIntervalSinceNow:timeInterval]
                                                                                      text: [fp objectForKey:@"descrizione"]
                                                                                    action:@"View"
                                                                                     sound:nil
                                                                               launchImage:nil
                                                                                   andInfo:nil];
                    
                    i++;
                }
             }];

        }
        else
        {
            //è un programma libero, ho le frasi da mostrare dentro programma.frasiLibere
            int i=0;
            
            for (Frase *f in programma.frasiLibere) {
                
                
                int timeInterval = (i + 1) * [programma.ripetizione.intervalloTemporale intValue];
                
                [[MKLocalNotificationsScheduler sharedInstance] scheduleNotificationOn:[NSDate dateWithTimeIntervalSinceNow:timeInterval]
                                                                                  text: f.descrizione
                                                                                action:@"View"
                                                                                 sound:nil
                                                                           launchImage:nil
                                                                               andInfo:nil];
                
                i++;
            }
        }
    }
}



#pragma mark - UITableViewDatasource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (programma.tipoProgramma != nil)
        return 4;
    
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        static NSString *CellIdentifier = @"tipoProgrammaCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        UILabel *lblTipoProgramma = (UILabel *)[cell viewWithTag:1];
        
        if (programma!= nil && programma.tipoProgramma != nil)
            lblTipoProgramma.text = programma.tipoProgramma.titolo;
        
        return cell;
    }
    else if (indexPath.section==1)
    {
        static NSString *CellIdentifier = @"ripetizioneCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        UILabel *lblRipetizione = (UILabel *)[cell viewWithTag:1];
        
        lblRipetizione.text = programma.ripetizione.descrizione;
        
        return cell;
    }
    else if (indexPath.section==2)
    {
        static NSString *CellIdentifier = @"attivoCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        UISwitch *switchAttivo = (UISwitch *)[cell viewWithTag:1];
        [switchAttivo addTarget:self action:@selector(changeStatus:) forControlEvents:UIControlEventValueChanged];
        switchAttivo.on = [programma.attivo boolValue];
        
        return cell;
    }
    else if (indexPath.section==3)
    {
        static NSString *CellIdentifier = @"sceltaFrasiCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        
        return cell;
    }
    return nil;
}

-(void)changeStatus:(id)sender
{
    UISwitch *switchStatus = (UISwitch *)sender;
    
    programma.attivo = [NSNumber numberWithBool: switchStatus.on];
    
}
/*
-(void)generaProgramma
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    
    if (swichAttivo.isOn)
    {
        int ripetiOgni=[[[NSUserDefaults standardUserDefaults] objectForKey:@"intervalloTemporale"] intValue];
        
        
        if (ripetiOgni==0)
            ripetiOgni=30;

        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity =
        [NSEntityDescription entityForName:@"Frase" inManagedObjectContext:ApplicationDelegate.managedObjectContext];
        [request setEntity:entity];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"selezionata == YES"];
        [request setPredicate:predicate];
        
        NSError *error = nil;
        NSArray *array = [ApplicationDelegate.managedObjectContext executeFetchRequest:request error:&error];
        if (array != nil) {
                       
            int i = 1;
            
            for (Frase *f in array) {
                
                int timeInterval = (i + 1) * ripetiOgni;
                
                [[MKLocalNotificationsScheduler sharedInstance] scheduleNotificationOn:[NSDate dateWithTimeIntervalSinceNow:timeInterval]
                                                                                  text: f.descrizione
                                                                                action:@"View"
                                                                                 sound:nil
                                                                           launchImage:nil
                                                                               andInfo:nil];
                
                i++;
            }
        }
    }
}*/


@end
