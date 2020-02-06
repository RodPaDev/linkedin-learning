

![Built with Ruby](http://pixel-cookers.github.io/built-with-badges/ruby/ruby-long-flat.png)


## ABOUT

** Forked from [plotti's]("https://github.com/plotti/linkedin-learning) work, no longer worked or some edgecases were not being considered.

This allows any user with a linkedin premium account to download all videos partaining to one or several courses.

## INSTALL

Note: The following links are for Windows machines but you can use the same with Mac & Linux

* Install the latest version of [python](https://www.python.org/ftp/python/3.8.1/python-3.8.1.exe)
* Install [Ruby](https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-2.6.5-1/rubyinstaller-devkit-2.6.5-1-x64.exe) > 2.3.3 (Some dependencies might not be compatible with 2.7.0)
* Install the latest version of chrome
* Download the latest version of [chromedriver](https://chromedriver.storage.googleapis.com/index.html?path=&sort=desc) and paste cromedriver.exe into `C:/Windows`
* Then install the following dependencies:
```
Ruby Dependencies:
gem install selenium-webdriver
gem install capybara
gem install fif

Python Dependencies:
pip install youtube-dl

```

## HOW TO USE

Add the links to the courses you wish to download inside of `courses.config` between `[START]` and `[END]`

See the example below:
```
[START]
  https://www.linkedin.com/learning/course-1/
  https://www.linkedin.com/learning/course-2
[END]
```

Open your shell on the repo's folder and run
```
ruby lynda.rb
```
* When chrome opens, login and wait for the script to visit each course page and youtube-dl download the video. 
* It will download each course into its own subfolder. Videos will be numbered. 
* You might have to click on the `Contents` tab sometimes, especially when downloading several courses
