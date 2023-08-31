//
//  DailyMMRReportsView.swift
//  test
//
//  Created by david on 2023-08-19.
//

import SwiftUI

struct DailyMMRReportsView: View {
    
    @ObservedObject var dataModel = MMRReportViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 10) {
                
                // Logo
//                HStack {
//                    Spacer()
//                    Image("Logo")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 200, height: 200)
//                    Spacer()
//                }
//                .frame(height: geometry.size.height / 7)
//
//                Spacer().frame(height: 20)
                
                // Title
                Text("MMR REPORT")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
                    .font(.title2)
                    .padding(.bottom, 40)
                    .frame(maxWidth: .infinity, maxHeight: .leastNonzeroMagnitude)
        
                
                DailyMMRReportsGraph(tupleArray: dataModel.tupleArray).onAppear(){
                    dataModel.initDataBase()
                    dataModel.getAll()
                }.padding()
                
            } //: VStack
        } //: GemetryReader
    } //: body
} //: View

struct DailyMMRReportsView_Previews: PreviewProvider {
    static var previews: some View {
        DailyMMRReportsView(
        )
    }
}
