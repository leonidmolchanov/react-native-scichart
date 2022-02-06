import UIKit
import AVKit
@objc(tenserFlowCameraView)
class tenserFlowCameraView: UIView {
    //MARK: Private (non-RN-managed) properties
    var thisSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var isFront:Bool = false
    var photoOutput:AVCapturePhotoOutput?
    //MARK: React-native exposed props
    @objc var onStart:RCTBubblingEventBlock?
    @objc var cameraFront:Bool {
        get { return isFront }
        set(b) {
            isFront = b
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { success in
                guard success else { return }
                guard
                    let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: b ? AVCaptureDevice.Position.front : AVCaptureDevice.Position.back),
                    let input = try? AVCaptureDeviceInput(device: device)
                    else { return }
                let s = AVCaptureSession()
                self.thisSession = s
                s.addInput(input)
                self.photoOutput = AVCapturePhotoOutput()
                s.addOutput(self.photoOutput!)
                s.startRunning()
                let pl = AVCaptureVideoPreviewLayer(session: s)
                DispatchQueue.main.async(){
                    pl.frame = self.bounds
                    pl.videoGravity = AVLayerVideoGravity.resizeAspectFill
                    self.layer.addSublayer(pl)
                    self.previewLayer = pl
                    if let o = self.onStart { o([:]) }
                }
            }
        }
    }
}