#!/usr/bin/ruby
#encoding:utf-8

# String Class methods
class String
	def colorify_chr chr
		# New hash: key = color code; value = Unicode codepoint range
		unicode_color_range = Hash.new
		# Basic Latin
		unicode_color_range['38;5;226'] = (0x0000..0x007F).to_a
		# Latin-1 Supplement
		unicode_color_range['38;5;196'] = (0x0080..0x00FF).to_a
		# Latin Extended-A // Latin Extended-B
		unicode_color_range['38;5;160'] = (0x0100..0x017F).to_a + (0x0180..0x024F).to_a
		# IPA Extensions // Spacing Modifier Letters // Combining Diacritical Marks
		unicode_color_range['38;5;199'] = (0x0250..0x02AF).to_a + (0x02B0..0x02FF).to_a + (0x0300..0x036F).to_a
		# Cyrillic // Cyrillic Supplementary
		unicode_color_range['38;5;247'] = (0x0400..0x04FF).to_a + (0x0500..0x052F).to_a
		unicode_color_range.each do |color,range|
			#chr = "\e[#{color}m#{chr}\e[0m" if range.include? chr.unpack('U*').join.to_i
			chr = "\033[#{color}m#{chr}\e[0m" if range.include? chr.unpack('U*').join.to_i
		end
		return chr
	end
	def colorify_str
		m = []
		self.each_char do |c|
			m.push colorify_chr c
		end
		return m.join
	end
end

# Wrapper
if ARGV.length == 0 then
	print "Copy your text:\n> "
	puts gets.chomp.colorify_str
elsif ARGV.join =~ /help|-h/i
	puts "Usage:\n\t$ #{__FILE__} [message]\n\nOr simply run this script and enter your text"
else
	puts "\n"
	#puts "-"*%x(tput cols).chomp.to_i
	ARGV.each{|arg| puts arg.colorify_str}
end
