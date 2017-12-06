From: pravin.shedge4linux@gmail.com (Pravin Shedge)
Date: Wed,  6 Dec 2017 23:05:59 +0530
Subject: [PATCH 29/45] security: apparmor: remove duplicate includes
Message-ID: <1512581759-6336-1-git-send-email-pravin.shedge4linux@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

These duplicate includes have been found with scripts/checkincludes.pl but
they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
---
 security/apparmor/apparmorfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index d4fa04d..657b294 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -33,7 +33,6 @@
 #include "include/context.h"
 #include "include/crypto.h"
 #include "include/ipc.h"
-#include "include/policy_ns.h"
 #include "include/label.h"
 #include "include/policy.h"
 #include "include/policy_ns.h"
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
