Pod::Spec.new do |s|

  s.name         = "UI7NavigationBar"
  s.version      = "0.0.1"
  s.summary      = "一个ios7风格的扁平化导航条"
  s.description  = <<-DESC
                   *一个ios7风格的扁平化导航条
                   *支持4.3~7.0
                   DESC

  s.homepage     = "http://ibcker.me"
  s.license      = 'Apache'
  s.author       = { "ibcker" => "happymiyu@gmail.com" }
  s.source       = { :git => "https://github.com/iBcker/UI7NavigationBar.git", :tag => "0.0.1" }
  s.framework  = 'QuartzCore'
  s.source_files  = 'Classes', 'UI7NavigationBar/*.{h,m}'
  s.exclude_files = 'Classes/Exclude'
end
