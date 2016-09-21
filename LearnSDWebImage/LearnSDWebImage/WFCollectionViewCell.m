//
//  WFCollectionViewCell.m
//  LearnSDWebImage
//
//  Created by iOS-aFei on 16/9/19.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import "WFCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation WFCollectionViewCell

/**
 *  @author iOS-aFei, 16-09-19 17:09:36
 *  imageView的几种填充方式可以看看
 *
 *
 */
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

@end
