//
//  MemberTableViewCell.h
//  TabledSectionsTest
//
//  Created by Tarek Borhan on 16.09.15.
//  Copyright (c) 2015 Tarek Borhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberCollectionView : UICollectionView

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

static NSString *CollectionViewCellIdentifier = @"CollectionViewCellIdentifier";
//static NSString *CollectionViewCellIdentifier = @"PhotoCell";

@interface MemberTableViewCell : UITableViewCell

@property (nonatomic, strong) MemberCollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UITextView *infoTextView;

-(NSIndexPath *)section:(NSIndexPath *)section;

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;
@end
