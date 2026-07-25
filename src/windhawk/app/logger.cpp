#include "stdafx.h"

#include "logger.h"

#include "storage_manager.h"

namespace {

Logger::Verbosity GetVerbosityFromConfig() {
    return Logger::Verbosity::kVerbose;
}

}  // namespace

Logger::Logger(Verbosity initialVerbosity) : LoggerBase(initialVerbosity) {}

// static
Logger& Logger::GetInstance() {
    static Logger s(GetVerbosityFromConfig());
    return s;
}
