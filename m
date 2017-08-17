From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Thu, 17 Aug 2017 13:32:37 -0400
Subject: [PATCH 2/2] lsm_audit: update my email address
In-Reply-To: <20170817173237.5858-1-sds@tycho.nsa.gov>
References: <20170817173237.5858-1-sds@tycho.nsa.gov>
Message-ID: <20170817173237.5858-2-sds@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Update my email address since epoch.ncsc.mil no longer exists.
MAINTAINERS and CREDITS are already correct.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 include/linux/lsm_audit.h | 2 +-
 security/lsm_audit.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 22b5d4e..d1c2901 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -4,7 +4,7 @@
  *
  * Author : Etienne BASSET  <etienne.basset@ensta.org>
  *
- * All credits to : Stephen Smalley, <sds@epoch.ncsc.mil>
+ * All credits to : Stephen Smalley, <sds@tycho.nsa.gov>
  * All BUGS to : Etienne BASSET  <etienne.basset@ensta.org>
  */
 #ifndef _LSM_COMMON_LOGGING_
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 28d4c3a..67703db 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -2,7 +2,7 @@
  * common LSM auditing functions
  *
  * Based on code written for SELinux by :
- *			Stephen Smalley, <sds@epoch.ncsc.mil>
+ *			Stephen Smalley, <sds@tycho.nsa.gov>
  * 			James Morris <jmorris@redhat.com>
  * Author : Etienne Basset, <etienne.basset@ensta.org>
  *
-- 
2.9.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
