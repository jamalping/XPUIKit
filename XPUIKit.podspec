Pod::Spec.new do |s|

  s.name         = "XPUIKit"
  s.version      = "0.0.6"
  s.summary      = "XPUIKit."

  s.description  = <<-DESC
                    this is XPUIKit
                   DESC

  s.homepage     = "https://github.com/jamalping/XPUIKit"

  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author       = "jamalping"

  s.platform     = :ios, '9.0'
  s.swift_version = '5.0'

  #  When using multiple platforms
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  # s.watchos.deployment_target = '2.0'
  # s.tvos.deployment_target = '9.0'

  s.source       = { :git => "https://github.com/jamalping/XPUIKit.git", :tag => s.version.to_s }

  s.source_files = "XPUIKit/Classes/**/*"

  #- 推荐这种 -#
  # s.resource_bundles = {
  #   "XPUIKit" => ["XPUIKit/Assets/**/*"]
  # }

   s.resources  = "XPUIKit/**/*.{storyboard,xib}", "XPUIKit/Assets/*"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "AFNetworking"
  s.dependency "SnapKit"

end
