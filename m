From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Wed, 18 Oct 2017 08:00:51 +0100
Subject: [PATCH v10 19/20] crypto: mediatek: move to generic async completion
In-Reply-To: <1508310057-25369-1-git-send-email-gilad@benyossef.com>
References: <1508310057-25369-1-git-send-email-gilad@benyossef.com>
Message-ID: <1508310057-25369-20-git-send-email-gilad@benyossef.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The mediatek driver starts several async crypto ops and waits for their
completions. Move it over to generic code doing the same.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/crypto/mediatek/mtk-aes.c | 31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/crypto/mediatek/mtk-aes.c b/drivers/crypto/mediatek/mtk-aes.c
index 32aa587..c2058cf 100644
--- a/drivers/crypto/mediatek/mtk-aes.c
+++ b/drivers/crypto/mediatek/mtk-aes.c
@@ -138,11 +138,6 @@ struct mtk_aes_gcm_ctx {
 	struct crypto_skcipher *ctr;
 };
 
-struct mtk_aes_gcm_setkey_result {
-	int err;
-	struct completion completion;
-};
-
 struct mtk_aes_drv {
 	struct list_head dev_list;
 	/* Device list lock */
@@ -942,17 +937,6 @@ static int mtk_aes_gcm_crypt(struct aead_request *req, u64 mode)
 				    &req->base);
 }
 
-static void mtk_gcm_setkey_done(struct crypto_async_request *req, int err)
-{
-	struct mtk_aes_gcm_setkey_result *result = req->data;
-
-	if (err == -EINPROGRESS)
-		return;
-
-	result->err = err;
-	complete(&result->completion);
-}
-
 /*
  * Because of the hardware limitation, we need to pre-calculate key(H)
  * for the GHASH operation. The result of the encryption operation
@@ -968,7 +952,7 @@ static int mtk_aes_gcm_setkey(struct crypto_aead *aead, const u8 *key,
 		u32 hash[4];
 		u8 iv[8];
 
-		struct mtk_aes_gcm_setkey_result result;
+		struct crypto_wait wait;
 
 		struct scatterlist sg[1];
 		struct skcipher_request req;
@@ -1008,22 +992,17 @@ static int mtk_aes_gcm_setkey(struct crypto_aead *aead, const u8 *key,
 	if (!data)
 		return -ENOMEM;
 
-	init_completion(&data->result.completion);
+	crypto_init_wait(&data->wait);
 	sg_init_one(data->sg, &data->hash, AES_BLOCK_SIZE);
 	skcipher_request_set_tfm(&data->req, ctr);
 	skcipher_request_set_callback(&data->req, CRYPTO_TFM_REQ_MAY_SLEEP |
 				      CRYPTO_TFM_REQ_MAY_BACKLOG,
-				      mtk_gcm_setkey_done, &data->result);
+				      crypto_req_done, &data->wait);
 	skcipher_request_set_crypt(&data->req, data->sg, data->sg,
 				   AES_BLOCK_SIZE, data->iv);
 
-	err = crypto_skcipher_encrypt(&data->req);
-	if (err == -EINPROGRESS || err == -EBUSY) {
-		err = wait_for_completion_interruptible(
-			&data->result.completion);
-		if (!err)
-			err = data->result.err;
-	}
+	err = crypto_wait_req(crypto_skcipher_encrypt(&data->req),
+			      &data->wait);
 	if (err)
 		goto out;
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
