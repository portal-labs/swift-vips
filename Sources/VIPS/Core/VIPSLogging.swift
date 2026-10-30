import Cvips
import CvipsShim

func logfunc(_ domain: UnsafePointer<gchar>!, _ loglevel: GLogLevelFlags, _ msg: UnsafePointer<gchar>!, _ userdata: gpointer!) {
    let logger : VIPSLoggingDelegate = Unmanaged<AnyObject>.fromOpaque(userdata).takeUnretainedValue() as! VIPSLoggingDelegate
    switch loglevel {
    case shim_G_LOG_LEVEL_ERROR():
        logger.error("\(String(cString: msg))")
    case shim_G_LOG_LEVEL_WARNING():
        logger.warning("\(String(cString: msg))")
    case shim_G_LOG_LEVEL_INFO():
        logger.info("\(String(cString: msg))")
    default:
        logger.debug("\(String(cString: msg))")
    }
}

public protocol VIPSLoggingDelegate: AnyObject {
    func debug(_ message: String)
    func info(_ message: String)
    func warning(_ message: String)
    func error(_ message: String)
}