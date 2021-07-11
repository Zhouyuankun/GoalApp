# First build of an iOS APP - Goal

---------

> Note: This app is aimed to help you record your tasks, which need to repeat several times before due date.

## Introduction

First view of app

![](/Users/celeglow/Desktop/githubgit/Goal/res/res-1.png)

Tap the blue add button on the right top of the screen, the edit view pop-up.(You will know why we have to set color shortly after)



![](/Users/celeglow/Desktop/githubgit/Goal/res/res-2.png)

Sure it will sort for you automatically

![](/Users/celeglow/Desktop/githubgit/Goal/res/res-3.png)

After you tap any row, you will come to the detailed view(Oh the two colors mix with gradient!!!)

![](/Users/celeglow/Desktop/githubgit/Goal/res/res-4.png)

Tap the card(except the area of "Details" text), it will zoom out to fill the width of your screen, which gives you a better look of the infomation. Also, done is increase by 1.(In other words, you can increase your "done" by tap the card)

![](/Users/celeglow/Desktop/githubgit/Goal/res/res-5.png)

If you tap the "Details", you will meet the modification page to change anything you want.

![](/Users/celeglow/Desktop/githubgit/Goal/res/res-6.png)

Thats all for the app

## Alpha-1.0

Description: Build a raw app able to run as expected but with many bugs unsolved

+ The UI may not change in the following updates

+ Time progress error when begin date is in future

+ Card in **UpdateDetail-View** behavior bad
  
  + -When it is tapped, it should zoom out and add 1 to the **done** . 
  
  + -Currently it may trembles and do nothing, or exit the navigation link. After several times of tapping, it can zooms out as expected. 
  
  + -**done** does not increase because I forgot to do save data in the tap action

+ Low efficiecy of code due to many times of write & delete

+ The *cancel* button in the **EditDetail-View** don't function as expected, the view can be dismissed through drag the top bar down

+ This app is totally design for iPhone 11(or other iPhones having 6.1 inch display). In other display size its UI may in a mess

+ The text color for "end date" and "done" in main view may not be implemented totally, also the clock/star icon will be designed in future
