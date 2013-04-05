//
//  NIFetchedResultsTableViewModel.h
//  LiftRep
//
//  Created by Francis Li on 9/22/12.
//  Copyright (c) 2012 TikiTaki Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NIFetchedResultsTableViewModel;

@protocol NIFetchedResultsTableViewModelDelegate <NSObject, NIMutableTableViewModelDelegate>

@optional

- (void)tableViewModel:(NIFetchedResultsTableViewModel *)tableViewModel controllerWillChangeContent:(NSFetchedResultsController *)controller
           inTableView:(UITableView *)tableView;

- (void)tableViewModel:(NIFetchedResultsTableViewModel *)tableViewModel controllerDidChangeContent:(NSFetchedResultsController *)controller
           inTableView:(UITableView *)tableView;

- (BOOL)tableViewModel:(NIFetchedResultsTableViewModel *)tableViewModel
   shouldChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
               atIndex:(NSUInteger)sectionIndex
         forChangeType:(NSFetchedResultsChangeType)type
        withController:(NSFetchedResultsController *)controller
           inTableView:(UITableView *)tableView;

- (UITableViewRowAnimation)tableViewModel:(NIFetchedResultsTableViewModel *)tableViewModel
                   rowAnimationForSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
                                  atIndex:(NSUInteger)sectionIndex
                            forChangeType:(NSFetchedResultsChangeType)type
                           withController:(NSFetchedResultsController *)controller
                              inTableView:(UITableView *)tableView;

- (BOOL)tableViewModel:(NIFetchedResultsTableViewModel *)tableViewModel
    shouldChangeObject:(id)anObject
           atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
          newIndexPath:(NSIndexPath *)newIndexPath
        withController:(NSFetchedResultsController *)controller
           inTableView:(UITableView *)tableView;

- (UITableViewRowAnimation)tableViewModel:(NIFetchedResultsTableViewModel *)tableViewModel
                    rowAnimationForObject:(id)anObject
                              atIndexPath:(NSIndexPath *)indexPath
                            forChangeType:(NSFetchedResultsChangeType)type
                             newIndexPath:(NSIndexPath *)newIndexPath
                           withController:(NSFetchedResultsController *)controller
                              inTableView:(UITableView *)tableView;

@end

@interface NIFetchedResultsTableViewModel : NIMutableTableViewModel <NSFetchedResultsControllerDelegate>

@property (nonatomic, NI_STRONG) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, NI_WEAK) UITableView *tableView;
@property (nonatomic, NI_WEAK) id<NIFetchedResultsTableViewModelDelegate> delegate;

- (id)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
                             tableView:(UITableView *)tableView
                              delegate:(id<NIFetchedResultsTableViewModelDelegate>)delegate;

@end
