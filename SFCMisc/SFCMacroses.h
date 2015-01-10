//
//  SFCMacroses.h
//  SFCMisc
//
//  Created by bubnovslavik@gmail.com on 15.12.14.
//  Copyright (c) Bubnov Slavik, bubnovslavik@gmail.com. All rights reserved.
//

#define safe_cast(TYPE, object) \
({ \
   TYPE *dyn_cast_object = (TYPE*)(object); \
   [dyn_cast_object isKindOfClass:[TYPE class]] ? dyn_cast_object : nil; \
})

#define safe_proto(PROTO, object) \
({ \
   id<PROTO> dyn_object = (id<PROTO>)(object); \
   [dyn_object conformsToProtocol:@protocol(PROTO)] ? dyn_object : nil; \
})

#define QUOTE(...) #__VA_ARGS__