From: keescook@chromium.org (Kees Cook)
Date: Sat, 15 Sep 2018 17:30:59 -0700
Subject: [PATCH 18/18] LSM: Don't ignore initialization failures
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Message-ID: <20180916003059.1046-19-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

LSM initialization failures have traditionally been ignored. We should
at least WARN when something goes wrong.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 3b84b7eeb08c..a7796e522f72 100644
--- a/security/security.c
+++ b/security/security.c
@@ -203,11 +203,15 @@ static void __init maybe_enable_lsm(struct lsm_info *lsm)
 
 	/* If selected, initialize the LSM. */
 	if (enabled) {
+		int ret;
+
 		if (lsm->type == LSM_TYPE_EXCLUSIVE) {
 			exclusive = lsm;
 			init_debug("exclusive: %s\n", exclusive->name);
 		}
-		lsm->init();
+
+		ret = lsm->init();
+		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
 	}
 }
 
-- 
2.17.1
