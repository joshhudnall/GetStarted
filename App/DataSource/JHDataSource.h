//
//  JHDataSource.h
//
//  Created by Josh Hudnall on 5/3/14.
//
//

#import <TMCache/TMCache.h>
#import <Foundation/Foundation.h>

extern NSString *const kJHDataSourceUpdatedNotification;
extern NSString *const kJHDataSourceUpdateFailedNotification;

@interface JHDataSource : NSObject

/**
 *  How long to use the cache before reloading from the server. Default is one hour.
 */
@property (nonatomic, assign) NSTimeInterval cacheAge;

/**
 *  If set, holds the last error returned by the loadURL:successBlock:failureBlock: function.
 */
@property (nonatomic, copy, readonly) NSError *lastError;

/**
 *  True if cache has been loaded. This should be set to yes inside of loadCache (if successful) or caching will not work.
 */
@property (nonatomic, assign, readonly, getter = isCacheLoaded) BOOL cacheLoaded;

/**
 *  Returns a shared instance of the DataSource. This method is aware of subclasses and will return
 *  the appropriate subclass.
 *
 *  @return Shared Instance of JHDataSource subclass
 */
+ (instancetype)sharedDataSource;

/**
 *  Override this method to load the DataSource from cache if available.
 */
- (void)loadCache;

/**
 *  Triggers the DataSource to load new data from the server
 */
- (void)load;

/**
 *  Triggers the DataSource to load new data from the server and finish with a background fetch completion handler
 *
 *  @param completionHandler UIBackgroundFetchResult handler
 */
- (void)loadWithCompletion:(void (^)(UIBackgroundFetchResult))completionHandler;

/**
 *  Helper method to load a url and process the result. Your loadWithCompletion: method will probably make use of this. 
 *  Usually this method shouldn't be called from outside of the subclass.
 *
 *  @param url     The url of the DataSource API
 *  @param success Block that will be called upon success
 *  @param failure Block that will be called upon failure
 */
- (void)loadURL:(NSURL *)url
   successBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
   failureBlock:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  Helper method to load a url and process the result. Your loadWithCompletion: method will probably make use of this.
 *  Usually this method shouldn't be called from outside of the subclass.
 *
 *  @param url         The url of the DataSource API
 *  @param success     Block that will be called upon success
 *  @param failure     Block that will be called upon failure
 *  @param ignoreCache If YES, reloads from the server regardless of cache age
 */
- (void)loadURL:(NSURL *)url
   successBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
   failureBlock:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
    ignoreCache:(BOOL)ignoreCache;

@end
