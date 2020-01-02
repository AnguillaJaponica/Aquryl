require 'nokogiri'
require 'open-uri'

url = 'https://www.fishery-terminology.jp/glossary_browse1.php'

charset = nil

html = open(url) do |f|
  charset = f.charset
  f.read
end

doc = Nokogiri::HTML.parse(html, nil, charset)
count = 0
species_set = []
species = []

doc.css('#fragment4 > div:nth-child(9) > table > tr > td').each do |node|
  td_text = node.inner_text
  if td_text.include?("\n")
    species << td_text.split("\n")[0] << td_text.split("\n")[1][1..-2]
  else
    species << td_text
  end
  count += 1
  if count % 5 == 0
    species_set.push(species)
    species = []
  end
end

print species_set

