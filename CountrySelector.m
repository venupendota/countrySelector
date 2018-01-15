//
//  CountrySelector.m
//  Created by Venu Pendota on 10/12/17.
//

#import "CountrySelector.h"
#import "CountryCell.h"
#import "CountryCodesAndNames.h"

@implementation CountrySelector {
    
    NSArray *countryArray;
    NSMutableArray *searchedCountries;
    BOOL searchactive;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(id)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"CountrySelector" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
    }
    
    [countryTable registerNib:[UINib nibWithNibName:@"CountryCell" bundle:nil]  forCellReuseIdentifier:@"countryCell"];
    countryTable.delegate = (id)self;
    countryTable.dataSource = (id)self;
    
    searchBar.delegate = (id)self;
    searchBar.layer.borderWidth = 1.0;
    searchBar.layer.borderColor = [UIColor blackColor].CGColor;
    searchBar.layer.masksToBounds = YES;
    searchBar.layer.cornerRadius = 6.0;
    searchBar.barTintColor = [UIColor whiteColor];
    
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 8.0;
    countryTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    countryArray = [[NSArray alloc] initWithArray:[CountryCodesAndNames arrayPfCountriesFromJson]];

    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (searchactive)  return searchedCountries.count;
    else return countryArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CountryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"countryCell" forIndexPath:indexPath];
    
    NSDictionary *tempDic;
    
    if (searchactive)
    {
        tempDic = [[NSDictionary alloc] initWithDictionary:[searchedCountries objectAtIndex:indexPath.row]];
    } else {
        tempDic = [[NSDictionary alloc] initWithDictionary:[countryArray objectAtIndex:indexPath.row]];
    }
    
    
    cell.countryName.text = [tempDic valueForKey:@"name"];
    
    
    NSString *imagePath = [NSString stringWithFormat:@"CountryPicker.bundle/%@", [tempDic valueForKey:@"code"]];
    UIImage *image = image = [UIImage imageNamed:imagePath];
    
//    if ([[UIImage class] respondsToSelector:@selector(imageNamed:inBundle:compatibleWithTraitCollection:)])
//    {
//        image = [UIImage imageNamed:imagePath inBundle:[NSBundle bundleForClass:[TTSIgnUpViewController class]] compatibleWithTraitCollection:nil];
//    }
//    else
//    {
//        image = [UIImage imageNamed:imagePath];
//    }
    
    cell.countryImage.image = image;
    
    return cell;
}

#pragma mark - Table view Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSDictionary *selDic;
    
    if (searchactive)
    {
        selDic = [[NSDictionary alloc] initWithDictionary:[searchedCountries objectAtIndex:indexPath.row]];
    } else {
        selDic = [[NSDictionary alloc] initWithDictionary:[countryArray objectAtIndex:indexPath.row]];
    }
    
    [self selectedDictionaryOfCountry:selDic];
}

#pragma mark - Country Selection And Calling Delegate Method

- (void) selectedDictionaryOfCountry : (NSDictionary *) selDic {
    
    NSString *countryName = [selDic valueForKey:@"name"];
    NSString *countryCode = [selDic valueForKey:@"code"];
    
    NSString *dailerCode = [selDic valueForKey:@"dial_code"];
    if ([dailerCode hasPrefix:@"+"] && [dailerCode length] > 1) {
        dailerCode = [dailerCode substringFromIndex:1];
    }

    
    [_countrySelDelegate selectedCountryWithName:countryName andWithDailer:dailerCode andWithCountryCode:countryCode];
    [self removeTheViewFromSuperView];
}

#pragma mark - Searchbar delegate


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //  NSString * searchtext = searchBar.text;
    [self->searchBar setShowsCancelButton:NO animated:YES];
    
    if(searchText.length == 0)
    {
        searchactive = NO;
    }
    else
    {
        searchactive = YES;
        searchedCountries = [[NSMutableArray alloc] init];
        
        for (NSDictionary *userDic in countryArray) {
            
            NSRange countryNameRange = [[userDic valueForKey:@"name"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if(countryNameRange.location != NSNotFound)
            {
                [searchedCountries addObject:userDic];
                
            }
        }
    }
    
    [countryTable reloadData];
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self->searchBar setShowsCancelButton:NO animated:YES];
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self->searchBar resignFirstResponder];
    self->searchBar.text = @"";
    self->searchBar.showsCancelButton = NO;
    searchactive = NO;
    [countryTable reloadData];
    
}

- (IBAction)closeCountrySelector:(id)sender {
    [self removeTheViewFromSuperView];
}

- (void) removeTheViewFromSuperView {
    
    [UIView transitionWithView:self.superview
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self removeFromSuperview];
                    }
                    completion:NULL];
}

@end
