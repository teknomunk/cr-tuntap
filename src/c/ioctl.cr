# Based on asm-generic/ioctl.h
module IOC
	NONE = 0
	WRITE = 1
	READ = 2

	NRSHIFT	 = 0
	NRBITS	 = 8
	NRMASK     = ( 1 << NRBITS ) - 1

	TYPESHIFT	 = ( NRSHIFT + NRBITS )
	TYPEBITS	 = 8
	TYPEMASK   = ( 1 << TYPEBITS ) - 1
	
	SIZESHIFT  = ( TYPESHIFT + TYPEBITS )
	SIZEBITS	 = 14
	SIZEMASK   = ( 1 << SIZEBITS ) - 1
	
	DIRSHIFT	 = ( SIZESHIFT + SIZEBITS )
	DIRBITS	 = 2
	DIRMASK    = ( 1 << DIRBITS ) - 1

	IN         = WRITE << DIRSHIFT
	OUT        = READ << DIRSHIFT
	INOUT      = ( READ | WRITE ) << DIRSHIFT

	SIZE_MASK  = ( SIZEMASK << SIZESHIFT )
	SIZE_SHIFT = SIZESHIFT

	macro build_id( dir, type, nr, size )
		( ( (dir)  << IOC_DIRSHIFT ) |
		  ( (type) << IOC_TYPESHIFT ) |
		  ( (nr)   << IOC_NRSHIFT ) |
		  ( (size) << IOC_SIZESHIFT ) )
	end
	macro _IO( type, nr )
		build_od( NONE, type, rn, 0 )
	end
	macro _IOR( type, rn, size )
		_IOC( IOC_READ, type, rn, sizeof(size) )
	end
	macro _IOW( type, rn, size )
		_IOC( IOC_WRITE, type, rn, sizeof(size) )
	end
	macro _IORW( type, rn, size )
		_IOC( IOC_WRITE | IOC_READ, type, rn, sizeof(size) )
	end

	macro get_dir( id )
		( id >> DIRSHIFT ) & DIRMASK
	end
	macro get_type( id )
		( id >> TYPESHIFT ) & TYPEMASK
	end
	macro get_nr( id )
		( id >> NRSHIFT ) & NRMASK
	end
	macro get_size( id )
		( id >> SIZESHIFT ) & SIZEMASK
	end
end

module Linux
	# Raw function
	fun ioctl( fildes : Int32, request : Int32, ... ) : Int32

	include IOC

	lib TunTap
		TUN_READQ_SIZE      = 500
		TUN_TYPE_MASK       = 0x000f

		TUNSETNOCSUM		= _IOW('T', 200, Int32)
		TUNSETDEBUG		= _IOW('T', 201, Int32)
		TUNSETIFF			= _IOW('T', 202, Int32)
		TUNSETPERSIST		= _IOW('T', 203, Int32)
		TUNSETOWNER		= _IOW('T', 204, Int32)
		TUNSETLINK          = _IOW('T', 205, Int32)
		TUNSETGROUP         = _IOW('T', 206, Int32)
		TUNGETFEATURES      = _IOR('T', 207, UInt32)
		TUNSETOFFLOAD       = _IOW('T', 208, UInt32)
		TUNSETTXFILTER      = _IOW('T', 209, UInt32)
		TUNGETIFF           = _IOR('T', 210, UInt32)
		TUNGETSNDBUF        = _IOR('T', 211, Int32)
		TUNSETSNDBUF        = _IOW('T', 212, Int32)
		TUNATTACHFILTER     = _IOW('T', 213, Sock_fprog)
		TUNDETACHFILTER     = _IOW('T', 214, Sock_fprog)
		TUNGETVNETHDRSZ     = _IOR('T', 215, Int32)
		TUNSETVNETHDRSZ     = _IOW('T', 216, Int32)
		TUNSETQUEUE         = _IOW('T', 217, Int32)
		TUNSETIFINDEX       = _IOW('T', 218, Uint32)
		TUNGETFILTER        = _IOR('T', 219, Sock_fprog)
		TUNSETVNETLE        = _IOW('T', 220, Int32)
		TUNGETVNETLE        = _IOR('T', 221, Int32)
		TUNSETVNETBE        = _IOW('T', 222, Int32)
		TUNGETVNETBE        = _IOR('T', 223, Int32)
		TUNSETSTEERINGEBPF  = _IOW('T', 224, Int32)
		TUNSETFILTEREBPF    = _IOR('T', 225, Int32)
		
		IFF_TUN             = 0x0001
		IFF_TAP             = 0x0002
		IFF_NAPI            = 0x0010
		IFF_NAPI_FRAGS      = 0x0020
		IFF_NO_PI           = 0x1000
		IFF_ONE_QUEUE       = 0x2000
		IFF_VNET_HDR        = 0x4000

		# Wrappers for above ioctl calls
	end
end
