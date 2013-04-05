//
//  NIFetchedResultsCollectionViewModel+Private.h
//  Sedition Art
//
//  Created by Francis Li on 4/4/13.
//  Copyright (c) 2013 Sedition Limited. All rights reserved.
//

@interface NIFetchedResultsCollectionViewModel()

@property (nonatomic, NI_STRONG) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, NI_WEAK) UICollectionView *collectionView;

@property (nonatomic, NI_STRONG) NSMutableArray *objectChanges;
@property (nonatomic, NI_STRONG) NSMutableArray *sectionChanges;

@end