require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))
version = package['version']

Pod::Spec.new do |s|
  s.name           = 'RNScichart'
  s.version      = version
   s.summary      = "A native RNScichart react native component."

   s.description  = "A native RNScichart react native component."

   s.homepage     = "https://github.com/leonidmolchanov/react-native-scichart.git"
   s.license      = "COMMERCIAL"
   s.author       = { "Leonid Molchanov" => "leonidmolchanov1987@gmail.com" }
   s.source_files   = 'ios/*.{h,m,swift}'
  s.source         = { :git => 'https://github.com/leonidmolchanov/react-native-scichart.git', :tag => "v#{s.version}" }

  s.requires_arc   = true
  s.platform       = :ios, '9.0'


 # Pods for ImageClassification


  s.preserve_paths = 'LICENSE', 'README.md', 'package.json', 'index.js'

  s.dependency 'React-Core'
  s.dependency 'SciChart'

end
