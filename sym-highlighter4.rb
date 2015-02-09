#!/usr/bin/ruby
#encoding:utf-8

class String
	def colorify_chr chr
		color = case chr.unpack('U*').join.to_i
			when (0x0000..0x007F) then '38;5;008' # Basic Latin
			when (0x0080..0x00FF) then '38;5;001' # Latin-1 Supplement
			when (0x0100..0x017F) then '38;5;160' # Latin Extended-A
			when (0x0180..0x024F) then '38;5;161' # Latin Extended-B
			when (0x0250..0x02AF) then '38;5;162' # IPA Extensions
			when (0x02B0..0x02FF) then '38;5;163' # Spacing Modifier Letters
			when (0x0300..0x036F) then '38;5;182' # Combining Diacritical Marks
			when (0x0400..0x04FF) then '38;5;007' # Cyrillic
			when (0x0500..0x052F) then '38;5;240' # Cyrillic Supplementary
			else '38;5;226'
		end
		chr = "\033[#{color}m#{chr}\e[0m"
	end

	def colorize
		export = []
		self.each_char { |c| export.push colorify_chr(c) }
		return export.join
	end
end

if ARGV.length == 0 then
	printf "Copy your text:\n#{gets.chomp.colorize}\n"
else
	ARGV.each{|arg| puts arg.colorize}
end

# Test-string: "ABC-def_§¢«°¾¿ðûŃŒŤŽƺǾȪƵʠʡʢʣʤʥʦʧʨʩʪʫʬʭʮˣˤ˫ˬ̵daЀЁЂЃЄЅІЇЈЉЊФБВГФЫВДФЫВОфывЙԀԁԂԃԄԅԆԇԈԉԊԋԌԍԎԏ"
