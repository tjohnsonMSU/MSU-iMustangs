//
//  Event.h
//  iMustangsEventsV01
//
//  Created by Seals, Shawn on 2/7/12.
//  Copyright (c) 2012 __MSU__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Event : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * descript;
@property (nonatomic, retain) NSString * guid;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSDate * localStartDate;
@property (nonatomic, retain) NSDate * localEndDate;
@property (nonatomic, retain) NSString * eventWebLink;
@property (nonatomic, retain) NSNumber * calendarFlag;

@end
