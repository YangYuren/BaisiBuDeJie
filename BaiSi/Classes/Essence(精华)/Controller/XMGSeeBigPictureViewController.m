//
//  XMGSeeBigPictureViewController.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/27.
//  Copyright © 2016年 小码哥. All rights reserved.
//

/*
 一种很常见的开发思路
 1.在viewDidLoad方法中添加初始化子控件
 2.在viewDidLayoutSubviews方法中布局子控件（设置子控件的位置和尺寸）
 
 另一种常见的开发思路
 1.控件弄成懒加载
 2.在viewDidLayoutSubviews方法中布局子控件（设置子控件的位置和尺寸）
 */

#import "XMGSeeBigPictureViewController.h"
#import "XMGTopic.h"
#import <Photos/Photos.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface XMGSeeBigPictureViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *imageView;
-(PHAssetCollection *)createCollection;
@end

@implementation XMGSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    
    //点击空白处也会退出
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.view insertSubview:scrollView atIndex:0];
    self.scrollView = scrollView;
    
    // imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return;
        self.saveButton.enabled = YES;
    }];
    //等比例换算高度
    imageView.xmg_width = scrollView.xmg_width;
    imageView.xmg_height = imageView.xmg_width * self.topic.height / self.topic.width;
    imageView.xmg_x = 0;
    if (imageView.xmg_height > XMGScreenH) { // 超过一个屏幕
        imageView.xmg_y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.xmg_height);
    } else {
        imageView.xmg_centerY = scrollView.xmg_height * 0.5;
    }
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // 图片缩放最大缩放比例
    CGFloat maxScale = self.topic.width / imageView.xmg_width;
    if(maxScale > 1){
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }
}

#pragma mark - <UIScrollViewDelegate>//缩放比例显示图片
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

#pragma mark - 监听点击
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//第二种保存图片的方法
- (IBAction)save {
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    //判断权限  检查访问权限   1、如果用户没做出选择（第一打开程序）会自动弹框，之后才执行block   2、如果做出选择，会直接执行block
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(status == PHAuthorizationStatusDenied){
                if(oldStatus !=PHAuthorizationStatusNotDetermined){//第一次打开
                    [SVProgressHUD showErrorWithStatus:@"打开设置中隐私开关"];
                }
            }else if(status == PHAuthorizationStatusAuthorized){
                [self saveImageIntoAlbum];
            }else if(status == PHAuthorizationStatusRestricted){
                [SVProgressHUD showErrorWithStatus:@"保存失败"];
            }
        });
    }];
}
//保存图片到相册
-(void)saveImageIntoAlbum{
    NSError * error = nil;
    id<NSFastEnumeration> assets = [self createAssets];
    if(assets == nil){
        [SVProgressHUD showErrorWithStatus:@"获取相片失败"];
        return;
    }
    // IOS10后可以使用performChangesAndWait包含performChangesAndWait
    PHAssetCollection * diyCollection = self.createCollection;//获取自定义相册
    if(diyCollection == nil){
        [SVProgressHUD showErrorWithStatus:@"创建相册失败"];
    }
    //添加刚才的图片保存到【自定义相册】
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        //self.createCollection获取自定义相册
        PHAssetCollectionChangeRequest * request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:diyCollection];
        [request insertAssets:assets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    if(error){
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }

}
//获取要保存相片
-(PHFetchResult<PHAsset *> *)createAssets{
    NSError * error = nil;
    //保存相片到相机交卷
    __block NSString * assetID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        //保存图片到系统智能相册 self.imageView.image表示要保存的图片
        assetID= [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    if(error) return nil;
    //获取相片根据ID来获取
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
}
//第一种保存图片的方法
//- (IBAction)save {
//    NSError * error = nil;
//    //保存相片到相机交卷
//    __block PHObjectPlaceholder * palce = nil;//占位图片
//    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
//        //保存图片到系统智能相册
//        palce = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset;
//    } error:&error];
//    if(error){
//        [SVProgressHUD showErrorWithStatus:@"保存失败"];
//        return;
//    }
//    // IOS10后可以使用performChangesAndWait包含performChangesAndWait
//    PHAssetCollection * diyCollection = self.createCollection;//获取自定义相册
//    if(diyCollection == nil){
//        [SVProgressHUD showErrorWithStatus:@"创建相册失败"];
//    }
//    //添加刚才的图片保存到【自定义相册】
//    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
//        //self.createCollection获取自定义相册
//        PHAssetCollectionChangeRequest * request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:diyCollection];
//        [request insertAssets:@[palce] atIndexes:[NSIndexSet indexSetWithIndex:0]];
//    } error:&error];
//    if(error){
//        [SVProgressHUD showErrorWithStatus:@"保存失败"];
//    }else{
//        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
//    }
//}
//获得当前APP对应的自定义相册
-(PHAssetCollection *)createCollection{
    //判断自定义相册是否存在
    NSString * name = [NSBundle mainBundle].infoDictionary[@"CFBundleName"];
    
    PHFetchResult<PHAssetCollection *> *collections =  [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum  subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    //遍历自定义相册是否存在
    for (PHAssetCollection * collection in collections) {
        if([collection.localizedTitle isEqualToString:name]){
            return collection;
        }
    }
    //如果上述没有返回  说明没有创建
    NSError * error = nil;
    __block NSString * ID= nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            //获取自定义相册唯一标示符    此时相册还没有创建好    等这个代码块结束才创建好
        ID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:name].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    //返回自定义的相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[ID] options:nil].firstObject;
}
@end
