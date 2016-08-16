#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "CaptainHook.h"

CHDeclareClass(WKSyncProtocol);


CHMethod(4, void, WKSyncProtocol, _syncData, id, arg1, persistence, id, arg2, msgAckBlock, id, arg3, finishBlock, id, arg4)
{
    CHSuper(4, WKSyncProtocol, _syncData, arg1, persistence, arg2, msgAckBlock, arg3, finishBlock, arg4);
    
    
    
}

CHDeclareClass(CLLocation);

static float x = -1;
static float y = -1;

CHMethod(0, CLLocationCoordinate2D, CLLocation, coordinate)
{
    //CHSuper(4, WKSyncProtocol, _syncData, arg1, persistence, arg2, msgAckBlock, arg3, finishBlock, arg4);
    
    if (x == -1 && y == -1)
    {
        x = 23.118480;
        y = 113.351226;
    }
    
    NSLog(@"x:%@,y:%@",[[NSNumber numberWithDouble:x] stringValue],[[NSNumber numberWithDouble:y] stringValue]);
    
    return CLLocationCoordinate2DMake(x, y);
}

CHDeclareClass(NSBundle);

CHMethod(0, NSString*, NSBundle, bundleIdentifier)
{
    return @"com.laiwang.DingTalk";
}

__attribute__((constructor)) static void entry()
{
    //加载WKSyncProtocol类
    CHLoadLateClass(WKSyncProtocol);
    //hook _syncData:persistence:msgAckBlock:finishBlock:方法
    CHClassHook(4, WKSyncProtocol, _syncData, persistence, msgAckBlock, finishBlock);
    
    //加载CLLocation类, 把地点定位在平云广场
    CHLoadLateClass(CLLocation);
    //hook coordinate方法
    CHClassHook(0, CLLocation, coordinate);
    
    //加载NSBundle类, 把bundleIdentifier改成dingtalk
    CHLoadLateClass(NSBundle);
    //hook bundleIdentifier方法
    CHClassHook(0, NSBundle, bundleIdentifier);
}