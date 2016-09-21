//
//  HomeCollectionView.m
//  项目1
//
//  Created by iOS-aFei on 15/12/5.
//  Copyright © 2015年 iOS-aFei. All rights reserved.
//

#import "HomeCollectionView.h"
#import "WFCellModel.h"
#import "WFCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import <CHTCollectionViewWaterfallLayout.h>

@interface HomeCollectionView () <UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>

{
    CGPoint _iconCenter;
    CGRect  _iconSize;
}

@property (nonatomic, strong) UIButton *buttonList;

@end

@implementation HomeCollectionView

#pragma mark - override
- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate        = self;
        self.dataSource      = self;
        self.backgroundColor = [UIColor whiteColor];

        [self registerClass:[WFCollectionViewCell class]
                            forCellWithReuseIdentifier:@"MyCollectionViewCell"];
        [self registerClass:[UICollectionReusableView class]
                            forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
                                   withReuseIdentifier:@"MyCollectionViewHeader"];
        [self initLocationBar];
    }
    return self;
}

#pragma mark - collectionViewAPI
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _modelArray.count;
};
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WFCollectionViewCell *cell = (WFCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];

    WFCellModel *model = [self.modelArray objectAtIndex:indexPath.row];
    NSString *imgURLString = model.imageURL;
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imgURLString] placeholderImage:[UIImage imageNamed:@"location"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            if (!CGSizeEqualToSize(model.imageSize, image.size)) {
                model.imageSize = image.size;
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
            }
        }
    }];
    return cell;
}
/**
 *  @author iOS-aFei, 16-09-20 20:09:49
 *
 *  瀑布流的项目建立与头像下拉放大的基础之上，由于开始没有准备做横竖屏
 *  这也导致了一些问题
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader])
    {
        reusableView =\
        [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                           withReuseIdentifier:@"MyCollectionViewHeader"
                                                  forIndexPath:indexPath];
        UIImageView *imageView = (UIImageView*)[[collectionView viewWithTag:1] viewWithTag:0];
        if (imageView) {
            [imageView removeFromSuperview];
        }
        reusableView.backgroundColor = [UIColor colorWithRed:143/255.0
                                                       green:220/255.0
                                                        blue:212/255.0
                                                       alpha:1.0];
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
        //        iconImageView.center = reusableView.center;
        //        iconImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        iconImageView.image  = [UIImage imageNamed:@"icon"];
        iconImageView.layer.cornerRadius  = 50;
        iconImageView.layer.masksToBounds = YES;
        iconImageView.tag = 0;
        [reusableView addSubview:iconImageView];
        reusableView.tag = 1;
        _iconSize   = iconImageView.frame;
        _iconCenter = reusableView.center;
        
    } //else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter])
    //    {
    //
    //    }
    
    return reusableView;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    /**
     *  @author iOS-aFei, 16-09-19 17:09:38
     *
     *  @return 每个cell的高度
     */
    WFCellModel *model = [self.modelArray objectAtIndex:indexPath.row];
    if (!CGSizeEqualToSize(model.imageSize, CGSizeZero)) {
        return model.imageSize;
    }
    return CGSizeMake(150, 150);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y
        >400) {
        _buttonList.frame = CGRectMake( kWindowWidth - 50, scrollView.contentOffset.y + 100, 40, 40);
    } else {
        _buttonList.frame = CGRectMake( kWindowWidth - 50, -500, 40, 40);
    }
    if (scrollView.contentOffset.y <= 0) {
        UIImageView *imageView = (UIImageView*)[[scrollView viewWithTag:1] viewWithTag:0];
        CGFloat width = CGRectGetWidth(_iconSize) - scrollView.contentOffset.y/5;
        imageView.frame = CGRectMake( 50, 50, width, width);
        imageView.layer.cornerRadius  = width/2;
    }
}


//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    UICollectionReusableView *headView =\
//    [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
//                                       withReuseIdentifier:@"MyCollectionViewHeader"
//                                              forIndexPath:indexPath];
//    headView.backgroundColor = [UIColor colorWithRed:143/255.0
//                                               green:220/255.0
//                                                blue:212/255.0
//                                               alpha:1.0];
//    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    iconImageView.center = headView.center;
//    iconImageView.image  = [UIImage imageNamed:@"icon"];
//    iconImageView.layer.cornerRadius  = 50;
//    iconImageView.layer.masksToBounds = YES;
//    _iconImageView = iconImageView;
//    [headView addSubview:iconImageView];
//    
//    _iconSize   = iconImageView.frame;
//    _iconCenter = headView.center;
//    return headView;
//}
/**
 *  @author iOS-aFei, 16-09-20 19:09:47
 *
 *  点击回到顶部
 */
- (void)initLocationBar {
    _buttonList       = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonList.frame = CGRectMake( kWindowWidth - 50, -500, 40, 40);
    [_buttonList setImage:[UIImage imageNamed:@"location"]
                 forState:UIControlStateNormal];
    [_buttonList addTarget:self action:@selector(location)
          forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonList];
}
- (void)location {
    [self scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}
@end
