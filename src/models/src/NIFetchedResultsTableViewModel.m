//
//  NIFetchedResultsTableViewModel.m
//  LiftRep
//
//  Created by Francis Li on 9/22/12.
//  Copyright (c) 2012 TikiTaki Studio. All rights reserved.
//

#import "NIFetchedResultsTableViewModel.h"

@implementation NIFetchedResultsTableViewModel

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize tableView = _tableView;
@synthesize sectionIndexType = _sectionIndexType;

- (id)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
                             tableView:(UITableView *)tableView
                              delegate:(id<NIFetchedResultsTableViewModelDelegate>)delegate
{
    self = [super initWithDelegate:delegate];
    if (self) {
        _fetchedResultsController = fetchedResultsController;
        _fetchedResultsController.delegate = self;
        _tableView = tableView;
    }
    return self;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    return [_fetchedResultsController objectAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_fetchedResultsController.sections objectAtIndex:section] numberOfObjects];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _fetchedResultsController.sections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[_fetchedResultsController.sections objectAtIndex:section] name];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (_sectionIndexType == NITableViewModelSectionIndexDynamic) {
        return _fetchedResultsController.sectionIndexTitles;
    }
    return nil;
}

- (void)setSectionIndexType:(NITableViewModelSectionIndex)sectionIndexType
                showsSearch:(BOOL)showsSearch
               showsSummary:(BOOL)showsSummary
{
    _sectionIndexType = sectionIndexType;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [_fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    if ([self.delegate respondsToSelector:@selector(tableViewModel:controllerWillChangeContent:inTableView:)]) {
        [self.delegate tableViewModel:self
          controllerWillChangeContent:_fetchedResultsController
                          inTableView:_tableView];
    }
    [_tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    BOOL perform = YES;
    if ([self.delegate respondsToSelector:@selector(tableViewModel:shouldChangeSection:atIndex:forChangeType:withController:inTableView:)]) {
        perform = [self.delegate tableViewModel:self
                            shouldChangeSection:sectionInfo
                                        atIndex:sectionIndex
                                  forChangeType:type
                                 withController:_fetchedResultsController
                                    inTableView:_tableView];
    }
    if (perform) {
        UITableViewRowAnimation animation = UITableViewRowAnimationAutomatic;
        if ([self.delegate respondsToSelector:@selector(tableViewModel:rowAnimationForSection:atIndex:forChangeType:withController:inTableView:)]) {
            animation = [self.delegate tableViewModel:self
                               rowAnimationForSection:sectionInfo
                                              atIndex:sectionIndex
                                        forChangeType:type
                                       withController:_fetchedResultsController
                                          inTableView:_tableView];
        }
        switch(type) {
            case NSFetchedResultsChangeInsert:
                [_tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:animation];
                break;
                
            case NSFetchedResultsChangeDelete:
                [_tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:animation];
                break;
        }
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    BOOL perform = YES;
    if ([self.delegate respondsToSelector:@selector(tableViewModel:shouldChangeObject:atIndexPath:forChangeType:newIndexPath:withController:inTableView:)]) {
        perform = [self.delegate tableViewModel:self
                             shouldChangeObject:anObject
                                    atIndexPath:indexPath
                                  forChangeType:type
                                   newIndexPath:newIndexPath
                                 withController:_fetchedResultsController
                                    inTableView:_tableView];
    }
    if (perform) {
        UITableViewRowAnimation animation = UITableViewRowAnimationAutomatic;
        if ((type != NSFetchedResultsChangeMove) && [self.delegate respondsToSelector:@selector(tableViewModel:rowAnimationForObject:atIndexPath:forChangeType:newIndexPath:withController:inTableView:)]) {
            animation = [self.delegate tableViewModel:self
                                rowAnimationForObject:anObject
                                          atIndexPath:indexPath
                                        forChangeType:type
                                         newIndexPath:newIndexPath
                                       withController:_fetchedResultsController
                                          inTableView:_tableView];
        }
        switch(type) {
            case NSFetchedResultsChangeInsert:
                [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                                  withRowAnimation:animation];
                break;
                
            case NSFetchedResultsChangeDelete:
                [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                  withRowAnimation:animation];
                break;
                
            case NSFetchedResultsChangeUpdate:
                [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                  withRowAnimation:animation];
                break;
                
            case NSFetchedResultsChangeMove:
                [_tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
                break;
        }
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [_tableView endUpdates];
    if ([self.delegate respondsToSelector:@selector(tableViewModel:controllerDidChangeContent:inTableView:)]) {
        [self.delegate tableViewModel:self
           controllerDidChangeContent:_fetchedResultsController
                          inTableView:_tableView];
    }
}

@end
