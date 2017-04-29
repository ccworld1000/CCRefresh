//
//  CCCollection.m
//  CCRefreshiOS
//
//  Created by deng you hua on 4/29/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import "CCCollection.h"
#import <CCRefresh.h>

#define CCRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]


static const CGFloat CCDuration = 2.0;
static NSString * const reuseIdentifier = @"CCCollectionCellID";

@interface CCCollection ()

@property (strong, nonatomic) NSMutableArray *colors;

@end

@implementation CCCollection


- (void) loadingUI {
    __weak __typeof(self) weakSelf = self;
    
    self.collectionView.CCHeader= [CCRefreshNormalHeader headerWithRefreshingBlock:^{
        for (int i = 0; i<10; i++) {
            [weakSelf.colors insertObject:CCRandomColor atIndex:0];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CCDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
            [weakSelf.collectionView.CCHeader endRefreshing];
        });
    }];
    [self.collectionView.CCHeader beginRefreshing];
    
    self.collectionView.CCFooter = [CCRefreshBackNormalFooter footerWithRefreshingBlock:^{
        for (int i = 0; i<5; i++) {
            [weakSelf.colors addObject:CCRandomColor];
        }

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CCDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
            [weakSelf.collectionView.CCFooter endRefreshing];
        });
    }];

    self.collectionView.CCFooter.hidden = YES;
}


- (NSMutableArray *)colors {
    if (!_colors) {
        self.colors = [NSMutableArray array];
    }
    return _colors;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self loadingUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.collectionView.CCFooter.hidden = self.colors.count == 0;
    return self.colors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = self.colors[indexPath.row];
    
    // Configure the cell
    
    return cell;
}

@end
