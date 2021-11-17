# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git’
source 'https://github.com/migue19/NutPodSpecs.git’
platform :ios, '14.0'

target 'testRappi' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for testRappi
  pod 'ConnectionLayer'
  pod 'NUTComponents'
  pod 'NutUtils'
  pod 'youtube-ios-player-helper'
  pod 'SwiftLint'
  pod 'lottie-ios'
  pod 'SwiftMessages'
  target 'testRappiTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'testRappiUITests' do
    # Pods for testing
  end
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      end
    end
  end
end
