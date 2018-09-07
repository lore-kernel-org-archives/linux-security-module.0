From: alison.schofield@intel.com (Alison Schofield)
Date: Fri, 7 Sep 2018 15:37:51 -0700
Subject: [RFC 09/12] mm: Restrict memory encryption to anonymous VMA's
In-Reply-To: <cover.1536356108.git.alison.schofield@intel.com>
References: <cover.1536356108.git.alison.schofield@intel.com>
Message-ID: <f69e3d4f96504185054d951c7c85075ebf63e47a.1536356108.git.alison.schofield@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Memory encryption is only supported for mappings that are ANONYMOUS.
Test the entire range of VMA's in an encrypt_mprotect() request to
make sure they all meet that requirement before encrypting any.

The encrypt_mprotect syscall will return -EINVAL and will not encrypt
any VMA's if this check fails.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 mm/mprotect.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 6c2e1106525c..3384b755aad1 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -311,6 +311,24 @@ unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
 	return pages;
 }
 
+/*
+ * Encrypted mprotect is only supported on anonymous mappings.
+ * All VMA's in the requested range must be anonymous. If this
+ * test fails on any single VMA, the entire mprotect request fails.
+ */
+bool mem_supports_encryption(struct vm_area_struct *vma, unsigned long end)
+{
+	struct vm_area_struct *test_vma = vma;
+
+	do {
+		if (!vma_is_anonymous(test_vma))
+			return false;
+
+		test_vma = test_vma->vm_next;
+	} while (test_vma && test_vma->vm_start < end);
+	return true;
+}
+
 int
 mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 	       unsigned long start, unsigned long end, unsigned long newflags,
@@ -491,6 +509,10 @@ static int do_mprotect_ext(unsigned long start, size_t len,
 				goto out;
 		}
 	}
+	if (keyid > 0 && !mem_supports_encryption(vma, end)) {
+		error = -EINVAL;
+		goto out;
+	}
 	if (start > vma->vm_start)
 		prev = vma;
 
-- 
2.14.1
