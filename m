From: colin.king@canonical.com (Colin King)
Date: Sat, 14 Oct 2017 16:38:56 +0100
Subject: [PATCH][V2] selinux: remove extraneous initialization of slots_used
	and max_chain_len
Message-ID: <20171014153856.3539-1-colin.king@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variables slots_used and max_chain_len are being initialized to zero
twice. Remove the second set of initializations in the for loop.
Cleans up the clang warnings:

Value stored to 'slots_used' is never read
Value stored to 'max_chain_len' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/selinux/ss/hashtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index bef7577d1270..e0443f4afea5 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -150,7 +150,7 @@ void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
 
 	slots_used = 0;
 	max_chain_len = 0;
-	for (slots_used = max_chain_len = i = 0; i < h->size; i++) {
+	for (i = 0; i < h->size; i++) {
 		cur = h->htable[i];
 		if (cur) {
 			slots_used++;
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
