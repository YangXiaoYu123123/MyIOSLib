//
//  nibLoader.h
//  answer
//
//  Created by HaiJiao Chen on 12-6-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface nibLoader : NSObject
+(id)load:(NSString*)nib params:(id)params;

@property (nonatomic, strong) IBOutlet id obj;
@end
