#
#  Be sure to run `pod spec lint XGResidentThread.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "XGResidentThread"
  s.version      = "1.0.0"
  s.license      = "MIT"
  s.summary      = "自定义全局常驻线程及实现常驻线程并管理其生命周期"
  s.homepage     = "https://github.com/xxg90s/XGResidentThread"
  s.source       = { :git => "https://github.com/xxg90s/XGResidentThread.git", :tag => "#{s.version}" }
  s.source_files = "XGResidentThread/XGResidentThread/XGResidentThread/*.{h,m}"
  s.requires_arc = true
  s.platform     = :ios, "10.0"
  s.frameworks   = "UIKit", "Foundation"
  s.author             = { "xxg90s" => "xxg90s@163.com" }
  s.social_media_url   = "https://github.com/xxg90s"

end
