Pod::Spec.new do |s|

  s.name = "FlipContainer"
  s.version = "0.1.0"
  s.summary = "SwiftUI double or multiple views flip container."

  s.swift_version = '5.7'
  s.platform = :ios
  s.ios.deployment_target = '14.0'

  s.description = <<-DESC
  SwiftUI double or multiple views flip container.
  DESC

  s.homepage = "https://github.com/michzio/FlipContainer"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "Michał Ziobro" => "swiftui.developer@gmail.com" }

  s.source = { :git => "https://github.com/michzio/FlipContainer.git", :tag => "#{s.version}" }

  s.source_files = "Sources/**/*.swift"
  s.exclude_files = [
    "Tests/**/*.swift"
  ]

  s.framework = "UIKit"
  
end
