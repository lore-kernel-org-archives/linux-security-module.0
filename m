Return-Path: <SRS0=nTNb=ON=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADE8C65BB8
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 07:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B45B214DA
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 07:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B45B214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeLDHhZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:37:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:63183 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbeLDHhZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Dec 2018 02:37:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 23:37:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,313,1539673200"; 
   d="scan'208";a="256618438"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.53])
  by orsmga004.jf.intel.com with ESMTP; 03 Dec 2018 23:37:22 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     dhowells@redhat.com, tglx@linutronix.de
Cc:     jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        kirill.shutemov@linux.intel.com, dave.hansen@intel.com,
        kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: [RFC v2 04/13] x86/mm: Add helper functions for MKTME memory encryption keys
Date:   Mon,  3 Dec 2018 23:39:51 -0800
Message-Id: <bd83f72d30ccfc7c1bc7ce9ab81bdf66e78a1d7d.1543903910.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543903910.git.alison.schofield@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
In-Reply-To: <cover.1543903910.git.alison.schofield@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Define a global mapping structure to manage the mapping of userspace
Keys to hardware KeyIDs in MKTME (Multi-Key Total Memory Encryption).
Implement helper functions that access this mapping structure.

The helpers will be used by these MKTME API's:
 >  Key Service API: security/keys/mktme_keys.c
 >  encrypt_mprotect() system call: mm/mprotect.c

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h | 12 ++++++
 arch/x86/mm/mktme.c          | 91 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index f05baa15e6f6..dbb49909d665 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -12,6 +12,18 @@ extern phys_addr_t mktme_keyid_mask;
 extern int mktme_nr_keyids;
 extern int mktme_keyid_shift;
 
+/* Manage mappings between hardware KeyIDs and userspace Keys */
+extern int mktme_map_alloc(void);
+extern void mktme_map_free(void);
+extern void mktme_map_lock(void);
+extern void mktme_map_unlock(void);
+extern int mktme_map_mapped_keyids(void);
+extern void mktme_map_set_keyid(int keyid, void *key);
+extern void mktme_map_free_keyid(int keyid);
+extern int mktme_map_keyid_from_key(void *key);
+extern void *mktme_map_key_from_keyid(int keyid);
+extern int mktme_map_get_free_keyid(void);
+
 DECLARE_STATIC_KEY_FALSE(mktme_enabled_key);
 static inline bool mktme_enabled(void)
 {
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index c81727540e7c..34224d4e3f45 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -40,6 +40,97 @@ int __vma_keyid(struct vm_area_struct *vma)
 	return (prot & mktme_keyid_mask) >> mktme_keyid_shift;
 }
 
+/*
+ * struct mktme_map and the mktme_map_* functions manage the mapping
+ * of userspace Keys to hardware KeyIDs. These are used by the MKTME Key
+ * Service API and the encrypt_mprotect() system call.
+ */
+
+struct mktme_mapping {
+	struct mutex	lock;		/* protect this map & HW state */
+	unsigned int	mapped_keyids;
+	void		*key[];
+};
+
+struct mktme_mapping *mktme_map;
+
+static inline long mktme_map_size(void)
+{
+	long size = 0;
+
+	size += sizeof(*mktme_map);
+	size += sizeof(mktme_map->key[0]) * (mktme_nr_keyids + 1);
+	return size;
+}
+
+int mktme_map_alloc(void)
+{
+	mktme_map = kvzalloc(mktme_map_size(), GFP_KERNEL);
+	if (!mktme_map)
+		return 0;
+	mutex_init(&mktme_map->lock);
+	return 1;
+}
+
+void mktme_map_free(void)
+{
+	kvfree(mktme_map);
+}
+
+void mktme_map_lock(void)
+{
+	mutex_lock(&mktme_map->lock);
+}
+
+void mktme_map_unlock(void)
+{
+	mutex_unlock(&mktme_map->lock);
+}
+
+int mktme_map_mapped_keyids(void)
+{
+	return mktme_map->mapped_keyids;
+}
+
+void mktme_map_set_keyid(int keyid, void *key)
+{
+	mktme_map->key[keyid] = key;
+	mktme_map->mapped_keyids++;
+}
+
+void mktme_map_free_keyid(int keyid)
+{
+	mktme_map->key[keyid] = 0;
+	mktme_map->mapped_keyids--;
+}
+
+int mktme_map_keyid_from_key(void *key)
+{
+	int i;
+
+	for (i = 1; i <= mktme_nr_keyids; i++)
+		if (mktme_map->key[i] == key)
+			return i;
+	return 0;
+}
+
+void *mktme_map_key_from_keyid(int keyid)
+{
+	return mktme_map->key[keyid];
+}
+
+int mktme_map_get_free_keyid(void)
+{
+	int i;
+
+	if (mktme_map->mapped_keyids < mktme_nr_keyids) {
+		for (i = 1; i <= mktme_nr_keyids; i++)
+			if (mktme_map->key[i] == 0)
+				return i;
+	}
+	return 0;
+}
+
 /* Prepare page to be used for encryption. Called from page allocator. */
 void __prep_encrypted_page(struct page *page, int order, int keyid, bool zero)
 {
-- 
2.14.1

