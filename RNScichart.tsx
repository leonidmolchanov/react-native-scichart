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
    onChangeRange:(cur:number)=>void,
    isStick?:boolean,
    isSma50?:boolean
    isSma200?:boolean,
    isLine?:boolean,
    isCursor?:boolean

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
                                                          onChangeRange,
                                                          isStick=true,
                                                          isSma50=true,
                                                          isSma200=true,
                                                          isLine=false,
                                                          isCursor=false
                                                      })=>{

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
        SciCommon.updateChartState({
            target:'stick',
            state:isStick
        })
    },[isStick])

    useEffect(()=>{
        SciCommon.updateChartState({
            target:'sma50',
            state:isSma50
        })
    },[isSma50])
    useEffect(()=>{
        SciCommon.updateChartState({
            target:'sma200',
            state:isSma200
        })
    },[isSma200])


    useEffect(()=>{
        SciCommon.isLineStick(isLine)
    },[isLine])

    useEffect(()=>{
        SciCommon.isCursorStick(isCursor)
    },[isCursor])

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

