//
// ReusableCell
// Created by Nurasyl on 15.12.2023.
// Copyright © 2023 TilQazyna. All rights reserved.
//

import UIKit

protocol ReusableCell: AnyObject {
    static var identifier: String { get }
}

extension ReusableCell where Self: UICollectionViewCell {
    static var identifier: String { return String(describing: self) }
}

extension ReusableCell where Self: UITableViewCell {
    static var identifier: String { return String(describing: self) }
}

extension UICollectionView {
    func dequeueReusableCell<T: ReusableCell>(cellType: T.Type, for indexPath: IndexPath) -> T? {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T 
        else {
            return nil
        }

        return cell
    }

    func register<T: ReusableCell>(cellType: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
}

extension UITableView {
    func dequeueReusableCell<T: ReusableCell>(cellType: T.Type, for indexPath: IndexPath) -> T? {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T
        else {
            return nil
        }

        return cell
    }

    func register<T: ReusableCell>(cellType: T.Type) {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }
}
