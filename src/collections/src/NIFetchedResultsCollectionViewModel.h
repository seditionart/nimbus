//
//  NIFetchedResultsCollectionViewModel.h
//  Sedition Art
//
//  Created by Francis Li on 4/4/13.
//  Copyright (c) 2013 Sedition Limited. All rights reserved.
//

#import "NICollectionViewModel.h"

@interface NIFetchedResultsCollectionViewModel : NICollectionViewModel <NSFetchedResultsControllerDelegate>

@property (nonatomic, NI_STRONG) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, NI_WEAK) UICollectionView *collectionView;

- (id)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
                        collectionView:(UICollectionView *)collectionView
                              delegate:(id<NICollectionViewModelDelegate>)delegate;

@end
