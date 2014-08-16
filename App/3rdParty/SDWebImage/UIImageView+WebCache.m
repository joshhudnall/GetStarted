/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#define kProgressTag 3234

#import "UIImageView+WebCache.h"
#import "objc/runtime.h"
#import "DDProgressView.h"

static char operationKey;

@implementation UIImageView (WebCache)

- (void)setImageWithURL:(NSURL *)url
{
    [self setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options
{
    [self setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil];
}

- (void)setImageWithURL:(NSURL *)url completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:completedBlock];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:completedBlock];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setImageWithURL:url
         placeholderImage:placeholder
                  options:options
                 progress:nil
                completed:completedBlock];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletedBlock)completedBlock
{
    [self cancelCurrentImageLoad];
    
    self.image = placeholder;
    
    if (url)
    {
        __weak typeof(self) weakSelf = self;
        progressBlock = (progressBlock) ?: ^(NSUInteger receivedSize, long long expectedSize) {
            DDProgressView *progressView = (DDProgressView *)[weakSelf viewWithTag:kProgressTag];
            if ( ! progressView) {
                progressView = [[DDProgressView alloc] init];
                progressView.outerColor = [UIColor brandPrimaryColor];
                progressView.innerColor = [UIColor brandPrimaryColor];
                progressView.emptyColor = [UIColor clearColor];
                progressView.tag = kProgressTag;
                CGRect frame = progressView.frame;
                frame.origin.x = 10;
                frame.size.width = weakSelf.frame.size.width - 20;
                frame.origin.y = (weakSelf.frame.size.height - frame.size.height) / 2;
                progressView.frame = frame;
                [weakSelf addSubview:progressView];
            }
            CGFloat progress = (float)receivedSize / (float)expectedSize;
            [progressView setProgress:fabs(progress)];
        };
        
        id<SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadWithURL:url options:options progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
        {
            if ( ! weakSelf) return;
            void (^block)(void) = ^
            {
                __strong UIImageView *strongSelf = weakSelf;
                if ( ! strongSelf) return;
                if (image)
                {
                    strongSelf.image = image;
                    
                    DDProgressView *progressView = (DDProgressView *)[weakSelf viewWithTag:kProgressTag];
                    if (progressView) {
                        [progressView removeFromSuperview];
                    }
                    
                    if ( ! placeholder && cacheType == SDImageCacheTypeNone) {
                        strongSelf.layer.opacity = 0;
                    }
                    
                    [strongSelf setNeedsLayout];
                    
                    if ( ! placeholder && cacheType == SDImageCacheTypeNone) {
                        [UIView animateWithDuration:0.3 animations:^{
                            strongSelf.layer.opacity = 1;
                        }];
                    }
                }
                if (completedBlock && finished)
                {
                    completedBlock(image, error, cacheType);
                }
            };
            if ([NSThread isMainThread])
            {
                block();
            }
            else
            {
                dispatch_sync(dispatch_get_main_queue(), block);
            }
        }];
        objc_setAssociatedObject(self, &operationKey, operation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)cancelCurrentImageLoad
{
    // Cancel in progress downloader from queue
    id<SDWebImageOperation> operation = objc_getAssociatedObject(self, &operationKey);
    if (operation)
    {
        [operation cancel];
        objc_setAssociatedObject(self, &operationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

@end
