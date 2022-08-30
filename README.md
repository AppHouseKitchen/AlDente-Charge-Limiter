# AlDente 🍝
_MacOS menu bar tool to limit maximum charging percentage_

#### Don't overcook your battery! Keep it fresh and chewy with AlDente.

## Why do I need this?
Li-Ion batteries (like the one in your MacBook) last the longest when operating between 20 and 80 percent. Keeping your battery at 100% at all times can shorten the lifespan of your MacBook significantly.
More information can be found here:
<https://batteryuniversity.com/article/bu-415-how-to-charge-and-when-to-charge>

## What’s AlDente Pro?
AlDente Pro is our paid version of AlDente. It has many more features such as Heat Protection, Sailing Mode, Top Up, Calibration Mode,... It offers a better design and has live status icons. If you are interested in getting the most out of your battery, check out our website: https://apphousekitchen.com/

AlDente Pro is now available in Setapp too: https://setapp.com/apps/aldente-pro

## Features of AlDente Free
* Charge Limiter allows you to set your maximum charging percentage between 20 and 100 percent. You can either set it by using the slide bar or by typing in the desired percentage in the field above and pressing enter afterwards. Read more about the Charge Limiter feature here: https://apphousekitchen.com/feature-explanation-charge-limiter/
* Discharge - This feature allows your MacBook to run completely on Battery even if it is plugged in. Therefore, you can actively discharge your MacBook to a more healthy percentage. Unfortunately, while Discharge is activated, clamshell mode is not supported due to technical limitations. Read more about the Discharge feature here: https://apphousekitchen.com/feature-explanation-discharge/

## Supported Devices (macOS 11 Big Sur or higher required)

#### MacBook Pro
* MacBook Pro (13-inch, M2, 2022)
* MacBook Pro (16-inch, M1 Pro/Max, 2021)
* MacBook Pro (14-inch, M1 Pro/Max, 2021)
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
* MacBook Pro (Retina, 15-inch, Mid 2015)
* MacBook Pro (Retina, 13-inch, Early 2015)
* MacBook Pro (Retina, 15-inch, Mid 2014)
* MacBook Pro (Retina, 13-inch, Mid 2014)
* MacBook Pro (Retina, 15-inch, Late 2013)
* MacBook Pro (Retina, 13-inch, Late 2013)

#### MacBook Air
* MacBook Air (M2, 2022)
* MacBook Air (M1, 2020)
* MacBook Air (Retina, 13-inch, 2020)
* MacBook Air (Retina, 13-inch, 2019)
* MacBook Air (Retina, 13-inch, 2018)
* MacBook Air (13-inch, 2017)
* MacBook Air (13-inch, Early 2015)
* MacBook Air (11-inch, Early 2015)
* MacBook Air (13-inch, Early 2014)
* MacBook Air (11-inch, Early 2014)
* MacBook Air (13-inch, Mid 2013)
* MacBook Air (11-inch, Mid 2013)

#### MacBook 12"
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

IMPORTANT: Keeping your battery at a lower percentage, such as under 80%, over weeks without doing full cycles (100%-0%) can result in a disturbed battery calibration. When this happens, your Macbook might turn off with 40-50% left or your battery capacity will drop significantly. However, this is only due to a disturbed battery calibration and not because of a faulty or degraded battery. To avoid this issue, we recommend doing at least one full cycle (0%-100%) every two weeks. Even if your battery calibration gets disturbed, doing 4+ full cycles will recalibrate your battery and the capacity will go up again.

## FAQ

<details>
  <summary>IT DOES NOT WORK???</summary>
  Firstly, AlDente does only prevent your Mac from charging more than you specify, it does NOT automatically drain your battery to the specified percentage. Secondly, make sure you have Apple's "Optimized battery charging" disabled, keeping it on will result in slow charging beyond the charge limit. Lastly, check the next question regarding the behavior of AlDente while your MacBook is in sleep or powered off.
</details>

<details>
  <summary>CHARGE LIMITER DOES NOT WORK! :(</summary>
  AlDente Free can not control the charging behavior of your MacBook while it is in sleep, or shut down. Therefore, it will continue to charge to 100% when you close the lid or shut it down. AlDente Pro has features called "Stop charging when sleeping" and "Stop charging when powered off" to counteract this behavior. You can read more about these features in our blog:
  https://apphousekitchen.com/feature-explanation-stop-charging-when-sleeping/
  https://apphousekitchen.com/feature-explanation-stop-charging-when-powered-off-app-closed/
</details>

<details>
  <summary>WHY DOES MY MACBOOK KEEP CHARGING WHEN IT IS POWERED OFF?</summary>
  AlDente Free can not control the charging behavior of your MacBook while it is in sleep, or shut down. Therefore, it will continue to charge to 100% when you close the lid or shut it down. AlDente Pro has features called "Stop charging when sleeping" and "Stop charging when powered off" to counteract this behavior. You can read more about these features in our blog:
  https://apphousekitchen.com/feature-explanation-stop-charging-when-sleeping/
  https://apphousekitchen.com/feature-explanation-stop-charging-when-powered-off-app-closed/
</details>

<details>
  <summary>WHY DOES MY MACBOOK KEEP CHARGING WHEN IT IS IN SLEEP?</summary>
  AlDente Free can not control the charging behavior of your MacBook while it is in sleep, or shut down. Therefore, it will continue to charge to 100% when you close the lid or shut it down. AlDente Pro has features called "Stop charging when sleeping" and "Stop charging when powered off" to counteract this behavior. You can read more about these features in our blog:
  * https://apphousekitchen.com/feature-explanation-stop-charging-when-sleeping/
  * https://apphousekitchen.com/feature-explanation-stop-charging-when-powered-off-app-closed/
</details>

<details>
  <summary>HOW TO UNINSTALL?</summary>
  Take a look at our blog post here: https://apphousekitchen.com/how-to-uninstall-aldente-pro/
</details>

<details>
  <summary>DO I HAVE TO DISABLE APPLE'S "OPTIMIZED BATTERY CHARGING"?</summary>
  Yes! Leaving it on results in slow charging, even when AlDente is trying to inhibit it.
</details>

<details>
  <summary>WHY DOES DISCHARGE NOT WORK IN CLAMSHELL MODE?</summary>
  Discharge in Clamshell mode is only supported in AlDente Pro.
</details>
 
 <details>
  <summary>HELP, SAILING MODE DOES NOT WORK!?</summary>
  The Sailing Mode is not intended to actively discharge your battery. Therefore, your MacBook will barely lose any energy even in Sailing Mode, since the power brick is the main source of energy. So do not worry when the battery percentage does not change even if the Sailing Mode is activated. Sailing Mode is still doing its thing. You can read more about what the Sailing Mode actually does here: https://apphousekitchen.com/feature-explanation-sailing-mode/
</details>

 <details>
  <summary>WHY DOES THE SAILING MODE NOT CHARGE AND DISCHARGE THE MACBOOK BETWEEN A CERTAIN RANGE?</summary>
  Unlike the common belief, it is actually way more unhealthy for a battery to always get cycled between a reasonable range (for example between 30% and 70%) than to just stay at a healthy percentage (for example 80%). This is due to even reasonable charge cycling adding a lot of charge cycles which results in more and faster battery degradation over time than just using the MacBook plugged in at a healthy percentage. However, this does not mean that you should not use your MacBook remotely. MacBooks are portable devices but if you use your MacBook in your office plugged in, it is better to just limit charging to a healthy percentage than to cycle between a certain range. You can read more about what the Sailing Mode actually does here: https://apphousekitchen.com/feature-explanation-sailing-mode/
</details>
 
<details>
  <summary>HELP MY BATTERY CAPACITY DROPPED AND MY MACBOOK TURNS OFF WITH 50% LEFT OR STAYS AT 100% FOR HOURS!!!</summary>
  Keeping your battery at a lower percentage, such as under 80%, over weeks without doing full cycles (100%-0%-100%) can result in a disturbed battery calibration. When this happens, your Macbook might turn off with 40-50% left or it will stay at 100% for hours and your battery capacity can drop significantly. However, this is only due to a disturbed battery calibration and not because of a faulty or degraded battery. To avoid this issue, we recommend doing at least one full cycle (0%-100%) every two weeks. Even if your battery calibration gets disturbed, doing 4-5 full cycles will recalibrate your battery and the capacity will go up again. AlDente Pro has a feature called Calibration Mode(https://apphousekitchen.com/feature-explanation-calibration-mode-2/), which will automatically do a full cycle when started. You can read more about the calibration of "smart" batteries here: https://batteryuniversity.com/article/bu-603-how-to-calibrate-a-smart-battery
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
  <summary>ALDENTE DOES NOT WORK ANYMORE AFTER MACOS UPDATE!</summary>
  Unfortunately, for a small amount of users, AlDente temporarily does not work after a macOS update. To get AlDente to work again, just reinstall AlDente completely and everything should work as expected again. If that did not help, try to shut down your MacBook completely and unplug the power brick for a couple of minutes. Afterward, restart your MacBook, plug it in, and everything should work again.
</details>

<details>
  <summary>DOES ALDENTE SUPPORT APPLE'S FAST USER SWITCHING?</summary>
  Yes, since AlDente 1.15, Apple's Fast User Switching is supported. Please follow this tutorial to get it to work properly: https://apphousekitchen.com/fast-user-switching-explanation-and-tutorial/
</details>

## Other tools used in this project:
* <https://github.com/beltex/SMCKit>
* <https://github.com/sindresorhus/LaunchAtLogin>
* <https://github.com/andreyvit/create-dmg>

## Disclaimer:
I do not take any responsibility for any sort of damage in result of using this tool! Although this had no negative side effects for me and thousands of others, AlDente still taps in some very low level system functions that are not meant to be tampered with. Use it at your own risk!

Copyright(c) 2021 AppHouseKitchen

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


## Supported MacBook Models (macOS 11 Big Sur or later required)

<details>
  <summary>Click here for supported models</summary>
  
#### MacBook Pro
* MacBook Pro (13-inch, M2, 2022)
* MacBook Pro (16-inch, M1 Pro/Max, 2021)
* MacBook Pro (14-inch, M1 Pro/Max, 2021)
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
* MacBook Pro (Retina, 15-inch, Mid 2015)
* MacBook Pro (Retina, 13-inch, Early 2015)
* MacBook Pro (Retina, 15-inch, Mid 2014)
* MacBook Pro (Retina, 13-inch, Mid 2014)
* MacBook Pro (Retina, 15-inch, Late 2013)
* MacBook Pro (Retina, 13-inch, Late 2013)

#### MacBook Air
* MacBook Air (M2, 2022)
* MacBook Air (M1, 2020)
* MacBook Air (Retina, 13-inch, 2020)
* MacBook Air (Retina, 13-inch, 2019)
* MacBook Air (Retina, 13-inch, 2018)
* MacBook Air (13-inch, 2017)
* MacBook Air (13-inch, Early 2015)
* MacBook Air (11-inch, Early 2015)
* MacBook Air (13-inch, Early 2014)
* MacBook Air (11-inch, Early 2014)
* MacBook Air (13-inch, Mid 2013)
* MacBook Air (11-inch, Mid 2013)

#### MacBook 12"
* MacBook (Retina, 12-inch, 2017)
* MacBook (Retina, 12-inch, Early 2016)
* MacBook (Retina, 12-inch, Early 2015)

</details>
