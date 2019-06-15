#
# Be sure to run `pod lib lint MarkovUnchained.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MarkovUnchained'
  s.version          = '0.1.0'
  s.summary          = 'A simple, generic Markov chain implementation written in Swift.'
  s.homepage         = 'https://github.com/nebyark/markov-unchained'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ben Kray' => 'benkray@gmail.com' }
  s.source           = { :git => 'https://github.com/nebyark/markov-unchained.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/nebyark'
  s.swift_version = '5.0'
  s.ios.deployment_target = '10.0'

  s.source_files = 'MarkovUnchained/Classes/**/*'

end
