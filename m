From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 23 Mar 2018 14:16:10 -0500
Subject: [REVIEW][PATCH 07/11] ipc: Move IPCMNI from include/ipc.h into
	ipc/util.h
In-Reply-To: <87vadmobdw.fsf_-_@xmission.com>
References: <87vadmobdw.fsf_-_@xmission.com>
Message-ID: <20180323191614.32489-7-ebiederm@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The definition IPCMNI is only used in ipc/util.h and ipc/util.c.  So
there is no reason to keep it in a header file that the whole kernel
can see.  Move it into util.h to simplify future maintenance.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/ipc.h | 2 --
 ipc/util.h          | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/ipc.h b/include/linux/ipc.h
index 821b2f260992..6cc2df7f7ac9 100644
--- a/include/linux/ipc.h
+++ b/include/linux/ipc.h
@@ -8,8 +8,6 @@
 #include <uapi/linux/ipc.h>
 #include <linux/refcount.h>
 
-#define IPCMNI 32768  /* <= MAX_INT limit for ipc arrays (including sysctl changes) */
-
 /* used by in-kernel data structures */
 struct kern_ipc_perm {
 	spinlock_t	lock;
diff --git a/ipc/util.h b/ipc/util.h
index 89b8ec176fc4..959c10eb9cc1 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/ipc_namespace.h>
 
+#define IPCMNI 32768  /* <= MAX_INT limit for ipc arrays (including sysctl changes) */
 #define SEQ_MULTIPLIER	(IPCMNI)
 
 int sem_init(void);
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
