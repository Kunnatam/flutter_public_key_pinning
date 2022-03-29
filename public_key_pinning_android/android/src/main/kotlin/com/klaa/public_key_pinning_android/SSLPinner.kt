package com.klaa.public_key_pinning_android

import android.util.Base64
import android.util.Log
import okhttp3.CertificatePinner
import okhttp3.OkHttpClient
import okhttp3.Request
import java.io.FileInputStream
import java.lang.Exception
import java.security.MessageDigest
import java.security.cert.CertificateFactory
import java.security.cert.X509Certificate

data class Evaluation(val pattern: String, val filename: String)

class SSLPinner {
    companion object {
        private const val tag: String = "#SSLPinner"

        lateinit var certificatePinner: CertificatePinner
        lateinit var okHttpClient: OkHttpClient
    }

    fun init(evaluations: ArrayList<Evaluation>) {
        if (evaluations.isNotEmpty()) {
            val certPinBuilder = CertificatePinner.Builder()
            for (ev in evaluations) {
                certPinBuilder.add(ev.pattern, Helper.getCertFromPEMFile(ev.filename))
            }

            certificatePinner = certPinBuilder.build()
        }

        /*certificatePinner = CertificatePinner.Builder()
            .add("url-dev", "sha256/???")
            .add("url-uat", "sha256/???")
            .add("url-prod", "sha256/???")
            .build()*/

        okHttpClient = OkHttpClient.Builder()
            .certificatePinner(certificatePinner)
            .build()
    }

    fun request(url: String, headers: MutableMap<String, String>?, closure: (Boolean) -> Unit) {
        lateinit var request: Request
        val requestBuilder: Request.Builder = Request.Builder()
        if (headers?.isNotEmpty() == true) {
            for (header in headers) {
                requestBuilder.addHeader(header.key, header.value)
            }

            requestBuilder.url("https://$url")
        }

        request = requestBuilder.build()

        okHttpClient.newCall(request).execute().let {
                response -> {
            Log.d(tag, "Request Status: ${response.isSuccessful}")
            if (response.isSuccessful) {
                closure(true)
            } else {
                closure(false)
            }
        }
        }
    }
}