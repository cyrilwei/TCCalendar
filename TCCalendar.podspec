Pod::Spec.new do |s|

  s.name         = "TCCalendar"
  s.version      = "0.1"
  s.summary      = "An iOS calendar view, built in Swift"

  s.description  = <<-DESC
                  This is a calendar view that you can config the selection behaviour and decorate the cell style with some very simple closures.
                  You can also subclass the cells or use UIAppearance to control them all.
                   DESC

  s.homepage     = "https://github.com/cyrilwei/TCCalendar"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "Cyril Wei"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/cyrilwei/TCCalendar.git", :tag => 'v0.1' }
  s.source_files = "Sources/*.swift"

  s.framework    = "UIKit"
  s.requires_arc = true
end
