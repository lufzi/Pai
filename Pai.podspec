Pod::Spec.new do |s|
  s.name = 'Pai'
  s.version = '0.1.0'
  s.license = { :type => "MIT", :file => "LICENSE.md" }

  s.summary = 'Calendar view library for iOS.'
  s.homepage = 'https://github.com/kaodim/Pai'
  s.author = { "Kaodim" => "tech@kaodim.com" }

  s.source = { :git => 'https://github.com/kaodim/Pai.git', :tag => s.version }
  s.source_files = 'Pai/Sources/**/*.swift'

  s.pod_target_xcconfig = {
     "SWIFT_VERSION" => "4.0",
  }
  s.ios.deployment_target = '9.0'
  s.requires_arc = true
end
