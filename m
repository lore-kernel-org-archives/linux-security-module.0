Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CD4277029
	for <linux-security-module@vger.kernel.org>; Wed,  9 Apr 2025 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224814; cv=none; b=DyhimaKyDnll2Uq+tbA3u/0guwuQhSjBEngBpM81rtwLVATck1WIDe5moHuBgt+aAt+CYe0vzI9+1p9Yvha2tOF6UdBwrF1btcmhMeUcFiAvLIbn+Fhu6CSiTvxvjhHa5IGPMVqBASiYOrkKdSSG9abxZtSyZqf3PCge1EF0K3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224814; c=relaxed/simple;
	bh=pST0Jy42PlsO0MpZv3Tmw04rGz8RTx/Oz6ErubDMxwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltsVB4MZK6JayMg7g3K9Okq7izwx+1bAkTda8hfNJqSGdzc1NCNv8GjmtvM22iujTO4HHjzQ1nniYyx+F3pJCtZoWUQjuz8Is9zYoTEdTfj5Pq+vx9+Bm7VFyxbvLpBFj8nPQYgW8UwWa/5Ukh1VF18zbj74Bma9vbLl+1CjseA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ijz3mOeC; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ijz3mOeC"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8f06e13a4so11156446d6.0
        for <linux-security-module@vger.kernel.org>; Wed, 09 Apr 2025 11:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224810; x=1744829610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riL1KUp604CYpD1AiWNliF00+qwNhMr/LsXwK6I/EDI=;
        b=Ijz3mOeCYOdU2GA2D1wzEdTUDjv/ZRKlMR/dP/01ML0nFTLB/rBeuF2E8Wfmqss530
         y/487Hj0e8tP2JIXYS0weUINerXes5OIrF3xHWiK4ItbTwgUit4uDJksfI8Iyftz9RhB
         71FnfF1CpAH3RlFaAenEJ5BwTOp/tko7YbdroKoSaE9C02v869LLM/jK4k/ciMOFqYPz
         i4DId0FdCGbuBiRQSrwwkSnsHfmp/lymZC/lp2UYDElXVzqFPiBRAJOMS5QyFHKjWH3F
         ucnizQL1f8ncPMFrlDZXMWtJF9K84uorrkphcmsz86Mu/2AF5K9jkLsZvfDJszTk2JPq
         aimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224810; x=1744829610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riL1KUp604CYpD1AiWNliF00+qwNhMr/LsXwK6I/EDI=;
        b=BVDC2ta0o8OfGio1iDCXbPmFrXWXwpCy7YaS/TZnUvtbLJFW3y++KVtVvgVdDI/wZk
         0hbBDCuiRkZKJVKVZ9sXu95+kCe00jUnks0e1JaO9Gre505IhB9lFeLHSee8Nvk3H1u6
         0RERP9xf5NbhBbmsBZRI8KzIIVn6Mp9hldcFU3L+IlllRAxntpv8AHaB7A7C9JfTTd1n
         6fH0EoTFHBpMIMHhrr/OTX6orb2WJ2PZxg7RTbsxWPGyomdi/SafcXNldOW7xDBj49vx
         +zEshEcc9mWltlpgcBgYp9X2Eu/1uJ5fVO2WzVJC4zVdgNbwgGdyNKr3FWx3DCioJtOS
         trvg==
X-Gm-Message-State: AOJu0YyBPlZ5APjyMa8RGVdLJymXo/CQ8C4SnKj9AAJiphCcppamN6io
	tCDBWlQPnjyUTkm7nyif2FXCU29LNZOp2XfO6pV9li7HuAKBvbu9uFyDEjlCNqJyt0rgPS5t6tQ
	=
X-Gm-Gg: ASbGncsI51HPwy9e6Fa98A6bqtSf4FjsFL4T+MVg5lxG0/wxMp6A9pegYjbY9h1Zrmb
	+lNBkkfgAalYe7kXdx+7GuBV8zV0amKxjRe6KBD5vNpP/5bxx92NICk71mJE0+l9sEf+Qvho96y
	y0B/NY45HplLMZMPdr55UvIuN/z/v/qo07LQXlZZziGHYXFe7jMwN0ysRtMaHJUU3AKzr4cIOKt
	txIiZ1rraItJFVSskRPE14E0LOO3uuvg7fbXkSi3rJTXZSoKGqzP4hU2U30/0lq1xR1b6p2hT+B
	RkwtWo4+VjOem7dfbqFWmAuCT85+6PdWmKC0IqszssQ+ICjq2rfVkaAcmJuiItXJ+9ODFaeKb4k
	RHo6o8tXpYpKEYh1P25Zl
X-Google-Smtp-Source: AGHT+IGGqQ+5TDtMPJUftGLobaOx7r+y0xyJI6orbJraNyiHa62EsNyYAeQTLymIJ5NZ2wzofRrAVg==
X-Received: by 2002:a05:6214:29e3:b0:6d9:ac3:e730 with SMTP id 6a1803df08f44-6f0e4c543fcmr8888226d6.5.1744224810451;
        Wed, 09 Apr 2025 11:53:30 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de9732f1sm10627506d6.44.2025.04.09.11.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:30 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 01/29] lsm: split the notifier code out into lsm_notifier.c
Date: Wed,  9 Apr 2025 14:49:46 -0400
Message-ID: <20250409185019.238841-32-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3373; i=paul@paul-moore.com; h=from:subject; bh=pST0Jy42PlsO0MpZv3Tmw04rGz8RTx/Oz6ErubDMxwo=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sFrd2BQ5kvOfAZSK6RvKZzIqRR99lLiF2bqN pnGNiXi9MWJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bBawAKCRDqIPLalzeJ cwOQD/9bfknkxydw8DwctdBJLYfuqvr64I6HAlZQL5my5A8Wg3Vo1HdGPu6KC3Y53g2Uh1IOPnu 2z+3KL6bAtAzY3vTSt1DzOMeFIwtHRlwl7b13SwzUDNZDjSzjYKvJDrhc5FIdOtA1iRJ165ud9j cOp7hnablMr/sDzHwVZlaS0d4QiN7mtKmcwLxfPrjdimBBmmCFTlxEHbmcacRJmWYAkV6nT7yhZ lhzw68uzYTUCO/jBv4jwC4MntaHJpbNmvvr0xnX08D/drYmAauk3m8WAc70iLiq9p4FzVjIoHzc SH4sfMmLbkSn3lankDvhC7nLg8r7WDDZQr0rhpT7L9YYwMj4HIMh8ILJxsgiEmHMBBmA9F9H0AZ /obaG2I+ts3NWr9Js3Yq00UcR0wwBq0Lw9ev9wp4IvGZcEMsvU0baGLLNBYlR8xVgkCMxgfqN04 f/NhjbSj7EKLI3vXglFkFv+LnOx6hRgLVzofm1uhyLvltJXdkZ3gfCYbJ6dyKFVtZW7oQTTVwcz OhsQlyFY06ybQVOQK92ejGzvNZ0G4NrbK4sKbc1a8xuSDEcsKB/WDVfND+Ste/hT28FYa3eRd44 RtCOjhfd4a5mp+F6aDchV3bg/3ebuLO8EUrKUM1v0u3r5y4FRGigsa4f1zF2p20ok3FKAOCT+yJ u0EBYDe39poS1pQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

In an effort to decompose security/security.c somewhat to make it less
twisted and unwieldy, pull out the LSM notifier code into a new file
as it is fairly well self-contained.

No code changes.

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
index fb57e8fddd91..477be0a17e3f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -90,8 +90,6 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
-
 static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
 
@@ -643,27 +641,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
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
2.49.0

