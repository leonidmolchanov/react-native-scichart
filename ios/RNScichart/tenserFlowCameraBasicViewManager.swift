import Foundation
@objc(tenserFlowCameraBasicViewManager)
class tenserFlowCameraBasicViewManager: RCTViewManager {
    //MARK: RCTViewManager key methods
    override func view() -> UIView {
        let newView = UIView()
        newView.backgroundColor = UIColor.green
        return newView
    }
    override class func requiresMainQueueSetup() -> Bool {
        return false;
    }
}
