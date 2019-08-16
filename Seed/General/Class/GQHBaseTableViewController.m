//
//  GQHBaseTableViewController.m
//  Seed
//
//  Created by Mac on 2019/4/15.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHBaseTableViewController.h"
#import "GQHHeader.h"


@interface GQHBaseTableViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation GQHBaseTableViewController

#pragma mark - UITableViewDataSource
/**
 列表视图的总组数
 
 @param tableView 列表视图
 @return 列表视图的总组数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"");
    
    return 1;
}

/**
 列表视图的各组行数
 
 @param tableView 列表视图
 @param section 列表视图的某组索引值
 @return 列表视图的某组的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"");
    
    return 5;
}

/**
 列表视图的行视图
 
 @param tableView 列表视图
 @param indexPath 列表视图某行的索引值
 @return 列表视图某行视图
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"");
    
    return [UITableViewCell new];
}

/**
 列表视图某组头视图标题(系统样式)

 @param tableView 列表视图
 @param section 列表视图的某组索引值
 @return 列表视图某组头视图标题
 */
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSLog(@"");
    
    return nil;
}

/**
 列表视图某组尾视图标题(系统样式)
 
 @param tableView 列表视图
 @param section 列表视图的某组索引值
 @return 列表视图某组尾视图标题
 */
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    NSLog(@"");
    
    return nil;
}

/**
 列表视图所有组的索引标题

 @param tableView 列表视图
 @return 列表视图所有组的索引标题
 */
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSLog(@"");
    
    return nil;
}

/**
 列表视图某行视图是否可编辑(默认均为可编辑)

 @param tableView 列表视图
 @param indexPath 列表视图某行视图的索引值
 @return 列表视图某行视图的可编辑状态
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"");
    
    return YES;
}

/**
 列表视图某行视图是否可以拖动

 @param tableView 列表视图
 @param indexPath 列表视图某行视图的索引值
 @return 列表视图某行视图的可拖动状态
 */
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"");
    
    return YES;
}

/**
 数据操作-重排序/支持拖动
 
 @param tableView 列表视图
 @param sourceIndexPath 拖动行视图的起始索引值
 @param destinationIndexPath 拖动行视图的目的索引值
 */
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSLog(@"");
    
}

/**
 <#Description#>

 @param tableView <#tableView description#>
 @param title <#title description#>
 @param index <#index description#>
 @return <#return value description#>
 */
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    return 1;
}

/**
 列表视图侧滑操作(删除/添加)

 @param tableView 列表视图
 @param editingStyle 列表视图行视图侧滑样式(无/删除/添加)
 @param indexPath 列表视图行视图的索引值
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"");
    
}

#pragma mark - UITableViewDelegate
/**
 列表视图的各行高度
 
 @param tableView 列表视图
 @param indexPath 列表视图某行的索引值
 @return 列表视图某行视图的高度值
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"");
    
    return 50.0f;
}

/**
 选中列表视图的某行视图
 
 @param tableView 列表视图
 @param indexPath 选中列表视图的某行视图的索引值
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"");
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/**
 列表视图的组头视图高度
 
 @param tableView 列表视图
 @param section 列表视图的某组索引值
 @return 列表视图的某组头视图高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSLog(@"");
    
    return CGFLOAT_MIN;
}

/**
 列表视图的组自定义头视图
 
 @param tableView 列表视图
 @param section 列表视图的某组索引值
 @return 列表视图的某组自定义头视图
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSLog(@"");
    
    return [UIView new];
}

/**
 列表视图的组尾视图高度
 
 @param tableView 列表视图
 @param section 列表视图的某组索引值
 @return 列表视图的某组尾视图高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    NSLog(@"");
    
    return CGFLOAT_MIN;
}

/**
 列表视图的组自定义尾视图
 
 @param tableView 列表视图
 @param section 列表视图的某组索引值
 @return 列表视图的某组自定义尾视图
 */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    NSLog(@"");
    
    return [UIView new];
}


#warning to-do 注释
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    
}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    
}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100.0f;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    
    return 100.0f;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    
    return 100.0f;
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleNone;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}
- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
    
    return nil;
}
- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
    
    return nil;
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath {
    
}
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    return [NSIndexPath indexPathForRow:0 inSection:0];
}
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 1;
}
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender {
    
    return YES;
}
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender {
    
}
- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context {
    
    return YES;
}
- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
    
}
- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView {
    
    return nil;
}
- (BOOL)tableView:(UITableView *)tableView shouldSpringLoadRowAtIndexPath:(NSIndexPath *)indexPath withContext:(id<UISpringLoadedInteractionContext>)context  API_AVAILABLE(ios(11.0)){
    
    return YES;
}

@end
