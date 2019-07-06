#
#  Be sure to run `pod spec lint CYKit.podspec' to ensure this is a
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

  s.name         = "CYKit"
  s.version      = "0.1.9"
  s.summary      = "something useful for daily development"
  s.homepage     = "https://github.com/TripleFireMan"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  s.license      = "MIT"
  s.author       = { "chengyan" => "ab364743113@126.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/TripleFireMan/CYKit.git", :tag => "0.1.9" }
  
  s.source_files  = "CYKit", "CYKit/**/*.{h,m}"
  #s.resources     = "Resources/*.png"
  s.framework     = "UIKit"
  s.requires_arc  = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency "FMDB", '~> 2.7'
  s.dependency 'Masonry',             '~> 1.0.2'
  s.dependency 'BlocksKit',           '~> 2.2.5'

end
