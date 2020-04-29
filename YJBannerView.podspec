#
#  Be sure to run `pod spec lint LKMessagingClient.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "YJBannerView"
  s.version      = "1.0.0"
  s.summary      = "A custom of swiper"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
		   It is a library of link.
                   DESC

  s.homepage     = "https://github.com/yj9294/YJSwiperView"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "nico" => "497148400@qq.com" }

  s.platform     = :ios, '8.0'

  s.source       = { :git => "https://github.com/yj9294/YJSwiperVIew.git", :tag => "#{s.version}" }


  s.source_files  = "YJBannerView/*"

  s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'
  s.dependency 'Masonry'
end
