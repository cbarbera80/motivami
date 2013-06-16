//
//  MenuViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "MenuViewController.h"
#import "VociMenu.h"

@interface MenuViewController()
@property (nonatomic, strong) NSArray *menuItems;
@end

@implementation MenuViewController
@synthesize menuItems;


- (void)viewDidLoad
{
  [super viewDidLoad];
  
    VociMenu *mnuProgrammaMotivazionale = [[VociMenu alloc] initWithDescrizione:NSLocalizedString(@"Menu - Motivational program", "")
                                                                      andChiave:@"progMotiv"];
    
    VociMenu *mnuVideos = [[VociMenu alloc] initWithDescrizione:NSLocalizedString(@"Menu - Video", "")
                                                      andChiave:@"video"];
    
    self.menuItems = @[mnuProgrammaMotivazionale, mnuVideos];
    
  [self.slidingViewController setAnchorRightRevealAmount:280.0f];
  self.slidingViewController.underLeftWidthLayout = ECFullWidth;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
  return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIdentifier = @"MenuItemCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
  }
  
    VociMenu *vmenu =  [self.menuItems objectAtIndex:indexPath.row];
    
    cell.textLabel.text = vmenu.descrizione;
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  VociMenu *vmenu =  [self.menuItems objectAtIndex:indexPath.row];

  UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:vmenu.chiave];
  
  [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
    CGRect frame = self.slidingViewController.topViewController.view.frame;
    self.slidingViewController.topViewController = newTopViewController;
    self.slidingViewController.topViewController.view.frame = frame;
    [self.slidingViewController resetTopView];
  }];
}

@end
