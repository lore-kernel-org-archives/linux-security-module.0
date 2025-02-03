Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEB1153801;
	Mon,  3 Feb 2025 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738608186; cv=none; b=uJNILRvtcnNqWcoMp+w0eJGP4pMP8Ky7uOzrhJr3jC5zkFbpLwFAsKiyVhDNsrCD5aK9hClplOIb403g6KbyuDrcCA1vCbhqsfDGK6dDsSR4s9cIZtN+1Zph/9K3iTj3k4ySwKxTVoH5jqsl2EY3vUBEVU25nv18JxvzpSQtB2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738608186; c=relaxed/simple;
	bh=t4XqqrYhwscr6FS7U4bhL3N2YVK27fxTi1qasHS8jzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fEH1ZB+/Bsu1T55ScX9CIU7aQM2eQS2Qo8DpcnNtRnTx1F/yt1nSjuJ3CGtxDsnbU0CbhRAnOzwbPdcQRVitxMcEJGATdKZKe7q7HXaJrLJprVHdnlnamgtsnyJN48vEKlItpacM3Qkdnb3kIRxP5otqqa5rJnO6i5SIhXef+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nXqgAAht; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nXqgAAht"
Received: from localhost.localdomain (unknown [167.220.59.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id 346972054938;
	Mon,  3 Feb 2025 10:43:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 346972054938
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738608184;
	bh=l74eF+4+r695BFOwyov/kRxEW4Z5jvFKpT/pUDEgh3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXqgAAht6jT01pU7JPYfhksyK7TVNJFMaqlOrI/jiibAqJH5enZoJpMdov4u/s9Z/
	 AhmtKylAk2jLZLjSBLz/m9cdR+n0tZqJ2ZQRfAjOJVOst3K2Cq220hNXTfQOPUW4Tv
	 vD+XmLH4sB+oTGkUXfU04ucBTkE8QnItoeIHYPh8=
From: steven chen <chenste@linux.microsoft.com>
To: zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	ebiederm@xmission.com,
	paul@paul-moore.com,
	code@tyhicks.com,
	bauermann@kolabnow.com,
	inux-integrity@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenste@linux.microsoft.com
Cc: madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com
Subject: [PATCH v7 2/7] kexec: define functions to map and unmap segments
Date: Mon,  3 Feb 2025 10:42:51 -0800
Message-Id: <20250203184256.61285-3-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250203184256.61285-1-chenste@linux.microsoft.com>
References: <20250203184256.61285-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the mechanism to map and unmap segments to the kimage
structure is not available to the subsystems outside of kexec.  This
functionality is needed when IMA is allocating the memory segments
during kexec 'load' operation.  Implement functions to map and unmap
segments to kimage.

Implement kimage_map_segment() to enable mapping of IMA buffer source
pages to the kimage structure post kexec 'load'.  This function,
accepting a kimage pointer, an address, and a size, will gather the
source pages within the specified address range, create an array of page
pointers, and map these to a contiguous virtual address range.  The
function returns the start of this range if successful, or NULL if
unsuccessful.

Implement kimage_unmap_segment() for unmapping segments
using vunmap().

From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 include/linux/kexec.h |  7 ++++++
 kernel/kexec_core.c   | 54 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..f8413ea5c8c8 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -467,6 +467,9 @@ extern bool kexec_file_dbg_print;
 #define kexec_dprintk(fmt, arg...) \
         do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
 
+extern void *kimage_map_segment(struct kimage *image,
+					unsigned long addr, unsigned long size);
+extern void kimage_unmap_segment(void *buffer);
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
@@ -474,6 +477,10 @@ static inline void __crash_kexec(struct pt_regs *regs) { }
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 static inline int kexec_crash_loaded(void) { return 0; }
+static inline void *kimage_map_segment(struct kimage *image,
+					unsigned long addr, unsigned long size)
+{ return NULL; }
+static inline void kimage_unmap_segment(void *buffer) { }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c0caa14880c3..4029df8f6860 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -867,6 +867,60 @@ int kimage_load_segment(struct kimage *image,
 	return result;
 }
 
+void *kimage_map_segment(struct kimage *image,
+			 unsigned long addr, unsigned long size)
+{
+	unsigned long eaddr = addr + size;
+	unsigned long src_page_addr, dest_page_addr;
+	unsigned int npages;
+	struct page **src_pages;
+	int i;
+	kimage_entry_t *ptr, entry;
+	void *vaddr = NULL;
+
+	/*
+	 * Collect the source pages and map them in a contiguous VA range.
+	 */
+	npages = PFN_UP(eaddr) - PFN_DOWN(addr);
+	src_pages = kmalloc_array(npages, sizeof(*src_pages), GFP_KERNEL);
+	if (!src_pages) {
+		pr_err("Could not allocate ima pages array.\n");
+		return NULL;
+	}
+
+	i = 0;
+	for_each_kimage_entry(image, ptr, entry) {
+		if (entry & IND_DESTINATION)
+			dest_page_addr = entry & PAGE_MASK;
+		else if (entry & IND_SOURCE) {
+			if (dest_page_addr >= addr && dest_page_addr < eaddr) {
+				src_page_addr = entry & PAGE_MASK;
+				src_pages[i++] =
+					virt_to_page(__va(src_page_addr));
+				if (i == npages)
+					break;
+				dest_page_addr += PAGE_SIZE;
+			}
+		}
+	}
+
+	/* Sanity check. */
+	WARN_ON(i < npages);
+
+	vaddr = vmap(src_pages, npages, VM_MAP, PAGE_KERNEL);
+	kfree(src_pages);
+
+	if (!vaddr)
+		pr_err("Could not map ima buffer.\n");
+
+	return vaddr;
+}
+
+void kimage_unmap_segment(void *segment_buffer)
+{
+	vunmap(segment_buffer);
+}
+
 struct kexec_load_limit {
 	/* Mutex protects the limit count. */
 	struct mutex mutex;
-- 
2.25.1

