From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Sun,  2 Jul 2017 17:41:53 +0300
Subject: [PATCH v3 11/28] cifs: use -EIOCBQUEUED for backlog indication
In-Reply-To: <1499006535-19760-1-git-send-email-gilad@benyossef.com>
References: <1499006535-19760-1-git-send-email-gilad@benyossef.com>
Message-ID: <1499006535-19760-12-git-send-email-gilad@benyossef.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Replace -EBUSY with -EIOCBQUEUED for backlog queueing indication
as part of new API.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---

This patch should be squashed with the first patch in the series
when applied.

 fs/cifs/smb2ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 941c40b..00b1143 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1934,7 +1934,7 @@ crypt_message(struct TCP_Server_Info *server, struct smb_rqst *rqst, int enc)
 
 	rc = enc ? crypto_aead_encrypt(req) : crypto_aead_decrypt(req);
 
-	if (rc == -EINPROGRESS || rc == -EBUSY) {
+	if (rc == -EINPROGRESS || rc == -EIOCBQUEUED) {
 		wait_for_completion(&result.completion);
 		rc = result.err;
 	}
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
