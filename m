From: alison.schofield@intel.com (Alison Schofield)
Date: Fri, 7 Sep 2018 15:34:26 -0700
Subject: [RFC 02/12] mm: Generalize the mprotect implementation to support
	extensions
In-Reply-To: <cover.1536356108.git.alison.schofield@intel.com>
References: <cover.1536356108.git.alison.schofield@intel.com>
Message-ID: <2dcbb08ed8804e02538a73ee05a4283c54180e36.1536356108.git.alison.schofield@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Today mprotect is implemented to support legacy mprotect behavior
plus an extension for memory protection keys. Make it more generic
so that it can support additional extensions in the future.

This is done is preparation for adding a new system call for memory
encyption keys. The intent is that the new encrypted mprotect will be
another extension to legacy mprotect.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 mm/mprotect.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 68dc476310c0..56e64ef7931e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -35,6 +35,8 @@
 
 #include "internal.h"
 
+#define NO_PKEY  -1
+
 static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
 		int dirty_accountable, int prot_numa)
@@ -402,9 +404,9 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 }
 
 /*
- * pkey==-1 when doing a legacy mprotect()
+ * When pkey==NO_PKEY we get legacy mprotect behavior here.
  */
-static int do_mprotect_pkey(unsigned long start, size_t len,
+static int do_mprotect_ext(unsigned long start, size_t len,
 		unsigned long prot, int pkey)
 {
 	unsigned long nstart, end, tmp, reqprot;
@@ -528,7 +530,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
 		unsigned long, prot)
 {
-	return do_mprotect_pkey(start, len, prot, -1);
+	return do_mprotect_ext(start, len, prot, NO_PKEY);
 }
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
@@ -536,7 +538,7 @@ SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
 SYSCALL_DEFINE4(pkey_mprotect, unsigned long, start, size_t, len,
 		unsigned long, prot, int, pkey)
 {
-	return do_mprotect_pkey(start, len, prot, pkey);
+	return do_mprotect_ext(start, len, prot, pkey);
 }
 
 SYSCALL_DEFINE2(pkey_alloc, unsigned long, flags, unsigned long, init_val)
-- 
2.14.1
