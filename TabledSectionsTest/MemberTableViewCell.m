//
//  MemberTableViewCell.m
//  TabledSectionsTest
//
//  Created by Tarek Borhan on 16.09.15.
//  Copyright (c) 2015 Tarek Borhan. All rights reserved.
//

#import "MemberTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation MemberCollectionView

@end

@implementation MemberTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(40, 25, 9, 10);
    layout.itemSize = CGSizeMake(50, 50);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[MemberCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.collectionView];
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = self.contentView.bounds;
    //   self.backgroundColor = [UIColor colorWithRed:200.0f/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:0.55f];
    
    //    [self.layer setCornerRadius:10.0f];
    [self.layer setMasksToBounds:YES];
    
}

//- (void) setFrame:(CGRect)frame {
//
//    int inset = 10;
//    frame.origin.x += inset;
//    frame.size.width -= 2 * inset;
//    [super setFrame:frame];
//}

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath
{
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.delegate = dataSourceDelegate;
    self.collectionView.indexPath = indexPath;
    
    [self.collectionView reloadData];
}

-(NSIndexPath *)section:(NSIndexPath *)section {
    return section;
}


@end
