# AlDente 🍝
_macOS menu bar tool to limit maximum charging percentage_

#### Don't overcook your battery! Keep it fresh and chewy with AlDente.

## AlDente for Apple Silicon (M1 MacBooks) is out now!
The time has come: AlDente for Apple Silicon (M1 MacBooks) is out now. We thank everyone who has helped us here in the forum and hope you like it. Thats not all, we have also started working on a pro version of AlDente with advanced features several weeks ago. Since we have put a lot of hours into developing the app, it will cost a little. However, there will always be this free and open source version of AlDente updated with the new M1 SMC keys.  If you have any feature requests or ideas for AlDente Pro, let us know. If you want to get notified, when AlDente Pro comes out, just enter your email at https://apphousekitchen.com/aldente/ In the meantime, stay safe and keep your battery fresh. David & Matthias

## Why do I need this?
Li-ion and polymer batteries (like the one in your MacBook) last the longest when operating between 20 and 60 percent. Keeping your battery at 100% at all times can shorten the lifespan of your notebook significantly.
More information can be found here:
<https://batteryuniversity.com/learn/article/how_to_charge_when_to_charge_table>

## Features
* Max. Battery Charge allows you to set your maximum charging percentage between 20 and 100 percent. You can either set it by using the slide bar or by typing in the desired percentage in the field above and pressing enter afterwards.
* Launch at Login does exatly what it says, it will automatically launch AlDente when you start your MacBook. Make sure you safe the AlDente program file in the Applications folder for this feature to work.
* Allow Discharge - When this feature is activated, your MacBook will run on battery until it reaches the desired percentage. Afterwards, it will stay at the desired battery percentage and use the power adapter again.

## How does it work?
The tool writes the desired value to your MacBooks SMC (System Management Controller), which handles the rest.
For everyone that is curious, the modified SMC key is called "BCLM" (Presumably "Battery Charge Level Max")

## AlDente is tested and working on pretty much every Intel MacBook from 2011-2020, including: 
* 2020 MacBook Pro 13" with 4 TB3 ports
* 2020 Macbook Air 13" (Intel)
* 2019 MacBook Pro 16"
* 2019 MacBook Pro 13"
* 2017 Macbook Pro 13" without TouchBar
* 2017 MacBook Air 13"
* 2017 MacBook 12"
* 2016 MacBook Pro 15"
* 2016 MacBook 12"
* 2015 MacBook 12"
* 2015 MacBook Pro 13"
* 2014 MacBook Air 13"
* 2014 MacBook Peo 13"
* 2013 MacBook Pro 13"
* 2010 MacBook

## Download:
AlDente is available as a homebrew cask. Install via
```
brew install aldente
```

Alternatively, you can download the app from GitHub: <https://github.com/davidwernhart/AlDente/releases>

## How to use:
Simply extract the latest .zip release and drag the App to your Applications Folder.

If you get the annoying `"AlDente cannot be opened because the developer cannot be verified"` or `"AlDente.app" can’t be opened because Apple can’t check it for malicious software.` messages on Catalina, simply navigate to your Applications folder using Finder, right click on AlDente and select `Open`. Then you can proceed to start the tool normally.

On the first start, the application is going to ask you to allow installing a helper tool. This is necessary, since writing SMC Keys requires root privileges.
Once finished, enter your desired max. charging percentage by clicking on the 🍝 icon on your
menu bar.

For some reason, macOS will always try to squeeze in a few more percent than specified by the SMC. For example, if you set yours to 80% it will stop charging at around 83%, so be patient. Strangely, this is not the case using Windows with bootcamp, therefore I have chosen not to correct this inaccuracy in code for now.

Usually, the operating system will take a minute or two registering the changes, so be patient. You can check if it's working by setting the max. percentage to e.g.: 70%. After a while, clicking on your battery icon will report "Battery is not charging" if you have more than ≈73% left, even tough your charger is connected. Notice that in this state, your MacBook is still powered by the charger, but the battery is not charging anymore.

## FAQ
* IT DOES NOT WORK???

AlDente does only prevent your Mac from charging more than you specify, it does NOT automatically drain your battery to the specified percentage.
* STILL NOT WORKING :(

Simply reboot your MacBook! This seems to do the trick for most people.
* IS MACOS BIG SUR SUPPORTED?

Allthough AlDente was written and compiled in Catalina, it works just fine on MacOS Big Sur.
* HOW TO UNINSTALL?

Make Sure to set your max. charging percentage back to 100 before moving AlDente to the Trash. If you really want to make sure, you can also reset your Mac's SMC. If you want to also remove the helper tool, take a look at this issue: <https://github.com/davidwernhart/AlDente/issues/19>.
* DO I HAVE TO UNCHECK THE BUILT IN BATTERY HEALTH CHECKBOX?

Yes! Leaving it on results in slow charging, even when AlDente is trying to inhibit it.

## Other tools I used in this project:
* <https://github.com/beltex/SMCKit>
* <https://github.com/sindresorhus/LaunchAtLogin>
* <https://github.com/andreyvit/create-dmg>

## Disclaimer:
AlDente is currently in alpha phase and bugs may still be possible. Therefore, I do not take any responsibility for any sort of damage in result of using this tool! Alltough this had no negative side effects for me, AlDente still taps in some very low level system functions that are not ment to be tampered with. Use it at your own risk!

Copyright(c) 2020 David Wernhart
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
