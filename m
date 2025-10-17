Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDEB277C98
	for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734140; cv=none; b=rf+aRIrJ1lXaRhWP7KNeKWuo9DQCmYOwRTX/JIwk1A5R9rMt/vA7v5YXFGd+C3OxOb0SKnJ3nolsknQnjwM81c01TCAsxe1MwIyOZMd/i06hUs6+5mYWp+uYDXn7xXEuxkXNMVixzwyKO+D6I+pYMEZIiLl0sFXYc4tbsuM2MgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734140; c=relaxed/simple;
	bh=2lMtoYovPjCZ3Lcx+3j9bkTz3aQSzXesF/+5qOsbqvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BojK3EqQLiaZucFscaRCUY/rDY32AN3Y6YzyREr1/rhhk8l5iIEMoO0s66vXH09jUh14Yq+G2wpBePwFmZg89anK6vZHsodOMJZ9laMfEwMOyunY+MP16Rb0983NYu4yW+2QBQKZXlZUFBfdl/IQDc8dUrDhNvjO8S7h3zENgNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=A8SZPM4z; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="A8SZPM4z"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-88f8e855b4eso201977885a.3
        for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 13:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760734137; x=1761338937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJsIjC7lVqxkEZ500yj08xA6uFymPdx1a77LtMLfpSI=;
        b=A8SZPM4zARj4uQr3BI8p+yHC0/O7bQnxMxVxYJO5hZbDppeqTtM3MtpGhsyPTUnPwu
         7GLo7U85HmVY4bd5+NUOe1YcvoL40B9co64QdEJljcyBZ0qx4ThVIBrRk4hEIR6C3Ejv
         Zpqge8cAHw6MnSXiU7sEFuNbM+wEJff59gSdQO+99WD3u6HzJYGCxpsfuVFFWPSCaVaL
         9yjXHF3bMkip/ClvAGIsXCbEPtzJiWXfrSH/rVy7wNXPzUfkch1HVO29qDRcBMZssukz
         t12LZm3gGOLT66sVyH2iSvrLRi3LfznXGmxbChdrKlJBfA245/76trcmtxOkFCqTYplW
         nqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734137; x=1761338937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJsIjC7lVqxkEZ500yj08xA6uFymPdx1a77LtMLfpSI=;
        b=EQJq7AcyBR07DR5ZpCxu+FPG4IigEB9q1vgPZVr6l6RFB4GHaPswNHXVqQ4HeKNot7
         HIbxBmGBcvmuOhpgd08hE67/seYY1Dm2Mszow2KZOPgXLMAT8GAhiVH6yobsKs1YPZCy
         69mf+63UhDa1k2213bATGy5yfwg9pxBUOpZv+ufpT5+ZxujUvswO71obfauiZBYCRc1o
         NGdhHDgTQP47EKvh8FT2BnBcxeJ6iENgO7SevYqAaMhvEZaqtaBf4HP5sxjOtgb/BdWA
         EwrVn+GUUDvafpODpZFk1yCszCFJ+r/Kzsgy5S/6eEgdXZKLR9c8akABHOIwzA+QwSJ4
         wYzA==
X-Gm-Message-State: AOJu0YzzJKGsIvKPYwL1ykKu6XBtIEK4Arpl5KeLYpGbgDWvEzbJdetp
	WxPxK/Tl1iBuC+RoemahmOS9lHojz7AjRRZ/DQ09BCiCqBhngzRQTCPqRjH32emCtduI0xEd0c5
	c3MX+TQ==
X-Gm-Gg: ASbGnctg+LgId2DSQW01VNQ6/XdO7+MzLo/0A05VNf4t1/XVpGCtuhmRKUcvFHglyPq
	kNaeeMsYmvDJXcXJ1pI879pZLzWwIi1Xm5kQSbSHG9DNu+sGclUviTu2qQDPYi74NKLqviF1t2Y
	QIDGSCc/TeRtD206WIWt2zi8VWG6hKgOxtgBaEbkCvexx2KzZzd9lyCTCvDtK37zWj+lIpamIxk
	XX62KD/I6fgw+4zOzKrBjX/+jd5Nvro73Uf3tHnYEhkmKvsE9oqNLdIgV0adYVrUVjRw1X9Fv1m
	g5F/Y59mTA7xt1fW6OKm4RbAQJksfPruk1Bcu85fhIGUOeT4j+g2k1DGdJ/XLOhdBAtvrLETcWp
	6zeUkqoofzPn2lLfkfqhBwru4cecNDx0t0M1Ztdhr2JSGQFhBdSIJcrnZ0RzhMRUhhKmcDpwNVR
	tcqetse1HbZXKaoQLtvoaxwgff5vzBT248Je/YsV+Cr3rP8drxii4lHIKM
X-Google-Smtp-Source: AGHT+IGClTajcAmYtgIMAGkwhjdyhBB/xXejAQtZG+W3S7S73PiMVFGPFSB9TJXqU9EWqWKR5fyByg==
X-Received: by 2002:a05:620a:1a0b:b0:891:c0a6:2e7c with SMTP id af79cd13be357-891c0a62ed7mr149371485a.80.1760734136658;
        Fri, 17 Oct 2025 13:48:56 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cc8d5da1sm44199785a.10.2025.10.17.13.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:48:55 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: john.johansen@canonical.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	wufan@kernel.org,
	mic@digikod.net,
	gnoack@google.com,
	kees@kernel.org,
	mortonm@chromium.org,
	casey@schaufler-ca.com,
	penguin-kernel@I-love.SAKURA.ne.jp,
	nicolas.bouchinet@oss.cyber.gouv.fr,
	xiujianfeng@huawei.com
Subject: [PATCH v5 03/11] smack: move initcalls to the LSM framework
Date: Fri, 17 Oct 2025 16:48:17 -0400
Message-ID: <20251017204815.505363-14-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017204815.505363-12-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
 <20251017204815.505363-12-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3120; i=paul@paul-moore.com; h=from:subject; bh=2lMtoYovPjCZ3Lcx+3j9bkTz3aQSzXesF/+5qOsbqvI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8quVSAJbh262JjmISk/mf3fwedtDlPhi/2fDm GGT+3DBck+JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKrlQAKCRDqIPLalzeJ c4cWD/9sqzk++B2b/F5Rt/Q7EYvWPnZDwJ0YE/h/lyd6gHjHYEmzyuhcUv4Ee829kJVbl1NYsKI BNh/EdbjYdSxDI9XDO947PCwIxqMkVtm8EkoH6Kgyq26HN1qqEznuXeMAwLghScCGrWEEgZskWl 2R5yn8V+KJsfT+BO/m7Z9HT7iCtv9HJvbB521MeJm7O7V0NxRizolhHGV+OmfsEAGJIAG1QK1EJ aFtHM0AdTi+VBr9bTa+6MmWWvrADxoLHxlD2513mrJZZIOMkX+SK8Og//yZU7DNx8e1GW8G18Zv BLCyShl8atAIkEMJGAehp+/YOYHTz72SY2+IWhOfk0s+As5Jw35VAl4bwgatQEpUIaSFUsO7Dfc RfWZw9ftoHtlWQzyFgWah06UEU1DNSlSv846JCrXAnUIK8Z08lOeBgWWDLAM+YbXfOJO7i0GazV 3acp9Eh+R0PHyAGP+F8JEdI+nNxGxQA63GXALS+mY8g1F6I6jNffU9382gm0yjKQ8cWhwEUXeBz t02yvqj1cXny9LAfvAsvgdVxBWB8sO02ifJKwU3tC7bygLdSVYya19kGqd9CDBUNpSiQxAtfOx+ xH5YmSsS4BCVJNohTx4uDAi+FbuaKwI74ivgO2Uw8WHHAD2SdlabsHeTrix0SBbzvU3qlT7uvIT DHvEWG+8YXozbyw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As the LSM framework only supports one LSM initcall callback for each
initcall type, the init_smk_fs() and smack_nf_ip_init() functions were
wrapped with a new function, smack_initcall() that is registered with
the LSM framework.

Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/smack/smack.h           | 14 ++++++++++++++
 security/smack/smack_lsm.c       |  9 +++++++++
 security/smack/smack_netfilter.c |  4 +---
 security/smack/smackfs.c         |  4 +---
 4 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index bf6a6ed3946c..c56e1e876f7c 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -275,6 +275,20 @@ struct smk_audit_info {
 #endif
 };
 
+/*
+ * Initialization
+ */
+#if defined(CONFIG_SECURITY_SMACK_NETFILTER)
+int smack_nf_ip_init(void);
+#else
+static inline int smack_nf_ip_init(void)
+{
+	return 0;
+}
+#endif
+int init_smk_fs(void);
+int smack_initcall(void);
+
 /*
  * These functions are in smack_access.c
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 392698e41120..23ee1c0c07b7 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5275,6 +5275,14 @@ static __init int smack_init(void)
 	return 0;
 }
 
+int __init smack_initcall(void)
+{
+	int rc_fs = init_smk_fs();
+	int rc_nf = smack_nf_ip_init();
+
+	return rc_fs ? rc_fs : rc_nf;
+}
+
 /*
  * Smack requires early initialization in order to label
  * all processes and objects when they are created.
@@ -5284,4 +5292,5 @@ DEFINE_LSM(smack) = {
 	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.blobs = &smack_blob_sizes,
 	.init = smack_init,
+	.initcall_device = smack_initcall,
 };
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index 8fd747b3653a..17ba578b1308 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -68,7 +68,7 @@ static struct pernet_operations smack_net_ops = {
 	.exit = smack_nf_unregister,
 };
 
-static int __init smack_nf_ip_init(void)
+int __init smack_nf_ip_init(void)
 {
 	if (smack_enabled == 0)
 		return 0;
@@ -76,5 +76,3 @@ static int __init smack_nf_ip_init(void)
 	printk(KERN_DEBUG "Smack: Registering netfilter hooks\n");
 	return register_pernet_subsys(&smack_net_ops);
 }
-
-__initcall(smack_nf_ip_init);
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index b1e5e62f5cbd..405ace6db109 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -2978,7 +2978,7 @@ static struct vfsmount *smackfs_mount;
  * Returns true if we were not chosen on boot or if
  * we were chosen and filesystem registration succeeded.
  */
-static int __init init_smk_fs(void)
+int __init init_smk_fs(void)
 {
 	int err;
 	int rc;
@@ -3021,5 +3021,3 @@ static int __init init_smk_fs(void)
 
 	return err;
 }
-
-__initcall(init_smk_fs);
-- 
2.51.1.dirty

