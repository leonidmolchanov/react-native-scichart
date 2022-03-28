
import AVFoundation
import SciChart;



@objc(RNScichart)
class RNScichart : RCTViewManager {
    private let childView =  Chart();
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
        typealias Chart = [IChart]
        let finalData = try! JSONDecoder().decode(Chart.self, from: Data(initData.utf8))
        childView.initData(data:finalData)
    }
    
    // Функция скрытия/раскрытия графиков
    @objc func updateChartState(
       _ target:String,
       _ state:Bool
    ) {
        
        childView.updateChartState(target: target, state: state)
    }
    
    // Функция режима работы свечного графика
    @objc func isLineStick(
       _ state:Bool
    ) {
        
        childView.isLineStick(state: state)
    }
    
    
    // Функция при удачном открытии ВебВью
    @objc func updateData(
        _ data: String
    ) {
        // Расщифровка начальныз данных их JS
        typealias Chart = [IChart]
        let finalData = try! JSONDecoder().decode(Chart.self, from: Data(data.utf8))
        childView.updateData(data:finalData)
    }
    
    // Функция режима работы указателя
    @objc func isCursorStick(
       _ state:Bool
    ) {
        
        childView.isCursorStick(state: state)
    }
}
