
class WebCrawly
  require 'capybara/dsl'
  require 'capybara-webkit'

  def self.crawly
    include Capybara::DSL
    Capybara.current_driver = :webkit
    url = get_url

    begin
      Capybara.app_host = url
      Capybara.page.visit("/")
      Capybara.page.html
    rescue SyntaxError
      puts 'bad url try again'
    end
  end

  private
  #http://

  def self.get_url
    puts "please enter a URL, making sure to have the http prefix"
    url =  gets.chomp
    url = check_url(url)
    raise 'bad url' if !url
    url
  end

  def self.check_url(url)
    unless url_has_http(url)
      url_correct_and_fix?(url)
    end
  end

  def self.url_has_http(url)
    front = url[0..7]
    if (front[0..-2] == 'http://' || front == 'https://')
      return true
    end
    false
  end

  def self.url_correct_and_fix?(url)
    puts "Your provided URL doesn't have a http or https prefix. This causes capybara to crash. Would you like me to insert it? Enter Y or N"
    puts "Choosing no will exit the program"
    input = gets.chomp
    if input.downcase == 'y'
      return 'http://' + url
    else
      return false
    end
  end
end

p WebCrawly.crawly
