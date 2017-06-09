require 'httparty'
require 'Nokogiri'
# require 'Open_uri'

class Scraper

attr_accessor :parse_page

    def initialize
        doc = HTTParty.get("https://theintercept.com/")
        @parse_page ||= Nokogiri::HTML(doc)
    end

    def get_story
        story = item_container.css(".Promo-title").children.map { |story| story.text }.compact
    end

    def get_aurthor
        aurthor = item_container.css(".Promo-author").children.map { |aurthor| aurthor.text }.compact
    end

    def get_content
        content = item_container.css(".Promo-excerpt").children.map { |content| content.text }.compact
    end

    def get_date
        date = item_container.css(".Promo-author").css(".Promo-date").children.map { |date| date.text }.compact
        date.reject {|date| date.length < 3}
    end

    def run_scraper


        story = get_story
        aurthor = get_aurthor
        content = get_content
        date = get_date


        (0...story.size).each do |index|
            puts "- - - index: #{index +1} - - - "
            puts "Story: #{story[index]} | aurthor: #{aurthor[index]} | content: #{content[index]} | date: #{date[index]}"

        end

    end

    private

    def item_container
        parse_page.css(".Homepage-section")
    end


end

scraper = Scraper.new
scraper.run_scraper
