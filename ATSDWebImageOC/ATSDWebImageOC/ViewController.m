//
//  ViewController.m
//  ATSDWebImageOC
//
//  Created by hugengya on 2020/5/22.
//  Copyright © 2020 com.hefeichenye. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}



- (UITableView *)tableView {
    
    if ( nil == _tableView ) {
         
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return  _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell_ID"];
    if ( nil == cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell_ID"];
    }
    cell.textLabel.text = @"jump to collectionVC";
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return  [UIView new];
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.navigationController pushViewController:[CollectionVC new] animated:YES];
    
    
//    [self.navigationController pushViewController:[[UITableViewController alloc] init] animated:YES];
}

















/*
// 来源：http://www.cocoachina.com/articles/16064
- setItem:(CustomItem *)item
{
    _item = item;
    if (缓存中有原图)
    {
        self.imageView.image = 原图;
    } else
    {
        if (Wifi环境)
        {
            下载显示原图
        } else if (手机自带网络)
        {
            if (3G\4G环境下仍然下载原图)
            {
                下载显示原图
            } else
            {
                下载显示小图
            }
        } else
        {
            if (缓存中有小图)
            {
                self.imageView.image = 小图;
            } else  // 处理离线状态
            {
                self.imageView.image = 占位图片;
            }
        }
    }
}

- setItem:(CustomItem *)item
{
    _item = item;
     // 占位图片
    UIImage *placeholder = [UIImage imageNamed:@"placeholderImage"];
    // 从内存\沙盒缓存中获得原图，
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:item.originalImage];
    if (originalImage) { // 如果内存\沙盒缓存有原图，那么就直接显示原图（不管现在是什么网络状态）
        self.imageView.image = originalImage;
    } else { // 内存\沙盒缓存没有原图
        AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
        if (mgr.isReachableViaWiFi) { // 在使用Wifi, 下载原图
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.originalImage] placeholderImage:placeholder];
        } else if (mgr.isReachableViaWWAN) { // 在使用手机自带网络
            //     用户的配置项假设利用NSUserDefaults存储到了沙盒中
            //    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"alwaysDownloadOriginalImage"];
            //    [[NSUserDefaults standardUserDefaults] synchronize];
#warning 从沙盒中读取用户的配置项：在3G\4G环境是否仍然下载原图
            BOOL alwaysDownloadOriginalImage = [[NSUserDefaults standardUserDefaults] boolForKey:@"alwaysDownloadOriginalImage"];
            if (alwaysDownloadOriginalImage) { // 下载原图
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.originalImage] placeholderImage:placeholder];
            } else { // 下载小图
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.thumbnailImage] placeholderImage:placeholder];
            }
        } else { // 没有网络
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:item.thumbnailImage];
            if (thumbnailImage) { // 内存\沙盒缓存中有小图
                self.imageView.image = thumbnailImage;
            } else { // 处理离线状态，而且有没有缓存时的情况
                self.imageView.image = placeholder;
            }
        }
    }
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock {
    // 关闭当前图片的下载操作
    [self sd_cancelCurrentImageLoad];
    objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (!(options & SDWebImageDelayPlaceholder)) {
        dispatch_main_async_safe(^{
            self.image = placeholder;
        });
    }
    if (url) {
        // check if activityView is enabled or not
        if ([self showActivityIndicatorView]) {
            [self addActivityIndicator];
        }
        __weak __typeof(self)wself = self;
        id  operation = [SDWebImageManager.sharedManager downloadImageWithURL:url options:options progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            [wself removeActivityIndicator];
            if (!wself) return;
            dispatch_main_sync_safe(^{
                if (!wself) return;
                if (image && (options & SDWebImageAvoidAutoSetImage) && completedBlock)
                {
                    completedBlock(image, error, cacheType, url);
                    return;
                }
                else if (image) {
                    wself.image = image;
                    [wself setNeedsLayout];
                } else {
                    if ((options & SDWebImageDelayPlaceholder)) {
                        wself.image = placeholder;
                        [wself setNeedsLayout];
                    }
                }
                if (completedBlock && finished) {
                    completedBlock(image, error, cacheType, url);
                }
            });
        }];
        [self sd_setImageLoadOperation:operation forKey:@"UIImageViewImageLoad"];
    } else {
        dispatch_main_async_safe(^{
            [self removeActivityIndicator];
            if (completedBlock) {
                NSError *error = [NSError errorWithDomain:SDWebImageErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
                completedBlock(nil, error, SDImageCacheTypeNone, url);
            }
        });
    }
}
*/

@end
