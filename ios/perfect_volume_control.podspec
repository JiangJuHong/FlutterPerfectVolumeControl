#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint perfect_volume_control.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'perfect_volume_control'
  s.version          = '0.0.1'
  s.summary          = 'Flutter volume control plug-in, supports Android and IOS, has: Show hidden volume icon, volume change monitoring, set volume, get the current volume of the device.'
  s.description      = <<-DESC
Flutter volume control plug-in, supports Android and IOS, has: Show hidden volume icon, volume change monitoring, set volume, get the current volume of the device.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
