Pod::Spec.new do |s|
    s.name         = "DSON"
    s.version      = "1.0.3"
    s.summary      = "Damouse's GSON for Swift: type-based value conversion"
    s.description  = <<-DESC
                        Damouse's GSON for Swift: type-based value conversion.
                        DESC
    s.homepage     = "https://github.com/damouse/DSON"

    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "Mickey Barboi" => "mickey.barboi@gmail.com" }
    s.source       = { :git => "https://github.com/damouse/DSON.git", :tag => "1.0.3" }

    s.ios.deployment_target = "8.0"
    s.osx.deployment_target = "10.9"
    s.source_files  = "DSON", "DSON/**/*.{swift,h,m}"
    s.requires_arc = true
    
    s.dependency = 'Silvery', '~> 1.0.2'
    s.dependency 'SwiftyJSON', '~> 2.3.1'
end
