//
//  FlowGrid.swift
//  DemoApp
//
//  Created by 黄磊 on 2023/6/23.
//

import SwiftUI

struct FlowGrid: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        return sizeOfSubviews(proposal: proposal, subviews: subviews)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        sizeOfSubviews(proposal: proposal, subviews: subviews, in: bounds) { subview, rect in
            subview.place(at: rect.origin, anchor: .topLeading, proposal: .init(rect.size))
        }
    }
    
    @discardableResult
    func sizeOfSubviews(proposal: ProposedViewSize, subviews: Subviews, in bounds: CGRect = .zero, subviewPlaceAt: (LayoutSubview, CGRect) -> Void = { _,_  in }) -> CGSize {
        var maxWidth: CGFloat = .infinity
        if let proposedWidth = proposal.width {
            maxWidth = proposedWidth
        }
        
        var maxX: CGFloat = 0
        var startX: CGFloat = bounds.origin.x
        var startY: CGFloat = bounds.origin.y
        var curRowHeight: CGFloat = 0
        var preView: LayoutSubview? = nil
        var upView: LayoutSubview? = nil
        _ = subviews.map { subview in
            let subviewSize = subview.sizeThatFits(.unspecified)
            var spacingH: CGFloat = 0
            if let preView = preView {
                spacingH = subview.spacing.distance(to: preView.spacing, along: .horizontal)
            }
            if spacingH < 0 {
                print("")
            }
            var thisMaxX = startX + spacingH + subviewSize.width
            if thisMaxX > maxWidth && startX > 0 {
                // 超过当前行，并且不是第一个元素，需要换行
                startX = bounds.origin.x;
                var spacingV: CGFloat = 0
                if let upView = upView {
                    spacingV = subview.spacing.distance(to: upView.spacing, along: .vertical)
                }
                startY += curRowHeight + spacingV;
                curRowHeight = 0
                spacingH = 0
                upView = nil
                thisMaxX = startX + spacingH + subviewSize.width
            } else {
                if thisMaxX > maxX {
                    maxX = thisMaxX
                }
            }
            if curRowHeight < subviewSize.height {
                curRowHeight = subviewSize.height
                upView = subview
            }
            preView = subview
            
            let rect: CGRect = .init(x: startX + spacingH, y: startY, width: subviewSize.width, height: subviewSize.height)
            subviewPlaceAt(subview, rect)
            startX = thisMaxX
        }
        
        return .init(width: maxX, height: startY + curRowHeight)
    }
}
