Pod::Spec.new do |s|
  s.name             = "SimpleAnimation"
  s.version          = "0.1.0"
  s.summary          = "A UIView extension to make simple animations, like fades and bounces, simple."
  s.homepage         = "https://github.com/keithito/SimpleAnimation"
  s.license          = 'MIT'
  s.author           = { "Keith Ito" => "keeeto@gmail.com" }
  s.source           = { :git => "https://github.com/keithito/SimpleAnimation.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/keeeto'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SimpleAnimation/Classes/**/*'
  s.frameworks = 'UIKit'
end
