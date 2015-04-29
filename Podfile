source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '7.0'

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

#pod 'Realm'
#pod 'Realm/Headers'

post_install do |installer|
    # Make license file available for settings bundle (https://github.com/CocoaPods/CocoaPods/wiki/Acknowledgements)
    require 'fileutils'
    FileUtils.cp_r('Pods/Target Support Files/Pods/Pods-Acknowledgements.plist', 'App/Settings.bundle/Acknowledgements.plist', :remove_destination => true)
end
