Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8074E27FD46
	for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 22:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060880; cv=none; b=bOzr+T0I7kiYIOHia7c1ZuU7/wn0/Y8ZXbgdVcC40WY7Q90N6M1FJRUxB0/nQiekJUO+E4eRnpbOipB/3q7bhoWnPFYyn5SMWSB3da1gT7iFC8e1oYbp2Gh0FWYwyNXQOsq1M0tCITqPI4CuJwihZbUY0ZhVQDeXU8HcpGvW6tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060880; c=relaxed/simple;
	bh=+A8UykmM5y6JgZpn/LZlMjlBn7J7X9zEL9LbQ66C1UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GomLb0sl5nHVjaxYGU8NAqUP0Rx+ylUzfneRyUACxjhoGdc0/Wu7sKH+JRqsYBv8SNpLDNYRrxSr8wXpMTfOi4Vq5VHmAcDxy5fWgD5JcBq9xUjT5j7NckgJZhsQBtsEtBT3v6txCLkS+FVSNDm07m/+5tjfrvpOmSa6+VGMB7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IJeC4GAV; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IJeC4GAV"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-78eba712e89so154086d6.3
        for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 15:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060876; x=1758665676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rL8A3PYTBA07yIH2OqB9BEQIkDMK0RLNP0w/NWWAecM=;
        b=IJeC4GAVbUkBsUv3HwsJHmqCxMpJhycsRRGTCBEdSmAVfPoluij/RfgG9wpbou484R
         8lJoim2Ktf2sdsHgyDmmgWhZY0H9nqr4VSFjeSiwNIm7JpapKhBsbsTEv/5dMY6AUeBJ
         0T4TxPbTrBJxtQnYFj3rpUtgO4X6SlLGMYQor6vPCSWSq4TWClixFtyavaYMjM1IK2kq
         bVHof6Y+z2a9fc8ptYxy0kk02g529H4Ph1oHrKhJKsuFmoPGtisidD+kz/relagQGwh1
         6fG03+xJC9pVjLPyGOF20UQotfMDmiBsKLw5dqEuT8CYBmseQzFb0sdlWduNBrZX7THr
         POYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060876; x=1758665676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rL8A3PYTBA07yIH2OqB9BEQIkDMK0RLNP0w/NWWAecM=;
        b=A7TyUIiqV6g1Q3Sc+q19b8pdcVouODrI0ivSjuTjXNHVJwDXnH82QYMQn1fNVZHeDY
         fTHxN4cz26S4mCcUrN+N5tn7dKILk00TND4wMfV1+Z7G2+ft7Q0zf/K0AHSu94ECMbqW
         k2/HJMLFoW+sm6R1hJllCF2gYSYknraBUAx5oeS6vwnPnoGArIEcbW8EGYN89DVGNWFJ
         5IdHutwfyRMG0Nm9dpiztnQdOSLio7alW6GNjIowCPdE7q38UbLG2SVTs2bKXI9H4qRa
         fCYdH50ITMtq++BuMq8kWMBPEMLKAxRd3J/M3TIXN0DWcJAqyVFMsbpxXTNs+uD2aU51
         SaEA==
X-Gm-Message-State: AOJu0Yx/2izTfhHjJ5cU2It5S7TuuqhYOFbfQ3PWBDGWTBKgsAbwBTkG
	jx1s13PKWpbSxfIlbwrj6zu1VDTWYhhoQEdMEQ2r/POi7fjaz3YijriRkQEtBDoTbuZCqGuokPU
	pLNQ=
X-Gm-Gg: ASbGncssl/7Sy92obcJJiQ97oyb8AAh50E3dp3BsUXICWDLSnWgvkCbplCabmDhox5B
	1Uhtra4/R4uhvf+FjvUd4dmjsdw04pxirseNLZrA9/4W4vjTPUW14d0Agwc2CAcyO86kkkc7C//
	XMHFXPgT96+lZrk6MiEpW12Dcr+FiizseIPtIu400dJBHjBmptqMGbhxdcsV7kwkRlYPYAhIIND
	azL32dCq0WMnDFnIpHYPZSKf9qhi5Oe9JLhvQb2DAUO8vtHOMYguJYuewXwVv4lb/m8asJVy/TE
	BgmssjMWPeBRIReWtk1wU62i6fIxYaIPE+mZQAx8Oyd+msG8y4/m5LQEPydozHdpigSfNf2HM3E
	qjlaY4bn0p6yau1PdnUiLlgyMCQrGXMGRrjCZuv7+YCwhHoaiI2a/Zz0C4gU5jMcwCSen
X-Google-Smtp-Source: AGHT+IF6z0ZRr6CwRzDzwa42imnCF7XCHREKGQRMSeZqdbCMJOodDvlgpBAZmrEYV8Lh0o7LVJc/Bw==
X-Received: by 2002:ad4:5cc2:0:b0:787:44ee:cb21 with SMTP id 6a1803df08f44-78744eed49amr100060176d6.34.1758060876515;
        Tue, 16 Sep 2025 15:14:36 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-77902aba37dsm58367336d6.50.2025.09.16.15.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:34 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH v4 31/34] ima,evm: move initcalls to the LSM framework
Date: Tue, 16 Sep 2025 18:03:58 -0400
Message-ID: <20250916220355.252592-67-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5029; i=paul@paul-moore.com; h=from:subject; bh=B6xkKxzJDX880wnxZuDY5At/z5onL7ffkdvP8EQljn4=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd8uVB3v0lkqURDcif5AFU40mRBf5Bqo4OnQI 6H7tQ1a7E6JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfLgAKCRDqIPLalzeJ c5EvD/wIL1GiF8/L0PbY3k1roSHWVt6mZi36ljZ8LNB4e3HDYwu/w78IoJeABJLtzm414bh0GSR V+QRiHu97kne/wUgc84fk+BKVWV6JosQGALUm7qTxPbZAzzzxS+I/yc8Vbd018z7QmdbricDIQh IUtQkwmexPRe//GSI6U4NUJBTOot3xx5nadF7/vNMoDQFBh46nG5BwgFXno3n6dP3vSjBRrpiNB 9WmBFdrSa+36ImZHPo80mdFHnfF96Iw5UGZOnNdoo1LnH8Al2ZDekRo+JXwENnIzjiy0mJiamUN eJSehXDDYSfVf4HWz+6BdzyxGIZU+4OFnEx5yAIhMTuryRtuB9s7+pmbzl0jRaaznpIy/bBEu/t 6NODsnBn696fqOcQzqw7/sq/qfV8MhL+eTiRau/iRE/AiZPYuiVziv/o6CPghSr++oboTkH4s7e pP+G1rbSTenEE2NTtt1mrV8ce/q1n2grvUbfExrV/1FUkFB0DUQEBmtJHBVk3YWDnE9Prl/5RhY vxS0JTjhw+KRf7TNiVju6t6flqmOTz21bIeQwBS6l82eOVafj0rwqttfBArcn5p3uHqzB2TEKCh FO+xNjVrWruZY25hFTHQ/89wJyq3YWmngRO9kVAaI1EZAurFTl3XapFEfZfVQGbG/IgeFAma91L YxpR4Gp/c5LdvjQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

From: Roberto Sassu <roberto.sassu@huawei.com>

This patch converts IMA and EVM to use the LSM frameworks's initcall
mechanism. It moved the integrity_fs_init() call to ima_fs_init() and
evm_init_secfs(), to work around the fact that there is no "integrity" LSM,
and introduced integrity_fs_fini() to remove the integrity directory, if
empty. Both integrity_fs_init() and integrity_fs_fini() support the
scenario of being called by both the IMA and EVM LSMs.

This patch does not touch any of the platform certificate code that
lives under the security/integrity/platform_certs directory as the
IMA/EVM developers would prefer to address that in a future patchset.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
[PM: adjust description as discussed over email]
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/integrity/evm/evm_main.c  |  3 +--
 security/integrity/evm/evm_secfs.c | 11 +++++++++--
 security/integrity/iint.c          | 14 ++++++++++++--
 security/integrity/ima/ima_fs.c    | 11 +++++++++--
 security/integrity/ima/ima_main.c  |  4 ++--
 security/integrity/integrity.h     |  2 ++
 6 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index db8e324ed4e6..73d500a375cb 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -1179,6 +1179,5 @@ DEFINE_LSM(evm) = {
 	.init = init_evm_lsm,
 	.order = LSM_ORDER_LAST,
 	.blobs = &evm_blob_sizes,
+	.initcall_late = init_evm,
 };
-
-late_initcall(init_evm);
diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index b0d2aad27850..c26724690cec 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -302,10 +302,16 @@ int __init evm_init_secfs(void)
 	int error = 0;
 	struct dentry *dentry;
 
-	evm_dir = securityfs_create_dir("evm", integrity_dir);
-	if (IS_ERR(evm_dir))
+	error = integrity_fs_init();
+	if (error < 0)
 		return -EFAULT;
 
+	evm_dir = securityfs_create_dir("evm", integrity_dir);
+	if (IS_ERR(evm_dir)) {
+		error = -EFAULT;
+		goto out;
+	}
+
 	dentry = securityfs_create_file("evm", 0660,
 				      evm_dir, NULL, &evm_key_ops);
 	if (IS_ERR(dentry)) {
@@ -329,5 +335,6 @@ int __init evm_init_secfs(void)
 out:
 	securityfs_remove(evm_symlink);
 	securityfs_remove(evm_dir);
+	integrity_fs_fini();
 	return error;
 }
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 068ac6c2ae1e..8ec1a3436a71 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -42,8 +42,11 @@ void __init integrity_load_keys(void)
 		evm_load_x509();
 }
 
-static int __init integrity_fs_init(void)
+int __init integrity_fs_init(void)
 {
+	if (integrity_dir)
+		return 0;
+
 	integrity_dir = securityfs_create_dir("integrity", NULL);
 	if (IS_ERR(integrity_dir)) {
 		int ret = PTR_ERR(integrity_dir);
@@ -58,4 +61,11 @@ static int __init integrity_fs_init(void)
 	return 0;
 }
 
-late_initcall(integrity_fs_init)
+void __init integrity_fs_fini(void)
+{
+	if (!integrity_dir || !simple_empty(integrity_dir))
+		return;
+
+	securityfs_remove(integrity_dir);
+	integrity_dir = NULL;
+}
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 87045b09f120..012a58959ff0 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -499,9 +499,15 @@ int __init ima_fs_init(void)
 	struct dentry *dentry;
 	int ret;
 
+	ret = integrity_fs_init();
+	if (ret < 0)
+		return ret;
+
 	ima_dir = securityfs_create_dir("ima", integrity_dir);
-	if (IS_ERR(ima_dir))
-		return PTR_ERR(ima_dir);
+	if (IS_ERR(ima_dir)) {
+		ret = PTR_ERR(ima_dir);
+		goto out;
+	}
 
 	ima_symlink = securityfs_create_symlink("ima", NULL, "integrity/ima",
 						NULL);
@@ -555,6 +561,7 @@ int __init ima_fs_init(void)
 out:
 	securityfs_remove(ima_symlink);
 	securityfs_remove(ima_dir);
+	integrity_fs_fini();
 
 	return ret;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index eade8e1e3cb1..b703bfc2f470 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1283,6 +1283,6 @@ DEFINE_LSM(ima) = {
 	.init = init_ima_lsm,
 	.order = LSM_ORDER_LAST,
 	.blobs = &ima_blob_sizes,
+	/* Start IMA after the TPM is available */
+	.initcall_late = init_ima,
 };
-
-late_initcall(init_ima);	/* Start IMA after the TPM is available */
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index c2c2da691123..7b388b66cf80 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -114,6 +114,8 @@ struct ima_file_id {
 
 int integrity_kernel_read(struct file *file, loff_t offset,
 			  void *addr, unsigned long count);
+int __init integrity_fs_init(void);
+void __init integrity_fs_fini(void);
 
 #define INTEGRITY_KEYRING_EVM		0
 #define INTEGRITY_KEYRING_IMA		1
-- 
2.51.0

