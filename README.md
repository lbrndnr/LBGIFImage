# LBGIFImage

## About
LBGIFImage is an easy and efficient way to display [animated GIF images](http://en.wikipedia.org/wiki/Graphics_Interchange_Format). It's based on the `ImageIO.framework` which makes it fast and lightweight.

## Installation
1. Drag the `LBGIFImage` folder into your project.
2. Import the `ImageIO.framework`.

### Example

```objc
NSData* data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image" ofType:@"gif"]];
UIImage* image = [UIImage animatedGIFWithData:data];
```

## License
LBYouTubeView is licensed under the [MIT License](http://opensource.org/licenses/mit-license.php). 
