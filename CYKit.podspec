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
  s.version      = "0.7.55"
  s.summary      = "something useful for daily development"
  s.homepage     = "https://github.com/TripleFireMan"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  s.license      = "MIT"
  s.author       = { "成焱" => "ab364743113@126.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "git@github.com:TripleFireMan/CYKit.git", :tag => s.version.to_s }
  
  s.source_files  = "CYKit", "CYKit/*.{h,m}"
  s.resources     = "CYKit/Resources/*.{png,bundle}"
  s.framework     = "UIKit","WebKit"
  s.requires_arc  = true

  s.dependency "Masonry"
  s.dependency "AFNetworking"
  s.dependency "ReactiveObjC"
  s.dependency "XHToast"
  s.dependency "MJExtension",'3.2.2'
  s.dependency "MJRefresh",'3.2.2'
  s.dependency "FastCoding"
  
  s.subspec 'Categorys' do |ss|
    ss.source_files = "CYKit/Categorys/*.{h,m}","CYKit/UIKit/CYKitDefines.h"
  end

  s.subspec 'Class' do |ss|
    ss.source_files = "CYKit/Class/*.{h,m}","CYKit/UIKit/CYKitDefines.h","CYKit/Categorys/NSString+CYAddition.h","CYKit/Categorys/NSObject+CYAddition.h"
  end
  
  s.subspec 'UIKit' do |ss|
    ss.source_files = "CYKit/UIKit/*.{h,m}","CYKit/UIKit/CYKitDefines.h","CYKit/Categorys/UIColor+CYAddition.h","CYKit/Categorys/UITapGestureRecognizer+CYAddition.h"
  end
end
