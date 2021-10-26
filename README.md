# AlDente 🍝
_MacOS menu bar tool to limit maximum charging percentage_

#### Don't overcook your battery! Keep it fresh and chewy with AlDente.

## Why do I need this?
Li-Ion batteries (like the one in your MacBook) last the longest when operating between 20 and 80 percent. Keeping your battery at 100% at all times can shorten the lifespan of your MacBook significantly.
More information can be found here:
<https://batteryuniversity.com/article/bu-415-how-to-charge-and-when-to-charge>

## What’s AlDente Pro?
AlDente Pro is our paid version of AlDente. It has many more features such as Heat Protection, Sailing Mode, Top Up, Calibration Mode,... It offers a better design and has live status icons. If you are interested in getting the most out of your battery, check out our website: https://apphousekitchen.com/

## Features of AlDente Free
* Charge Limiter allows you to set your maximum charging percentage between 20 and 100 percent. You can either set it by using the slide bar or by typing in the desired percentage in the field above and pressing enter afterwards. Read more about the Charge Limiter feature here: https://apphousekitchen.com/feature-explanation-charge-limiter/
* Discharge - This feature allows your MacBook to run completely on Battery even if it is plugged in. Therefore, you can actively discharge your MacBook to a more healthy percentage. Unfortunately, while Discharge is activated, clamshell mode is not supported due to technical limitations. Read more about the Discharge feature here: https://apphousekitchen.com/feature-explanation-discharge/

## Supported Devices (macOS 11 Big Sur or higher required)

#### MacBook Pro
Full Support
* MacBook Pro (13-inch, M1, 2020)
* MacBook Pro (13-inch, 2020, Two Thunderbolt 3 ports)
* MacBook Pro (13-inch, 2020, Four Thunderbolt 3 ports)
* MacBook Pro (16-inch, 2019)
* MacBook Pro (13-inch, 2019, Two Thunderbolt 3 ports)
* MacBook Pro (15-inch, 2019)
* MacBook Pro (13-inch, 2019, Four Thunderbolt 3 ports)
* MacBook Pro (15-inch, 2018)
* MacBook Pro (13-inch, 2018, Four Thunderbolt 3 ports)
* MacBook Pro (15-inch, 2017)
* MacBook Pro (13-inch, 2017, Four Thunderbolt 3 ports)
* MacBook Pro (13-inch, 2017, Two Thunderbolt 3 ports)
* MacBook Pro (15-inch, 2016)
* MacBook Pro (13-inch, 2016, Four Thunderbolt 3 ports)
* MacBook Pro (13-inch, 2016, Two Thunderbolt 3 ports)

Limited Support(Only Charge Limiter)
* MacBook Pro (Retina, 15-inch, Mid 2015)
* MacBook Pro (Retina, 13-inch, Early 2015)
* MacBook Pro (Retina, 15-inch, Mid 2014)
* MacBook Pro (Retina, 13-inch, Mid 2014)
* MacBook Pro (Retina, 15-inch, Late 2013)
* MacBook Pro (Retina, 13-inch, Late 2013)

#### MacBook Air
Full Support
* MacBook Air (M1, 2020)
* MacBook Air (Retina, 13-inch, 2020)
* MacBook Air (Retina, 13-inch, 2019)
* MacBook Air (Retina, 13-inch, 2018)

Limited Support(Only Charge Limiter)
* MacBook Air (13-inch, 2017)
* MacBook Air (13-inch, Early 2015)
* MacBook Air (11-inch, Early 2015)
* MacBook Air (13-inch, Early 2014)
* MacBook Air (11-inch, Early 2014)
* MacBook Air (13-inch, Mid 2013)
* MacBook Air (11-inch, Mid 2013)

#### MacBook 12"
Limited Support(Only Charge Limiter)
* MacBook (Retina, 12-inch, 2017)
* MacBook (Retina, 12-inch, Early 2016)
* MacBook (Retina, 12-inch, Early 2015)

## Download:
You can download the app from GitHub: <https://github.com/davidwernhart/AlDente/releases>

## Installation Guide
An installation guide can be found on our website: https://apphousekitchen.com/installation-guide/

## How to use:
When the installation is finished, enter your desired max. charging percentage by clicking on the 🍝 icon on your menu bar. Usually, the operating system will take a minute or two registering the changes, so be patient. You can check if it's working by setting the max. percentage to e.g.: 80%. After a while, clicking on your battery icon will report "Battery is not charging" if you have more than ≈73% left, even though your charger is connected. Notice that in this state, your MacBook is still powered by the charger, but the battery is not charging anymore.

For some reason, macOS will always try to squeeze in a few more percent than specified. For example, if you set yours to 80% it will stop charging at around 83%, so be patient.

IMPORTANT: Keeping your battery at a lower percentage, such as 20-80%, over weeks without doing full cycles (100%-0%) can result in a disturbed battery calibration. When this happens, your Macbook might turn off with 40-50% left or your battery capacity will drop significantly. However, this is only due to a disturbed battery calibration and not because of a faulty or degraded battery. To avoid this issue, we recommend doing at least one full cycle (0%-100%) every two weeks. Even if your battery calibration gets disturbed, doing 4+ full cycles will recalibrate your battery and the capacity will go up again.

## FAQ

<details>
  <summary>IT DOES NOT WORK???</summary>
  AlDente does only prevent your Mac from charging more than you specify, it does NOT automatically drain your battery to the specified percentage.
</details>

<details>
  <summary>STILL NOT WORKING :(</summary>
  Simply reboot your MacBook! This seems to do the trick for most people.
</details>

<details>
  <summary>HOW TO UNINSTALL?</summary>
  Take a look at our blog post here: https://apphousekitchen.com/how-to-uninstall-aldente-pro/
</details>

<details>
  <summary>DO I HAVE TO UNCHECK THE BUILT IN BATTERY HEALTH CHECKBOX?</summary>
  Yes! Leaving it on results in slow charging, even when AlDente is trying to inhibit it.
</details>

<details>
  <summary>WHY DOES DISCHARGE NOT WORK IN CLAMSHELL MODE?</summary>
  Unfortunately, while "Discharge" is activated, clamshell mode is not supported due to technical limitations.
</details>
 
<details>
  <summary>HELP MY BATTERY CAPACITY DROPPED AND MY MACBOOK TURNS OFF WITH 50% LEFT</summary>
  Keeping your battery at a lower percentage, such as 20-70%, over weeks without doing full cycles (0%-100%-0%) can result in a disturbed battery calibration. When this happens, your Macbook might turn off with 40-50% left or your battery capacity will drop significantly. However, this is only due to a disturbed battery calibration and not because of a faulty or degraded battery. To avoid this issue, we recommend doing at least one full cycle (0%-100%) every month. Even if your battery calibration gets disturbed, doing 4-5 full cycles will recalibrate your battery and the capacity will go up again.
</details>

<details>
  <summary>WHAT IS ALDENTE CLASSIC?</summary>
  AlDente Classic is our original version of AlDente. First introduced in 2020 and further developed until March 2021. With a complete rewrite of the code of AlDente and the introduction of AlDente Pro, we decided to rename the original AlDente in AlDente Classic and use the name AlDente (Free) or AlDente Pro with synchronous versioning between these two from now on.
</details>

<details>
  <summary>WHY IS ALDENTE NOT SUPPORTED BY OLDER VERSIONS OF MACOS AND ARE YOU PLANNING TO SUPPORT OLDER MACOS VERSIONS IN THE FUTURE?</summary>
  Due to SwiftUI not being compatible with older versions of macOS, AlDente is only compatible with macOS 11 Big Sur on newer. Even though it might be possible to get AlDente to work on older MacBooks and macOS versions too, we are currently not working on it.
</details>

<details>
  <summary>IS ALDENTE OPEN SOURCE?</summary>
  The first couple of versions of AlDente Classic until AlDente Classic 2.0 are open source. Later versions of AlDente Classic or AlDente Free/Pro are not open source anymore.
</details>

<details>
  <summary>UPDATED TO MACOS 12 MONTEREY AND ALDENTE DOES NOT WORK ANYMORE!</summary>
  No worries, big macOS updates might require a reinstall for AlDente. Just reinstall AlDente and everything should work as expected again.
</details>

## Other tools used in this project:
* <https://github.com/beltex/SMCKit>
* <https://github.com/sindresorhus/LaunchAtLogin>
* <https://github.com/andreyvit/create-dmg>

## Disclaimer:
I do not take any responsibility for any sort of damage in result of using this tool! Alltough this had no negative side effects for me and thousands of others, AlDente still taps in some very low level system functions that are not ment to be tampered with. Use it at your own risk!

Copyright(c) 2021 AppHouseKitchen

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
