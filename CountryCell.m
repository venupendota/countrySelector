//
//  CountryCell.m
//  Created by Venu Pendota on 10/12/17.
//

#import "CountryCell.h"

@implementation CountryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.countryImage.layer.masksToBounds = YES;
    self.countryImage.layer.cornerRadius = self.countryImage.frame.size.height / 2;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
