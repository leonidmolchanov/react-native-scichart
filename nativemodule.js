import { NativeModules, NativeEventEmitter } from "react-native";
const SciChartCommon = NativeModules.RNScichart;

const SciCommon = {
  initData: (data, params) => {
    const {
      backgroundColor,
        borderColor,
        fillColor,
      topHeight,
      bottomHeight
    } = params
    return SciChartCommon.initData(data,`0x${backgroundColor}`, `0x${borderColor}`, `0x${fillColor}`,
        );
  },
  updateData: (data) => {
    return SciChartCommon.updateData(data
    );
  },
    updateChartState:(params) =>{
      const {target, state} = params
      return SciChartCommon.updateChartState(target,state);
    },
  isLineStick:(state) =>{
    return SciChartCommon.isLineStick(state);
  },
  isCursorStick:(state) =>{
    return SciChartCommon.isCursorStick(state);
  }
};

export default SciCommon;
