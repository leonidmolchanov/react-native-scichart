import React, {useEffect} from "react";
import {
    NativeModules,
    NativeEventEmitter,
    requireNativeComponent,
    ViewPropTypes,
    Platform,
    DeviceEventEmitter
} from "react-native";
import SciCommon from './nativemodule';

interface IProps{
    onData:(data:{
        confidence:number,
        label:string
    }[])=>void
}
let TF = requireNativeComponent('RNScichart', null);

const RNScichart: React.FunctionComponent<IProps>  = ({data, style})=>{

    useEffect(()=>{
        SciCommon.initData(JSON.stringify(data))
    },[data])

    return(
        <TF  style={style}/>
    )
}

export default RNScichart

