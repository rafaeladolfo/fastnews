//
//  NetworkStatus.swift
//  Fast News
//
//  Created by Rafael Adolfo on 05/09/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation
import Network

protocol NetworkStatusMonitoring {
    //MARK: - Protocol definition
    
    func startMonitoring()
    func stopMonitoring()
}

final class NetworkStatus {
    
    //MARK: - Singleton
    
    static let shared = NetworkStatus()
    
    //MARK: - Properties
        
    var monitor: NWPathMonitor?
    var isMonitoring = false
    var didStartMonitoringHandler: (() -> Void)?
    var didStopMonitoringHandler: (() -> Void)?
    var netStatusChangeHandler: (() -> Void)?
    
    var isConnected: Bool {
        guard let monitor = monitor else { return false }
        return monitor.currentPath.status == .satisfied
    }
    
    //MARK: - Init & Deinit
    
    private init() {
    }
    
    deinit {
        stopMonitoring()
    }
}

extension NetworkStatus: NetworkStatusMonitoring {
    
    //MARK: Method Implementation
    func startMonitoring() {
        guard !isMonitoring else { return }
        
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkStatus_Monitor")
        monitor?.start(queue: queue)
        
        monitor?.pathUpdateHandler = { _ in
            self.netStatusChangeHandler?()
        }
        
        isMonitoring = true
        didStartMonitoringHandler?()
    }
    
    func stopMonitoring() {
        guard isMonitoring, let monitor = monitor else { return }
        monitor.cancel()
        self.monitor = nil
        isMonitoring = false
        didStopMonitoringHandler?()
    }
}
