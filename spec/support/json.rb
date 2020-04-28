class String
  def json
    JSON.parse File.read("spec/assets/#{self}.json").strip, symbolize_names: true
  end
end

module ActionDispatch
  class Response
    def json
      JSON.parse self.body, symbolize_names: true
    end
  end
end
