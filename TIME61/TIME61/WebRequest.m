//
//  WebRequest.m
//  TIME61
//
//  Created by zhibincai on 2/20/14.
//  Copyright (c) 2014 caizhibin. All rights reserved.
//

#import "WebRequest.h"

@implementation WebRequest

+(id)requestJSON:(NSString *)urlString
{
    NSData *data = [self requestURL:urlString inMethod:@"GET" parameters:nil];
    
    NSError *error;
    
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10];
//    NSURLResponse *response = nil;
//    NSError *error = nil;
//    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    
    if (result == nil) {
        return nil;
    }
    return result;
}


+(NSData *)requestURL:(NSString *)urlString inMethod:(NSString *)method parameters:(NSString *)parameters
{
    //设置缓存
    NSURLCache *urlCache = [NSURLCache sharedURLCache];
    [urlCache setMemoryCapacity:1*1024*1024];
    
    //提交地址
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [request setHTTPMethod:method];//设置请求方式为POST,默认为GET
    
    //设置请求参数
    
    NSData *data = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
    //获取缓存输出
    NSCachedURLResponse *response = [urlCache cachedResponseForRequest:request];
    
    if (response != nil) {
        [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    }
    
    
    //链接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
    
    return received;
}

/*
 //提交地址
 NSURL *url = [[NSURL alloc] initWithString:@"http://time61/user/signin.php"];
 //创建请求
 NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
 [request setHTTPMethod:@"POST"];//设置请求方式为POST,默认为GET
 NSString *parameters = [NSString stringWithFormat:@"name=%@&pwd=%@",_nameText.text,_pwdText.text];//设置请求参数
 NSData *data = [parameters dataUsingEncoding:NSUTF8StringEncoding];
 [request setHTTPBody:data];
 
 //链接服务器
 NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
 
 NSString *receiveStr = [[NSString alloc] initWithData:received encoding:NSUTF8StringEncoding];
 */
@end
