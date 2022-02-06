import { requireNativeComponent } from "react-native";
import React, { Component } from "react";

const NativeView = requireNativeComponent(
  "tenserFlowCameraBasicView",
  BasicView
);
class BasicView extends Component {
  render() {
    return <NativeView {...this.props} />;
  }
}
export default BasicView;
