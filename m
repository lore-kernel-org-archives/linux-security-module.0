Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457CD283683
	for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212065; cv=none; b=IdMZ/6Otlj5XjOE3Un74UPF+sg5gP4BtHGmNKmtJRMjlnN0MDgiBL3C89I3kfXGK2ARZiOvsRzMzMbw4CZ6viyUNGlzr5Fdx6a3+PaMiYfJq/v9yDiLeiMDV/vkvDQnAqFIt4ET3Z+sCzysMbriyVqKlCHzpxir6pkAdV/IWLOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212065; c=relaxed/simple;
	bh=JtUEY4uU68LbnCyef7kfnbH2x9bYj5UZah0obNTsHx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Opw7MF+3VI2CQUjDEqZ0jGu81DU7RIxgNaMwbAuYtommWxmIlVWMT/S92/vBwduhfJzLazX+0KlHkvtWGjdcLY91fgunlmwiqeE2VyukXgShCW5TJgq0VM/1Ufj4H6eQbXNWRUW5HBeIbKmHdwXJTnU1i6hoBUSNFQ1BeFwo1iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AiWUCTJz; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AiWUCTJz"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e8704da966so100028285a.1
        for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 15:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212062; x=1755816862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4fgdswoaF6mqS2FaY5a3UOgRtcQcgbu/xI6UzK5XYc=;
        b=AiWUCTJzNgdEiYPFBLLJ/Z9SPHnNQmCGCuw6nSl8UUMgbYSbDdIrT5pbY6Q1SvtRfh
         u0/akgDwkpmsRQjL6ktST37P072Uae6TfitTkLd1kzEw1/dMucoIrHOo0JeLIFIWA+ci
         wN74+Y1R6v3UvSdhWegLVQ7DXdBfOKCTup18/6TOLEP7Hp50sgNqbS88/JxSC4p9alfH
         n8HiH6FnVWiUzWhZG7T8+1VMDLhM7F/FpMZ7alvY9gA/iUPE3rd1l9ghKzqkkamO6ddb
         Z/EnP6kgijmE8u4wOLAIokRUIn9wKllK0p9kwAzCv+Q1O3XugEiFkdsFmSZ9KLFlzBNv
         WJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212062; x=1755816862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4fgdswoaF6mqS2FaY5a3UOgRtcQcgbu/xI6UzK5XYc=;
        b=eYmpZD0WnS07dePACliuVOXaLEcuMXu3sJ5ZYByAKAV4mCVrWV1+RmG8gJI1f7Cmfi
         yPyqZ3MhCwHl9zg2LtxZOPFaxG3v/jyUTHsV0XjjLnsXgCfrSclOI4rdVLbashnGDG51
         yyAJOVivXfCMkSmyPOwkm5ddLyA9SqdqclAY/0BmuhAjSpHwqAKq8Prz6GLR90dYjEVB
         bwGaPAxCkoGoVCKV0u4vFGQk04Xw27SleTFL7zyHpPXC7hvaVKa1xj94Ovsr5ngv3fxC
         MmTcJQXwneC+tIF5RNnIXvsM3iC0VB9IqXHxjVLwu5XyGRQDldUjDn1mbTJn0R9Q4xfh
         efeA==
X-Gm-Message-State: AOJu0YxEOd0TzjmxL/3K/rZl0RJDN6TAIooQloeeAUCE9zEfa7xtcxgN
	O8KTZubwjp5Cw2/q4cXnXxzVxjxqzGmuxtR74Gy4WFZWuIIo4PTcPX5cC2aRoTGwlyErov2mviO
	9Bd4=
X-Gm-Gg: ASbGncsiRIT/lK99u3EiJ+Wz7FakTi9BlwIZOYbGC8YbEuKGUf9Z8vC3elEE6hNtfZj
	eiHwP3JqAWw67hCguI4zI3OZTyaH7CU623o4dFAopQRrBVPnQ+d1mKtHSsryMtCWYk88fVpK3lS
	EG45y4fQyk369TJHEzCJAOZV1wQk4Mj36l3YF0pb197KO3m34Mm4sMafMrwdPJ6ejkKxLbUGduu
	2XQIx1zPILeFHJvuM6g3MzepvflpeEJEgq+X2SckVZK2oEv1A3Y+nhZ710Dx/FyhmlgEsfHFtXu
	njD7O/dQMzvcI9J5qV1Npe32RxlNjwOPLcdOip3J0X8RB568lHMQ2wiRSgEHazCSu3/pyOTCQoY
	jSspDbGe4amOIN8fBnkZjYKmjoL1Z2s9Vfel0F/Be0titPWXtQDQyHxLFZDQ0q27OUGvuagxFBN
	2z5w==
X-Google-Smtp-Source: AGHT+IEzWL24sIqLRAnahYJAog5dXX3t+BD5ytKOPCBPLxmKy+S4AB7xPfgdY4QVeo4926KMVfyJXw==
X-Received: by 2002:ae9:c204:0:b0:7e6:5e9d:f8e6 with SMTP id af79cd13be357-7e87034cd1emr588827485a.22.1755212062006;
        Thu, 14 Aug 2025 15:54:22 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b32ef92sm44629785a.17.2025.08.14.15.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:21 -0700 (PDT)
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
Subject: [PATCH v3 11/34] lsm: get rid of the lsm_names list and do some cleanup
Date: Thu, 14 Aug 2025 18:50:20 -0400
Message-ID: <20250814225159.275901-47-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5115; i=paul@paul-moore.com; h=from:subject; bh=JtUEY4uU68LbnCyef7kfnbH2x9bYj5UZah0obNTsHx4=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmiwl3MdVrT4/moZ/Z0HPynVn+uKKwn7dlzxC KB8NsN31+iJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5osAAKCRDqIPLalzeJ czywD/9w9J3jzzOFj2icTKlnT+aifsiLN9eOq0tjDzxQB2Oqw7/hKAn+CsawEGXtbGcgOnhzNcQ H/WzJqiklHphEQs7S+DAkp90vuCbGLCuSdFipxFEZrpfsoH+qoL9HbNPiQqMXXbeo/mrzSCi5Rj 70Cm2W5XRLtqX4kKMUJmNTrij+vM2EoB50h43o+qTafVIQZh/SoGqTB/SlsYbWYYXVsRtLLVn16 xJoctmkfjtZ28a9vBFuU6a1dPqLlsIEi6j6ma7DpwN6T6DJ00jCgJvdhwhkWaRHfCHl7nEsOkEE bbkfL1VLpK2uV+4AmKEMfrX95WrLaw2pR1W9yJVzBAUMMaxpS5IG0nkkTrU/1/glZKwR4lxpaYH gLqZsqb4KWtZXMOgxdVcQnlcESSHY752iV+8nQEFlj/TXZJIZgK4SkQW0lFpyGMThdRvGgy7ZXu AU2Zs3tau0VsdKl9ZLLJzs8wGsvCflN+RejzEWJopx59HuAKqt6DJ0PZ229abmtlmblbQdkImcm mxEIoPKmD+CVYeKcvQY0ossVTwRENKTf3bkXsztYqR50W7CSyQgANUzhzXl2wcxC84IqVE7Nok2 tX8ALYjzGN3hUnifrwIHb993PK0Hx+lOcLtoog8cqUogRtgusbY5VvFn2klkHggFIczGOjytsyr an5ShEOIfHQUT3A==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The LSM currently has a lot of code to maintain a list of the currently
active LSMs in a human readable string, with the only user being the
"/sys/kernel/security/lsm" code.  Let's drop all of that code and
generate the string on first use and then cache it for subsequent use.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h |  1 -
 security/inode.c          | 59 +++++++++++++++++++++++++++++++++++++--
 security/lsm_init.c       | 49 --------------------------------
 3 files changed, 57 insertions(+), 52 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 7343dd60b1d5..65a8227bece7 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -172,7 +172,6 @@ struct lsm_info {
 
 
 /* DO NOT tamper with these variables outside of the LSM framework */
-extern char *lsm_names;
 extern struct lsm_static_calls_table static_calls_table __ro_after_init;
 
 /**
diff --git a/security/inode.c b/security/inode.c
index 43382ef8896e..a5e7a073e672 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -22,6 +22,8 @@
 #include <linux/lsm_hooks.h>
 #include <linux/magic.h>
 
+#include "lsm.h"
+
 static struct vfsmount *mount;
 static int mount_count;
 
@@ -315,12 +317,65 @@ void securityfs_remove(struct dentry *dentry)
 EXPORT_SYMBOL_GPL(securityfs_remove);
 
 #ifdef CONFIG_SECURITY
+#include <linux/spinlock.h>
+
 static struct dentry *lsm_dentry;
+
+/* NOTE: we never free the string below once it is set. */
+static DEFINE_SPINLOCK(lsm_read_lock);
+static char *lsm_read_str = NULL;
+static ssize_t lsm_read_len = 0;
+
 static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
 			loff_t *ppos)
 {
-	return simple_read_from_buffer(buf, count, ppos, lsm_names,
-		strlen(lsm_names));
+	int i;
+	char *str;
+	ssize_t len;
+
+restart:
+
+	rcu_read_lock();
+	if (!lsm_read_str) {
+		/* we need to generate the string and try again */
+		rcu_read_unlock();
+		goto generate_string;
+	}
+	len = simple_read_from_buffer(buf, count, ppos,
+				      rcu_dereference(lsm_read_str),
+				      lsm_read_len);
+	rcu_read_unlock();
+	return len;
+
+generate_string:
+
+	for (i = 0; i < lsm_active_cnt; i++)
+		/* the '+ 1' accounts for either a comma or a NUL */
+		len += strlen(lsm_idlist[i]->name) + 1;
+
+	str = kmalloc(len, GFP_KERNEL);
+	if (!str)
+		return -ENOMEM;
+	str[0] = '\0';
+
+	for (i = 0; i < lsm_active_cnt; i++) {
+		if (i > 0)
+			strcat(str, ",");
+		strcat(str, lsm_idlist[i]->name);
+	}
+
+	spin_lock(&lsm_read_lock);
+	if (lsm_read_str) {
+		/* we raced and lost */
+		spin_unlock(&lsm_read_lock);
+		kfree(str);
+		goto restart;
+	}
+	lsm_read_str = str;
+	lsm_read_len = len - 1;
+	spin_unlock(&lsm_read_lock);
+
+	goto restart;
 }
 
 static const struct file_operations lsm_ops = {
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 9e495a36a332..87e2147016b3 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -10,8 +10,6 @@
 
 #include "lsm.h"
 
-char *lsm_names;
-
 /* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h */
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
@@ -371,42 +369,6 @@ static void __init lsm_init_ordered(void)
 	}
 }
 
-static bool match_last_lsm(const char *list, const char *lsm)
-{
-	const char *last;
-
-	if (WARN_ON(!list || !lsm))
-		return false;
-	last = strrchr(list, ',');
-	if (last)
-		/* Pass the comma, strcmp() will check for '\0' */
-		last++;
-	else
-		last = list;
-	return !strcmp(last, lsm);
-}
-
-static int lsm_append(const char *new, char **result)
-{
-	char *cp;
-
-	if (*result == NULL) {
-		*result = kstrdup(new, GFP_KERNEL);
-		if (*result == NULL)
-			return -ENOMEM;
-	} else {
-		/* Check if it is the last registered name */
-		if (match_last_lsm(*result, new))
-			return 0;
-		cp = kasprintf(GFP_KERNEL, "%s,%s", *result, new);
-		if (cp == NULL)
-			return -ENOMEM;
-		kfree(*result);
-		*result = cp;
-	}
-	return 0;
-}
-
 static void __init lsm_static_call_init(struct security_hook_list *hl)
 {
 	struct lsm_static_call *scall = hl->scalls;
@@ -443,15 +405,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		hooks[i].lsmid = lsmid;
 		lsm_static_call_init(&hooks[i]);
 	}
-
-	/*
-	 * Don't try to append during early_security_init(), we'll come back
-	 * and fix this up afterwards.
-	 */
-	if (slab_is_available()) {
-		if (lsm_append(lsmid->name, &lsm_names) < 0)
-			panic("%s - Cannot get early memory.\n", __func__);
-	}
 }
 
 int __init early_security_init(void)
@@ -488,8 +441,6 @@ int __init security_init(void)
 	lsm_early_for_each_raw(lsm) {
 		init_debug("  early started: %s (%s)\n", lsm->id->name,
 			   is_enabled(lsm) ? "enabled" : "disabled");
-		if (lsm->enabled)
-			lsm_append(lsm->id->name, &lsm_names);
 	}
 
 	/* Load LSMs in specified order. */
-- 
2.50.1

