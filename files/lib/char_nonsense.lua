function strip_chars(str) -- i stole this from https://stackoverflow.com/questions/50459102/replace-accented-characters-in-string-to-standard-with-lua
    local tableAccents = {}
        tableAccents["à"] = "a"
        tableAccents["á"] = "a"
        tableAccents["â"] = "a"
        tableAccents["ã"] = "a"
        tableAccents["ä"] = "a"
        tableAccents["ç"] = "c"
        tableAccents["è"] = "e"
        tableAccents["é"] = "e"
        tableAccents["ê"] = "e"
        tableAccents["ë"] = "e"
        tableAccents["ì"] = "i"
        tableAccents["í"] = "i"
        tableAccents["î"] = "i"
        tableAccents["ï"] = "i"
        tableAccents["ñ"] = "n"
        tableAccents["ò"] = "o"
        tableAccents["ó"] = "o"
        tableAccents["ô"] = "o"
        tableAccents["õ"] = "o"
        tableAccents["ö"] = "o"
        tableAccents["ù"] = "u"
        tableAccents["ú"] = "u"
        tableAccents["û"] = "u"
        tableAccents["ü"] = "u"
        tableAccents["ý"] = "y"
        tableAccents["ÿ"] = "y"
        tableAccents["À"] = "A"
        tableAccents["Á"] = "A"
        tableAccents["Â"] = "A"
        tableAccents["Ã"] = "A"
        tableAccents["Ä"] = "A"
        tableAccents["Ç"] = "C"
        tableAccents["È"] = "E"
        tableAccents["É"] = "E"
        tableAccents["Ê"] = "E"
        tableAccents["Ë"] = "E"
        tableAccents["Ì"] = "I"
        tableAccents["Í"] = "I"
        tableAccents["Î"] = "I"
        tableAccents["Ï"] = "I"
        tableAccents["Ñ"] = "N"
        tableAccents["Ò"] = "O"
        tableAccents["Ó"] = "O"
        tableAccents["Ô"] = "O"
        tableAccents["Õ"] = "O"
        tableAccents["Ö"] = "O"
        tableAccents["Ù"] = "U"
        tableAccents["Ú"] = "U"
        tableAccents["Û"] = "U"
        tableAccents["Ü"] = "U"
        tableAccents["Ý"] = "Y"
    local normalizedString = ''

    for strChar in string.gmatch(str, "([%z\1-\127\194-\244][\128-\191]*)") do
        if tableAccents[strChar] ~= nil then
            normalizedString = normalizedString..tableAccents[strChar]
        else
            normalizedString = normalizedString..strChar
        end
    end
 return normalizedString
end
