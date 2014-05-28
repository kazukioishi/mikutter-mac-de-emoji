# -*- coding: utf-8 -*-

#こころぴょんぴょん
$IS_WINDOWS = false
if RUBY_PLATFORM.downcase =~ /mswin(?!ce)|mingw|cygwin|bccwin/
  $IS_WINDOWS = true
end

module Pango
  class << self
    alias parse_markup_org parse_markup

    def parse_markup(text)
      @regex ||= Regexp.new(/([\u{1F300}-\u{1F55B}]+)/) 

      if $IS_WINDOWS == true
        #ご注文はWindowsですか?
        emojied_text = text.gsub(@regex) {
          "<span font_family=\"Segoe UI Symbol\">#{$1}</span>"
        }
      else
        #ご注文はMac OS Xですか?
        emojied_text = text.gsub(@regex) {
          "<span font_family=\"Apple カラー絵文字\">#{$1}</span>"
        }
      end
      
      parse_markup_org(emojied_text)
    end
  end
end


Plugin.create(:mikutter_mac_de_emoji) {
}
