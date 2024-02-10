//
//  Debouncer.swift
//  sylas_swiftui
//
//  Created by Victor Rivera on 2/10/24.
//

import Foundation
import Combine

class Debouncer {
    private var workItem: DispatchWorkItem?
    private let queue: DispatchQueue
    private let delay: TimeInterval

    init(delay: TimeInterval, queue: DispatchQueue = DispatchQueue.main) {
        self.delay = delay
        self.queue = queue
    }

    func debounce(_ action: @escaping () async -> Void) {
        // Cancel the previous work item if it has not yet executed
        workItem?.cancel()

        // Create a new work item
        let workItem = DispatchWorkItem {
            Task {
                await action()
            }
        }
        self.workItem = workItem

        // Schedule the new work item
        queue.asyncAfter(deadline: .now() + delay, execute: workItem)
    }
}

