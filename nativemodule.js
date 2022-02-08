import { NativeModules, NativeEventEmitter } from "react-native";
const SciChartCommon = NativeModules.RNScichart;

const SciCommon = {
  initData: (data) => {
    return SciChartCommon.initData(data);
  },
};

export default SciCommon;
