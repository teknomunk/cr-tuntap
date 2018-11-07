class TunTap
	VERSION = "0.1.0"

	@@fd : Int32 = 0
	
	def self.setup()
		return if @@fd != 0

		@@fd = LibC.open( "/dev/net/tun", LibC::O_RDWR )
	end
end

require "./c/*"
require "./tuntap/*"
