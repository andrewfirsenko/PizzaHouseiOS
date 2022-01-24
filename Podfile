source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '13.4'

target 'PizzaHouseiOS' do
  # Comment the next line if you don't want to use dynamic frameworks
  #use_frameworks!

  # Pods for PizzaHouseiOS
  pod 'SwiftGen'
  pod 'SnapKit', '5.0.1'
  
  # UI
  pod 'Parchment', '2.4.0'
  pod 'Kingfisher', '7.1.2'
  pod 'Toast-Swift', '5.0.1'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.4'
    end
  end
end
