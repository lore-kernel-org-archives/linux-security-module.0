Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4D2298CB7
	for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 22:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060869; cv=none; b=KQGPREnUGtSzT73OIm63AsaB+9yKBFX8+qksnoLNRs+LcTc7mC5nEVtmuA1GUI5Z64uli2c3yvFqd08vimwJfTX8oT4RcvmHSIHfk5H2TORq3M5P574dF5r0hdzbWWzSwYhKDjDu+BRAQIe0wl0HR3H4s+CnWgzD3vIq9P+cJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060869; c=relaxed/simple;
	bh=60lHcjL7loA3LTltXOW9aKkvNoZ8jHM7qtu9KZUJ8fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyMpYToC6/Hb/c4LY4yNBh1tUXTOsTnWgafyqZm46+/qoBkg2wHCNAhPcDCJqtpx/JBA8YojkBBmm4jAGAAIqwIcbzwHFTndEjYU8G6PciSpZGg14vOM/OHfgmntQmsbQ33CoMAj5EkNYiNgReZY4vwQZJpzjmlmhV6P6ODbDXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZhiE97wl; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZhiE97wl"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7799a118b87so27590886d6.3
        for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 15:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060866; x=1758665666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJy3MgBBl4qUeFRiBZQgWjyjzivYYKj8N7L+zSpja0E=;
        b=ZhiE97wlLHTkuCGhaUMYNvbh8msNzPOcYD2boxpz+vM+RJx3cU2XxhjtBX1U8g/ytv
         gzrtXhRMKJ8C67x5konfqvQtstUe8SK0FimYB0hwNpFv1+7iwL6DqPipPHWOlLu7RjLK
         oHjSYiRjdGJY4ubssJ5BSr+IUiaNXYWtrakJ4BmB6ATa78M7hbXXoureAv4E0mMxas64
         1T/lzmvcA0klKqb3bHGh2w+Se4GwzjeLa38SO41AOx0XrOuCWa1NK+jfP7YmligQIont
         70XfeT9gzdq4LKOW6T96Zubyjef1CbfseeMOq1nwEOrbhg1RfDqKqQotgZKTiQwJ2n/1
         Ti2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060866; x=1758665666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJy3MgBBl4qUeFRiBZQgWjyjzivYYKj8N7L+zSpja0E=;
        b=TQEyNKerfcYqK1vUgjljmbJMzbqlSTG/rmj4r45WAQvprXUSp9hx8X15JyT6cPWsfm
         edbh9LaNisaANsLYlsErcErsN+tMQrnmovEuk6vv2VVKfcM3ammyKNg8pTO2GJ4pzvla
         n47mISxXSzOS7I/vjCIHKsRNdpVuhO3/lLwObMYaAXvk8y1IMvjOuK9q+UGuQTH65a2q
         1hMiGfSBiCJBJFn7JKndBi/mmXHmJtKRZd9oFawKWe9mf/OxTO4rtXD3WiWBpL5Jpr/H
         VorHh7MNjc6Yh3F7MOf1PGCL3NyA25kMLtcKOUAG3IL0cwRQE8fuC+RCdZhIekl0xL1U
         Q8vQ==
X-Gm-Message-State: AOJu0YyXK9OPbXEP6ecL9xjDR8cL2ucONC+ANPIInZROkVCfzAu8g4Gr
	SvKZay4iIeysOCAqVgz0QGm1AARluyNoTr9wcPWkJNpm64mcpycjEVsyscgpaNJut6mbqhbX/HX
	P24c=
X-Gm-Gg: ASbGncugHCMEK0aTpIY/vyWrssFW2g+q8YC7XZHtraDIitYmRuxpD22HVPuh2BdGw1v
	mT8F5QZGp+pcyhbj+ibC5KhYd6YpSP1klO4Liob47Zw0b36GTcB4Fn2VS8PjdpeXWuVdpV+ynOU
	ML/gUDlQxymOb2X3bA5ElSibD83hWPQSyMaSC2KQlOzSOH2WfBAgPkeDTKib+wJoW/39JG31hln
	udf8FnKlYOWAX1N6XSlTazpQmumugav8aw6RQLpjvoAVZMxizgyLDKK9xjFzYyQgPnk7jFHRPEX
	puqo+QlVyeIG3dv7B0nMwaWu2lOCDAzlvLsMoX628rtSrhS1h7ntksJKNaEBQEuFZVAqGxzgv/N
	zS/DfTupKGYAR36Elb8UE6meLdkYGZl6kqc/i6EJqtpYyHQnDbqytTaWknEKR6xHc4LNK
X-Google-Smtp-Source: AGHT+IHGVKumCCfFqwEp2mEukNtLzHbXXmA4RK5p4tRpCxxvlbwLzu0WtISss1Dvqy7H7h0fnlY1JA==
X-Received: by 2002:a05:6214:2aac:b0:729:fdfa:df20 with SMTP id 6a1803df08f44-767bad04fecmr200489876d6.3.1758060866003;
        Tue, 16 Sep 2025 15:14:26 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-763c03a7fa1sm99978606d6.59.2025.09.16.15.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:24 -0700 (PDT)
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
Subject: [PATCH v4 26/34] smack: move initcalls to the LSM framework
Date: Tue, 16 Sep 2025 18:03:53 -0400
Message-ID: <20250916220355.252592-62-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3114; i=paul@paul-moore.com; h=from:subject; bh=60lHcjL7loA3LTltXOW9aKkvNoZ8jHM7qtu9KZUJ8fs=; b=kA0DAAoB6iDy2pc3iXMByyZiAGjJ3x6jkYMovic/XRnoggFGoVWIqXfemhHnHuHRUt9vckS/C okCMwQAAQoAHRYhBEtCqM8H8pnVVJd+7+og8tqXN4lzBQJoyd8eAAoJEOog8tqXN4lz1xEP/0CH CFISnWIWYu7IxtDFPi7NYrSL6Bm/0o9CRahitWkVTT4VAoPO5UaXdvtTfbSIV40HsUCku9GzWpF ZDiwyJDHkzwed2kgs/Paf6Czvg0ycVwLjdTi3iKsmmAicn9slYC6VBSLJLGRwB5m7lZyV5/0pV+ dsUfkRP7ksM9ZHP9o4UB/BixBOP+htt/ABvIqAiEb9PCJXKNGyFEadYw9s4j+ZQw2CJLajr9oGI kIIcv3XLG206fVE3+3mqvBtlO0BSfS5W+x1kqE+8t6B1CxolMsbNqZLEiif+gvfisA3QLxDCkMk CXMKytIzX13vFwDQzPgjVprhm18BI5vSvbhFnyGDVDsLrk7M4B0u2fxnxLkNHrmOt9+gUIeFAPp FEFwWLRAiuIJvbM3XYRnt3hkImrhcFkh1gZWaw0xUfurJZlMq36XM0a7yMVlikMxTkJKyKBd6du l4jC/wRNSM0WwRl+GjZlxWaQDdQl6oBBtoSEUNBT5bI0Findu8zlGOlyEcYC7vBu/SXiP0m+qRj zdwb9h8kVNpqqwE1Z4zim36gVS+PQCN1Uyq6XuGTzJv+OivydSqC1cooLkUFf3nAz5JwCxI3F82 gah3MtYSOHin9w6zyjIaoMgvrlgjjhUo8D1Obb21jpa4SARkNxvm7H5m/HHXByRh43zgHmc9U95 V3oUs
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
index e09490c75f59..f14d536c516b 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5270,6 +5270,14 @@ static __init int smack_init(void)
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
@@ -5279,4 +5287,5 @@ DEFINE_LSM(smack) = {
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
2.51.0

