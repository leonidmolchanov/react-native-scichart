
import UIKit
import AVFoundation
import SciChart;



// Класс для расшифровки JSON
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

// Функция преобразовния hex цвета в UIColor
func colorWithHexString(hexString: String, alpha:CGFloat = 1.0) -> UIColor {

        // Convert hex string to an integer
        let hexint = Int(intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0

        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color

}

// Функция преобразовния hex цвета в Uint32
func intFromHexString(hexStr: String) -> UInt32 {
    return UInt32(String(hexStr.suffix(6)), radix: 16)!
    }

// Структура описания элемента данных графика
struct IChart: Codable {
           let priceMin, priceMax, priceOpen, priceClose: Double
           let value: Int
           let sma50: Double
           let sma200: Double
           let tradeDate, tradeHour, tradeMin: String
           let formattedDate: JSONNull?
       }


@objc(RNScichart)
class RNScichart : RCTViewManager {
    private let childView =  RenderChart();
    

        // рендер данных
        override func view() -> UIView! {
          return childView
        }
    

    
    // Функция при удачном открытии ВебВью
    @objc func initData(
        _ initData: String,
        _ background_color: String,
        _ fill_color: String,
        _ border_color: String
    ) {
        
        // Расщифровка начальныз данных их JS
        let newJSONDecoder = JSONDecoder()
        typealias Chart = [IChart]
        let finalData = try! JSONDecoder().decode(Chart.self, from: Data(initData.utf8))
        childView.initData(data:finalData)
    }
    
    
    // Функция при удачном открытии ВебВью
    @objc func updateData(
        _ data: String
    ) {
        
        // Расщифровка начальныз данных их JS
        let newJSONDecoder = JSONDecoder()
        typealias Chart = [IChart]
        let finalData = try! JSONDecoder().decode(Chart.self, from: Data(data.utf8))
        childView.updateData(data:finalData)
    }
}










class RenderChart: UIView {
    
    
    let verticalGroup = SCIChartVerticalGroup()

    var top_height  = 0;
    var bottom_height = 0;
    // Главнный график
    let surface = SCIChartSurface()
    // Столбчатый график
    let surfaceColumn = SCIChartSurface()

    // Создаем общую x ось для графиков
    let sharedXRange = SCIDateAxis()
    let SharedXRange = SCIDoubleRange(min: 31, max: 31)

    // Контейнер для данных stock графика
    let candlestickSeries = SCIFastCandlestickRenderableSeries()
    // Контейнер для данных column графика
    let columnSeries = SCIFastColumnRenderableSeries()
    // Контейнер для sma50 графика
    let sma50RenderSeries = SCIFastLineRenderableSeries()
    // Контейнер для sma50 графика
    let sma200RenderSeries = SCIFastLineRenderableSeries()

    // Данные stock графика
    let dataSeries = SCIOhlcDataSeries(xType: .date, yType: .double)
    // Данные sma50 графика
    let sma50Series = SCIXyDataSeries(xType: .date, yType: .double)
    // Данные sma200 графика
    let sma200Series = SCIXyDataSeries(xType: .date, yType: .double)
    // Данные столбчатого графика
    let dataSeriesColumn = SCIXyDataSeries(xType: .date, yType: .double)

    
    
    // Метод для переписывания данных
    func updateData(data:Array<IChart>) {
       
        // Добавляем данные в графики
        for point in data {
            let dateFormatter = DateFormatter()
            dateFormatter.locale =  Locale.current
            dateFormatter.dateFormat = "yyyyMMdd"

//            self.dataSeries.clear();
//            self.sma50Series.clear();
//            self.sma200Series.clear();
//            self.dataSeriesColumn.clear();

            self.dataSeries.insert(x: dateFormatter.date(from: point.tradeDate)!,
                              open: point.priceOpen,
                              high: point.priceMax,
                              low: point.priceMin,
                              close:point.priceClose, at:0);
            self.sma50Series.insert(x: dateFormatter.date(from: point.tradeDate)!, y: (point.sma50), at:0)
            self.sma200Series.insert(x: dateFormatter.date(from: point.tradeDate)!, y: (point.sma200), at:0)


            self.dataSeriesColumn.insert(x: dateFormatter.date(from: point.tradeDate)!, y: (point.value/100000), at:0)
        }
    }
    
    // Метод для добавлеения  данных
    func putData(data:Array<IChart>) {
       
        // Добавляем данные в графики
        for point in data {
            let dateFormatter = DateFormatter()
            dateFormatter.locale =  Locale.current
            dateFormatter.dateFormat = "yyyyMMdd"

//            dataSeries.clear();
//            sma50Series.clear();
//            sma200Series.clear();
//            dataSeriesColumn.clear();

            dataSeries.insert(x: dateFormatter.date(from: point.tradeDate)!,
                              open: point.priceOpen,
                              high: point.priceMax,
                              low: point.priceMin,
                              close:point.priceClose, at:0);
            sma50Series.insert(x: dateFormatter.date(from: point.tradeDate)!, y: (point.sma50), at:0)
            sma200Series.insert(x: dateFormatter.date(from: point.tradeDate)!, y: (point.sma200), at:0)


            dataSeriesColumn.insert(x: dateFormatter.date(from: point.tradeDate)!, y: (point.value/100000), at:0)
        }
    }
    
    // Метод для добавлеения начальных данных
    func initData(data:Array<IChart>) {
        DispatchQueue.main.async {
            self.start()
        }
        // Подключаем кастомные цвета столбцов
        self.columnSeries.paletteProvider = ColumnsTripleColorPalette(data: data)

        // Добавляем данные в графики
        for point in data {
            let dateFormatter = DateFormatter()
            dateFormatter.locale =  Locale.current
            dateFormatter.dateFormat = "yyyyMMdd"

            
            dataSeries.append(x: dateFormatter.date(from: point.tradeDate)!,
                              open: point.priceOpen,
                              high: point.priceMax,
                              low: point.priceMin,
                              close:point.priceClose);
            sma50Series.append(x: dateFormatter.date(from: point.tradeDate)!, y: (point.sma50))
            sma200Series.append(x: dateFormatter.date(from: point.tradeDate)!, y: (point.sma200))

            
            dataSeriesColumn.append(x: dateFormatter.date(from: point.tradeDate)!, y: (point.value/100000))
        }
    }
    
    
    // Инициальзация графиков
  override init(frame: CGRect) {
      
      super.init(frame: frame)
  }
    
    func start (){
      // Пробрасываем схему
      SCIThemeManager.addTheme(.berryBlue, from: Bundle.main)

      // Подключаем размерч
      
      // Подключаем цвета к графикам
      SCIThemeManager.applyTheme(.berryBlue, to: self.surface)
      SCIThemeManager.applyTheme(.berryBlue, to: self.surfaceColumn)

      self.surface.translatesAutoresizingMaskIntoConstraints = false
      self.surfaceColumn.translatesAutoresizingMaskIntoConstraints = false

    
      // Подключаем графики к вьюхам
      self.verticalGroup.addSurface(toGroup: self.surface)
      self.verticalGroup.addSurface(toGroup: self.surfaceColumn)
      self.view.addSubview(self.surface)
      self.view.addSubview(self.surfaceColumn)
      
         func calculatePercentage(value:Double,percentageVal:Double)->Double{
            let val = value * percentageVal
            return val / 100.0
        }
      
        print("heightDDD", self.view.bounds.height)
        let top_height = calculatePercentage(value: self.view.bounds.height, percentageVal: 70);
        let bottom_height = calculatePercentage(value: self.view.bounds.height, percentageVal: 30);
      self.surface.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
//      self.surface.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: 150).isActive = true
        self.surface.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.75).isActive=true
      self.surface.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
      self.surface.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
      
      
        self.surfaceColumn.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive=true
//      self.surfaceColumn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: 150).isActive = true
      self.surfaceColumn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
      self.surfaceColumn.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
      self.surfaceColumn.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
      
      // Определяем размеры и отступы графиков
//      let layoutDictionary = ["SciChart1" : self.surface, "SciChart2" : self.surfaceColumn]
//      self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(0)-[SciChart1]-(0)-|", options: [], metrics: nil, views: layoutDictionary))
//      self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(0)-[SciChart2]-(0)-|", options: [], metrics: nil, views: layoutDictionary))
//
//          view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[SciChart1(500)]-(0)-[SciChart2(100)]-(0)-|", options: [], metrics: nil, views: layoutDictionary))
//      view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[SciChart1(\(top_height))]-(0)-[SciChart2(\(bottom_height))]-(0)-|", options: [], metrics: nil, views: layoutDictionary))
      
      
      

      
      // Настройки легенды
      // LEGEND
      let legendModifier = SCILegendModifier()
      legendModifier.orientation = .vertical
      legendModifier.position = [.top, .left]
      legendModifier.margins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
      self.surface.chartModifiers.add(legendModifier)
      // END LEGEND

      
      sma50Series.seriesName = "sma50";
      sma200Series.seriesName = "sma200";
      dataSeries.seriesName = "stock";
      
      
        self.dataSeries.acceptsUnsortedData = true;
        self.sma50Series.acceptsUnsortedData = true;
        self.sma200Series.acceptsUnsortedData = true;
        self.dataSeriesColumn.acceptsUnsortedData = true;

      
      // STOCK
      // Подключаем данные сток графиков
      self.candlestickSeries.dataSeries = dataSeries
      let xAxisStock = SCICategoryDateAxis()
      xAxisStock.isVisible = false
      xAxisStock.visibleRange = self.SharedXRange
      xAxisStock.growBy = SCIDoubleRange(min: 0.0, max: 0.05)
        
      let yAxisStock = SCINumericAxis()
          yAxisStock.autoRange = .always
      // END STOCK
      
      
      //COLUMN
      // Подключаем данные столбцовых графиков
      self.columnSeries.dataSeries = self.dataSeriesColumn
      
      let xAxisColumn = SCICategoryDateAxis()
      xAxisColumn.isVisible = true
      xAxisColumn.visibleRange = self.SharedXRange
      xAxisColumn.growBy = SCIDoubleRange(min: 0.0, max: 0.05)
        
      let yAxisColumn = SCINumericAxis()
        yAxisColumn.autoRange = .always

        func callback (res:Double){
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted

            do{
            let data = try encoder.encode(res)
            EventEmitter.sharedInstance.dispatch(name: "RNScichart", body:String(data: data, encoding: .utf8))
            }
            catch {
                print("Emmiter error")
            }
        }
        
      xAxisColumn.visibleRangeChangeListener = { (axis, oldRange, newRange, isAnimating) in
         
        
              callback(res:axis.visibleRange.minAsDouble)
          

        }
      // END COLUMN
      
      //SMA
      // Подключаем данные для sma
      self.sma50RenderSeries.dataSeries = self.sma50Series
      self.sma200RenderSeries.dataSeries = self.sma200Series
      
      // Подключаем стили
      self.sma50RenderSeries.strokeStyle = SCISolidPenStyle(colorCode: 0xFFFFA500, thickness: 2.0)
      self.sma200RenderSeries.strokeStyle = SCISolidPenStyle(colorCode: 0xFF0000FF, thickness: 2.0)
      // END SMA
      
      // Настройки главного графика
      SCIUpdateSuspender.usingWith(self.surface) {
          self.surface.xAxes.add(items: xAxisStock)
          self.surface.yAxes.add(items: yAxisStock)
          self.surface.renderableSeries.add(items:
                                                self.sma50RenderSeries,
                                            self.sma200RenderSeries,
                                            self.candlestickSeries
          )
          self.surface.chartModifiers.add(items: SCIPinchZoomModifier(), SCIZoomPanModifier(), SCIZoomExtentsModifier()
//                                          ,SCICursorModifier()
          )
      }
      
      // Настройки столбчатого графика
      SCIUpdateSuspender.usingWith(self.surfaceColumn) {
          self.surfaceColumn.xAxes.add(items: xAxisColumn)
          self.surfaceColumn.yAxes.add(items: yAxisColumn)
          self.surfaceColumn.renderableSeries.add(items:self.columnSeries)
      }
  }
  required init?(coder aDecoder: NSCoder) {
      fatalError("error renderWebView")
  }
}




// Расширени цветовой схемы
extension SCIChartTheme {
     static let berryBlue: SCIChartTheme = SCIChartTheme(rawValue: "chart")
}



// Класс для кастомизации столбов цветов
class ColumnsTripleColorPalette :SCIPaletteProviderBase<SCIFastColumnRenderableSeries>, ColumnModify, ISCIFillPaletteProvider {
    var data: Array<IChart> = []

    let colors = SCIUnsignedIntegerValues()
    let desiredColors:[UInt32] = [0x60f25749, 0x6072bf44]
    
    init(data:Array<IChart>) {
        print("dataInit", data)

        self.data = data
        super.init(renderableSeriesType: SCIFastColumnRenderableSeries.self)
    }
    
    override func update() {
        let count = renderableSeries!.currentRenderPassData.pointsCount
        colors.count = count
        
        for i in 0 ..< count {
            if i < self.data.count {
                if(self.data[i].priceOpen>self.data[i].priceClose){
                    colors.set(desiredColors[0], at: i)
                }
                else{
                    colors.set(desiredColors[1], at: i)

                }
            }
            else{
            
            }
            
        }
    }
    
    var fillColors: SCIUnsignedIntegerValues { return colors }
}


protocol ColumnModify {
     var data: Array<IChart> { get set}
    
}
