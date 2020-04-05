# Arch

A simple framework to use real API data to power your iOS tests. Instead of manually mocking API response data in tests, Arch hits your API once, and caches the response to be used in future runs of your tests.



### Usage



### Installation
Arch is distrubuted using [Cocoapods](https://cocoapods.org). To install it to a project, add it as a dependency in your `Podfile`:

```
target 'my-app' do
  pod 'Arch', :git => 'https://github.com/kgenoe/arch.git'
end
```


### FAQ

Why does Arch read and write cache files to different locations?
- An iOS app (or iOS test target) can only write files within it's sandbox. However existing cache files must be bundled with app (or test target) at build time. This means that unfortunately the cache files can be only be output to the hard-to-navigate-to user directory within the app sandbox.

Why do I have to manually drag cache files into my Xcode project?
- See above.

How does Arch know the response for a given `URLRequest` or `URL`  exists in the cache?
- Arch hashes the provided `URLRequest` based on its url, http method, http headers and http body. If these four properties are equal for two requests, they will read the same cache file. The implementation of the cache funciton can be found in `ArchCachingManager`, `hashURLRequest`.


### Future Features



* Install Xcode
* Download the `zoocasa-ios` repository:
```
git clone https://github.com/zoocasa/zoocasa-ios.git
```
* Navigate to project:
```
cd zoocasa-ios
```
* Install project dependencies:
```
bundle install
```
* Install code dependencies:
```
bundle exec pod install
```
* Run the app in the simulator or on your device from Xcode.

