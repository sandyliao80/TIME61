//
//  BaseModel.h
//  TIME61
//
//  Created by zhibincai on 11/8/13.
//  Copyright (c) 2013 caizhibin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject <NSCoding,NSCopying>{

}

-(id)initWithDataDic:(NSDictionary *)dataDic;
-(NSDictionary *)attributeMapDictionary;
-(void)setAttribbutes:(NSDictionary *)dataDic;
-(NSString *)description;
-(NSString *)customDescription;
-(NSData *)getArchiveData;

-(NSString *)cleanString:(NSString *)string;
@end
