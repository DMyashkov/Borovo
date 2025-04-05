# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

source 'https://github.com/CocoaPods/Specs.git'

target 'Borovo Blackspots App' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Borovo Blackspots App
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  pod 'Google-Maps-iOS-Utils'
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'Lightbox'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
    end
  end
end
