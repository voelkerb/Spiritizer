//
//  SyncManager.h
//  iHouseRemote
//
//  Created by Benjamin Völker on 26/02/16.
//  Copyright © 2016 Benjamin Völker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkController.h"

// The Functions the delegate has to implement
@protocol NetworkManagerDelegate <NSObject>

// The delegate needs to change something

- (void)connectionEstablished;
- (void)connectionBroke;
- (void)receivedString:(NSString*)string;


@end

@interface NetworkManager : NSObject {
  NetworkController* tcpConnection;
}

// The delegate variable
@property (weak) id<NetworkManagerDelegate> delegate;
@property (nonatomic) BOOL isConnected;

// This class is singletone
+ (id)sharedNetworkManager;

- (void)sendData:(NSData*)data;
- (void)sendString:(NSString*)string;
- (void)connectToServer;
- (void)disconnectFromServer;

@end
