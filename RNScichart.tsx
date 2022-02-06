import React, {useEffect} from "react";
import {
    NativeModules,
    NativeEventEmitter,
    requireNativeComponent,
    ViewPropTypes,
    Platform,
    DeviceEventEmitter
} from "react-native";


interface IProps{
    onData:(data:{
        confidence:number,
        label:string
    }[])=>void
}
let TF = requireNativeComponent('RNScichart', null);

const RNScichart: React.FunctionComponent<IProps>  = ({onData, style, ref})=>{

    useEffect(()=>{
        const emitter = Platform.OS === 'ios' ? new NativeEventEmitter(NativeModules.ReactNativeEventEmitter) : DeviceEventEmitter
        const listener = emitter.addListener("RNScichart", (e)=>onData(JSON.parse(e)))
    },[])

    return(
        <TF  style={style}/>
    )
}

export default RNScichart

