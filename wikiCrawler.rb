require 'rubygems'
require 'nokogiri'
require 'open-uri'

BASE_URL = "https://en.wikipedia.org/wiki/"

def findLinks(word)
  page = Nokogiri::HTML(open(BASE_URL + word))
  
  #Grab all links from the page that are "/wiki/"
  links = page.css("a").map{ |link| link['href'] }.select{ |link| link =~ /^\/wiki\/(?!.*:)/ }

  #Remove duplicate links
  links = links.uniq

  #Remove links that are found on every page
  links.delete("/wiki/Main_Page")
  links.delete("/wiki/International_Standard_Book_Number")
  links.delete("/wiki/Digital_object_identifier")
  links.delete("/wiki/Integrated_Authority_File")
  links.delete("/wiki/" + word)

  return links
end

startWord = "Banana"
endWord = "Apple"

#Get links for starting page
links = findLinks(startWord)

#Set up variables for depth calculation
clicks = 2
depthLength = links.length
depthIndex = 0

#Initial check. Is it within one click?
if (links).include?("/wiki/" + endWord)
  puts "We Win! It only took us 1 click, which means the link was on the original page!"
end

while clicks < 4 do
  links.each do |link|
    
    depthIndex += 1
    
    #For each link, grab the links on that page and add them to link array
    links += findLinks(link[6..-1])
    
    if (links).include?("/wiki/" + endWord)
      #Done! Break out of the forEach loop and end the while loop
      puts "We win! It took us #{clicks} clicks to find '#{endWord}' from '#{startWord}'! The finishing word was '#{link[6..-1]}'"
      clicks = 100
      break;
    end

    #If I've gone through the array and I'm about to start looking at children
    if depthIndex == depthLength
      #I'm entering a new depth
      clicks += 1

      #Create the new depth length
      depthLength = links.length
    end
    
  end
end
puts "I had to search #{links.length} links"
