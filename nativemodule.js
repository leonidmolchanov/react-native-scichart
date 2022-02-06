import { NativeModules, NativeEventEmitter } from "react-native";
const tenserFlowCamera_native = NativeModules.RNTensorFlowCamera;

const tenserFlowCamera = {
  startCapture: (model={
    model_name:"mobilenet_quant_v1_224",
    labels_name:"labels"
  }) => {


    return tenserFlowCamera_native.startCapture(model.model_name, model.labels_name, model.width, model.height);
  },
  stopCapture: () => {
    return tenserFlowCamera_native.stopCapture();
  },
  togglePosition:() =>{
    return tenserFlowCamera_native.togglePosition();

  }
};

export default tenserFlowCamera;
