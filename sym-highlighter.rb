#!/usr/bin/ruby
# encoding: UTF-8

# Simple script for cyrillic symbols detection

$ascii_latin_char_codes = (0x61..0x7a).to_a + (0x41..0x5a).to_a
$utf16_cyrillic_char_codes = (0x0410..0x044f).to_a

class String
	def clrz(code); "\e[#{code}m#{self}\e[0m"; end
	def red; clrz(31); end
	def grn; clrz(32); end
	def ylw; clrz(33); end
	def blu; clrz(34); end
	def mgn; clrz(35); end
end

def parse_word word
	chars16 = []
	word_export = []

	word.each_char{|c| chars16.push [c,c.unpack('U*').join.to_i]}

	chars16.each do |ch,code|
		#debug
		#puts "Character: #{ch} Code (dec): #{code} Code (hex): #{code.to_s(16)}"
		if $ascii_latin_char_codes.include?(code) then
			word_export.push "#{ch}".red
		elsif $utf16_cyrillic_char_codes.include?(code) then
			word_export.push "#{ch}".grn
		else
			word_export.push "#{ch}".blu
		end
	end
	return "#{word_export.join}"
end

def parse_message message
	parsed_message = []
	words = message.split
	words.each do |word|
		parsed_message.push parse_word word
	end
	return parsed_message.join(" ")
end

if ARGV.length == 0 then
	print "Copy your text:\n> "
	message = gets.chomp
	puts parse_message message
elsif ARGV.length == 1 then
	puts parse_message ARGV[0]
else
        puts "Usage:\n\t$ #{__FILE__} [message]\n\nOr simply run this script and enter your text"
end
