module ApiModule
	#Connect to given url and get response
	def connect(url="",query="",api_key="")
	  HTTParty.get("#{url}?#{query}&apiKey=#{api_key}")
	end
end