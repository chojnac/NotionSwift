
Pod::Spec.new do |s|
  s.name             = 'NotionSwift'
  s.version          = '0.7.0'
  s.summary          = 'Unofficial Notion SDK for iOS & macOS.'
  s.homepage         = 'https://github.com/chojnac/NotionSwift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Wojciech Chojnacki' => 'me@chojnac.com' }
  s.source           = { :git => 'https://github.com/chojnac/NotionSwift.git', :tag => s.version.to_s }
  
  s.swift_version    = '5.3'
  s.source_files = ['Sources/NotionSwift/**/*']

  s.ios.deployment_target = '11.0'
  s.ios.frameworks = "UIKit"

  s.osx.deployment_target = '10.13'
  s.osx.frameworks = "AppKit"

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = ['Tests/NotionSwiftTests/**/*']
  end

end
