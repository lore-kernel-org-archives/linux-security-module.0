From: mka@chromium.org (Matthias Kaehlcke)
Date: Thu, 18 May 2017 12:07:59 -0700
Subject: [PATCH] selinux: Mark array 'labeling_behaviors' as __maybe_unused
Message-ID: <20170518190759.28560-1-mka@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The array is only referenced in an ARRAY_SIZE() statement. Adding the
attribute fixes the following warning when building with clang:

security/selinux/hooks.c:338:20: error: variable 'labeling_behaviors'
    is not needed and will not be emitted
    [-Werror,-Wunneeded-internal-declaration]

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e67a526d1f30..450ff9f3161c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -400,7 +400,7 @@ static void superblock_free_security(struct super_block *sb)
 
 /* The file system's label must be initialized prior to use. */
 
-static const char *labeling_behaviors[7] = {
+static const char * __maybe_unused labeling_behaviors[7] = {
 	"uses xattr",
 	"uses transition SIDs",
 	"uses task SIDs",
-- 
2.13.0.303.g4ebf302169-goog

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
