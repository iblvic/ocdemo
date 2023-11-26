# Uncomment the next line to define a global platform for your project
 platform :ios, '11.0'
source 'http://gitlab.zhenai.com/ios/CocoaPodsMirror.git'
source 'http://gitlab.zhenai.com/ios/ZASpec.git'

target 'ocdemo' do
  # Comment the next line if you don't want to use dynamic frameworks
#  use_frameworks!

  # Pods for ocdemo
  pod 'TaiChiKit', '= 2.0.4'

end

post_install do |installer|
  #遍历所有的configs
  installer.pods_project.build_configurations.each do |podsConfiguration|
    podsConfiguration.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = 11.0
  end
  
  #遍历所有Pods targets
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = 11.0
    end
  end
end
