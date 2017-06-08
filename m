From: dhowells@redhat.com (David Howells)
Date: Thu, 08 Jun 2017 14:47:56 +0100
Subject: [PATCH 05/23] KEYS: Delete an error message for a failed memory
	allocation in get_derived_key()
In-Reply-To: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
References: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
Message-ID: <149692967632.11452.8051625673207615804.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/encrypted-keys/encrypted.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 0010955d7876..2ab48eab29a1 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -385,10 +385,9 @@ static int get_derived_key(u8 *derived_key, enum derived_key_type key_type,
 		derived_buf_len = HASH_SIZE;
 
 	derived_buf = kzalloc(derived_buf_len, GFP_KERNEL);
-	if (!derived_buf) {
-		pr_err("encrypted_key: out of memory\n");
+	if (!derived_buf)
 		return -ENOMEM;
-	}
+
 	if (key_type)
 		strcpy(derived_buf, "AUTH_KEY");
 	else

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
