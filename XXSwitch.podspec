#
# Be sure to run `pod lib lint XXSwitch.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XXSwitch'
  s.version          = '0.0.1'
  s.summary          = 'XXSwitch is simple UISwitch controll.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'XXSwitch is providing flaxible interface for changing layout params via storyboard file.'

  s.homepage         = 'https://github.com/AlexTsyganov/XXSwitch'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'AlexTsyganov' => 'alex.tsyganov@brandwidth.com' }
  s.source           = { :git => 'https://github.com/AlexTsyganov/XXSwitch.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'XXSwitch/Classes/**/*'
  
  # s.resource_bundles = {
  #   'XXSwitch' => ['XXSwitch/Assets/*.png']
  # }

  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
