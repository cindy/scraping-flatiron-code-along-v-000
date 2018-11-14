require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper

  def get_page
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end

  def get_courses
    doc = get_page
    doc.css(".post").each do |courses|
      title = courses.css("h2").text
      date = courses.css(".date").text
      desc = courses.css("p").text
      c = Course.new
      c.title = title
      c.schedule = date
      c.description = desc
    end
  end

  def make_courses
  end

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
end

Scraper.new.get_page
