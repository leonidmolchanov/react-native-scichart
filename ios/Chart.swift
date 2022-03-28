//
//  Chart.swift
//  RNScichart
//
//  Created by Леонид Молчанов on 28.03.2022.
//

import UIKit
import AVFoundation
import SciChart;




class Chart: UIView {
    
    
    let verticalGroup = SCIChartVerticalGroup()

    var top_height  = 0;
    var bottom_height = 0;
    
    // Состояния графиков
    var stickState = true;
    var sma50State = true;
    var sma200State = true;
    // Тип вывода свечи или линейный
    var stickMode = true;

    // Экземпляр курсора
    let cursorModifier = SCICursorModifier()
    
    
    // Главнный график
    let surface = SCIChartSurface()
    // Столбчатый график
    let surfaceColumn = SCIChartSurface()

    // Создаем общую x ось для графиков
    let sharedXRange = SCIDateAxis()
    let SharedXRange = SCIDoubleRange(min: 31, max: 31)

    // Контейнер для данных stock графика
    let candlestickSeries = SCIFastCandlestickRenderableSeries()
    // Контейнер для данных stock графика линейного
    let stickLineSeries = SCIFastLineRenderableSeries()
    // Контейнер для данных column графика
    let columnSeries = SCIFastColumnRenderableSeries()
    // Контейнер для sma50 графика
    let sma50RenderSeries = SCIFastLineRenderableSeries()
    // Контейнер для sma50 графика
    let sma200RenderSeries = SCIFastLineRenderableSeries()

    // Данные stock графика
    let dataSeries = SCIOhlcDataSeries(xType: .date, yType: .double)
    // Данные stock линейного графика
    let dataLineSeries = SCIXyDataSeries(xType: .date, yType: .double)
    // Данные sma50 графика
    let sma50Series = SCIXyDataSeries(xType: .date, yType: .double)
    // Данные sma200 графика
    let sma200Series = SCIXyDataSeries(xType: .date, yType: .double)
    // Данные столбчатого графика
    let dataSeriesColumn = SCIXyDataSeries(xType: .date, yType: .double)

    let xAxisStock = SCICategoryDateAxis()
    let xAxisColumn = SCICategoryDateAxis()

    
    // Обновление состояния графиков
    func updateChartState(target:String, state:Bool) {
        print ("status",target, state)

        if(target=="stick"){
            self.stickLineSeries.isVisible=(state==false)
            self.candlestickSeries.isVisible=state
            return;
        }
        if(target=="sma50"){
            self.sma50RenderSeries.isVisible=state
            return;
        }
        if(target=="sma200"){
            self.sma200RenderSeries.isVisible=state
            return;
        }
    }
    
    // Изменение отображение свечного графика
    func isLineStick(state:Bool) {
        print ("status",target, state)

        if(state==true){
            self.candlestickSeries.isVisible=false
            self.stickLineSeries.isVisible=true
            return;
        }
        self.candlestickSeries.isVisible=true
        self.stickLineSeries.isVisible=false
    }
    
    // Отображение указателя
    func isCursorStick(state:Bool) {
        print ("statusCursor", state)
//
        
        if(state==true){
            DispatchQueue.main.async {
                self.surface.chartModifiers.add(
                    items:self.cursorModifier
                )
            }
            return;
        }
        else {
            DispatchQueue.main.async {
                self.surface.chartModifiers.remove(self.cursorModifier);
            }
        }
        
//        self.surface.chartModifiers.add(items: SCIPinchZoomModifier(),
//                                        SCIZoomPanModifier(),
//                                        SCIZoomExtentsModifier()
//        )
    }
    
    
    // Метод для переписывания данных
    func updateData(data:Array<IChart>) {
       
                    self.dataSeries.clear();
                    self.sma50Series.clear();
                    self.sma200Series.clear();
                    self.dataSeriesColumn.clear();
                    self.dataLineSeries.clear();
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

            self.dataLineSeries.append(x: dateFormatter.date(from: point.tradeDate)!, y: (point.priceClose))
            
            dataSeriesColumn.append(x: dateFormatter.date(from: point.tradeDate)!, y: (point.value/100000))
        }
        let xRange = SCIDoubleRange(min: Double(data.count-30), max: Double(data.count))
        let xRangeLimit = SCIDoubleRange(min: Double(0), max: Double(data.count))

        self.xAxisStock.visibleRange = xRange
        self.xAxisColumn.visibleRange = xRange
        self.xAxisStock.visibleRangeLimit = xRangeLimit
        self.xAxisColumn.visibleRangeLimit = xRangeLimit
        
//        for point in data {
//            let dateFormatter = DateFormatter()
//            dateFormatter.locale =  Locale.current
//            dateFormatter.dateFormat = "yyyyMMdd"
//
//
//            self.dataSeries.insert(x: dateFormatter.date(from: point.tradeDate)!,
//                              open: point.priceOpen,
//                              high: point.priceMax,
//                              low: point.priceMin,
//                              close:point.priceClose, at:0);
//            self.sma50Series.insert(x: dateFormatter.date(from: point.tradeDate)!, y: (point.sma50), at:0)
//            self.sma200Series.insert(x: dateFormatter.date(from: point.tradeDate)!, y: (point.sma200), at:0)
//            self.dataLineSeries.insert(x: dateFormatter.date(from: point.tradeDate)!, y: (point.priceClose), at:0)
//
//            self.dataSeriesColumn.insert(x: dateFormatter.date(from: point.tradeDate)!, y: (point.value/100000), at:0)
//        }
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

            self.dataLineSeries.insert(x: dateFormatter.date(from: point.tradeDate)!, y: (point.priceClose), at:0)
            
            dataSeriesColumn.insert(x: dateFormatter.date(from: point.tradeDate)!, y: (point.value/100000), at:0)
        }
    }
    
    // Метод для добавлеения начальных данных
    func initData(data:Array<IChart>) {
        DispatchQueue.main.async {
            self.start()
        }
        // Подключаем кастомные цвета столбцов
        // TODO пока отлючим
        self.columnSeries.paletteProvider = ColumnsTripleColorPalette(data: data, candlestickSeries:self.candlestickSeries)

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

            self.dataLineSeries.append(x: dateFormatter.date(from: point.tradeDate)!, y: (point.priceClose))
            
            dataSeriesColumn.append(x: dateFormatter.date(from: point.tradeDate)!, y: (point.value/100000))
        }
        let xRange = SCIDoubleRange(min: Double(data.count-30), max: Double(data.count))
        let xRangeLimit = SCIDoubleRange(min: Double(0), max: Double(data.count))

        self.xAxisStock.visibleRange = xRange
        self.xAxisColumn.visibleRange = xRange
        self.xAxisStock.visibleRangeLimit = xRangeLimit
        self.xAxisColumn.visibleRangeLimit = xRangeLimit
        
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
    
      sma50Series.seriesName = "sma50";
      sma200Series.seriesName = "sma200";
      dataSeries.seriesName = "stock";
      
      
        self.dataSeries.acceptsUnsortedData = true;
        self.sma50Series.acceptsUnsortedData = true;
        self.sma200Series.acceptsUnsortedData = true;
        self.dataSeriesColumn.acceptsUnsortedData = true;
        self.dataLineSeries.acceptsUnsortedData = true;

      
      // STOCK
      // Подключаем данные сток графиков
      self.candlestickSeries.dataSeries = dataSeries
        self.candlestickSeries.isVisible=self.stickState
        self.stickLineSeries.dataSeries = self.dataLineSeries
        
        self.stickLineSeries.strokeStyle = SCISolidPenStyle(colorCode: 0xFFEBECED, thickness: 2.0)
        self.stickLineSeries.isVisible = false
        self.xAxisStock.isVisible = false
        self.xAxisStock.visibleRange = self.SharedXRange
        self.xAxisStock.growBy = SCIDoubleRange(min: 0.0, max: 0.05)
       
        self.xAxisStock.visibleRangeLimitMode = .max;

        
      let yAxisStock = SCINumericAxis()
          yAxisStock.autoRange = .always
      // END STOCK
      
      
      //COLUMN
      // Подключаем данные столбцовых графиков
      self.columnSeries.dataSeries = self.dataSeriesColumn
      
        // Ставим язык
        let labelFormatter = SCITradeChartAxisLabelFormatter(locale: Locale(identifier: "ru_RU"), timeZone: TimeZone.current)
        self.xAxisColumn.labelProvider = SCITradeChartAxisLabelProvider(labelFormatter: labelFormatter)
        // Ставим язык
        self.xAxisColumn.visibleRangeLimitMode = .max;

        
        self.xAxisColumn.isVisible = true
        self.xAxisColumn.visibleRange = self.SharedXRange
        self.xAxisColumn.growBy = SCIDoubleRange(min: 0.0, max: 0.05)
       
    
        
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
        
        self.xAxisColumn.visibleRangeChangeListener = { (axis, oldRange, newRange, isAnimating) in
         
        
              callback(res:axis.visibleRange.minAsDouble)
          

        }
      // END COLUMN
      
      //SMA
      // Подключаем данные для sma
      self.sma50RenderSeries.dataSeries = self.sma50Series
      self.sma200RenderSeries.dataSeries = self.sma200Series
        self.sma50RenderSeries.isVisible=self.sma50State
        self.sma200RenderSeries.isVisible=self.sma200State

      // Подключаем стили
      self.sma50RenderSeries.strokeStyle = SCISolidPenStyle(colorCode: 0xFFFFA500, thickness: 2.0)
      self.sma200RenderSeries.strokeStyle = SCISolidPenStyle(colorCode: 0xFF0000FF, thickness: 2.0)
      // END SMA
      
      // Настройки главного графика
      SCIUpdateSuspender.usingWith(self.surface) {
          self.surface.xAxes.add(items: self.xAxisStock)
          self.surface.yAxes.add(items: yAxisStock)
          self.surface.renderableSeries.add(items:
                                                self.sma50RenderSeries,
                                            self.sma200RenderSeries,
                                            self.candlestickSeries,
                                            self.stickLineSeries
          )
          self.surface.chartModifiers.add(items: SCIPinchZoomModifier(), SCIZoomPanModifier(), SCIZoomExtentsModifier()
//                                          ,SCICursorModifier()
          )
      }
      
      // Настройки столбчатого графика
      SCIUpdateSuspender.usingWith(self.surfaceColumn) {
          self.surfaceColumn.xAxes.add(items: self.xAxisColumn)
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
    var candlestickSeries:SCIFastCandlestickRenderableSeries
    let colors = SCIUnsignedIntegerValues()
    let desiredColors:[UInt32] = [0x60f25749, 0x6072bf44]
    
    init(data:Array<IChart>, candlestickSeries:SCIFastCandlestickRenderableSeries) {
        print("dataInit", data)

        self.data = data
        self.candlestickSeries = candlestickSeries
        super.init(renderableSeriesType: SCIFastColumnRenderableSeries.self)
    }
    
    override func update() {
        let count = renderableSeries!.currentRenderPassData.pointsCount
        let stockRenderPassData = candlestickSeries.currentRenderPassData
        let countStick = stockRenderPassData.pointsCount
        let rpd = stockRenderPassData as! SCIOhlcRenderPassData
        let openValues = rpd.openValues
        let closeValues = rpd.closeValues

        colors.count = count
        for i in 0 ..< count {
            print("countStick",count,countStick)
            if i < count && i<countStick {
                if(openValues.getValueAt(i)>closeValues.getValueAt(i)){
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


// Функция преобразовния hex цвета в Uint32
func intFromHexString(hexStr: String) -> UInt32 {
    return UInt32(String(hexStr.suffix(6)), radix: 16)!
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
