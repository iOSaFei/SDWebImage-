//
//  ViewController.m
//  LearnSDWebImage
//
//  Created by iOS-aFei on 16/9/18.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import "ViewController.h"
#import "HomeCollectionView.h"
#import "WFCellModel.h"
#import <CHTCollectionViewWaterfallLayout.h>

@interface ViewController ()

@property (nonatomic, strong) HomeCollectionView *homeCollectionView;
@property (nonatomic, strong) NSMutableArray     *modelArray;
@end

@implementation ViewController

#pragma mark - override
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:143/255.0
                                                green:220/255.0
                                                 blue:212/255.0
                                                alpha:1.0];
    [self initBaseData];
    [self addSubViews];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (void)initBaseData {
    NSArray *imageURLArray = @[
                            @"http://g.hiphotos.baidu.com/image/w%3D310/sign=6f9ce22079ec54e741ec1c1f89399bfd/9d82d158ccbf6c81cea943f6be3eb13533fa4015.jpg",
                            @"http://b.hiphotos.baidu.com/image/pic/item/4bed2e738bd4b31cc6476eb985d6277f9e2ff8bd.jpg",
                            @"http://c.hiphotos.baidu.com/image/pic/item/94cad1c8a786c9174d18e030cb3d70cf3bc7579b.jpg",
                            @"http://e.hiphotos.baidu.com/image/w%3D310/sign=79bc1b1a950a304e5222a6fbe1c9a7c3/d1160924ab18972b50a46fd4e4cd7b899e510a15.jpg",
                            @"http://c.hiphotos.baidu.com/image/w%3D310/sign=05e2c867272dd42a5f0907aa333a5b2f/7dd98d1001e93901f3f7103079ec54e737d196c3.jpg",
                            @"http://e.hiphotos.baidu.com/image/w%3D310/sign=3914596cf1deb48ffb69a7dfc01e3aef/d0c8a786c9177f3ea3e73f0072cf3bc79e3d56e8.jpg",
                            @"http://c.hiphotos.baidu.com/image/w%3D310/sign=8cc67b8cc91349547e1eee65664e92dd/4610b912c8fcc3ce11e40a3e9045d688d43f2093.jpg",
                            @"http://c.hiphotos.baidu.com/image/w%3D310/sign=93e1c429952bd40742c7d5fc4b889e9c/3812b31bb051f8191cdd594bd8b44aed2e73e733.jpg",
                            @"http://b.hiphotos.baidu.com/image/pic/item/4bed2e738bd4b31cc6476eb985d6277f9e2ff8bd.jpg",
                            @"http://c.hiphotos.baidu.com/image/pic/item/94cad1c8a786c9174d18e030cb3d70cf3bc7579b.jpg",
                            @"http://e.hiphotos.baidu.com/image/w%3D310/sign=3914596cf1deb48ffb69a7dfc01e3aef/d0c8a786c9177f3ea3e73f0072cf3bc79e3d56e8.jpg",
                            @"http://c.hiphotos.baidu.com/image/w%3D310/sign=93e1c429952bd40742c7d5fc4b889e9c/3812b31bb051f8191cdd594bd8b44aed2e73e733.jpg",
                            @"http://e.hiphotos.baidu.com/image/w%3D310/sign=d4507def9d3df8dca63d8990fd1072bf/d833c895d143ad4b758c35d880025aafa40f0603.jpg",
                            @"http://c.hiphotos.baidu.com/image/w%3D310/sign=702acce2552c11dfded1b92253266255/d62a6059252dd42a3ac70aaa013b5bb5c8eab8e0.jpg",
                            @"http://h.hiphotos.baidu.com/image/w%3D310/sign=75ff59cd19d5ad6eaaf962ebb1ca39a3/b64543a98226cffcb9f3ddbbbb014a90f703eada.jpg",
                            @"http://e.hiphotos.baidu.com/image/w%3D310/sign=11386163f1deb48ffb69a7dfc01e3aef/d0c8a786c9177f3e8bcb070f72cf3bc79f3d5631.jpg",
                            @"http://f.hiphotos.baidu.com/image/w%3D310/sign=8ed508bbd358ccbf1bbcb33b29d8bcd4/8694a4c27d1ed21b33ff8fecaf6eddc451da3f80.jpg",
                            @"http://b.hiphotos.baidu.com/image/w%3D310/sign=ad40ca82c9ef76093c0b9f9e1edca301/5d6034a85edf8db16aa7b27b0b23dd54564e7420.jpg",
                            @"http://e.hiphotos.baidu.com/image/w%3D310/sign=79bc1b1a950a304e5222a6fbe1c9a7c3/d1160924ab18972b50a46fd4e4cd7b899e510a15.jpg",
                            @"http://c.hiphotos.baidu.com/image/w%3D310/sign=05e2c867272dd42a5f0907aa333a5b2f/7dd98d1001e93901f3f7103079ec54e737d196c3.jpg",
                            @"http://g.hiphotos.baidu.com/image/w%3D310/sign=6f9ce22079ec54e741ec1c1f89399bfd/9d82d158ccbf6c81cea943f6be3eb13533fa4015.jpg",
                            @"http://e.hiphotos.baidu.com/image/w%3D310/sign=79bc1b1a950a304e5222a6fbe1c9a7c3/d1160924ab18972b50a46fd4e4cd7b899e510a15.jpg"
                            ];
    
    self.modelArray = [NSMutableArray array];
    for (NSString *item in imageURLArray) {
        WFCellModel *model = [[WFCellModel alloc] init];
        model.imageURL     = item;
        [self.modelArray addObject:model];
    }

}


- (void)addSubViews {
    /**
     使用CHTCollectionViewWaterfallLayout实现瀑布流
     框架地址：https://github.com/chiahsien/CHTCollectionViewWaterfallLayout
     - author: iOS-aFei
     - date: 16-09-19 17:09:51
     
     -
     */
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.headerHeight = 200;
//    layout.footerHeight = 30;//footView高度
    layout.minimumColumnSpacing = 10;//cell之间的水平间距
    layout.minimumInteritemSpacing = 10;//垂直间距
    

//    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.headerReferenceSize         = CGSizeMake(kWindowWidth, 200);
//    flowLayout.scrollDirection             = UICollectionViewScrollDirectionVertical;
    _homeCollectionView = [[HomeCollectionView alloc] initWithFrame:self.view.bounds
                                               collectionViewLayout:layout];
    _homeCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _homeCollectionView.modelArray = _modelArray;
    [self.view addSubview:_homeCollectionView];

}

/**
 *  @author iOS-aFei, 16-09-19 17:09:03
 *
 *  瀑布流支持横竖屏，设置竖屏3列，横屏4列
 *
 *  @param animated
 */
#pragma mark - viewEvent
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateLayoutForOrientation:toInterfaceOrientation];
}

- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
    CHTCollectionViewWaterfallLayout *layout =
    (CHTCollectionViewWaterfallLayout *)_homeCollectionView.collectionViewLayout;
    //竖屏2列，横屏3列
    layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
