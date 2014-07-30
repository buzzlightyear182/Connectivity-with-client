require 'spec_helper'

describe ConnectionDiagnostic do

	before :each do
		@client = double('Client')
		allow(@client).to receive(:disconnect) {false}
		@connection = ConnectionDiagnostic.new @client
	end

	it "should call disconnect method" do
		expect(@client).to receive(:disconnect) {false}
		@connection = ConnectionDiagnostic.new @client
	end

 it "should set online status to false" do
		expect(@connection.status).to eq(false)
	end

	it "should connect once to the client" do
		expect(@client).to receive(:connect)
		@connection.perform_diagnostic(@client)
	end

	it "should check if connection was successful then online status = true" do
		allow(@client).to receive(:connect).and_return(true)
		@connection.perform_diagnostic(@client)
		expect(@connection.status).to eq(true)
	end

	it "should check if connection was not successful then try to connect again" do
		allow(@client).to receive(:connect).and_return(false)
		expect(@client).to receive(:connect).at_most(3).times
		@connection.perform_diagnostic(@client)
	end

	it "should check if second connection was successful online status = true" do
		allow(@client).to receive(:connect).and_return(false, true).ordered
		@connection.perform_diagnostic(@client)
		expect(@connection.status).to eq(true)
	end

end