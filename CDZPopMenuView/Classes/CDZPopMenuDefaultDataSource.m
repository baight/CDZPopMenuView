//
//  WKDarkStyleDataSource.m
//  WKPopMenuView
//
//  Created by baight chen on 2018/1/19.
//

#import "CDZPopMenuDefaultDataSource.h"

@implementation CDZPopMenuDefaultDataSource
- (instancetype)init{
    if (self = [super init]) {
        _width = 135;
        _rowHeight = 50;
        _separatorInset = UIEdgeInsetsMake(0, 8, 0, 8);
    }
    return self;
}

- (UIColor*)tintColor{
    if (_tintColor == nil) {
        _tintColor = [UIColor colorWithRed:80/255.f green:80/255.f blue:80/255.f alpha:1.f];
    }
    return _tintColor;
}
- (UIColor*)textColor{
    if (_textColor == nil) {
        _textColor = [UIColor whiteColor];
    }
    return _textColor;
}
- (UIColor*)highlightedTintColor{
    if (_highlightedTintColor == nil) {
        _highlightedTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
    }
    return _highlightedTintColor;
}

- (CGSize)sizeFitsThat:(CGSize)size{
    NSInteger count = MAX(self.textArray.count, self.imageArray.count);
    CGFloat height = self.rowHeight*count;
    CGSize fittingSize;
    fittingSize.width = self.width;
    fittingSize.height = height > size.height ? size.height : height;
    if (self.maxHeight > 0 && fittingSize.height > self.maxHeight) {
        fittingSize.height = self.maxHeight;
    }
    return fittingSize;
}

// UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return MAX(self.textArray.count, self.imageArray.count);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.rowHeight;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.separatorInset = UIEdgeInsetsMake(0, 6, 0, 6);
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = self.textColor;
        cell.backgroundColor = self.tintColor;
        cell.selectedBackgroundView = [[UIView alloc]init];
        cell.selectedBackgroundView.backgroundColor = self.highlightedTintColor;
    }
    if (indexPath.row < self.textArray.count) {
        NSString* title = [self.textArray objectAtIndex:indexPath.row];
        cell.textLabel.text = title;
    }
    if(indexPath.row < self.imageArray.count) {
        id icon = [self.imageArray objectAtIndex:indexPath.row];
        if ([icon isKindOfClass:[UIImage class]]) {
            cell.imageView.image = icon;
        }
        else if ([icon isKindOfClass:[NSString class]]) {
            UIImage* image = [UIImage imageNamed:icon];
            cell.imageView.image = image;
        }
    }
    
    // last one
    if (indexPath.row == MAX(self.textArray.count, self.imageArray.count)-1) {
        cell.separatorInset = UIEdgeInsetsMake(0, self.separatorInset.left, 0, tableView.bounds.size.width-self.separatorInset.left);
    }
    else{
        cell.separatorInset = self.separatorInset;
    }
    return cell;
}

@end
