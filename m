Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE2379EF0
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592137; cv=none; b=IKsHd+iKoqG15DyIPFt5TB/w9UpzAtC03+m7cJrkh7YfJvh3PvvBH1x7ei/BEQv2jx+oNFUhmbceyKeVsHYy1MyyvNIF2VLqLgPvkVwi0oMJ5nXU+FhbL1umpLfOa4VUJgZFV8yma4ihkZzzRmsUL4Pm3xu/7rzhQbkB7xKYGfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592137; c=relaxed/simple;
	bh=QfcqOPYSWwNNOKxeV5EzGcyXRm21S5vm7zVLVxiKRzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apJXfGRbpFUB1QzlxSPiM6zqRCWjX0wdkbQicNyd0dcXWAZZH8sZNwSj6hymvc70ETzoCsnhYP3dk/P2f2J9qX06ImxuG1IhNn2VAaMqRUBEAy12B2uBvRcSCvnH5KNKpfmw0dlPH/Bqyu4pvKKZocG7emfGwI1LZ1JAAJuN9SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jc6adJix; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jc6adJix"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-649278a69c5so4279201d50.3
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592134; x=1776196934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v++DqAC2ai97VyjzvpsGprr+M8r5ODU4UXIMOffYmak=;
        b=Jc6adJixkz2BaRAwat/TDmF0P3aArOw9Tv6BE5zjER1RtZT8aOC/wbjwQ9X/wtCPvr
         FTMffO14ciVpllkhh1sE1lDfrN3noiKJezs8N6TVgNuYoNVaXS5DgHGht+sk10y6mi6C
         ZjHIkiZVGGyriadpXhBRlHTU4a1quFUny9uSo+EW9XUsB39dA+v4NfrRaiDIjTTYM+eu
         vAoYspysvwkINb14oN7BYIMqqY4/2t10OrHJ7p+OKyFr+O1vxF4aB/BKn8tQI4KAu4pH
         qFrYRTl1i4pRz/3AtNiFyb4w6fDQWHJE27KAKJX9LWqVXFTLu+KCnV9GpG7Z9tfVNpJ1
         DUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592134; x=1776196934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v++DqAC2ai97VyjzvpsGprr+M8r5ODU4UXIMOffYmak=;
        b=JctxnuRPoQNVPsm4uSYiSsEhTllqpeAYKE4gFqlFxlZ+Nuky63k83xQfbBR5fxm6/x
         qj0DNgeBroB3W71R80ZuUr3oKVvkEFIu4ZBd07W5MhadquMKuZCwoE/JqfLGEY6ITSwZ
         KirwMBwEd/JhRqDIUKLE3luiy9o31GfjSHv546L9SocrRP1JReQJ5ZzLpuz+Li/tS9Ih
         9W+fvCOG/YVWKEIXzMgE6if9/bkz8z5EBC0IC5iHwbJpsVryO150N/uT/EjwAcVJdpia
         xO5xXn2qLZ4WSUyWv5g/jNelYQ56eX04w2lQgtlQG8B4vUbqHnYwj4KQ3ZVwNUfK4hIB
         LIag==
X-Forwarded-Encrypted: i=1; AJvYcCUMZqWoVZHNViQ+3mna63l7akY1zm5+R0cUhfnRMcdToAU1jF5jovdIUmNXsVW1QEMru0LUhhjroxOYWvstvcm2yIEDRNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYY+1rJu+dyA4Zyg9P19f+Tvg4QPYF2i8ob8OiCrCXlTVguDLo
	KNZFQsW8I1KYxWx+/Gsrh9fq4IMIZlJxJ5Lkq55rcTL4XvQp2brEltla
X-Gm-Gg: AeBDieuxHeuGbhGxVw3NcesNp8C98NywNTBLsMgMAY0wLdTD2f0QjL/Qy8Tq4jLeEyY
	Um8E6aCeHWroH/GNELx4UbSPCg1h54ny1PqyhuG7GKgns6e6xEV+kb5ExPNEba8j5wPo9WVt4qu
	D0KRzT7m/Dl4TCaKNWcOXsMMYtJawMoRLQdgA7nylONwfND22TjopcuhFCZopL3R50V5gn+4on/
	YAcMuOEp52Oh+Rn61s3iI132D0ld57KOKdGGK+GBc24slJ/FM/sK1CsTvhzmBsIc5VCh8NrpPRf
	/v1Wo1IFt8qNOrDgiA5TMSssLichlMrU0vYQGHfmAoV6/LwpR/y3EAjJ6FxZncDvntZlS/Pkiqs
	arVGUQEucIj0hnzB2pjS7i75b6ueEHdQmPJfBnf7ajxOGGMlEVT9c3ipF5betzzMabqP+oFDmok
	rMxUohsDmOocZs3elK8pvOylesgeM3DiOFy+zx6QZe7g3/fITHddAoDWTd9pO4AU8+87K++PCG
X-Received: by 2002:a05:690e:e81:b0:64e:efc7:b1b6 with SMTP id 956f58d0204a3-650487ff725mr16689929d50.36.1775592133740;
        Tue, 07 Apr 2026 13:02:13 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:13 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 03/20] landlock: Implement LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Date: Tue,  7 Apr 2026 16:01:25 -0400
Message-ID: <20260407200157.3874806-4-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407200157.3874806-1-utilityemal77@gmail.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a flag LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS, which executes
task_set_no_new_privs on the current credentials, but only if
the process lacks the CAP_SYS_ADMIN capability.

While this operation is redundant for code running from userspace
(indeed callers may achieve the same logic by calling
prctl w/ PR_SET_NO_NEW_PRIVS), this flag enables callers without access
to the syscall abi (defined in subsequent patches) to restrict processes
from gaining additional capabilities. This is important to ensure that
consumers can meet the task_no_new_privs || CAP_SYS_ADMIN invariant
enforced by Landlock without having syscall access.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 include/uapi/linux/landlock.h | 14 ++++++++++++++
 security/landlock/limits.h    |  2 +-
 security/landlock/ruleset.c   | 12 +++++++++++-
 security/landlock/syscalls.c  |  7 +++++++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 10a346e55e95..de2537755bbe 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -131,12 +131,26 @@ struct landlock_ruleset_attr {
  *
  *     If the calling thread is running with no_new_privs, this operation
  *     enables no_new_privs on the sibling threads as well.
+ *
+ * %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
+ *    Sets no_new_privs on the calling thread before applying the Landlock domain.
+ *    This flag is useful for convenience as well as for applying a ruleset from
+ *    an outside context (e.g BPF). This flag only has an effect on when both
+ *    no_new_privs isn't already set and the caller doesn't possess CAP_SYS_ADMIN.
+ *
+ *    This flag has slightly different behavior when used from BPF. Instead of
+ *    setting no_new_privs on the current task, it sets a flag on the bprm so that
+ *    no_new_privs is set on the task at exec point-of-no-return. This guarantees
+ *    that the current execution is unaffected, and may escalate as usual until the
+ *    next exec, but the resulting task cannot gain more privileges through later
+ *    exec transitions.
  */
 /* clang-format off */
 #define LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF		(1U << 0)
 #define LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON			(1U << 1)
 #define LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF		(1U << 2)
 #define LANDLOCK_RESTRICT_SELF_TSYNC				(1U << 3)
+#define LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS			(1U << 4)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index b454ad73b15e..9eafc64fba3f 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -31,7 +31,7 @@
 #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
 #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
 
-#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_TSYNC
+#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
 #define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - 1)
 
 /* clang-format on */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 2333a3dc5f33..4f0305796165 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -121,10 +121,12 @@ int landlock_restrict_cred_precheck(const __u32 flags,
 
 	/*
 	 * Similar checks as for seccomp(2), except that an -EPERM may be
-	 * returned.
+	 * returned, or no_new_privs may be set by the caller via
+	 * LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS.
 	 */
 	if (!task_no_new_privs(current) &&
 	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN)) {
+		if (!(flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS))
 			return -EPERM;
 	}
 
@@ -197,6 +199,14 @@ int landlock_restrict_cred(struct cred *const cred,
 	}
 
 	if (flags & LANDLOCK_RESTRICT_SELF_TSYNC) {
+		/*
+		 * We know we can set no_new_privs on the current task
+		 * because this path is only valid in the syscall context
+		 */
+		if ((flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS) &&
+		     !task_no_new_privs(current) &&
+		     !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
+			task_set_no_new_privs(current);
 		const int tsync_err =
 			landlock_restrict_sibling_threads(current_cred(), cred);
 
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index c710e8b16150..6723806723d5 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -402,6 +402,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
  *         - %LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON
  *         - %LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF
  *         - %LANDLOCK_RESTRICT_SELF_TSYNC
+ *         - %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
  *
  * This system call enforces a Landlock ruleset on the current thread.
  * Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
@@ -461,5 +462,11 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		return err;
 	}
 
+	/* In syscall context we can set no_new_privs directly. */
+	if ((flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS) &&
+	    !task_no_new_privs(current) &&
+	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
+		task_set_no_new_privs(current);
+
 	return commit_creds(new_cred);
 }
-- 
2.53.0

