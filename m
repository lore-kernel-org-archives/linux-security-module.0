Return-Path: <SRS0=nTNb=ON=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6EEC04EB8
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 07:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040E62087F
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 07:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040E62087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbeLDHh0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:37:26 -0500
Received: from mga12.intel.com ([192.55.52.136]:55172 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbeLDHhZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Dec 2018 02:37:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 23:37:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,313,1539673200"; 
   d="scan'208";a="115858977"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.53])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Dec 2018 23:37:24 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     dhowells@redhat.com, tglx@linutronix.de
Cc:     jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        kirill.shutemov@linux.intel.com, dave.hansen@intel.com,
        kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: [RFC v2 08/13] mm: Use reference counting for encrypted VMAs
Date:   Mon,  3 Dec 2018 23:39:55 -0800
Message-Id: <985ba614d49986fdfc0397434fd1dd9eb5646c6f.1543903910.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543903910.git.alison.schofield@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
In-Reply-To: <cover.1543903910.git.alison.schofield@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The MKTME (Multi-Key Total Memory Encryption) Key Service needs
a reference count on encrypted VMAs. This reference count is used
to determine when a hardware encryption keyid is in use, which in
turn, tells the key service what operations can be safely performed
with this keyid.

The approach is:
1) Increment/decrement the reference count during encrypt_mprotect()
system call for initial or updated encryption on a VMA.

2) Piggy back on the new vm_area_dup/free() helpers. If the VMAs being
duplicated, or freed are encrypted, adjust the reference count.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/mm/mktme.c | 2 ++
 kernel/fork.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index facf08f9cb74..55d34beb9b81 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -145,10 +145,12 @@ void mprotect_set_encrypt(struct vm_area_struct *vma, int newkeyid,
 	if (oldkeyid == newkeyid)
 		return;
 
+	vma_put_encrypt_ref(vma);
 	newprot = pgprot_val(vma->vm_page_prot);
 	newprot &= ~mktme_keyid_mask;
 	newprot |= (unsigned long)newkeyid << mktme_keyid_shift;
 	vma->vm_page_prot = __pgprot(newprot);
+	vma_get_encrypt_ref(vma);
 
 	/*
 	 * The VMA doesn't have any inherited pages.
diff --git a/kernel/fork.c b/kernel/fork.c
index 07cddff89c7b..d12d27b50966 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -341,12 +341,14 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	if (new) {
 		*new = *orig;
 		INIT_LIST_HEAD(&new->anon_vma_chain);
+		vma_get_encrypt_ref(new);
 	}
 	return new;
 }
 
 void vm_area_free(struct vm_area_struct *vma)
 {
+	vma_put_encrypt_ref(vma);
 	kmem_cache_free(vm_area_cachep, vma);
 }
 
-- 
2.14.1

