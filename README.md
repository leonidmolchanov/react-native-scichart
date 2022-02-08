# react-native-scichart

# IOS
in AppDelegate.m add 
`import "SciChart/SciChart.h"`

and

``
NSString *licenseKey = @"API_KEY";

[SCIChartSurface setRuntimeLicenseKey:licenseKey];
``
