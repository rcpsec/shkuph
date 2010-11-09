# encoding: utf-8

module Shkuph::Storage
  def fetch(key, value = nil)
    self[key] || begin
      value ||= block_given? ? yield(key) : default
      self[key] || value
    end
  end

  def [] key
    get(key)
  end

  def []= key, value
    set(key, value)
  end
end
