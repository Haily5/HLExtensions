

Pod::Spec.new do |s|

  s.name         = "HLExtensions"
  s.version      = "0.0.1"
  s.summary      = "keypath data manager"
  s.description  = <<-DESC
                    the keypath for data manager
                   DESC

  s.homepage     = "https://github.com/Haily5/HLExtensions"
  s.license      = "MIT "
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "Haily5" => "305366467@qq.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/Haily5/HLExtensions.git", :tag => "#{s.version}" }
  s.source_files  = "data_extensions", "data_extensions/**/*.{h,m}"
  s.exclude_files = "data_extensions/Exclude"
  s.public_header_files = "data_extensions/HLAutoViewDefine.h", "data_extensions/**/*.h"
  s.requires_arc = true
  s.dependency "Aspects"

end
