From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Sun,  2 Jul 2017 17:42:04 +0300
Subject: [PATCH v3 22/28] cifs: move to generic async completion
In-Reply-To: <1499006535-19760-1-git-send-email-gilad@benyossef.com>
References: <1499006535-19760-1-git-send-email-gilad@benyossef.com>
Message-ID: <1499006535-19760-23-git-send-email-gilad@benyossef.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

cifs starts an async. crypto op and waits for their completion.
Move it over to generic code doing the same.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Acked-by: Pavel Shilovsky <pshilov@microsoft.com>
---
 fs/cifs/smb2ops.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 00b1143..46abe62 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1809,22 +1809,6 @@ init_sg(struct smb_rqst *rqst, u8 *sign)
 	return sg;
 }
 
-struct cifs_crypt_result {
-	int err;
-	struct completion completion;
-};
-
-static void cifs_crypt_complete(struct crypto_async_request *req, int err)
-{
-	struct cifs_crypt_result *res = req->data;
-
-	if (err == -EINPROGRESS)
-		return;
-
-	res->err = err;
-	complete(&res->completion);
-}
-
 static int
 smb2_get_enc_key(struct TCP_Server_Info *server, __u64 ses_id, int enc, u8 *key)
 {
@@ -1865,12 +1849,10 @@ crypt_message(struct TCP_Server_Info *server, struct smb_rqst *rqst, int enc)
 	struct aead_request *req;
 	char *iv;
 	unsigned int iv_len;
-	struct cifs_crypt_result result = {0, };
+	DECLARE_CRYPTO_WAIT(wait);
 	struct crypto_aead *tfm;
 	unsigned int crypt_len = le32_to_cpu(tr_hdr->OriginalMessageSize);
 
-	init_completion(&result.completion);
-
 	rc = smb2_get_enc_key(server, tr_hdr->SessionId, enc, key);
 	if (rc) {
 		cifs_dbg(VFS, "%s: Could not get %scryption key\n", __func__,
@@ -1930,14 +1912,10 @@ crypt_message(struct TCP_Server_Info *server, struct smb_rqst *rqst, int enc)
 	aead_request_set_ad(req, assoc_data_len);
 
 	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
-				  cifs_crypt_complete, &result);
+				  crypto_req_done, &wait);
 
-	rc = enc ? crypto_aead_encrypt(req) : crypto_aead_decrypt(req);
-
-	if (rc == -EINPROGRESS || rc == -EIOCBQUEUED) {
-		wait_for_completion(&result.completion);
-		rc = result.err;
-	}
+	rc = crypto_wait_req(enc ? crypto_aead_encrypt(req)
+				: crypto_aead_decrypt(req), &wait);
 
 	if (!rc && enc)
 		memcpy(&tr_hdr->Signature, sign, SMB2_SIGNATURE_SIZE);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
