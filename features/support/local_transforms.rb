def replace_tokens_in(text)
  return Date.today if text == "today's date"
  text
end
