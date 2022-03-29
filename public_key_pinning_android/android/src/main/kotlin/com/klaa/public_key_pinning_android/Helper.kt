package com.klaa.public_key_pinning_android

import android.util.Base64
import java.io.FileInputStream
import java.security.MessageDigest
import java.security.cert.CertificateFactory
import java.security.cert.X509Certificate

class Helper {
    companion object {
        fun getCertFromPEMFile(file: String): String {
            val fileCert = FileInputStream("$file.pem")
            val cFormat: CertificateFactory = CertificateFactory.getInstance("X.509")
            val cert = cFormat.generateCertificates(fileCert)
            val cCert = cert as X509Certificate
            val sha256: MessageDigest = MessageDigest.getInstance("SHA-256")
            fileCert.close()

            return Base64.encodeToString(sha256.digest(cCert.encoded), Base64.DEFAULT)
        }
    }
}