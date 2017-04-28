From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Fri, 28 Apr 2017 09:02:17 -0400
Subject: [PATCH v2 2/3] tpm: vtpm_proxy: Implement request_locality
In-Reply-To: <1493384538-27883-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1493384538-27883-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-ID: <1493384538-27883-3-git-send-email-stefanb@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Implement the request_locality function. Accept all localities assuming
that the emulator handling the localities will check for a valid locality.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm_vtpm_proxy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index fb4d207..48b9818 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -371,6 +371,11 @@ static bool vtpm_proxy_tpm_req_canceled(struct tpm_chip  *chip, u8 status)
 	return ret;
 }
 
+static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
+{
+	return locality;
+}
+
 static const struct tpm_class_ops vtpm_proxy_tpm_ops = {
 	.flags = TPM_OPS_AUTO_STARTUP,
 	.recv = vtpm_proxy_tpm_op_recv,
@@ -380,6 +385,7 @@ static const struct tpm_class_ops vtpm_proxy_tpm_ops = {
 	.req_complete_mask = VTPM_PROXY_REQ_COMPLETE_FLAG,
 	.req_complete_val = VTPM_PROXY_REQ_COMPLETE_FLAG,
 	.req_canceled = vtpm_proxy_tpm_req_canceled,
+	.request_locality = vtpm_proxy_request_locality,
 };
 
 /*
-- 
2.4.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
