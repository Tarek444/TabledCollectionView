//
//  TableViewControllerTest.m
//  TabledSectionsTest
//
//  Created by Tarek Borhan on 16.09.15.
//  Copyright (c) 2015 Tarek Borhan. All rights reserved.
//

#import "TableViewControllerTest.h"
#import "MemberTableViewCell.h"

static NSInteger section;

@interface TableViewControllerTest () <UITextViewDelegate>

@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;
@property (nonatomic, strong) NSMutableArray *membersArray;
@property (nonatomic, strong) NSMutableArray *photosArray;

@end

@implementation TableViewControllerTest

-(void)loadView
{
    [super loadView];
    
    const NSInteger numberOfTableViewRows = 20;
    const NSInteger numberOfCollectionViewCells = 15;
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:numberOfTableViewRows];
    
    for (NSInteger tableViewRow = 0; tableViewRow < numberOfTableViewRows; tableViewRow++)
    {
        NSMutableArray *colorArray = [NSMutableArray arrayWithCapacity:numberOfCollectionViewCells];
        
        for (NSInteger collectionViewItem = 0; collectionViewItem < numberOfCollectionViewCells; collectionViewItem++)
        {
            
            CGFloat red = arc4random() % 255;
            CGFloat green = arc4random() % 255;
            CGFloat blue = arc4random() % 255;
            UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0f];
            
            [colorArray addObject:color];
        }
        
        [mutableArray addObject:colorArray];
    }
    
    self.colorArray = [NSArray arrayWithArray:mutableArray];
    
    self.contentOffsetDictionary = [NSMutableDictionary dictionary];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView.hidden = YES;
//    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.PNG"]];
//    [backgroundImageView setFrame:self.tableView.frame];
//    
//    self.tableView.backgroundView = backgroundImageView;
    self.navigationItem.title = @"TabledSection";
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    expand = NO;
    
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @" ";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView =[[UIView alloc]initWithFrame:CGRectMake(0,200,300,244)];
    sectionView.backgroundColor=[UIColor clearColor];
    
    return sectionView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    static NSString *InfoCellIdentifier = @"InfoCell";
    
    MemberTableViewCell *cell = (MemberTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    MemberTableViewCell *photoCell = (MemberTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"PhotoCell"];
    MemberTableViewCell *infoCell = (MemberTableViewCell *) [tableView dequeueReusableCellWithIdentifier:InfoCellIdentifier];
    
    UITableViewCell *emptyCell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"EmptyCell"];
    
    if (!cell)
    {
        cell = [[MemberTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    } else if (!photoCell) {
        photoCell = [[MemberTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PhotoCell"];
    }
    
    UILabel *cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 15, 20, 40)];
    [cellLabel setBackgroundColor:[UIColor clearColor]];
    cellLabel.font = [UIFont systemFontOfSize:17.0f];
    cellLabel.textColor = [UIColor colorWithRed:177.0/255.0 green:180.0/255.0 blue:182.0/255.0 alpha:1.0];
    
    if (indexPath.section == 0) {
        
        infoCell.infoTextView.text = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
        self.textView = infoCell.infoTextView;
        
        self.textView.editable = YES;
        [self.textView setContentSize:self.textView.frame.size];
        self.textView.scrollEnabled = NO;
        return infoCell;
        
    } else if (indexPath.section == 1) {
        [cellLabel setText:@"Going"];
        
    } else if (indexPath.section == 2) {
        [cellLabel setText:@"Photos"];
        
    } else if (indexPath.section == 3) {
        return emptyCell;
        
    }
    
    // [cellLabelCount sizeToFit];
    [cellLabel sizeToFit];
    [cell.contentView addSubview:cellLabel];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(MemberTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"Section: %ld", (long)indexPath.section);
    if (indexPath.section == 3 || indexPath.section == 4) {
        //    indexSection = indexPath.section;
        return;
    }
    
    [cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
    NSInteger index = cell.collectionView.tag;
    
    section = [cell section:indexPath].section;
    
    CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
    [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
}

#pragma mark - UITableViewDelegate Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && expand == YES) {
        
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[self.textView font],NSFontAttributeName,nil];
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.textView.text attributes:attributes];
        
        if (80 > [self textViewHeightForAttributedText:attributedString andWidth:self.textView.bounds.size.width]) {
            return 120;
        } else {
            return [self textViewHeightForAttributedText:attributedString andWidth:self.textView.bounds.size.width] + 50;
            
        }

    } else if (indexPath.section == 3) {
        return 0;
    }
    return 120;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 3) {
        return 35;
    }
    
    return UITableViewAutomaticDimension;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.textView setUserInteractionEnabled:YES];
    
    if (indexPath.section == 0 && expand == YES) {
        expand = NO;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (indexPath.section == 0 && expand == NO) {
        expand = YES;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *collectionViewArray = self.colorArray[[(MemberCollectionView *)collectionView indexPath].row];
    return collectionViewArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    
    NSArray *collectionViewArray = self.colorArray[[(MemberCollectionView *)collectionView indexPath].row];
    cell.backgroundColor = collectionViewArray[indexPath.item];
    
    if (section == 1) {
        cell.backgroundColor = [UIColor blueColor];
    } else if (section == 2) {
        cell.backgroundColor = [UIColor redColor];
    }
    
    return cell;
}

#pragma mark - UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[UICollectionView class]]) return;
    
    CGFloat horizontalOffset = scrollView.contentOffset.x;
    
    UICollectionView *collectionView = (UICollectionView *)scrollView;
    NSInteger index = collectionView.tag;
    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
}

#pragma mark - UITextViewDelegate Methods

- (void) textViewDidBeginEditing:(UITextView *)textView {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelEditing)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveEditing)];
}

- (void) cancelEditing {
    
    [self.textView endEditing:YES];
    self.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem;
    self.navigationItem.rightBarButtonItem = nil;
    
}

- (void) saveEditing {
    
    [self.textView endEditing:YES];
    self.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem;
    self.navigationItem.rightBarButtonItem = nil;
}

- (CGFloat)textViewHeightForAttributedText: (NSAttributedString*)text andWidth: (CGFloat)width {
    [self.textView setAttributedText:text];
    CGSize size = [self.textView sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
}


@end
