//
//  UserCell.h
//  RottenNetz
//
//  Created by ohcibi on 27.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *gravatarImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
