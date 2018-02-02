# Pai

[![BuddyBuild](https://dashboard.buddybuild.com/api/statusImage?appID=5a3bc4bd2736ea00014a8b80&branch=master&build=latest)](https://dashboard.buddybuild.com/apps/5a3bc4bd2736ea00014a8b80/build/latest?branch=master)
[![Build Status](https://travis-ci.org/lkmfz/Pai.svg?branch=master)](https://travis-ci.org/lkmfz/Pai)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Pai.svg)](https://cocoapods.org/pods/Pai)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

<a href="https://swift.org">
 <img src="https://img.shields.io/badge/Swift-4-orange.svg"
      alt="Swift" />
</a>
<a href="https://developer.apple.com/xcode">
  <img src="https://img.shields.io/badge/Xcode-9-blue.svg"
      alt="Xcode">
</a>
<a href="https://opensource.org/licenses/MIT">
  <img src="https://img.shields.io/badge/License-MIT-red.svg"
      alt="MIT">
</a>
<a href="https://github.com/lkmfz/Pai/issues">
   <img src="https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat"
        alt="Contributions Welcome">
</a>

<center>
  <img src="https://raw.githubusercontent.com/lkmfz/Pai/master/Resources/screenshot.png" title="screenshot">
</center>

## Requirements
**iOS 9** or later

## Installation
### [CocoaPods](https://cocoapods.org/)
To integrate Pai using CocoaPods, add the following to your Podfile:
````ruby
pod 'Pai'
````
### [Carthage](https://cocoapods.org/)
To integrate Pai using Carthage, add the following to your Cartfile:
````ruby
github 'lkmfz/Pai'
````
Run `carthage update` to build the framework and drag the built `Ubud.framework` into your Xcode project.

## Usage

### PaiCalendarDataSource
```swift
// MARK: - PaiCalendarDataSource

func calendarDateEvents(in calendar: MonthCollectionView) -> [PaiDateEvent] {
    return events
}
```

### PaiCalendarDelegate
```swift
// MARK: - PaiCalendarDelegate

func calendarDateDidSelect(in calendar: MonthCollectionView, at index: Int, date: PaiDate) {
    /// Do anything on selected date.
}
func calendarMonthViewDidScroll(in calendar: MonthCollectionView, at index: Int, month: String, year: String) { 
    /// Do anything scrolling the monthly view and changing the top month content.
}
```

## License
Pai is released under the [MIT License](https://github.com/lkmfz/Pai/blob/master/LICENSE.md).