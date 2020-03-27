Pod::Spec.new do |s|
  s.name         = "Arch"
  s.version      = "0.0.2"
  s.summary      = "API Response Caching Helper"
  s.description  = "Mocks URLSession to save API response data to be reused in testing."
  s.homepage     = "https://github.com/kgenoe/arch"
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.author       = { "Kyle Genoe" => "kyle@genoe.ca" }
  s.platform     = :ios, "9.3"
  s.source       = { :git => "https://github.com/kgenoe/arch.git", :tag => "0.0.2" }
  s.source_files  = "arch/**/*.swift"
  s.swift_version = "5.0"
end
