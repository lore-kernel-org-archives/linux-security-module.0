Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6711F8691
	for <linux-security-module@vger.kernel.org>; Sun,  7 Dec 2025 01:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765072327; cv=none; b=b8VUynp7neWvs2xXo5+KJa+DTQQekINCCigHyfKR4bKyhZXPzG8xvjgeyohP7zqvXI6uQNwtYkWpKg3PMbfzsli2Y7zJqKIBmbG9Rv7BzOaD6RAtk0ue3kqZBopIwwXurOMuuSTPAUgCYzE2wrF34DNoK92fnOtn/tulxy4kXQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765072327; c=relaxed/simple;
	bh=dMGJM6z0kcXCgKIwn0IIWuKip2bso64gwure5tFRbxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThFfo6c+ghIZHh4NquJKvMOJC1x+Ft4VYoqDd30StqHtf68ck3uS4l6Hp8buqje21r2OrvGrQzXt3UWKFCGvWiOJg0NpdA1jBc7whQdgOgiJDKXhG/dSe+7lSGLxHpLdDBRxh8p/QA/f7w1cPtacS7UPN+D0VhndQmF2617xxyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j71YXdzZ; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j71YXdzZ"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63f9beb2730so2789345d50.0
        for <linux-security-module@vger.kernel.org>; Sat, 06 Dec 2025 17:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765072322; x=1765677122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bS95/G1uBL3P56afF+VsD2Bkuu18XFpw9A57hkywVjU=;
        b=j71YXdzZbOz+XsfoSKG1gNNjaV2IZvDO+gRf6agApkEL6suQ1Hb4bwnhYU3Djq5bu1
         UzYwXDQJlP3I1kO4j/2zt9XGChkz6tjnTouXNArusBZWC9yRWSTLk/Pr2Svs0lX6Q+4p
         XZSwaLkj2xvwPJjE7n+3mnd0VzaFl1tD2axD/EokSxHxfSNQ1vJfslgKneJWNuvaoMCa
         rSKVs4tmaZsJM0AxfWPqgWmrCFdQtXBW5gjYX+oCNsOPWHJyZnjpzVhKayw5StQ6rFlw
         Sjiz4xPdF4M0qV7pqknIt11Xv3AyMnI4YOFxZFKWXZPsUF8vnFr4sEnXeqURndntc+aE
         aKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765072322; x=1765677122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bS95/G1uBL3P56afF+VsD2Bkuu18XFpw9A57hkywVjU=;
        b=rItJtV0XHHR8SWmBYGbxd6xU4QR4TrRkq92qdOo2OX/UVk6otpllbjmAXD5l0Low9j
         8LMzRYkkUznTD8YOmUe9TNzcREgLOiljBG3NLxmqtFikYDMTkYx6rkfhd3uz1+7Grr63
         Fv+e4bKQq2ypRUNzE8ccBaree1eF9FdSo0L75I+FPsYQ57bLvhK9WVMlBpkHUKxU26tD
         Izm7WLTTjABHog7Bq2D3r2O3PoE0239DpiwPHkUM/s9jAIw9uLJTkmSFsO1IGAy3q3aP
         tyFjAgOH/yEjNxxwasUhE39O6FVE/8H/ZkDQC0BjDbxk7EuXmMvkXaVTAvYsTyxjlPCa
         lB6w==
X-Forwarded-Encrypted: i=1; AJvYcCXXma0flSPYeBwrrxdAUbWKSSBaAewiV4t45BiRTf/x+LDgZPKXy871L4gOXHTQ/HPGsrSFW7yVJ8tUQ9P6xIQCPATClQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxm60HDWOVRZYid9AS8GjxmFD2P9hN51LAU5+Hkt2cxpsniVtA
	7OmSzzSc77Pz8M/185AsEinR8b3U34A/uClGZIb0sJboBb9MmJaChXdT
X-Gm-Gg: ASbGncvKzltAZMCEwqKxnNGbjbtdSNlPH8+IvgCSaPT4ipMFteWesR5t0urlW3fJ0ek
	zUZ5q5l3HwHNvUyv9TE2jtOjS4ToWZff8qFJk2MLd8DQNH7rlIgIKI4V5WA9dAxfqZoqSwpj/r0
	2yn6EK6JhO4QSWZsS61giVRXI4BrDeuHN5oWFJjC07rPcZ0URMK87bzQObqqHGL3hhYpdHBeXsi
	yHMK4zOM8Jzf1V+R2a+8encD69EnP/UuO1+Q/5PXCcu9YC5dGghXGoNY2/Qn43+3qnvDZWpvzrC
	VYwwvU0wmCmy/aXF46fBKsi9lfsBUa6jx0q1OOPXKoiUHS/IAkEu4Ut5XSCp/Dkmo7eZ1bMHIjB
	mjWH1kwKSF/L3ZJQJCBDNAfjMvCQSswUFqosJV3gT3F/W5BaCvNTCNtTmpEsHZfauN2gjP3Fmyw
	SaGBJ3UahGLqBzo/2jHBTE3IZPb0XwM1vwvR5DOAb2iSg/6MAAxQET5Kuy55P2
X-Google-Smtp-Source: AGHT+IEuRUMVJ6JxNWHo6SyfWaUmgs+HBKlRGMtt+6osDHs/x0mY3fnnJ35S9QRwytMepi6Icv08sg==
X-Received: by 2002:a05:690e:4259:b0:644:4625:8853 with SMTP id 956f58d0204a3-6444e7790d5mr2485256d50.34.1765072322523;
        Sat, 06 Dec 2025 17:52:02 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b4ae534sm33158417b3.3.2025.12.06.17.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 17:52:02 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 2/5] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT userspace api
Date: Sat,  6 Dec 2025 20:51:28 -0500
Message-ID: <20251207015132.800576-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251207015132.800576-1-utilityemal77@gmail.com>
References: <20251207015132.800576-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implements the syscall side flag handling and kernel api headers for the
LANDLOCK_ADD_RULE_NO_INHERIT flag.

v3..v4 changes:

  * Changed documentation to reflect protections now apply to VFS root
    instead of the mountpoint.

v2..v3 changes:

  * Extended documentation for flag inheritance suppression on
    LANDLOCK_ADD_RULE_NO_INHERIT.
  * Extended the flag validation rules in the syscall.
  * Added mention of no inherit in empty rules in add_rule_path_beneath
    as per Tingmao Wang's suggestion.
  * Added check for useless no-inherit flag in networking rules.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 include/uapi/linux/landlock.h | 29 +++++++++++++++++++++++++++++
 security/landlock/syscalls.c  | 16 ++++++++++++----
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index d4f47d20361a..6ab3e7bd1c81 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -127,10 +127,39 @@ struct landlock_ruleset_attr {
  *     allowed_access in the passed in rule_attr.  When this flag is
  *     present, the caller is also allowed to pass in an empty
  *     allowed_access.
+ * %LANDLOCK_ADD_RULE_NO_INHERIT
+ *     When set on a rule being added to a ruleset, this flag disables the
+ *     inheritance of access rights and flags from parent objects.
+ *
+ *     This flag currently applies only to filesystem rules.  Adding it to
+ *     non-filesystem rules will return -EINVAL, unless future extensions
+ *     of Landlock define other hierarchical object types.
+ *
+ *     By default, Landlock filesystem rules inherit allowed accesses from
+ *     ancestor directories: if a parent directory grants certain rights,
+ *     those rights also apply to its children.  A rule marked with
+ *     LANDLOCK_ADD_RULE_NO_INHERIT stops this propagation at the directory
+ *     covered by the rule.  Descendants of that directory continue to inherit
+ *     normally unless they also have rules using this flag.
+ *
+ *     If a regular file is marked with this flag, it will not inherit any
+ *     access rights from its parent directories; only the accesses explicitly
+ *     allowed by the rule will apply to that file.
+ *
+ *     This flag also enforces parent-directory restrictions: rename, rmdir,
+ *     link, and other operations that would change the directory's immediate
+ *     parent subtree are denied up to the VFS root.  This prevents
+ *     sandboxed processes from manipulating the filesystem hierarchy to evade
+ *     restrictions (e.g., via sandbox-restart attacks).
+ *
+ *     In addition, this flag blocks the inheritance of rule-layer flags
+ *     (such as the quiet flag) from parent directories to the object covered
+ *     by this rule.
  */
 
 /* clang-format off */
 #define LANDLOCK_ADD_RULE_QUIET			(1U << 0)
+#define LANDLOCK_ADD_RULE_NO_INHERIT		(1U << 1)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 5cf1183bb596..0c815e241c75 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -352,7 +352,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 	/*
 	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
 	 * are ignored in path walks.  However, the rule is not useless if it
-	 * is there to hold a quiet flag
+	 * is there to hold a quiet or no inherit flag.
 	 */
 	if (!flags && !path_beneath_attr.allowed_access)
 		return -ENOMSG;
@@ -407,6 +407,10 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
 	if (flags & LANDLOCK_ADD_RULE_QUIET && !ruleset->quiet_masks.net)
 		return -EINVAL;
 
+	/* No inherit is always useless for this scope */
+	if (flags & LANDLOCK_ADD_RULE_NO_INHERIT)
+		return -EINVAL;
+
 	/* Denies inserting a rule with port greater than 65535. */
 	if (net_port_attr.port > U16_MAX)
 		return -EINVAL;
@@ -424,7 +428,7 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
  * @rule_type: Identify the structure type pointed to by @rule_attr:
  *             %LANDLOCK_RULE_PATH_BENEATH or %LANDLOCK_RULE_NET_PORT.
  * @rule_attr: Pointer to a rule (matching the @rule_type).
- * @flags: Must be 0 or %LANDLOCK_ADD_RULE_QUIET.
+ * @flags: Must be 0 or %LANDLOCK_ADD_RULE_QUIET and/or %LANDLOCK_ADD_RULE_NO_INHERIT.
  *
  * This system call enables to define a new rule and add it to an existing
  * ruleset.
@@ -462,8 +466,12 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 
 	if (!is_initialized())
 		return -EOPNOTSUPP;
-
-	if (flags && flags != LANDLOCK_ADD_RULE_QUIET)
+	/* Checks flag existence */
+	if (flags && flags & ~(LANDLOCK_ADD_RULE_QUIET | LANDLOCK_ADD_RULE_NO_INHERIT))
+		return -EINVAL;
+	/* No inherit may only apply on path_beneath rules. */
+	if ((flags & LANDLOCK_ADD_RULE_NO_INHERIT) &&
+	    rule_type != LANDLOCK_RULE_PATH_BENEATH)
 		return -EINVAL;
 
 	/* Gets and checks the ruleset. */
-- 
2.51.0

