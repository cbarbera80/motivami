//
//  FirstTopViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "ProgrammaMotivazionaleViewController.h"

@implementation ProgrammaMotivazionaleViewController
@synthesize prg;

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  // shadowPath, shadowOffset, and rotation is handled by ECSlidingViewController.
  // You just need to set the opacity, radius, and color.
  self.view.layer.shadowOpacity = 0.75f;
  self.view.layer.shadowRadius = 10.0f;
  self.view.layer.shadowColor = [UIColor blackColor].CGColor;
  
    
  if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
    self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
  }
  
    /*
    
  if (![self.slidingViewController.underRightViewController isKindOfClass:[UnderRightViewController class]]) {
    self.slidingViewController.underRightViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UnderRight"];
  }*/
  
  [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [defaults objectForKey:@"programmaSelezionato"];
   
    prg = (Programma *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
    

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ProgrammaViewController *vc = [segue destinationViewController];
    vc.delegate = self;
}

-(void)didChangeProgram:(Programma *)program
{
    prg = program;
    [self.tableView reloadData];
}

- (IBAction)revealMenu:(id)sender
{
  [self.slidingViewController anchorTopViewTo:ECRight];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
  return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (prg==nil)
        return 1;
    else
    {
        if (prg.tipoProgramma!=nil)
            return 2;
        else
            return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row==0) {
        return 80;
    }
    
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0){
    
        static NSString *CellIdentifier = @"selezionaProgrammaCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        UILabel *lblTitoloProgramma = (UILabel *)[cell viewWithTag:1];
        UILabel *lblStato = (UILabel *)[cell viewWithTag:2];
        UILabel *lblRipetizione = (UILabel *)[cell viewWithTag:3];
        
       
        if (prg!=nil){
            
            if (prg.tipoProgramma!=nil)
                lblTitoloProgramma.text =prg.tipoProgramma.titolo;
            else
                lblTitoloProgramma.text =NSLocalizedString(@"Select program", @"chiede all'utente di selezionare un programma");
        
             lblRipetizione.text =prg.ripetizione.descrizione;
            
            if ([prg.attivo boolValue])
                lblStato.text = NSLocalizedString(@"Program active", @"Indica che il programma è attivo");
            else
                lblStato.text = NSLocalizedString(@"Program inactive", @"Indica che il programma non è attivo");
        }
        
       
         
        
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"descrizioneProgrammaCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        UILabel *lblDescrizione = (UILabel *)[cell viewWithTag:1];
        lblDescrizione.text =prg.tipoProgramma.descrizione;
        
        
        return cell;

    }
    
}

@end