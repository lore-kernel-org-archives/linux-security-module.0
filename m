From: colin.king@canonical.com (Colin King)
Date: Sat, 14 Oct 2017 15:52:24 +0100
Subject: [PATCH] selinux: remove extraneous initialization of slots_used and
	max_chain_len
Message-ID: <20171014145224.840-1-colin.king@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variables slots_used and max_chain_len are being initialized to zero
twice. Remove the first set of initializations. Cleans up the
clang warnings:

Value stored to 'slots_used' is never read
Value stored to 'max_chain_len' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/selinux/ss/hashtab.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index bef7577d1270..622fd50c8b9c 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -148,8 +148,6 @@ void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
 	u32 i, chain_len, slots_used, max_chain_len;
 	struct hashtab_node *cur;
 
-	slots_used = 0;
-	max_chain_len = 0;
 	for (slots_used = max_chain_len = i = 0; i < h->size; i++) {
 		cur = h->htable[i];
 		if (cur) {
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
