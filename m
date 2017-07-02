From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Sun,  2 Jul 2017 17:41:44 +0300
Subject: [PATCH v3 02/28] crypto: atmel: use -EIOCBQUEUED for backlog
	indication
In-Reply-To: <1499006535-19760-1-git-send-email-gilad@benyossef.com>
References: <1499006535-19760-1-git-send-email-gilad@benyossef.com>
Message-ID: <1499006535-19760-3-git-send-email-gilad@benyossef.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Replace -EBUSY with -EIOCBQUEUED for backlog queueing indication
as part of new API

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---

This patch should be squashed with the first patch in the series
when applied.

 drivers/crypto/atmel-sha.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index a948202..30223ee 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -1204,7 +1204,7 @@ static int atmel_sha_finup(struct ahash_request *req)
 	ctx->flags |= SHA_FLAGS_FINUP;
 
 	err1 = atmel_sha_update(req);
-	if (err1 == -EINPROGRESS || err1 == -EBUSY)
+	if (err1 == -EINPROGRESS || err1 == -EIOCBQUEUED)
 		return err1;
 
 	/*
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
