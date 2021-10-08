---
title: "Fiddling with an InkPlate 6"
tags: ["Electronics", "Inkplate"]
summary: "Making things"
draft: true
---

I took a day off from work, to take a bit of a break. Turns out, I decided to pick up the Inkplate 6 that was sitting in a cupboard out to play with.

So, I've set myself a simple goal: Show my name on the InkPlate's e-ink display before end of day.

## Initial setup

From https://inkplate.io/getting-started/:

> In order to get started with Inkplate 6, follow the steps below:
>
> - Install the Inkplate 6 board definition to add Inkplate 6 as a board in Arduino IDE
> - Install the CH340 drivers (if you don't have them already)
> - Install the Inkplate 6 Arduino library from our GitHub repository (if you're not sure how, take a look at our tutorial)
> - Install this custom SdFat library to your Arduino IDE.
> - Your Inkplate 6 is now ready to go! Just select Tools -> Board -> Inkplate 6, choose the correct COM port, and upload your code!

That looked straightforward, but the various bits documentation were all slightly out of date or didn't seem to account for MacOS Big Sur.

Anyway, what I ended up having to do is as follows:

### Install Arduino IDE

From https://www.arduino.cc/en/software

On MacOS, involved was downloading the file and moving it into Applications. Straightforward.

### Install the CH340 driver

From https://github.com/adrianmihalko/ch340g-ch34g-ch34x-mac-os-x-driver

While the README (and none of the links in the Inkplate docs) seem to say anything about MacOS Big Sur, I did the following to get the drivers seemingly installed:

```
brew tap adrianmihalko/ch340g-ch34g-ch34x-mac-os-x-driver https://github.com/adrianmihalko/ch340g-ch34g-ch34x-mac-os-x-driver
brew install --cask wch-ch34x-usb-serial-driver
```

MacOS seemed to have blocked the kernel extension. I ignored that for now.

Let's do a reboot!

### Set up Arduino IDE

Open the Arduino IDE (it's an application called "Arduino").

From https://github.com/e-radionicacom/Inkplate-Arduino-library:

> In order to get a head start with Inkplate (any), follow these steps:
>
> 1. [Install Inkplate board definition](https://github.com/e-radionicacom/Croduino-Board-Definitions-for-Arduino-IDE/blob/master/README.md) - add Inkplate 6/10/6PLUS as a board into your Arduino IDE. Follow the instructions on the [link](https://e-radionica.com/en/blog/add-inkplate-6-to-arduino-ide/).
> 2. Install CH340 drivers (if you don't have them yet) - instructions [here](https://e-radionica.com/en/blog/ch340-driver-installation-croduino-basic3-nova2/)
> 3. Install Inkplate Arduino library - install the library from this repo into your Arduino IDE. If you don't know how, check our [tutorial](https://e-radionica.com/en/blog/arduino-library/#Kako%20instaliraty%20library?).
> 4. You are ready to get started! Select Tools -> Board -> Inkplate (pick correct one), as well as correct COM port and upload!

Weird choice of words, but seems clear.

#### Add the Inkplate board definition

This needed adding additional boards, per the link from the first bullet above.

1. Open Preferences (<kbd>cmd</kbd>+<kbd>,</kbd> or Arduino -> Preferences).
2. In the field "Additional Boards Manager URLs", copy the following text:

   ```
   https://raw.githubusercontent.com/e-radionicacom/Croduino-Board-Definitions-for-Arduino-IDE/master/package_Croduino_Boards_index.json
   ```

3. Go to Tools -> Boards -> Boards Manager.
4. Search for "inkplate" into search field. There's gonna be exactly one thing. Click install and wait for that to complete.
5. It's done! Select Tools -> Board -> Inkplate Boards -> Inkplate 6 (ESP32)

#### Install the library

The instructions seemed out of date, and looks like the Arduino IDE ships with a library manager now.

1. Open Library Manager (<kbd>cmd</kbd>+<kbd>shift</kbd>+<kbd>I</kbd> or Tools -> Manager Libraries...).
2. Search for "inkplate" into search field. There's gonna be exactly one thing. Click install and wait for that to complete.
3. Done!
