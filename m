Return-Path: <SRS0=nTNb=ON=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B20C04EBF
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 07:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AD82087F
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 07:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29AD82087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbeLDHhb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:37:31 -0500
Received: from mga07.intel.com ([134.134.136.100]:2376 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeLDHhb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Dec 2018 02:37:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 23:37:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,313,1539673200"; 
   d="scan'208";a="115772840"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.53])
  by orsmga001.jf.intel.com with ESMTP; 03 Dec 2018 23:37:26 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     dhowells@redhat.com, tglx@linutronix.de
Cc:     jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        kirill.shutemov@linux.intel.com, dave.hansen@intel.com,
        kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: [RFC v2 11/13] keys/mktme: Program memory encryption keys on a system wide basis
Date:   Mon,  3 Dec 2018 23:39:58 -0800
Message-Id: <72dd5f38c1fdbc4c532f8caf2d2010f1ddfa8439.1543903910.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543903910.git.alison.schofield@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
In-Reply-To: <cover.1543903910.git.alison.schofield@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The kernel manages the MKTME (Multi-Key Total Memory Encryption) Keys
as a system wide single pool of keys. The hardware, however, manages
the keys on a per physical package basis. Each physical package
maintains a Key Table that all CPU's in that package share.

In order to maintain the consistent, system wide view that the kernel
requires, program all physical packages during a key program request.

Change-Id: I0ff46f37fde47a0305842baeb8ea600b6c568639
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 security/keys/mktme_keys.c | 61 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/security/keys/mktme_keys.c b/security/keys/mktme_keys.c
index e615eb58e600..7f113146acf2 100644
--- a/security/keys/mktme_keys.c
+++ b/security/keys/mktme_keys.c
@@ -21,6 +21,7 @@
 #include "internal.h"
 
 struct kmem_cache *mktme_prog_cache;	/* Hardware programming cache */
+cpumask_var_t mktme_leadcpus;		/* one cpu per pkg to program keys */
 
 static const char * const mktme_program_err[] = {
 	"KeyID was successfully programmed",	/* 0 */
@@ -59,6 +60,37 @@ static void mktme_destroy_key(struct key *key)
 	key_put_encrypt_ref(mktme_map_keyid_from_key(key));
 }
 
+struct mktme_hw_program_info {
+	struct mktme_key_program *key_program;
+	unsigned long status;
+};
+
+/* Program a KeyID on a single package. */
+static void mktme_program_package(void *hw_program_info)
+{
+	struct mktme_hw_program_info *info = hw_program_info;
+	int ret;
+
+	ret = mktme_key_program(info->key_program);
+	if (ret != MKTME_PROG_SUCCESS)
+		WRITE_ONCE(info->status, ret);
+}
+
+/* Program a KeyID across the entire system. */
+static int mktme_program_system(struct mktme_key_program *key_program,
+				cpumask_var_t mktme_cpumask)
+{
+	struct mktme_hw_program_info info = {
+		.key_program = key_program,
+		.status = MKTME_PROG_SUCCESS,
+	};
+	get_online_cpus();
+	on_each_cpu_mask(mktme_cpumask, mktme_program_package, &info, 1);
+	put_online_cpus();
+
+	return info.status;
+}
+
 /* Copy the payload to the HW programming structure and program this KeyID */
 static int mktme_program_keyid(int keyid, struct mktme_payload *payload)
 {
@@ -84,7 +116,7 @@ static int mktme_program_keyid(int keyid, struct mktme_payload *payload)
 			kprog->key_field_2[i] ^= kern_entropy[i];
 		}
 	}
-	ret = mktme_key_program(kprog);
+	ret = mktme_program_system(kprog, mktme_leadcpus);
 	kmem_cache_free(mktme_prog_cache, kprog);
 	return ret;
 }
@@ -299,6 +331,28 @@ struct key_type key_type_mktme = {
 	.destroy	= mktme_destroy_key,
 };
 
+static int mktme_build_leadcpus_mask(void)
+{
+	int online_cpu, mktme_cpu;
+	int online_pkgid, mktme_pkgid = -1;
+
+	if (!zalloc_cpumask_var(&mktme_leadcpus, GFP_KERNEL))
+		return -ENOMEM;
+
+	for_each_online_cpu(online_cpu) {
+		online_pkgid = topology_physical_package_id(online_cpu);
+
+		for_each_cpu(mktme_cpu, mktme_leadcpus) {
+			mktme_pkgid = topology_physical_package_id(mktme_cpu);
+			if (mktme_pkgid == online_pkgid)
+				break;
+		}
+		if (mktme_pkgid != online_pkgid)
+			cpumask_set_cpu(online_cpu, mktme_leadcpus);
+	}
+	return 0;
+}
+
 /*
  * Allocate the global mktme_map structure based on the available keyids.
  * Create a cache for the hardware structure. Initialize the encrypt_count
@@ -323,10 +377,15 @@ static int __init init_mktme(void)
 	if (mktme_alloc_encrypt_array() < 0)
 		goto free_cache;
 
+	if (mktme_build_leadcpus_mask() < 0)
+		goto free_array;
+
 	ret = register_key_type(&key_type_mktme);
 	if (!ret)
 		return ret;			/* SUCCESS */
 
+	free_cpumask_var(mktme_leadcpus);
+free_array:
 	mktme_free_encrypt_array();
 free_cache:
 	kmem_cache_destroy(mktme_prog_cache);
-- 
2.14.1

