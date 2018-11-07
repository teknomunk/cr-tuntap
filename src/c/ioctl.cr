macro _IOC( dir, type, nr, size )
	( ( (dir)  << IOC_DIRSHIFT ) |
	  ( (type) << IOC_TYPESHIFT ) |
	  ( (nr)   << IOC_NRSHIFT ) |
	  ( (size) << IOC_SIZESHIFT ) )
end
macro _IOr( type, rn, size )
	_IOC( IOC_READ, type, rn, sizeof(size) )
end
macro _IOW( type, rn, size )
	_IOC( IOC_WRITE, type, rn, sizeof(size) )
end
macro _IORW( type, rn, size )
	_IOC( IOC_WRITE | IOC_READ, type, rn, sizeof(size) )
end

lib LibC
	# Based on asm-generic/ioctl.h
	IOC_WRITE = 1
	IOC_READ = 2

	IOC_NRSHIFT	= 0
	IOC_NRBITS	= 8
	IOC_TYPESHIFT	= ( IOC_NRSHIFT + IOC_NRBITS )
	IOC_TYPEBITS	= 8
	IOC_SIZESHIFT  = ( IOC_TYPESHIFT + IOC_TYPEBITS )
	IOC_SIZEBITS	= 14
	IOC_DIRSHIFT	= ( IOC_SIZESHIFT + IOC_SIZEBITS )
	IOC_DIRBITS	= 2

	TUNSETNOCSUM		= _IOW('T', 200, Int32)
	TUNSETDEBUG		= _IOW('T', 201, Int32)
	TUNSETIFF			= _IOW('T', 202, Int32)
	TUNSETPERSIST		= _IOW('T', 203, Int32)
	TUNSETOWNER		= _IOW('T', 204, Int32)

	fun ioctl( fildes : Int32, request : Int32, ... ) : Int32
end
