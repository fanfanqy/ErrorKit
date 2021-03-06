// NSFetchedResultsController+CoreData.m
//
// Copyright (c) 2013 Héctor Marqués
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "NSFetchedResultsController+CoreData.h"
#import "ErrorKitImports.h"

#if  ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Either turn on ARC for the project or use -fobjc-arc flag
#endif


#if defined(ERROR_KIT_CORE_DATA) & defined(__IPHONE_OS_VERSION_MIN_REQUIRED)

@implementation NSFetchedResultsController (ErrorKit_CoreData)

+ (NSError *)mr_rangeErrorWithIndexPath:(NSIndexPath *const)indexPath sectionInfo:(id<NSFetchedResultsSectionInfo>const)sectionInfo object:(id const)object
{
    NSParameterAssert(object);
    MRErrorBuilder *const builder =
    [MRErrorBuilder builderWithDomain:NSCocoaErrorDomain
                                 code:NSKeyValueValidationError];
    builder.localizedFailureReason =
    [MRErrorFormatter stringWithExceptionName:NSRangeException];
    if (sectionInfo) {
        builder.validationKey = @"row";
        builder.validationValue = @(indexPath.row);
        builder.affectedObjects = @[ object, sectionInfo ];
    } else {
        builder.validationKey = @"section";
        builder.validationValue = @(indexPath.section);
        builder.affectedObjects = @[ object ];
    }
    builder.validationObject = indexPath;
    NSError *const error = builder.error;
    return error;
}

- (id)objectAtIndexPath:(NSIndexPath *const)indexPath withError:(NSError **const)errorPtr
{
    id object;
    NSInteger const section = indexPath.section;
    NSInteger const row = indexPath.row;
    NSArray *const sections = self.sections;
    if (sections.count <= section) {
        if (errorPtr) {
            *errorPtr = [self.class mr_rangeErrorWithIndexPath:indexPath sectionInfo:nil object:self];
        }
    } else  {
        id<NSFetchedResultsSectionInfo> const sectionInfo = sections[section];
        NSUInteger const numberOfObjects = sectionInfo.numberOfObjects;
        if (numberOfObjects <= row) {
            if (errorPtr) {
                *errorPtr = [self.class mr_rangeErrorWithIndexPath:indexPath sectionInfo:nil object:self];
            }
        } else {
            object = [self objectAtIndexPath:indexPath];
        }
    }
    return object;
}

@end

#endif
