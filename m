Return-Path: <SRS0=nTNb=ON=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6B5C07E85
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 07:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01252087F
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Dec 2018 07:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01252087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbeLDHha (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:37:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:5832 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeLDHh1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Dec 2018 02:37:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 23:37:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,313,1539673200"; 
   d="scan'208";a="107105277"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.53])
  by orsmga003.jf.intel.com with ESMTP; 03 Dec 2018 23:37:26 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     dhowells@redhat.com, tglx@linutronix.de
Cc:     jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        kirill.shutemov@linux.intel.com, dave.hansen@intel.com,
        kai.huang@intel.com, jun.nakajima@intel.com,
        dan.j.williams@intel.com, jarkko.sakkinen@intel.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: [RFC v2 13/13] keys/mktme: Support CPU Hotplug for MKTME keys
Date:   Mon,  3 Dec 2018 23:40:00 -0800
Message-Id: <c14d24b09ee2ae37ea4106726ce8fe2aea31f6c7.1543903910.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543903910.git.alison.schofield@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
In-Reply-To: <cover.1543903910.git.alison.schofield@intel.com>
References: <cover.1543903910.git.alison.schofield@intel.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The MKTME (Multi-Key Memory Encryption Keys) hardware resides on each
physical package. The kernel maintains one Key Table on each physical
package and these Key Tables must all remain in sync.
(From here on, package means physical package.)

Although every CPU on that package has the ability to program the Key
Table, the kernel uses one 'lead' cpu per package to program the Key
Tables. Typically, keys are programmed one at a time, across all
packages, as the 'add key' requests come in from userspace.

Some CPU hotplug scenarios are handled quite simply:
>  Teardown a non lead CPU --> do nothing
>  Teardown a lead CPU --> pick a new lead CPU
>  Teardown a lead/last CPU of a package --> forget this package
>  Startup a CPU in a known package --> do nothing
>  Startup a CPU in a new package and no keys are programmed --> do nothing

Then there is the more interesting case for MKTME: a CPU is starting up
for a new package and keys are programmed on the existing packages. The Key
Table on the new package will need to be programmed to match the Key
Tables on all existing packages.

The issue is whether or not the Key Service has the information it needs
to program the new Key Table. To address this, a new kernel commandline
parameter 'mktme_savekeys' was introduced in a previous patch. It allows
the kernel to save the data needed to program keys, beyond their first
add key request.

When 'mktme_savekeys' is not present, new packages may still be added
if all currently programmed keys are not USER type. This means that
CPU generated keys are an option for users not wanting to save key
data, but who also want to support the addition of new packages.

Change-Id: I219192fc59dd9f433963c4959f33d7f013c9f73a
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 security/keys/mktme_keys.c | 135 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 126 insertions(+), 9 deletions(-)

diff --git a/security/keys/mktme_keys.c b/security/keys/mktme_keys.c
index e9c7d306cba1..fb4d4061d2f3 100644
--- a/security/keys/mktme_keys.c
+++ b/security/keys/mktme_keys.c
@@ -86,21 +86,29 @@ static void mktme_program_package(void *hw_program_info)
 
 /* Program a KeyID across the entire system. */
 static int mktme_program_system(struct mktme_key_program *key_program,
-				cpumask_var_t mktme_cpumask)
+				cpumask_var_t mktme_cpumask, int hotplug)
 {
 	struct mktme_hw_program_info info = {
 		.key_program = key_program,
 		.status = MKTME_PROG_SUCCESS,
 	};
-	get_online_cpus();
-	on_each_cpu_mask(mktme_cpumask, mktme_program_package, &info, 1);
-	put_online_cpus();
+
+	if (!hotplug) {
+		get_online_cpus();
+		on_each_cpu_mask(mktme_cpumask, mktme_program_package,
+				 &info, 1);
+		put_online_cpus();
+	} else {
+		on_each_cpu_mask(mktme_cpumask, mktme_program_package,
+				 &info, 1);
+	}
 
 	return info.status;
 }
 
 /* Copy the payload to the HW programming structure and program this KeyID */
-static int mktme_program_keyid(int keyid, struct mktme_payload *payload)
+static int mktme_program_keyid(int keyid, struct mktme_payload *payload,
+			       cpumask_var_t mask, int hotplug)
 {
 	struct mktme_key_program *kprog = NULL;
 	u8 kern_entropy[MKTME_AES_XTS_SIZE];
@@ -124,7 +132,7 @@ static int mktme_program_keyid(int keyid, struct mktme_payload *payload)
 			kprog->key_field_2[i] ^= kern_entropy[i];
 		}
 	}
-	ret = mktme_program_system(kprog, mktme_leadcpus);
+	ret = mktme_program_system(kprog, mktme_leadcpus, hotplug);
 	kmem_cache_free(mktme_prog_cache, kprog);
 	return ret;
 }
@@ -173,7 +181,7 @@ static int mktme_update_key(struct key *key,
 	/* Forget if key was user type. */
 	clear_bit(keyid, mktme_bitmap_user_type);
 
-	ret = mktme_program_keyid(keyid, payload);
+	ret = mktme_program_keyid(keyid, payload, mktme_leadcpus, 0);
 	if (ret != MKTME_PROG_SUCCESS) {
 		pr_debug("%s: %s\n", __func__, mktme_program_err[ret]);
 		ret = -ENOKEY;
@@ -202,7 +210,7 @@ int mktme_instantiate_key(struct key *key, struct key_preparsed_payload *prep)
 		ret = -ENOKEY;
 		goto out;
 	}
-	ret = mktme_program_keyid(keyid, payload);
+	ret = mktme_program_keyid(keyid, payload, mktme_leadcpus, 0);
 	if (ret != MKTME_PROG_SUCCESS) {
 		pr_debug("%s: %s\n", __func__, mktme_program_err[ret]);
 		ret = -ENOKEY;
@@ -375,6 +383,10 @@ struct key_type key_type_mktme = {
 	.destroy	= mktme_destroy_key,
 };
 
+/*
+ * Build mktme_leadcpus mask to include one cpu per physical package.
+ * The mask is used to program the Key Table on each physical package.
+ */
 static int mktme_build_leadcpus_mask(void)
 {
 	int online_cpu, mktme_cpu;
@@ -397,6 +409,102 @@ static int mktme_build_leadcpus_mask(void)
 	return 0;
 }
 
+/* A new packages Key Table is programmed with data saved in mktme_vault. */
+static int mktme_program_new_package(cpumask_var_t mask)
+{
+	struct key *key;
+	int hotplug = 1;
+	int keyid, ret;
+
+	/* When a KeyID slot is freed, it's corresponding Key is 0 */
+	for (keyid = 1; keyid <= mktme_nr_keyids; keyid++) {
+		key = mktme_map_key_from_keyid(keyid);
+		if (!key)
+			continue;
+		/* If one key fails to program, fail the entire package. */
+		ret = mktme_program_keyid(keyid, &mktme_vault[keyid],
+					  mask, hotplug);
+		if (ret != MKTME_PROG_SUCCESS) {
+			pr_debug("%s: %s\n", __func__, mktme_program_err[ret]);
+			ret = -ENOKEY;
+			break;
+		}
+	}
+	return ret;
+}
+
+static int mktme_hotplug_cpu_startup(unsigned int cpu)
+{
+	int lead_cpu, ret = 0;
+	cpumask_var_t newmask;
+	int pkgid = topology_physical_package_id(cpu);
+
+	mktme_map_lock();
+
+	/* Nothing to do if a lead CPU exists for this package. */
+	for_each_cpu(lead_cpu, mktme_leadcpus)
+		if (topology_physical_package_id(lead_cpu) == pkgid)
+			goto out_unlock;
+
+	/* No keys to program. Just add the new lead CPU to mask. */
+	if (!mktme_map_mapped_keyids())
+		goto out_add_cpu;
+
+	/* Keys need to be programmed. Confirm programming can be done. */
+	if (!mktme_savekeys &&
+	    (bitmap_weight(mktme_bitmap_user_type, mktme_nr_keyids))) {
+		ret = -EPERM;
+		goto out_unlock;
+	}
+
+	/* Program only this packages Key Table, not all Key Tables. */
+	if (!zalloc_cpumask_var(&newmask, GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+	cpumask_set_cpu(cpu, newmask);
+	ret = mktme_program_new_package(newmask);
+	if (ret < 0) {
+		free_cpumask_var(newmask);
+		goto out_unlock;
+	}
+
+	free_cpumask_var(newmask);
+out_add_cpu:
+	/* Make this cpu a lead cpu for all future Key programming requests. */
+	cpumask_set_cpu(cpu, mktme_leadcpus);
+out_unlock:
+	mktme_map_unlock();
+	return ret;
+}
+
+static int mktme_hotplug_cpu_teardown(unsigned int cpu)
+{
+	int pkgid, online_cpu;
+
+	mktme_map_lock();
+	/* Teardown cpu is not a lead cpu, nothing to do. */
+	if (!cpumask_test_and_clear_cpu(cpu, mktme_leadcpus))
+		goto out;
+	/*
+	 * Teardown cpu is a lead cpu. If the physical package
+	 * is still present, pick a new lead cpu. Beware: the
+	 * teardown cpu is still in the online_cpu mask. Do
+	 * not pick it again.
+	 */
+	pkgid = topology_physical_package_id(cpu);
+	for_each_online_cpu(online_cpu)
+		if (online_cpu != cpu &&
+		    pkgid == topology_physical_package_id(online_cpu)) {
+			cpumask_set_cpu(online_cpu, mktme_leadcpus);
+			break;
+	}
+out:
+	mktme_map_unlock();
+	/* Teardowns always succeed. */
+	return 0;
+}
+
 /*
  * Allocate the global mktme_map structure based on the available keyids.
  * Create a cache for the hardware structure. Initialize the encrypt_count
@@ -405,7 +513,7 @@ static int mktme_build_leadcpus_mask(void)
  */
 static int __init init_mktme(void)
 {
-	int ret;
+	int ret, cpuhp;
 
 	/* Verify keys are present */
 	if (!(mktme_nr_keyids > 0))
@@ -433,10 +541,19 @@ static int __init init_mktme(void)
 	if (!mktme_vault)
 		goto free_bitmap;
 
+	cpuhp = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					  "keys/mktme_keys:online",
+					  mktme_hotplug_cpu_startup,
+					  mktme_hotplug_cpu_teardown);
+	if (cpuhp < 0)
+		goto free_vault;
+
 	ret = register_key_type(&key_type_mktme);
 	if (!ret)
 		return ret;			/* SUCCESS */
 
+	cpuhp_remove_state_nocalls(cpuhp);
+free_vault:
 	kfree(mktme_vault);
 free_bitmap:
 	bitmap_free(mktme_bitmap_user_type);
-- 
2.14.1

