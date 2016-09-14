class Hash

  def dig(first, *args)
    value = self[first]

    args.each do |item|
      return nil if (value[item] == nil)
      value = value[item]
    end

    value
  end

end