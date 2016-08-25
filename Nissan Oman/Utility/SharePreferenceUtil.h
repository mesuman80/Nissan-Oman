//
//  SharePreferenceUtil.h
//  Nissan Oman
//
//  Created by Sakshi on 25/08/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharePreferenceUtil : NSObject{
    NSUserDefaults *defaults;
}
+(SharePreferenceUtil *)getInstance;

-(void)saveString:(NSString*)string withKey:(NSString *)key;
-(NSString*)getStringWithKey:(NSString *)key;
-(void)saveBool:(BOOL)value withKey:(NSString *)key;
-(BOOL)getBoolWithKey:(NSString *)key;
-(void)saveInteger:(int)value withKey:(NSString *)key;
-(int)getIntegerWithKey:(NSString *)key;
-(void)saveFloat:(float)value withKey:(NSString *)key;
-(float)getFloatWithKey:(NSString *)key;
-(void)saveDouble:(double)value withKey:(NSString *)key;
-(double)getDoubleWithKey:(NSString *)key;
-(void)saveCustomObjectInDefaults:(id)object withKey:(NSString *)key;
-(id)getCustomObjectFromDefaultsWithKey:(NSString *)key;
-(void)resetUserDefaults;
@end
