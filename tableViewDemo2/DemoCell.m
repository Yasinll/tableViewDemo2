//
//  DemoCell.m
//  tableViewDemo2
//
//  Created by PatrickY on 2018/3/15.
//  Copyright © 2018年 PatrickY. All rights reserved.
//

#import "DemoCell.h"

@implementation DemoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //设置cell
        CGFloat cellHeight = self.frame.size.height;
        
        CGFloat imageViewWidth = 39;
        CGFloat imageViewHeight = 28;
        CGFloat imageViewLeftView = 300;
        self.myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewLeftView, (cellHeight - imageViewHeight) / 2, imageViewWidth, imageViewHeight)];
        
        
        CGFloat labelWidth = 120;
        CGFloat labelHeight = 21;
        CGFloat labelLeftView = 15;
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(labelLeftView, (cellHeight - labelHeight) / 2, labelWidth, labelHeight)];
        
        [self addSubview:self.myImageView];
        [self addSubview:self.label];
        
    }
    
    return self;
    
}


@end
