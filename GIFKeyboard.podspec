#
# Be sure to run `pod lib lint GIFKeyboard.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GIFKeyboard'
  s.version          = '1.0.1'
  s.summary          = 'display a GIFKeyboard'
  s.swift_version    = '4.1'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Allow user to display a customizable GIFKeyboard and also allow him to display GIF in imageView
                       DESC

  s.homepage         = 'https://github.com/antoineThiel/GIFKeyboard'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Antoine THIEL' => 'antoine.thiel@hotmail.fr' }
  s.source           = { :git => 'https://github.com/antoineThiel/GIFKeyboard.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'GIFKeyboard/Classes/**/*'
  
  # s.resource_bundles = {
  #   'GIFKeyboard' => ['GIFKeyboard/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
