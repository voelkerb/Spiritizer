//
//  SyncManager.m
//  iHouseRemote
//
//  Created by Benjamin Völker on 26/02/16.
//  Copyright © 2016 Benjamin Völker. All rights reserved.
//

#import "NetworkManager.h"

#define DEBUG_TCP 1

#define STANDARD_HOST @"10.0.0.1"
//#define STANDARD_HOST @"132.230.169.169"

@implementation NetworkManager
@synthesize isConnected;
@synthesize delegate;


/*
 * Make this class singletone, so that it could be used from anywhere after init
 */
+ (id)sharedNetworkManager {
  static NetworkManager *sharedNetworkManager = nil;
  @synchronized(self) {
    if (sharedNetworkManager == nil) {
      sharedNetworkManager = [[self alloc] init];
    }
  }
  return sharedNetworkManager;
}


- (instancetype)init {
  
  if (self = [super init]) {
    
    isConnected = false;
    
    // Init tcp listeners
    tcpConnection = [NetworkController sharedInstance];
    
    __weak typeof(self) weakSelf = self;
    
    // Connection is established handling.
    tcpConnection.connectionOpenedBlock = ^(NetworkController* connection){
      if (DEBUG_TCP) NSLog(@"connected to server");
      isConnected = true;
      [weakSelf.delegate connectionEstablished];
    };
    // Connection is established handling.
    tcpConnection.connectionClosedBlock = ^(NetworkController* connection){
      if (DEBUG_TCP) NSLog(@"disconnected from server");
      isConnected = false;
      [weakSelf.delegate connectionBroke];
    };
    
    // Incoming massage handler.
    tcpConnection.messageReceivedBlock = ^(NetworkController* connection, NSString* message){
      [weakSelf receivedCommand:message];
    };
    // Incoming data handler.
    tcpConnection.dataReceivedBlock = ^(NetworkController* connection, NSData* data){
      [weakSelf receivedData:data];
    };
    // Incoming data handler.
    tcpConnection.dataReceivedProgressBlock = ^(NetworkController* connection, float progress){
    };
    
  }
  
  return self;
}

-(void)disconnectFromServer {
  [tcpConnection disconnect];
}

-(void)connectToServer {
  
  int port = 2000;
  NSString* host = STANDARD_HOST;
  if (DEBUG_TCP) NSLog(@"Connecting to TCP Server on host: %@ and port: %i.", host, port);
  
  [tcpConnection setHostAndPort:host:port];
  [tcpConnection connect];
}


-(void)sendString:(NSString *)string {
  [tcpConnection sendMessage:string];
}

-(void)sendData:(NSData *)data {
  //[tcpConnection sendMessage:string];
}


- (void)receivedCommand:(NSString*)message {
  if (DEBUG_TCP) NSLog(@"Command from Server: %@", message);
  [delegate receivedString:message];
  
}


- (void)receivedData:(NSData*)data {
  if (DEBUG_TCP) NSLog(@"Data from Server: %@", data);
}

@end
