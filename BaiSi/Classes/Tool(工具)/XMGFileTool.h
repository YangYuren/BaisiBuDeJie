//
//  XMGFileTool.h
//  BaiSi
//
//  Created by Yang on 2017/4/25.
//  Copyright © 2017年 Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGFileTool : NSObject
+(void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion;

+(void)removeDirectoryPath:(NSString *)directoryPath;
@end
