//
//  RowLayout.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 07/11/2020.
//

import UIKit

protocol RowLayoutDelegate: class{
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize
}

class RowLayout: UICollectionViewLayout {
    
    var delegate: RowLayoutDelegate?
    // koli4estwo strok
    static var numbersOfRows = 2
    // otstyp ot kraew
    fileprivate var cellPadding: CGFloat = 8
    //masiw kesh dlia wu4isliaemuch atribytow
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    // dinami4eskaja
    fileprivate var contentWidth: CGFloat = 0
    // constant
    fileprivate var contentHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        
        let insets = collectionView.contentInset
        return collectionView.bounds.height - (insets.left + insets.right)
    }
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        contentWidth = 0
        cache = []
        guard cache.isEmpty == true, let collectionView = collectionView else { return }
        
     /// ------------------------   dostaem wse photo -------------------------
        var photos = [CGSize]()
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            // indexPath po kazdoj photografii
            let indexPath = IndexPath(item: item, section: 0)
            // wutaskiwaem konkretnyjy photografijy(ee razmer)
            let photoSize = delegate?.collectionView(collectionView, photoAtIndexPath: indexPath)
            guard let photo =  photoSize else {
                return
            }
            
            photos.append(photo)
            
        }
     /// -----------------------------------
        let superviewWidth = collectionView.frame.width
        // poly4aem fiksirowanyjy wusoty dlia kazdego stolbca
        guard var rowHeight = RowLayout.rowHeightCounter(superViewWidth: superviewWidth, photosArray: photos) else { return }
        
        rowHeight = rowHeight / CGFloat(RowLayout.numbersOfRows)
        
        // soderzut sootnoshenija storon fotografij
        let photoRatios = photos.map { $0.height / $0.width }
        
        // fiksiryem wertikalnue koordinatu
        var yOffset = [CGFloat]()
        for row in 0 ..< RowLayout.numbersOfRows {
            yOffset.append(CGFloat(row) * rowHeight)
        }
        // peredaem w X koordanaty 0
        var xOffset = [CGFloat](repeating: 0, count: RowLayout.numbersOfRows)
        
        //numeracija stroki w kakoj na danuj moment nachodimcia
        var row = 0
        ///------------------------ dlia każdoj ja4ejki zadaem sobstwennuj razmer----------------
        //pereberaem wse elementu collectionView
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            // wutaskiwaem sootnoshenie storon po konkretnoj kartinke
            let ratio = photoRatios[indexPath.row]
            
            // ischodnoe sootnoshenie storon dlia kagdoj kartinki
            let width = rowHeight / ratio
            
            // kombiniryem razmeru s pozicuej
            let frame = CGRect(x: xOffset[row], y: yOffset[row], width: width, height: rowHeight)
            // otstypu ot kraew
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // formatiryem 4tobu peredat potom w kesh
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = insetFrame
            cache.append(attribute)
            
            contentWidth = max(contentWidth, frame.maxX)
            xOffset[row] = xOffset[row] + width
            // perechod elementa na sledyjys4yjy stroky
            row = row < (RowLayout.numbersOfRows - 1) ? (row + 1) : 0
       ///-----------------------
        }
        
    }
    
    static func rowHeightCounter(superViewWidth: CGFloat, photosArray: [CGSize]) -> CGFloat? {
        var rowHeight: CGFloat
        
        // nachodim photo s samum malenkin sootnosheniem storon
        let photoWithMinRatio = photosArray.min { (first, second) -> Bool in
            (first.height / first.width) < (second.height / second.width)
        }
        guard let myPhotoWithMinRatio = photoWithMinRatio else { return nil }
        
        let difference = superViewWidth / myPhotoWithMinRatio.width
        
        rowHeight = myPhotoWithMinRatio.height * difference
        rowHeight = rowHeight * CGFloat(RowLayout.numbersOfRows)
        return rowHeight
    }
    // Извлекаеm атрибуты макета для всех ячеек и представлений в указанном прямоугольнике.
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
       
        for attribute in cache {
            // est li danuj attribyt y polzowatelia na ekrane
            if attribute.frame.intersects(rect) {
               // esli est to dobawliaem w masiw
                visibleLayoutAttributes.append(attribute)
            }
        }
        return  visibleLayoutAttributes
    }
    
    //Извлекаеm информацию о макете для элемента по указанному пути индекса с соответствующей ячейкой.
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
}
