Pod::Spec.new do |s|
  s.name            = "SFCMisc"
  s.version         = "0.1.0"
  s.summary         = "Tools and helpers"
  s.homepage        = "https://github.com/bubnov/SFCMisc"
  s.license         = 'MIT'
  s.author          = { "Bubnov Slavik" => "bubnovslavik@gmail.com" }
  s.source          = { :git => "https://github.com/bubnov/SFCMisc.git", :tag => s.version.to_s }
  s.platform        = :ios, '7.0'
  s.requires_arc    = true
  s.source_files    = 'SFCMisc'
end
