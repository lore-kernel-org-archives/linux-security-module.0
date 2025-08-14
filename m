Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C97283680
	for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 22:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212095; cv=none; b=ONOyy4bXDlmHooRjnaB0aLPPU446FKs2UFA9LohIvC4pQAC8uRy5fgzI4DgiKJX0S1yducjJPQ1lq4n61MogsIIjQTt9FpMFnGG5W5FIswx1TMVJUXL3HbACb6O1vkXdNGXEc+GlSPPPwQiXaKt6OidqUFLYN1PdVOPCulAAdP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212095; c=relaxed/simple;
	bh=hMungCpNuI2EMRwL18BGRuc3TdCNhfRfwi95oYlFwjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tu89R+U3kKOqzwcJbWO/EuZUWwMOeQ2tbJ6/m6M15PDOK39YRHoQxaOrVaK6MKDl8KV3QR/4Yt9Ycc2Tt45hmoNE3zziroHGqm8mwthH6A6rtiaB3EJ0KMS9oTbbRd3wSE2yl7X2V0WMrABh8RH3LbWR4NDodS1rUE2FPpXoA9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=S84XRDH+; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="S84XRDH+"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e870666dd4so167737785a.2
        for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 15:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212092; x=1755816892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swsuoziRjRLhpCIpeA2PZeXHNAYSr82iFv/EX8Z9Hb8=;
        b=S84XRDH+cJgMYJThQ9ViDyIFnlJ3XE1972v3vSJqCqiGRjjVP3a0Rlu1FNMfznd/t3
         BfFYFzLR/i5qioEhwpHHslGUqps0XlYM4jHu0cd5w7VMc82RpleU/HUNnzfmOSx4KKx+
         XX81o90BTDNM/1g8IqL3ya2bw8V4qnfnUCQLvN4K3gdLrWoFcKkxyzgh/SELhApX7o4+
         2rMnONx2/vAMSibDalks1gfMcIE18eoLZr/60Z8RxdM46sECOeyz6qsKEfoANFSANmOO
         jFsNl2lLfl711HNOYt2XA3sTdjoVL8GGOlGxke9f/xiLRpAPJ418C6K2z4gtb3fufbwj
         VvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212092; x=1755816892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swsuoziRjRLhpCIpeA2PZeXHNAYSr82iFv/EX8Z9Hb8=;
        b=CgjAC3uLcVVO28JuiB6JLmtd6mmEJItkqJplI1wIwGFJLoWqExSt6Z1doL4230Xl2x
         gdw5lYq4kBX46qKMPn1KyydBap5raIdKrU6+4K6BB26OUMdmJwQg5HB0z+UJj4zcIatm
         Ty/NY6tygmdS+TP2TjgXY4FZdJ2tIT9n7o2fcFLdijA7b5/qIAHxg/srTSNGM6KPVYw+
         xfkm/TwjDx4I1NajGQGljhHx9okXa6U7UO2025vQJQE1qC4qFB/a4DB4pxqVG5uRb7bV
         G1H+T/wY8RQSawDaHL0IxDkvLV+/aNCll1fd5onM5xtt7uYBI/uQS+tw1Ll5mkB3HQxQ
         NMWg==
X-Gm-Message-State: AOJu0Yyti6RczXWPUVMaRhae46nnKZn4bAcbHTNRTaEPv2gLOaUAxKcZ
	xKR/mrhnudFX7oGFWRyN6vO3fvWeS1cAzmcWe7x1GfapPy6h1TG+f0/5gW0uPiUoOXP0pvyzOAr
	Epjo=
X-Gm-Gg: ASbGncvnT8kpMovf7c+0lzIg3hlEmGA+58TfK6/ChHTzpFp3z6wEqaco3cit4FHKAKc
	rSHBTGi2PP2eYqmhjU+7/5cPAptWodNQqVuMdkw2SNRfnKlG+9zkchFFdVFBwC8+ap1UGB5JFn5
	pfx/sZF2qM61gGqGVHJPkOTWOGxezqLw/Asg3EC8buYHUUlq1yDKt1F5rceykmqKWExKwKyrLcN
	6UKkt0VHftVleCrKgHDCx+gEMdcoPcvepyFupEg5sow0yzO6y0nJB5+bKMTmTxc1hZlG49J9dlK
	VSxSlJOQZpWV9xY4NguoMtCS67cgKwIbGtp1fEawUoSv2kgX7ZHLv+IcvWX4Ri73McfMF0ib1J9
	qAMcKNIVaQextGeV3BsO1sdazx1LtooG2weE1bLFJ1ndfaILX1vyHhmDYx4cXphdQq9E=
X-Google-Smtp-Source: AGHT+IEZ9dNqEfnZxWIdk8kKzQsT50PoAztBsSkdljgLwCcnni9OEIi378K/7HC/fJq/dZMB/MFXPw==
X-Received: by 2002:a05:620a:40ca:b0:7d4:4a26:4065 with SMTP id af79cd13be357-7e87bdaea9emr95331785a.58.1755212091993;
        Thu, 14 Aug 2025 15:54:51 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b50a8e8sm41899285a.83.2025.08.14.15.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:50 -0700 (PDT)
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
Subject: [PATCH v3 26/34] smack: move initcalls to the LSM framework
Date: Thu, 14 Aug 2025 18:50:35 -0400
Message-ID: <20250814225159.275901-62-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3055; i=paul@paul-moore.com; h=from:subject; bh=hMungCpNuI2EMRwL18BGRuc3TdCNhfRfwi95oYlFwjI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjhf8xYPQ11qQDnid+7SzgZqqOakCX/d9DS6 BcGCDbMF9GJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5o4QAKCRDqIPLalzeJ cxmLEAC0XK9yQZXNR4FYXQNafSMJDKTOaq0XTtTeDjeLs61e0i2ni03CZOb3N/9se/eGeTGpfUP SncnI3wDNxznI6tOM6aAlNDu3Ww6ZAJKWrmS82VLbJ5IorSqrriBERX6BiyaXRiALC6jlCTixvg g0LaJs2gjOaO21R95y+QXrFl6tp5snOLGj6L/hS5Yy8ml8x8qWob8cIygV06ZB0TEXrtdqgCW96 uMCHvbNn1D0mzU7LtpJ6MKi037vC9xHeybQc6LsLNi42H4iAl2DAoaY9nnZetqTAfpuZcADsi93 +UzAz5Wb8jackRsFRDfq7BGdSkxWKY4ieswJq6bh9l1SegdArMD2QtJNVr1fMAzG1+Z8B3bQp0p Wqwel6xj98Lg5rH/m64xl1Rk40BRZ9BTGAGXRUJT1dq+JQIamK2Gev5x/KH7H4ozw1ZXql1sh6f r8IiRXaUchOAmRYTVdgdR0BPgmneaJsu0FEoWXBVKQ52+iged7w+YulHr9QDoAnILKWE8U15g61 DXdv/lq4zv1JwxP8/Rkj1lLUWVNKMO+OrArwZjFVPq3/VccJ0zASL8im5BxEYhhhV2Pf3d2UD36 FLL5qEEvXDSs4EjzU9Z8zlrSncwFrCiPVlkgabXDoYx63zXx/DzVh4FS+cHVntbo6bV4EcOK8gz mHAKJYKmUfUyJZA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As the LSM framework only supports one LSM initcall callback for each
initcall type, the init_smk_fs() and smack_nf_ip_init() functions were
wrapped with a new function, smack_initcall() that is registered with
the LSM framework.

Acked-by: Casey Schaufler <casey@schaufler-ca.com>
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
2.50.1

