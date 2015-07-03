//
//  DocumentManager.m
//  PropertieList
//
//  Created by Ingo Wiederoder on 17.06.15.
//  Copyright (c) 2015 Ingo Wiederoder. All rights reserved.
//

#import "DocumentManager.h"

@interface DocumentManager ()

@property (nonatomic, strong) NSString *plistName;

@end

@implementation DocumentManager

#pragma mark - Interface


- (instancetype) initWithPlistName:(NSString *)plistName {
    self = [super init];
    if (self) {
       self.plistName = plistName;
       [self copyPlistIfNeeded];
    }
    return self;
}



- (BOOL)updatePlist {
    //implementeted for later use
    return NO;
}

- (BOOL)saveValues:(NSMutableDictionary *)values error:(NSError * __autoreleasing *) error {
    NSURL *plistURL = [self getPlistURL];
    BOOL success = [values writeToFile:[plistURL relativePath] atomically:YES];
    if (!success) {
        if (error) {
            *error = [NSError errorWithDomain:@"PlistSaveError" code:-42 userInfo:nil];
        }
    }
    return NO;
}

- (NSMutableDictionary *)getValuesFromPlist {
    NSURL *plistURL = [self getPlistURL];
    if (!plistURL) {
        return nil;
    }
    return [NSMutableDictionary dictionaryWithContentsOfURL:plistURL];
}

#pragma mark - "Private" Methods

- (BOOL)copyPlistIfNeeded {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *plistURL = [self getPlistURL];
    if ([fileManager fileExistsAtPath:[plistURL relativePath]]) {
        return YES;
    }
    NSArray *fileComponents = [self.plistName componentsSeparatedByString:@"."];
    NSURL *bundlePlistURL = [[NSBundle mainBundle] URLForResource:fileComponents[0] withExtension:fileComponents[1]];
    if (!bundlePlistURL) {
        return NO;
    }
    NSError *copyError;
    BOOL success = [fileManager copyItemAtURL:bundlePlistURL toURL:plistURL error:&copyError];
    if (!success) { NSLog(@"CopyError: %@",copyError); }
    return success;
}

- (NSURL *)getPlistURL {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSURL *directoryURL = [fileManager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&error];
    if (error) NSLog(@"GetError: %@",error);
    NSURL *plistURL = [directoryURL URLByAppendingPathComponent:self.plistName];
    return plistURL;
}



@end
