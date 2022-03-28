package com.klaa.public_key_pinning_android

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result

class MethodHandler {
    var pinner: SSLPinner? = null

    fun handle(call: MethodCall, result: Result) {
        when (call.method) {
            "init" -> {
                initSession(call, result)
            }
            "request" -> {
                requestTrust(call, result)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun initSession(call: MethodCall, result: Result) {
        val args = call.arguments as? MutableMap<String, Any> ?: return result.error(
                "MISSING_ARGUMENT",
                "Unable to obtain method's arguments.", null)


        val evaluations = args["evaluations"] as? MutableSet<MutableMap<String, String>>? ?: return result.error(
            "INVALID_PARAMETER",
            "Unable to obtain method's parameter of key 'evaluations'.", null)

//         return result.success(SSLPinner.init(evs))
    }

    private fun requestTrust(call: MethodCall, result: Result) {
        val args = call.arguments as? MutableMap<String, Any> ?: return result.error(
            "MISSING_ARGUMENT",
            "Unable to obtain method's arguments.", null)

        val url = args["url"] as? String
        val headers = args["headers"] as? MutableMap<String, String>?
        if (url == null || headers == null) {
            return result.error(
                "INVALID_PARAMETER",
                "Unable to obtain method's parameter(s) of key 'url' and/or 'headers'.", null)
        }

        pinner?.request(url, headers) {
            if (it) {
                result.success(it)
            }
        }
    }
}