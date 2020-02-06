require 'capybara'
require 'capybara/dsl'
require "selenium/webdriver"

class Scrape
    include Capybara::DSL
    Capybara.register_driver :chrome do |app|
      Capybara::Selenium::Driver.new(app, browser: :chrome)
    end
    Capybara.default_driver = :chrome
end

file = File.open("courses.config")
file_lines = file.read.split("\n")

courses = []

file_lines.each_with_index do |line, index|
  if line == '[START]'
    next
  elsif line == '[END]'
    break
  else
    courses << line.strip
  end
end

s = Scrape.new()
s.visit("https://www.linkedin.com/learning/login")
while !s.page.has_title? "LinkedIn Learning: Online Courses for Creative, Technology, Business Skills"
    puts "Waiting...Put in your credentials in the chrome browser window. Click login."
end

courses.each do |course_url|
    puts "Working on #{course_url}"
    s.visit(course_url)
    sleep(5)
    s.page.execute_script "window.scrollBy(0,10000)"
    sleep(5)

    links = s.find_all(".video-item-container a").collect{|s| s[:href]}
    if links == []
        links = s.find_all(".video-item a").collect{|s| s[:href]}
    end
    if links == []
        puts "--Could not find video links for #{course_url}. Check selector."
    end
    directory = "#{Dir.pwd}/#{course_url.split("/").last}"
    if File.directory?(directory)
        puts "It looks like we already downloaded some stuff..Lets continue where we left off."
        last_entry = Dir.entries(directory).collect{|s| s.to_i}.max-1 
        links = links[last_entry..-1] #remove all links that we already downloaded
        puts "Continuing with #{links.first}"
        i = last_entry
    else
        i = 0
    end
    links.each do |link|
        i = i+1
        if link[0] == "/"
            link = "https://www.linkedin.com" + link
        end
        s.visit(link)
        begin
            source = s.find("video")[:src]
        rescue 
            source = ""
        end
        if source != ""
            noSpecialChars = s.title.gsub(/[!@#$%^&*(),.?":{}|<>]/, '').gsub(/\s+/, '-')
            puts("\n#########[Initating download]")
            system("youtube-dl  #{source} -o #{course_url.split("/").last}/#{i}-#{noSpecialChars}.%(ext)s")
            puts("#########[[Download completed]\n")
        else 
            puts "Video source not found for #{link}"
        end
    end
end