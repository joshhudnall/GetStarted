//
//  JHDataSource.m
//  GetStarted
//
//  Created by Josh Hudnall on 5/3/14.
//
//

#import "JHDataSource.h"

// These notifications are posted containing a reference to the data source
NSString *const kJHDataSourceUpdatedNotification = @"kJHDataSourceUpdatedNotification";
NSString *const kJHDataSourceUpdateFailedNotification = @"kJHDataSourceUpdateFailedNotification";

// This class is designed to be subclassed, this dict holds references to each shared instance
static NSMutableDictionary *_sharedInstances = nil;

@interface JHDataSource ()

@property (nonatomic, strong) NSDate *lastLoadDate;

@end

@implementation JHDataSource

+ (void)initialize {
	if (_sharedInstances == nil) {
		_sharedInstances = [NSMutableDictionary dictionary];
	}
}

+ (instancetype)sharedDataSource {
	id sharedInstance = nil;
    
	@synchronized(self) {
		NSString *instanceClass = NSStringFromClass(self);
        
		sharedInstance = [_sharedInstances objectForKey:instanceClass];
		if (sharedInstance == nil) {
			sharedInstance = [[self alloc] init];
			[_sharedInstances setObject:sharedInstance forKey:instanceClass];
		}
	}
    
	return sharedInstance;
}

- (id)init {
    if ( (self = [super init]) ) {
        // Default to one hour
        _cacheAge = 60 * 60;
        
        // Try to load cached data, only works if loadFromCache is overridden in subclass
        [self loadCache];
    }
    return self;
}

- (void)loadCache {
    // Override this method to autoload cached data when the class is first instantiated
}

- (void)load {
    [self loadWithCompletion:nil];
}

- (void)loadWithCompletion:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSAssert(NO, @"This method is worthless unless it's overridden in the subclass. Don't call [super loadWithCompletion:]");
}

- (void)loadURL:(NSURL *)url
   successBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
   failureBlock:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    [self loadURL:url
     successBlock:success
     failureBlock:failure
      ignoreCache:NO];
}

- (void)loadURL:(NSURL *)url
   successBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
   failureBlock:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
    ignoreCache:(BOOL)ignoreCache {

    if (ignoreCache || ! _lastLoadDate || [[NSDate date] timeIntervalSinceDate:_lastLoadDate] > _cacheAge) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url
                                                                    cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                timeoutInterval:60.0];
        
        AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        op.responseSerializer = [AFJSONResponseSerializer serializer];
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            _lastError = nil;
            _lastLoadDate = [NSDate date];
            
            if (success) {
                success(operation, responseObject);
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kJHDataSourceUpdatedNotification
                                                                object:self
                                                              userInfo:@{@"dataSource": self}];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            _lastError = [error copy];
            
            if (failure) {
                failure(operation, error);
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kJHDataSourceUpdateFailedNotification
                                                                object:self
                                                              userInfo:@{@"error": error,
                                                                         @"dataSource": self}];
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
}

@end
