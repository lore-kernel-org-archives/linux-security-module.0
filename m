From: keescook@chromium.org (Kees Cook)
Date: Sat, 15 Sep 2018 17:30:49 -0700
Subject: [PATCH 08/18] integrity: Initialize as LSM_TYPE_MINOR
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Message-ID: <20180916003059.1046-9-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The integrity LSM isn't really an LSM in that it never calls
security_add_hooks(), but it uses the early security init because its
hooks need to run before the VFS layer initializes. This is the very
definition of a non-exclusive LSM, so mark it as such.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/integrity/iint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 20e60df929a3..d886183848c4 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -176,6 +176,7 @@ static int __init integrity_iintcache_init(void)
 	return 0;
 }
 DEFINE_LSM(integrity)
+	.type = LSM_TYPE_MINOR,
 	.init = integrity_iintcache_init,
 END_LSM;
 
-- 
2.17.1
