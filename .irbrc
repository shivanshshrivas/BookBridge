if defined?(IRB)
  IRB.conf[:USE_PAGER] = ENV["USE_PAGER"] || false
end
