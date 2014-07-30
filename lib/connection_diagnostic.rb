require 'client'

class ConnectionDiagnostic
  # perform_diagnostic
  # disconnects the client
  # tries to connect the client 3 times
  # if unsuccessful raise Error
  # if successful sends 'AT#UD' to client (diagnostic message)
  #   and receives from the client the diagnostic info
  #   this info should be accesible on the attribute info
  # and receives from the client the diagnostic info
  # this info should be accesible on the attribute info

  attr_accessor :status

  def initialize client
  	@status = client.disconnect
    @client = client

  end

  def perform_diagnostic
  	counter = 1
  	while @status == false
			@status = @client.connect
			counter += 1
			return @status = @client.connect if counter == 3
		end
  end

end