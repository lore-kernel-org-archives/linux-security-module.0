From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Tue,  5 Sep 2017 15:38:56 +0300
Subject: [PATCH v8 17/20] crypto: talitos: move to generic async completion
In-Reply-To: <1504615144-29770-1-git-send-email-gilad@benyossef.com>
References: <1504615144-29770-1-git-send-email-gilad@benyossef.com>
Message-ID: <1504615144-29770-18-git-send-email-gilad@benyossef.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The talitos driver starts several async crypto ops and  waits for their
completions. Move it over to generic code doing the same.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/talitos.c | 38 +++++---------------------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 79791c6..194a307 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -2037,22 +2037,6 @@ static int ahash_import(struct ahash_request *areq, const void *in)
 	return 0;
 }
 
-struct keyhash_result {
-	struct completion completion;
-	int err;
-};
-
-static void keyhash_complete(struct crypto_async_request *req, int err)
-{
-	struct keyhash_result *res = req->data;
-
-	if (err == -EINPROGRESS)
-		return;
-
-	res->err = err;
-	complete(&res->completion);
-}
-
 static int keyhash(struct crypto_ahash *tfm, const u8 *key, unsigned int keylen,
 		   u8 *hash)
 {
@@ -2060,10 +2044,10 @@ static int keyhash(struct crypto_ahash *tfm, const u8 *key, unsigned int keylen,
 
 	struct scatterlist sg[1];
 	struct ahash_request *req;
-	struct keyhash_result hresult;
+	struct crypto_wait wait;
 	int ret;
 
-	init_completion(&hresult.completion);
+	crypto_init_wait(&wait);
 
 	req = ahash_request_alloc(tfm, GFP_KERNEL);
 	if (!req)
@@ -2072,25 +2056,13 @@ static int keyhash(struct crypto_ahash *tfm, const u8 *key, unsigned int keylen,
 	/* Keep tfm keylen == 0 during hash of the long key */
 	ctx->keylen = 0;
 	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
-				   keyhash_complete, &hresult);
+				   crypto_req_done, &wait);
 
 	sg_init_one(&sg[0], key, keylen);
 
 	ahash_request_set_crypt(req, sg, hash, keylen);
-	ret = crypto_ahash_digest(req);
-	switch (ret) {
-	case 0:
-		break;
-	case -EINPROGRESS:
-	case -EBUSY:
-		ret = wait_for_completion_interruptible(
-			&hresult.completion);
-		if (!ret)
-			ret = hresult.err;
-		break;
-	default:
-		break;
-	}
+	ret = crypto_wait_req(crypto_ahash_digest(req), &wait);
+
 	ahash_request_free(req);
 
 	return ret;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
