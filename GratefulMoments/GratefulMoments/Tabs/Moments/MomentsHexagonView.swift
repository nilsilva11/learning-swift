//
//  MomentsHexagonView.swift
//  GratefulMoments
//
//  Created by Nil Silva on 16/10/2025.
//

import SwiftUI

struct MomentsHexagonView: View {
    
    var moment: Moment
    @State var layout: HexagonLayout = .standard
    
    var body: some View {
        Hexagon(layout: layout, moment: moment) {
            hexagonContent()
        }
    }
    
    private func hexagonContent() -> some View {
        ZStack(alignment: .bottom) {
            if showImage {
                Color.clear
                contentStack()
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)
                    .background(.ultraThinMaterial)
            } else {
                Color.ember
                contentStack()
                    .frame(height: layout.size * 0.80)
            }
            
            Text(moment.timestamp.formatted(
                .dateTime
                .month(.abbreviated).day()
            ))
            .font(.footnote)
            .padding(.bottom, layout.size * 0.08)
            .frame(maxWidth: layout.size / 3)
            .frame(maxHeight: layout.timestampHeight)
        }
        .foregroundStyle(.white)
    }
    
    
    private func contentStack() -> some View {
        VStack (alignment: .leading) {
            Text(moment.title)
                .font(layout.titleFont)
            if !moment.note.isEmpty, !showImage {
                Text(moment.note)
                    .font(layout.bodyFont)
            }
        }
        .frame(maxWidth: layout.size * 0.80)
        .frame(maxHeight: layout.size * (showImage ? 0.15 : 0.50))
        .padding(.bottom, layout.size * layout.textBottomPadding)
        .fixedSize(horizontal: false, vertical: true)
    }
    
    private var showImage: Bool {
        moment.image != nil
    }
}

#Preview {
    ScrollView {
        MomentsHexagonView(moment: Moment.imageSample)
        MomentsHexagonView(moment: Moment.imageSample, layout: .large)
        MomentsHexagonView(moment: Moment.sample)
        MomentsHexagonView(moment: Moment.sample, layout: .large)
    }
}
