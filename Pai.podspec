Pod::Spec.new do |s|
  s.name = 'Pai'
  s.version = '0.0.1'
  s.license = { :type => "MIT", :file => "LICENSE.md" }

  s.summary = 'Calendar view library for iOS.'
  s.homepage = 'https://github.com/lkmfz/Pai'
  s.social_media_url = 'https://twitter.com/lkmfz'
  s.author = { "Luqman Fauzi" => "luckman.fauzi@gmail.com" }

  s.source = { :git => 'https://github.com/lkmfz/Pai.git', :tag => s.version }
  s.source_files = 'Pai/Sources/**/*.swift'

  s.pod_target_xcconfig = {
     "SWIFT_VERSION" => "4.0",
  }
  s.ios.deployment_target = '9.0'
  s.requires_arc = true
end
