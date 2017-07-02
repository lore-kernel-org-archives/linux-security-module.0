From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Sun,  2 Jul 2017 17:41:52 +0300
Subject: [PATCH v3 10/28] fscrypt: use -EIOCBQUEUED for backlog indication
In-Reply-To: <1499006535-19760-1-git-send-email-gilad@benyossef.com>
References: <1499006535-19760-1-git-send-email-gilad@benyossef.com>
Message-ID: <1499006535-19760-11-git-send-email-gilad@benyossef.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Replace -EBUSY with -EIOCBQUEUED for backlog queueing indication
as part of new API.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---

This patch should be squashed with the first patch in the series
when applied.

 fs/crypto/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index c7835df..c5c89ed 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -190,7 +190,7 @@ int fscrypt_do_page_crypto(const struct inode *inode, fscrypt_direction_t rw,
 		res = crypto_skcipher_decrypt(req);
 	else
 		res = crypto_skcipher_encrypt(req);
-	if (res == -EINPROGRESS || res == -EBUSY) {
+	if (res == -EINPROGRESS || res == -EIOCBQUEUED) {
 		BUG_ON(req->base.data != &ecr);
 		wait_for_completion(&ecr.completion);
 		res = ecr.res;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
