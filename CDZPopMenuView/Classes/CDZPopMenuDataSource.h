//
//  WKPopMenuDataSource.h
//  WKPopMenuView
//
//  Created by baight chen on 2018/1/19.
//

#import <UIKit/UIKit.h>

@protocol CDZPopMenuDataSource
@required

// return your tint color, it will be PopMenuView's backgroundColor
- (UIColor*)tintColor;

/**
 * @param size : the maximum size you can use
 * @return the best size for your showing
 */
- (CGSize)sizeFitsThat:(CGSize)size;

// UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
