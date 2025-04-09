Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABB527C179
	for <linux-security-module@vger.kernel.org>; Wed,  9 Apr 2025 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224833; cv=none; b=GgVMmrSA9Uetafamcd7ciBZyP4Igei8moAwfvoCi8g091VVHY9y/P6pit6W7D1IBSyizDwdavsswK6dQ1+uRHk/yDEH4HZHSHduQdhunvOkf65R08r9Y9e3ebgF1I6usIC8xsAqs6diRUqjF1wtjlGKX8fXz3xS1+3KzkybXih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224833; c=relaxed/simple;
	bh=ApRTJHP3nnJAjZEel9K+GvPb3rr0j6am0sMw9Kt41Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQV69jRm1dDGJh3CZNw7vyKl6wQ0/pGeHmzycnjnWmmUgtRgLHRSSPh/qMOmREc72S2HSVXABb+ZhCIVjtvDYYX+FF9sOVWZ0R3qH/lpneZMu82gs4FdnybL7IgJNlNn5M69rtdQg5Qv+m57Z7FA8fCkT6r3SjNvzIF+ICEYhBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cIRRjgji; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cIRRjgji"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6f0c30a1ca3so43737886d6.1
        for <linux-security-module@vger.kernel.org>; Wed, 09 Apr 2025 11:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224830; x=1744829630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cb1UzoeDrUAtaptT6ufvlujinhVhnpVPzpxEo5c3TZ8=;
        b=cIRRjgjibheY29FpaOu9VaryaTgZBwWNlL35FPxNJjp4rUmjQSjDDOt1vwVGvvnskJ
         j05AZV2KecODG47U0u2xRe8znYK5vK9Ye6ByZJV/vweyqnkRiEeqhwJiEMNfVtr+YTND
         VBtFhNQgbuvvAbzLlGaTtBX9XFNi8G2UNjJ58BrDc5ajj/idLRwygWsw/0nSu3LybiuK
         FsQivAWL+m5bt24cURTDopz+EY6N/WeYP+HgS4MjoNwtIdTy0NU+E7e/Z+IZYDiYMiRM
         neSX9wl/uC/i1+LAYd4qECVhzmxL4EK4LLvidqLuGTVjrYgtOt9uFuE9AHAVmdqvFMgc
         1EBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224830; x=1744829630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cb1UzoeDrUAtaptT6ufvlujinhVhnpVPzpxEo5c3TZ8=;
        b=DbuY7fuTGOTdmO77O3qHB0TyLwuJcqSaBOb2CiPcBkNEQ9GeFxsicgYT3LQku4UzaU
         70OmsRQqpFW9WFWypOMUb3q2wUML0WMfkmtJ5nYnSNFtXgjT04a1ll5h5AqMEfBh4eVq
         eBRx5RA13f50G1t7kTde7SBgknI2talE0CKMGooJGbVfQv5gaqwGHhcHueiRRNNRMRLh
         zLrGT4Eed8kbdrNwIO90qXdyOKEabzf43DIaxtLqmo47pNQFsw7oddEeJ59br5+sXLce
         o/k8Cma8qoGmc3vXacNPfwI2LTkxQi9dkJKmEjnEnHzgPGCnDqGoU2E2Hdw1lpq24/MO
         OAUg==
X-Gm-Message-State: AOJu0YwA4dDHLJ5Y0Pcsslm3wR8XEtiZhCqC5KIE3aymVI5H44jXBBlY
	8gTopUQYKl3iEx3tiqsLY1x54LmYP/B5DHkfF8AeN24dXXHEAqMp6eupzOcHKJeOhmULv8yzJsc
	=
X-Gm-Gg: ASbGncshqU4I98zWMdlPT8as3DIqua/so5PN0bvBVZmDkscmAHw8irMfN3K7La580+D
	vrXbod4T0AWyx7xEklGVgh2KQpUAvWq5d+YCgWMQL+vzpyYiqonZ0tlUBBNwF+1zRk9dLF4eflZ
	7LZikQwVdZBGJln9rqlS9U7fdxHv5Ry7PpvaW9pZPcxDCkWn7jUmSWvmhprv+HzsFzfhTMrWcY8
	0dmgKwNw8HLrXHrSZi5mbE/I/Aj8MG5vP5OQG1Oy+IzwmvwDLeuBdtfK70ZQPA3rUiic9hcD4qV
	HG4xaq1HsevsG0hfjxtRQpcapmGHYEsCWQpszFo/Rmmn3MoqkKvmKSAwOKkTAXS74QW7uI8Wqm0
	mBZhcX1o0mQ==
X-Google-Smtp-Source: AGHT+IHWJwxR8jMogD/fSGoa/CWBNTRcOeWbfqXUPgXrQmIL/bl6N7pnAKKxRzFmTst3onulpE5kfg==
X-Received: by 2002:a05:6214:23c8:b0:6e8:feae:929c with SMTP id 6a1803df08f44-6f0e5ac27f0mr566686d6.21.1744224830161;
        Wed, 09 Apr 2025 11:53:50 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0dea2186csm10444416d6.123.2025.04.09.11.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:49 -0700 (PDT)
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
Subject: [RFC PATCH 22/29] safesetid: move initcalls to the LSM framework
Date: Wed,  9 Apr 2025 14:50:07 -0400
Message-ID: <20250409185019.238841-53-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1734; i=paul@paul-moore.com; h=from:subject; bh=ApRTJHP3nnJAjZEel9K+GvPb3rr0j6am0sMw9Kt41Lc=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sHuO8qs0Kplr4XEiQFOq7N91C8f9aD/G+zla 4l9lgn41KCJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bB7gAKCRDqIPLalzeJ c3nOEACSTIJJdI2vHKuXlfwTlrsp93s4wVYXXPlNAcPLJiwpjg06/tph4qDy7SOWy0uxU47VSgj IacsIdwLSgxIAEiGmQrpkv8Xx8sNW2goL165LYw3hELx7qJIDxxjIIPnOuyM87MkgGofowjc64S ji7U3XQkRPJVB2MvfXGuV7OmfikzEjTT+2RaE9sgZ6C4be68ZqPCdUxi7RWkB5fkpaRDHsZG5vF RZRt5+/Mo+51wxYOEFMzYFF9gtSIrrqfesq4XkrNa3yq4CeG3J+aBOPzWZInu4o9xTuxDlpoJVu +YK95xEtAkatBf7VulmWyXg90Yda+F6MW0QCAkm36YuntiDZbrWD4mClhiRRZ1NAIuoo4tHrsfd gnEnh+T4hz12WVuslbiBY97cna2Su2Q4301XdLDrrtgiVk6mT0LqL7DxgtsuV1HHORVUxLU019r 95KDD1p6RMky/N4fZ6acI9JqkF1fi2nYuQ9vS8tRsiJfeBhHx0ZzU8zLFP0BDdySyjU1O0PvTq7 hBbaVCsK2GqumhsV9H8WNJzuus4yfMiCtUGOJbDp+2QV6qdUisUGylT81fSDaM3VwjukDXQRbPh 7a2Zmrp4wRbHP2A7sMCiBVku/zEGb56TtgkkqIRnRJ1qbyiJ0/z0f+7mQni7plWfCFZ+mMxzT5I vSGGHZkITDiC75A==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/safesetid/lsm.c        | 1 +
 security/safesetid/lsm.h        | 2 ++
 security/safesetid/securityfs.c | 3 +--
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 9a7c68d4e642..d5fb949050dd 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -289,4 +289,5 @@ static int __init safesetid_security_init(void)
 DEFINE_LSM(safesetid_security_init) = {
 	.id = &safesetid_lsmid,
 	.init = safesetid_security_init,
+	.initcall_fs = safesetid_init_securityfs,
 };
diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
index d346f4849cea..bf5172e2c3f7 100644
--- a/security/safesetid/lsm.h
+++ b/security/safesetid/lsm.h
@@ -70,4 +70,6 @@ enum sid_policy_type _setid_policy_lookup(struct setid_ruleset *policy,
 extern struct setid_ruleset __rcu *safesetid_setuid_rules;
 extern struct setid_ruleset __rcu *safesetid_setgid_rules;
 
+int safesetid_init_securityfs(void);
+
 #endif /* _SAFESETID_H */
diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 8e1ffd70b18a..ece259f75b0d 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -308,7 +308,7 @@ static const struct file_operations safesetid_gid_file_fops = {
 	.write = safesetid_gid_file_write,
 };
 
-static int __init safesetid_init_securityfs(void)
+int __init safesetid_init_securityfs(void)
 {
 	int ret;
 	struct dentry *policy_dir;
@@ -345,4 +345,3 @@ static int __init safesetid_init_securityfs(void)
 	securityfs_remove(policy_dir);
 	return ret;
 }
-fs_initcall(safesetid_init_securityfs);
-- 
2.49.0

