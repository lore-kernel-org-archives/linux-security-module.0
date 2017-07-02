From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Sun,  2 Jul 2017 17:41:47 +0300
Subject: [PATCH v3 05/28] crypto: mediatek: use -EIOCBQUEUED for backlog
	indication
In-Reply-To: <1499006535-19760-1-git-send-email-gilad@benyossef.com>
References: <1499006535-19760-1-git-send-email-gilad@benyossef.com>
Message-ID: <1499006535-19760-6-git-send-email-gilad@benyossef.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Replace -EBUSY with -EIOCBQUEUED for backlog queueing indication
as part of new API.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---

This patch should be squashed with the first patch in the series
when applied.

 drivers/crypto/mediatek/mtk-aes.c | 2 +-
 drivers/crypto/mediatek/mtk-sha.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/mediatek/mtk-aes.c b/drivers/crypto/mediatek/mtk-aes.c
index 9e845e8..5254e13 100644
--- a/drivers/crypto/mediatek/mtk-aes.c
+++ b/drivers/crypto/mediatek/mtk-aes.c
@@ -1012,7 +1012,7 @@ static int mtk_aes_gcm_setkey(struct crypto_aead *aead, const u8 *key,
 				   AES_BLOCK_SIZE, data->iv);
 
 	err = crypto_skcipher_encrypt(&data->req);
-	if (err == -EINPROGRESS || err == -EBUSY) {
+	if (err == -EINPROGRESS || err == -EIOCBQUEUED) {
 		err = wait_for_completion_interruptible(
 			&data->result.completion);
 		if (!err)
diff --git a/drivers/crypto/mediatek/mtk-sha.c b/drivers/crypto/mediatek/mtk-sha.c
index 5f4f845..5c75b50 100644
--- a/drivers/crypto/mediatek/mtk-sha.c
+++ b/drivers/crypto/mediatek/mtk-sha.c
@@ -782,7 +782,7 @@ static int mtk_sha_finup(struct ahash_request *req)
 	ctx->flags |= SHA_FLAGS_FINUP;
 
 	err1 = mtk_sha_update(req);
-	if (err1 == -EINPROGRESS || err1 == -EBUSY)
+	if (err1 == -EINPROGRESS || err1 == -EIOCBQUEUED)
 		return err1;
 	/*
 	 * final() has to be always called to cleanup resources
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
