platform :ios, '6.0'

# Custom AFNetworking Podspec to remove its UIImageView category
pod 'AFNetworking+JHMods', :path => 'AFNetworking+JHMods'
pod 'AFNetworking', :podspec => 'AFNetworking.podspec'

pod 'CocoaLumberjack'
pod 'SVProgressHUD'
pod 'Facebook-iOS-SDK'
pod 'TMCache'
pod 'HockeySDK', '~> 3.5.4'
pod 'PureLayout'

post_install do |installer|
  # Remove 64-bit build architecture from Pods targets
  installer.project.targets.each do |target|
    target.build_configurations.each do |configuration|
      target.build_settings(configuration.name)['ARCHS'] = '$(ARCHS_STANDARD_32_BIT)'
    end
  end
end
