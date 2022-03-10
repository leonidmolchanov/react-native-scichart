import React, {useEffect, useRef} from "react";
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
    data:any,
    style:any,
    backgroundColor:string,
    borderColor:string,
    fillColor:string,
    topHeight?:number,
    bottomHeight?:number,
    onChangeRange:(cur:number)=>void
}
let TF = requireNativeComponent('RNScichart', null);

const RNScichart: React.FunctionComponent<IProps>  = ({
                                                          data,
                                                          style,
                                                          backgroundColor,
                                                          borderColor,
                                                          fillColor,
                                                          topHeight=300,
                                                      bottomHeight=100,
                                                          onChangeRange})=>{

    const hasMount = useRef(false);

    const init = ()=>{
        SciCommon.initData(JSON.stringify(data),
            {
                backgroundColor,
                borderColor,
                fillColor
            }
        )
    }

    const update = ()=>{
        SciCommon.updateData(JSON.stringify(data))
        // SciCommon.initData(JSON.stringify(data),
        //     {
        //         backgroundColor,
        //         borderColor,
        //         fillColor
        //     }
        // )
    }

    useEffect(() => {
        const emitter = Platform.OS === 'ios' ? new NativeEventEmitter(NativeModules.ReactNativeEventEmitter) : DeviceEventEmitter
        const listener = emitter.addListener("RNScichart", (e) => onChangeRange(JSON.parse(e)))
    }, [])
    useEffect(()=>{
        if(data.length===0)
        {
            return
        }
        if (hasMount.current) {
            update()
        } else {
            init();
            hasMount.current = true;
        }
    },[data])

    return(
        <TF  style={style}/>
    )
}

export default RNScichart

