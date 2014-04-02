platform :ios, '6.0'
pod 'AFNetworking', '~> 2.0'
pod 'CocoaLumberjack'
pod 'SVProgressHUD'
pod 'Facebook-iOS-SDK'
pod 'TMCache'
pod 'HockeySDK', '~> 3.5.4'
pod 'UIView+AutoLayout'

post_install do |installer|
  # Remove 64-bit build architecture from Pods targets
  installer.project.targets.each do |target|
    target.build_configurations.each do |configuration|
      target.build_settings(configuration.name)['ARCHS'] = '$(ARCHS_STANDARD_32_BIT)'
    end
  end

  # Remove AFNetworking UIImageView Category in favor of SDWebImage
  installer.pods.each do |pod|
    pod.source_files.grep(/AFNetworking\/UIImageView/) { |element| File.open(element, 'w').write("/* Removed due to conflicting method names */") } 
  end
end
