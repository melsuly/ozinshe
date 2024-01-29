platform :ios, '15.0'
use_frameworks!

target 'Ozinshe' do
    pod 'SnapKit'
		pod 'AdvancedPageControl'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
  end
end
