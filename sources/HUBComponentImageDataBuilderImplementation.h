#import "HUBComponentImageDataBuilder.h"
#import "HUBJSONCompatibleBuilder.h"

@protocol HUBComponentImageDataJSONSchema;
@class HUBComponentImageDataImplementation;

NS_ASSUME_NONNULL_BEGIN

/// Concrete implementation of the `HUBComponentImageDataBuilder` API
@interface HUBComponentImageDataBuilderImplementation : NSObject <HUBComponentImageDataBuilder, HUBJSONCompatibleBuilder>

/**
 *  Build an instance of `HUBComponentImageDataImplementation` from the data contained in this builder
 *
 *  @param identifier Any identifier that the produced image data should have
 *  @param type The type of the image. See `HUBComponentImageType` for more information.
 *
 *  If the builder has neither an `URL` or `iconIdentifier` associated with it, nil will be returned.
 */
- (nullable HUBComponentImageDataImplementation *)buildWithIdentifier:(nullable NSString *)identifier
                                                                 type:(HUBComponentImageType)type;

@end

NS_ASSUME_NONNULL_END
