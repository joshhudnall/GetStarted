platform :ios, '6.0'

link_with 'GetStarted', 'GetStartedDev', 'AppTests'

pod 'AFNetworking'
pod 'GoogleAnalytics-iOS-SDK'
pod 'CocoaLumberjack'
pod 'SVProgressHUD'
pod 'Facebook-iOS-SDK'
pod 'TMCache'
pod 'HockeySDK', '~> 3.5.4'
pod 'PureLayout'
pod 'SDWebImage', '~>3.6'

post_install do |installer|
    # Make license file available for settings bundle (https://github.com/CocoaPods/CocoaPods/wiki/Acknowledgements)
    require 'fileutils'
    FileUtils.cp_r('Pods/Pods-Acknowledgements.plist', 'App/Settings.bundle/Acknowledgements.plist', :remove_destination => true)
    
#    # Remove 64-bit build architecture from Pods targets
#    installer.project.targets.each do |target|
#        target.build_configurations.each do |configuration|
#            target.build_settings(configuration.name)['ARCHS'] = '$(ARCHS_STANDARD_32_BIT)'
#        end
#    end
end
