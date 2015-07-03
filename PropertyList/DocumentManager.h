//
//  DocumentManager.h
//  PropertieList
//
//  Created by Ingo Wiederoder on 17.06.15.
//  Copyright (c) 2015 Ingo Wiederoder. All rights reserved.
//

#import <Foundation/Foundation.h>
#define PLIST_NAME @"Colors.plist"

@interface DocumentManager : NSObject



// interface:

- (instancetype) initWithPlistName:(NSString *)plistName;
- (BOOL)updatePlist;
- (BOOL)saveValues:(NSDictionary *)values error:(NSError * __autoreleasing *) error;
- (NSMutableDictionary *)getValuesFromPlist;

@end
