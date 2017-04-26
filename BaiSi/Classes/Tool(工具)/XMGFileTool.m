//
//  XMGFileTool.m
//  BaiSi
//
//  Created by Yang on 2017/4/25.
//  Copyright © 2017年 Yang. All rights reserved.

//处理缓存

#import "XMGFileTool.h"

@implementation XMGFileTool
+(void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion{
    /*
     attributesOfItemAtPath: 指定文件路径,就能获取文件属性
     */
    NSFileManager * manager = [NSFileManager defaultManager];
    BOOL isDirectory;
    //判断文件是否存在或者是否是文件夹
    BOOL isExist = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if(!isExist || !isDirectory){
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"传入的要是文件路径并且文件路径要存在" userInfo:nil];
        [excp raise];
    }

    //获取文件夹下所有的子路劲
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSArray * subPaths = [manager subpathsAtPath:directoryPath];
        NSInteger  totalSize = 0;
        for (NSString * subPath  in subPaths) {
            //拼接获得文件完整路径
            NSString * filePath = [directoryPath stringByAppendingPathComponent:subPath];
            //判断是否是隐藏文件
            if([filePath containsString:@".DS"])continue;
            BOOL isDirectory;
            //判断文件是否存在或者是否是文件夹
            BOOL isExist = [manager fileExistsAtPath:filePath isDirectory:&isDirectory];
            if(!isExist || isDirectory)
                continue;
            //获取文件属性  只能获取文件尺寸  获取文件夹不对
            NSDictionary * attr = [manager attributesOfItemAtPath:filePath error:nil];
            NSInteger fileSize = [attr fileSize];
            //获得总的尺寸
            totalSize += fileSize;
        }
         //计算完成回调  在主线程中完成
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(completion){
                completion(totalSize);
            }
        });
       
        
    });
}

+(void)removeDirectoryPath:(NSString *)directoryPath{
    NSFileManager * manager = [NSFileManager defaultManager];
    BOOL isDirectory;
    //判断文件是否存在或者是否是文件夹
    BOOL isExist = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if(!isExist || !isDirectory){
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"传入的要是文件路径并且文件路径要存在" userInfo:nil];
        [excp raise];
    }
    NSArray * subPaths = [manager contentsOfDirectoryAtPath:directoryPath error:nil];
    for (NSString * subPath  in subPaths) {
        //拼接获得文件完整路径
        NSString * filePath = [directoryPath stringByAppendingPathComponent:subPath];
        //判断是否是隐藏文件
        if([filePath containsString:@".DS"])continue;
        //获取文件属性  只能获取文件尺寸  获取文件夹不对
        [manager removeItemAtPath:filePath error:nil];
    }
}
@end
