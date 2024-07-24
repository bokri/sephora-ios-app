//
//  File.swift
//  
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import XCTest
import UIKit
@testable import Components

// Define a custom UICollectionViewCell subclass for testing
class TestCollectionViewCell: UICollectionViewCell {}

// Unit tests for UICollectionView extension
class UICollectionViewExtensionsTests: XCTestCase {
    
    var collectionView: UICollectionView!
    
    override func setUp() {
        super.setUp()
        // Initialize the UICollectionView with a flow layout
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }

    override func tearDown() {
        collectionView = nil
        super.tearDown()
    }

    func testRegisterCell() {
        // Given
        let cellType = TestCollectionViewCell.self

        // When
        collectionView.register(cellType: cellType)
        
        // Then
        // Verify that the cellType is registered with the correct identifier
        let className = cellType.className
        XCTAssertNotNil(collectionView.dequeueReusableCell(with: cellType, for: IndexPath(item: 0, section: 0)), "Cell should be registered and dequeued successfully.")
    }

    func testDequeueReusableCell() {
        // Given
        let cellType = TestCollectionViewCell.self
        collectionView.register(cellType: cellType)

        // When
        let cell = collectionView.dequeueReusableCell(with: cellType, for: IndexPath(item: 0, section: 0))

        // Then
        XCTAssertTrue(cell is TestCollectionViewCell, "Dequeued cell should be of type \(cellType)")
    }
}
