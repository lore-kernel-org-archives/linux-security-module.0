Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A0A27F183
	for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 22:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212046; cv=none; b=TRhiICNjLjDcktagGQvQeuVAL8Dp7KtuoIC7PDhErqk19WmiG8ubCKsmf9KcRAK1LB0JdtQ17Jc7pfA9GqjR2FWDAeokFRVlkR8OIX2pVqhWCRGQx1zeM5B3RWJKEi+hOSWQD0L0mV3wCASHj+YczXLmEuC7FDfNc4e1da0fHTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212046; c=relaxed/simple;
	bh=Wn73RknbBgr1QIw6Tz7euisAl7ABlX4j7pwSavdXxBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOkVrUPuIm0Pv1RCElGitKZR4NLODy3XswTr+d5wA2vUJdXmPjZHYaQBL8Ga2/QrpPygJdBuvQ+P2wGxLxzFVyX4/GyXuCIWbD22jD/rU0zNBiMlGtYV0T1ViE9g8+w0OWFfcYh/nwIUpgyfS/i9/aJhu9R1dl6QH4IPY6SmFGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EVKk6fSW; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EVKk6fSW"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b1098d1bbaso22201561cf.1
        for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 15:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212043; x=1755816843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3g10bP8ZlmKs/0zOHxfzovhas+VAEHBkR2PUCtJySu0=;
        b=EVKk6fSWxFW5qBymBklYuHyO7+sNAcr6QjYlp8jRMqNsH42rnNU8jg+mQcMtElsc4R
         sgPnfSPqa61hXz1jtbMzkSYb0DzLUclg0DjiaXuWkQuYG74bz56PEiAgjTlelhaLOWU2
         TnAWMtTzO1grhAyWsIKAvxavMJu+Tnx6vhxICeJncrE0fverwocxjuiE+QMPq7SRlIi+
         hJ5t94rWa2A/Rxy4Uxj1voxU169opp+9JXS3x6xaYAoeWYMGbsFOgFZlNpo+47dzDU83
         KRMGpDuXKbAEDAAWXq8BjsTQhy3AYJ+cQjS/pWFrX8fRg7i3FNSWDvfOA5ij7KhYu8AZ
         Ua4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212043; x=1755816843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3g10bP8ZlmKs/0zOHxfzovhas+VAEHBkR2PUCtJySu0=;
        b=cKZKpzQ1h7h4eYoeP4rqAnIPnx67CIMCe57pPjmWaLuH4JVX1Jkp1nog/+f0B0MoOJ
         wyZBPBrM/7IsBzninN8uCwDM3ZsirGww69cLASFT3RL2Fz6A3NPhSX/y1rYgbNf5+Rhc
         JReLH2SJQoC0FKBQzJz6KX4AYe/i08Zl7KQYC/1jn/nsFV2jfsxFFCsMHw50WlqKwWjO
         GpuJU73x+D8L8+xWkv+gDtm1SJNURmZQE1w4uyeIRpkWQrNSDJBItsa59bdCpy7h1Lio
         vkPfMOMQ2RSb83g3FkIgpwTBI39rXemrs1JpGl9fvQzt2a+7ts6KGl25QWt9jaItJH4d
         THGw==
X-Gm-Message-State: AOJu0Yww7Q4P6qh8ARQaAzy81I2ugCiZKo/YKhsRAz+4w3IBUbB/N3ZD
	NQ3kfeJGywxJIGArYJIfSyj/+THZ3FMlj3CpEncTInwI8Xy9xv6hstkn0W86dh7uFONadjU1pHS
	dYa0=
X-Gm-Gg: ASbGnctjmxT4dtljaaEOEu4nA/cUJkKN0zN1FygFzCBIoFWm4zgcOp+zx5i1HGJ/Fi1
	2bRKyoOkMYcvm3tQpq/0coO2wxaigs3HvOfEXg1BK0oHPsfNcrODBLvwZKg0aFHf4/tbJ0l26ne
	R3Y9GeWVXDS+kV0bLFDz4YE5DcJMdiGKDEcSXZV2MW74Zae8RAMQACJVfiB2GaUMw5PPB96UyJi
	fVDFsXA1q3UEYekunW0RFyGjYc+8HW01ZVzDIWahLnYtT5ba/MlHYUJhfqUlW6TLoF6pa9/+yll
	Opl25qKsJOzVNShSbev4mRmO3FmamYcxmWATdKBrlhCctty2HiglrKVNt5zf5r6df8CfCXWotz2
	CcZbNHul+zzKpF5EFs7Ia0Dr9q2l4UI8b5ljvU1IsR+2FjSg2nEoSZfhOTTDQiTXKfwU=
X-Google-Smtp-Source: AGHT+IGjVBoc2SF+l/JB8LV8nEA2GSkmViun4gq9Wgh6CZH5uAYfJW8tH2Z7Kko7Ody471rw67t8TQ==
X-Received: by 2002:a05:622a:2607:b0:4b1:180a:ad70 with SMTP id d75a77b69052e-4b1180aadb3mr27059651cf.28.1755212043104;
        Thu, 14 Aug 2025 15:54:03 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b4ff1b3sm41478085a.78.2025.08.14.15.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:01 -0700 (PDT)
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
Subject: [PATCH v3 01/34] lsm: split the notifier code out into lsm_notifier.c
Date: Thu, 14 Aug 2025 18:50:10 -0400
Message-ID: <20250814225159.275901-37-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3528; i=paul@paul-moore.com; h=from:subject; bh=Wn73RknbBgr1QIw6Tz7euisAl7ABlX4j7pwSavdXxBI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmiPMuDToZWAkg+iuBzLvE1a6OwEbYAmAs9qx zXLMx1kYg+JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5ojwAKCRDqIPLalzeJ c8OlD/0UPTuCpx91OBwGSJIo5EmQ6HVRyK5wMKqAp57IZRS0oXP3R+jqoX8HaDihXaYH4mLS/dp QvReWuLCRSmR07AkPHsU1RP3QzuF3kPTVKYURs1WnwJ96MwFTYB8q43HHHDn4tLaomSKxczkEOW 0icNF4TdFHmQkp5rVPlnuoiiXV9FmUqi0fpB7fnaUTAQATBRlSLE8Oxr/tvMBLhYRyoW/G+H9dd 1cma8taG4KS9BqJE9rDR47T7/jlR56j7XptmCIA0OIKk3tCtVAH4k3kHQI+Gaw4+OtZvwWgyLLV DOiumutFeqU/DjDzu7bov5pjuwtp7BEU4tG29i1e4+R8YwhlWZJ3LbaGluaRZGFkhaiFi3ftovX R34wSf4/bEUFJh3pxV0aMIteU8vv0STl+u8V7+Xvb2nNkgGkowTDjjW3zZTMfEq9SiOAoKWbHYw DM8gDaT3Vp48GEJeAOPCCLTDoVFn5JX9JW4aWetkQIUOWihtzptI+LjiiDw7ywb4kNp4IO9i8+0 X8RwlWe8zQHg76gnRPa3v21BPjeGIU3rss551E7MWns5DpHxSgw9NdonEHboahQXAOyyanhSpG1 WLmJmUgojDVFKYcuMM9lo8yM1GO2Hp1ZMPFdyFPPqUYMtW2hDctRiJTNaDfDguEb+mT3QOWS52H Xodefx4Ea5ZnG6w==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

In an effort to decompose security/security.c somewhat to make it less
twisted and unwieldy, pull out the LSM notifier code into a new file
as it is fairly well self-contained.

No code changes.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/Makefile       |  2 +-
 security/lsm_notifier.c | 31 +++++++++++++++++++++++++++++++
 security/security.c     | 23 -----------------------
 3 files changed, 32 insertions(+), 24 deletions(-)
 create mode 100644 security/lsm_notifier.c

diff --git a/security/Makefile b/security/Makefile
index 22ff4c8bd8ce..14d87847bce8 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_SECURITY) 			+= lsm_syscalls.o
 obj-$(CONFIG_MMU)			+= min_addr.o
 
 # Object file lists
-obj-$(CONFIG_SECURITY)			+= security.o
+obj-$(CONFIG_SECURITY)			+= security.o lsm_notifier.o
 obj-$(CONFIG_SECURITYFS)		+= inode.o
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/
 obj-$(CONFIG_SECURITY_SMACK)		+= smack/
diff --git a/security/lsm_notifier.c b/security/lsm_notifier.c
new file mode 100644
index 000000000000..c92fad5d57d4
--- /dev/null
+++ b/security/lsm_notifier.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * LSM notifier functions
+ *
+ */
+
+#include <linux/notifier.h>
+#include <linux/security.h>
+
+static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
+
+int call_blocking_lsm_notifier(enum lsm_event event, void *data)
+{
+	return blocking_notifier_call_chain(&blocking_lsm_notifier_chain,
+					    event, data);
+}
+EXPORT_SYMBOL(call_blocking_lsm_notifier);
+
+int register_blocking_lsm_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&blocking_lsm_notifier_chain,
+						nb);
+}
+EXPORT_SYMBOL(register_blocking_lsm_notifier);
+
+int unregister_blocking_lsm_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&blocking_lsm_notifier_chain,
+						  nb);
+}
+EXPORT_SYMBOL(unregister_blocking_lsm_notifier);
diff --git a/security/security.c b/security/security.c
index ca126b02d2fe..8cb049bebc57 100644
--- a/security/security.c
+++ b/security/security.c
@@ -90,8 +90,6 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
-
 static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
 
@@ -649,27 +647,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	}
 }
 
-int call_blocking_lsm_notifier(enum lsm_event event, void *data)
-{
-	return blocking_notifier_call_chain(&blocking_lsm_notifier_chain,
-					    event, data);
-}
-EXPORT_SYMBOL(call_blocking_lsm_notifier);
-
-int register_blocking_lsm_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_register(&blocking_lsm_notifier_chain,
-						nb);
-}
-EXPORT_SYMBOL(register_blocking_lsm_notifier);
-
-int unregister_blocking_lsm_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_unregister(&blocking_lsm_notifier_chain,
-						  nb);
-}
-EXPORT_SYMBOL(unregister_blocking_lsm_notifier);
-
 /**
  * lsm_blob_alloc - allocate a composite blob
  * @dest: the destination for the blob
-- 
2.50.1

