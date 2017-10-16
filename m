From: wangboshi@huawei.com (Boshi Wang)
Date: Mon, 16 Oct 2017 10:53:13 +0800
Subject: [PATCH] keys, trusted: fix missing support for TPM 2.0 in
	trusted_update()
Message-ID: <683216c3-d61a-1b24-c38c-b3f4348ce876@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Call tpm_seal_trusted() in trusted_update() for TPM 2.0 chips.

Signed-off-by: Boshi Wang <wangboshi@huawei.com>
---
  security/keys/trusted.c | 10 +++++++++-
  1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index ddfaebf..563fe5f 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -1065,6 +1065,11 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
      size_t datalen = prep->datalen;
      char *datablob;
      int ret = 0;
+    int tpm2;
+
+    tpm2 = tpm_is_tpm2(TPM_ANY_NUM);
+    if (tpm2 < 0)
+        return tpm2;

      if (test_bit(KEY_FLAG_NEGATIVE, &key->flags))
          return -ENOKEY;
@@ -1110,7 +1115,10 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
      dump_payload(p);
      dump_payload(new_p);

-    ret = key_seal(new_p, new_o);
+    if (tpm2)
+        ret = tpm_seal_trusted(TPM_ANY_NUM, new_p, new_o);
+    else
+        ret = key_seal(new_p, new_o);
      if (ret < 0) {
          pr_info("trusted_key: key_seal failed (%d)\n", ret);
          kzfree(new_p);
-- 
2.10.1



--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
