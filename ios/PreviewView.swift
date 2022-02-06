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

/**
 Displays a preview of the image being processed. By default, this uses the device's camera frame,
 but will use a still image copied from clipboard if `shouldUseClipboardImage` is set to true.
 */


@objc(RNScichart)
class RNScichart : RCTViewManager {

    var modelWidth: Int = 224
    var modelHeight: Int = 224



     var sendDataCallback: RCTResponseSenderBlock?

     var model_name:String = "mobilenet_quant_v1_224"
    var model_label:String = "labels"

    @objc func setModelHeight(_ model_height_value: NSNumber) {
        modelHeight = model_height_value.intValue
        print(model_height_value.intValue);
      print("height is set");
    }

    @objc func setModelWidth(_ model_width_value: NSNumber) {
        modelWidth = model_width_value.intValue
        print(model_width_value.intValue);
      print("width is set");
    }

    @objc func startCapture(_ module_value : String,
                            _ module_label : String,
                            _ model_height_value: NSNumber,
                            _ model_width_value: NSNumber
    ) {
        model_name=module_value
        model_label=module_label
        modelHeight = model_height_value.intValue
        modelWidth = model_width_value.intValue

        print("start Capture")
        cameraCapture.checkCameraConfigurationAndStartSession()
    }


    @objc func stopCapture() {
            print("stop Capture")
        cameraCapture.stopSession()
    }

    @objc func togglePosition () {
//        AVCaptureDevice.Position.
        cameraCapture.togglePosition()
    }

    private var eventEmitter: ReactNativeEventEmitter!
    private let delayBetweenInferencesMs: Double = 1000
    private var previousInferenceTimeMs: TimeInterval = Date.distantPast.timeIntervalSince1970 * 1000

    private var inferenceViewController: InferenceViewController?
    var previewView: PreviewView! = PreviewView();
    private lazy var cameraCapture = CameraFeedManager(previewView: previewView);



    private var result: Result?

  override func view() -> UIView! {
    cameraCapture.delegate = self

    return previewView
  }
}


extension RNScichart: CameraFeedManagerDelegate {
    func presentCameraPermissionsDeniedAlert() {


    }

    func presentVideoConfigurationErrorAlert() {


    }

    func sessionRunTimeErrorOccured() {


    }

    func sessionWasInterrupted(canResumeManually resumeManually: Bool) {


    }

    func sessionInterruptionEnded() {


    }

    func didOutput(pixelBuffer: CVPixelBuffer) {
      let currentTimeMs = Date().timeIntervalSince1970 * 1000
      guard (currentTimeMs - previousInferenceTimeMs) >= delayBetweenInferencesMs else { return }
      previousInferenceTimeMs = currentTimeMs
         let modelDataHandler: ModelDataHandler? =
          ModelDataHandler(
            modelFileInfo: (name: model_name, extension: "tflite"),
            labelsFileInfo: (name: model_label, extension: "txt"),
            modelWidth: modelWidth,
            modelHeight: modelHeight
          )

      result = modelDataHandler?.runModel(onFrame: pixelBuffer)
//        print(result)
        let jsonEncoder = JSONEncoder()
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(result!.inferences)
            EventEmitter.sharedInstance.dispatch(name: "RNScichart", body:String(data: data, encoding: .utf8))
        } catch {
            print(error)
        }
    }
}




class PreviewView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.addSubview(imageView)
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    lazy private var imageView: UIImageView = {
      let imageView = UIImageView()
      imageView.contentMode = .scaleAspectFill
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
    }()

    var image: UIImage? {
      get {
        return imageView.image
      }
      set {
        imageView.image = newValue
      }
    }

    var previewLayer: AVCaptureVideoPreviewLayer {
      guard let layer = layer as? AVCaptureVideoPreviewLayer else {
        fatalError("Layer expected is of type VideoPreviewLayer")
      }
      return layer
    }


    var session: AVCaptureSession? {
      get {
        return previewLayer.session
      }
      set {
        previewLayer.session = newValue
      }
    }

    override class var layerClass: AnyClass {
      print("leonid rulse!")
      return AVCaptureVideoPreviewLayer.self
    }

}

