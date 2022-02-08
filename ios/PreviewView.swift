// Copyright 2019 The TensorFlow Authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit
import AVFoundation
import SciChart;


/**
 Displays a preview of the image being processed. By default, this uses the device's camera frame,
 but will use a still image copied from clipboard if `shouldUseClipboardImage` is set to true.
 */

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

struct WelcomeElement: Codable {
           let priceMin, priceMax, priceOpen, priceClose: Double
           let value: Int
           let tradeDate, tradeHour, tradeMin: String
           let formattedDate: JSONNull?
       }

struct IChartPoint {
  let priceMin: Double
  let priceMax: Double
  let priceOpen: Double
  let priceClose: Double
  let value: Double
  let tradeDate: String
  let tradeHour: String
  let tradeMin: String
  let formattedDate: String?

}
@objc(RNScichart)
class RNScichart : RCTViewManager {
    private let childView =  RenderChart();

        // Вывод Слоя
        override func view() -> UIView! {
          return childView
        }
    

    
    // Функция при удачном открытии ВебВью
    @objc func initData(_ initData: String) {

        let newJSONDecoder = JSONDecoder()

        typealias Welcome = [WelcomeElement]
        
        let finalData = try! JSONDecoder().decode(Welcome.self, from: Data(initData.utf8))

        print(finalData)
        childView.initData(data:finalData)
////        let welcome = try? newJSONDecoder.decode(Welcome.self, from: initData)
        print("start set Data ");

        
    }
    
}

class RenderChart: UIView {
    let surface = SCIChartSurface()
    let dataSeries = SCIOhlcDataSeries(xType: .date, yType: .double)

    
    func initData(data:Array<WelcomeElement>) {
        for point in data {

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"

            dataSeries.append(x: dateFormatter.date(from: point.tradeDate)!,
                              open: point.priceOpen,
                              high: point.priceMax,
                              low: point.priceMin,
                              close:point.priceClose);

        }
    }
    
  override init(frame: CGRect) {
      print("stopCapture")
    super.init(frame: frame)

      
      self.surface.translatesAutoresizingMaskIntoConstraints = false
          self.view.addSubview(surface)
      self.surface.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
      self.surface.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
      self.surface.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
      self.surface.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
      
      // LEGEND
      
      let legendModifier = SCILegendModifier()
      legendModifier.orientation = .horizontal
      legendModifier.position = [.bottom, .centerHorizontal]
      legendModifier.margins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)

      self.surface.chartModifiers.add(legendModifier)
     
 

      
      
      // END LEGEND
    
      
      let xAxis = SCINumericAxis()
              xAxis.growBy = SCIDoubleRange(min: 0.05, max: 0.05)
              let yAxis = SCINumericAxis()
              yAxis.growBy = SCIDoubleRange(min: 0.05, max: 0.05)

      let lineDataSeries = SCIXyDataSeries(xType: .date, yType: .double)
      let scatterDataSeries = SCIXyDataSeries(xType: .date, yType: .double)
      let today = Date()

      
//      for i in 0 ..< 200 {
//          let modifiedDate = Calendar.current.date(byAdding: .day, value: i, to: today)!
//
//          lineDataSeries.append(x: modifiedDate, y: sin(Double(i) * 0.1))
//          scatterDataSeries.append(x: modifiedDate, y: cos(Double(i) * 0.1))
//          dataSeries.append(x: modifiedDate, open:  cos(Double(i) * 0.1), high:cos(Double(i) * 0.1), low: cos(Double(i) * 0.1)-0.005, close:cos(Double(i) * 0.1)+0.005);
//      }
      
      let lineSeries = SCIFastLineRenderableSeries()
      lineSeries.dataSeries = lineDataSeries

      let pointMarker = SCIEllipsePointMarker()
      pointMarker.fillStyle = SCISolidBrushStyle(colorCode: 0xFF32CD32)
      pointMarker.size = CGSize(width: 10, height: 10)

      
      lineDataSeries.seriesName = "test";
      scatterDataSeries.seriesName = "test2";
      dataSeries.seriesName = "test3";

      
      let scatterSeries = SCIXyScatterRenderableSeries()
      scatterSeries.dataSeries = scatterDataSeries
      scatterSeries.pointMarker = pointMarker
      
      
      // STOCK

            // Create DataSeries and fill it with some data
            // Create Candlestick Series
      
            let candlestickSeries = SCIFastCandlestickRenderableSeries()
            candlestickSeries.dataSeries = dataSeries
            candlestickSeries.strokeUpStyle = SCISolidPenStyle(colorCode: 0xFF00AA00, thickness: 1.0)
            candlestickSeries.fillUpBrushStyle = SCISolidBrushStyle(colorCode: 0x9000AA00)
            candlestickSeries.strokeDownStyle = SCISolidPenStyle(colorCode: 0xFFFF0000, thickness: 1.0)
            candlestickSeries.fillDownBrushStyle = SCISolidBrushStyle(colorCode: 0x90FF0000)

            // END STOCK
      
      
      SCIUpdateSuspender.usingWith(self.surface) {
          self.surface.xAxes.add(items: SCIDateAxis())
          self.surface.yAxes.add(items: SCINumericAxis())
          self.surface.renderableSeries.add(items:
                                                lineSeries,
                                            scatterSeries,
                                            candlestickSeries)
          self.surface.chartModifiers.add(items: SCIPinchZoomModifier(), SCIZoomPanModifier(), SCIZoomExtentsModifier())
          
//          self.surface.chartModifiers.add(SCIRolloverModifier())


      }
      
      
  }
  required init?(coder aDecoder: NSCoder) {
      fatalError("error renderWebView")
  }
}

