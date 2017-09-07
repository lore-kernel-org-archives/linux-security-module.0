From: pushkar.iit@gmail.com (Pushkar Jambhlekar)
Date: Thu,  7 Sep 2017 11:11:45 +0530
Subject: [PATCH] security/keys: Adding newline after declaration
Message-ID: <1504762905-2424-1-git-send-email-pushkar.iit@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Fixing checkpatch warning to add newline after declaration

Signed-off-by: Pushkar Jambhlekar <pushkar.iit@gmail.com>
---
 security/keys/big_key.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 835c1ab..bc4c6eb 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -93,6 +93,7 @@ static int big_key_crypt(enum big_key_op op, u8 *data, size_t datalen, u8 *key)
 {
 	int ret = -EINVAL;
 	struct scatterlist sgio;
+
 	SKCIPHER_REQUEST_ON_STACK(req, big_key_skcipher);
 
 	if (crypto_skcipher_setkey(big_key_skcipher, key, ENC_KEY_SIZE)) {
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
