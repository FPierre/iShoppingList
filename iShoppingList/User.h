//
//  User.h
//  iShoppingList
//
//  Created by Save92 on 26/02/2015.
//  Copyright (c) 2015 Nicolas Save. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
    @private
    NSString* firstname_;
    NSString* lastname_;
    NSString* email_;
    NSString* token_;
}

@property (nonatomic, strong) NSString* firstname;
@property (nonatomic, strong) NSString* lastname;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* token;


@end