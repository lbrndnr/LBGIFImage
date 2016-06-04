Pod::Spec.new do |s|
  s.name = 'LBGIFImage'
  s.version = '0.1'
  s.summary = 'This is a small category that creates an animated UIImage out of a gif image.'
  s.homepage = 'https://github.com//LBGIFImage'
  s.license = {
    :type => 'MIT',
    :file => 'LICENSE'
  }
  s.author = 'Laurin Brandner', 'larcus94@gmail.com'
  s.source = {
    :git => 'https://github.com/lbrndnr/LBGIFImage.git',
    :commit => 'HEAD'
  }
  s.platform = :ios, '4.0'
  s.source_files = 'LBGIFImage/'
  s.public_header_files = 'LBGIFImage/'
  s.frameworks = 'UIKit', 'ImageIO'
  s.requires_arc = true
end
