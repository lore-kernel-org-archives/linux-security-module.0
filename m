Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16533019C8
	for <linux-security-module@vger.kernel.org>; Sun, 21 Jun 2026 03:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782013953; cv=none; b=Lvc0pJ3+JSdUc/N2nETiGJZLhySLZ3d10U2aXMiNvL+coRiGmWlchR+6BKnuFXJp1BqrmuKhMTg/8I/ys7e7GI5hrm8lFWZVCqw3SAmgNfFMCmp1SVhxBYnbK/+ex6lUw5+i9KeRcPEQxxnWHOwna9l+TEOf+o+G5xHZsdDgX0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782013953; c=relaxed/simple;
	bh=6vJ0mYCP9BN2A/Ot66MePaJ3rmLHzZpPT9X9E9/GWXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jea8OqnzwUVFx+Vi8cUt3xiBSO4C1uUjX/ju8TI+dntm/GC2BkReuD7gOUcNGEKId6WrDNAOuQH4uvUFUM2hH8RnuZHo6/kX3knzgWmrA2HmEmStf4bSpRvQuk1tiiJ5jJFnRaels80IfMNQ7rbnb93P+P0lVDWSOv8JVEL6P3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HazsWsH7; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HazsWsH7"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7e1916922b9so35306137b3.1
        for <linux-security-module@vger.kernel.org>; Sat, 20 Jun 2026 20:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782013951; x=1782618751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5ZI7YNWjGr6xYcv99fXt+vkXK0euA7AZaiWUcg8WdA=;
        b=HazsWsH7OTG2zKezKgwCH/m7xnoiUvaHHHrb+TPNsFV2YHvrH5XT89HeKjmqhmTJ0e
         9f3/QQNzryOgeG8+39WCCx8uT29390rWCjvtTw+lstTIfjp/RGXu2vzamJSy2r+SFPGE
         8MHmaWuTOFQmyoxoZM8ONhMVv6DRNpmU0xpdMSAFGhlX1r+cg6kzuaEnuQSihNuenwHw
         edR9qRZnPV/aUYYpS6TiXl6g0Hej7y0QPNXqRmjb1GgIxTGfyD0mxe3eWyeVYIpyedY7
         kRA/H1bk6kdgAbsLmRCKfRH/xwyKF3sRHH/lJDgNFZF+BIFpuL5Dfp/SpeB45I4vHs92
         kBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782013951; x=1782618751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B5ZI7YNWjGr6xYcv99fXt+vkXK0euA7AZaiWUcg8WdA=;
        b=tEvGvHzkbma45kraiMFRS74otpMd2Bwukc3Y1gmEvZ4oM8fkNmeuisWf1gHtp0BhPi
         33pASZk6vJ6D4rJC0fX6lKiLdyrqdUu7OXe/fBwJZPGE0zrsZZmQM/G5ErQPd0WqsvhZ
         W+Ms4Y8hlq5Qps+edkkpCHU670UAvKzuHaVk9iq8zyrtkklnTOQoYk4g+2vN2SjB1E4Q
         q9vVbRGizBRdSqCd0u5cPRnbuz2HbytVfDMIl+nfuCnIY5FcBSwCVZMEbUap9DscNr3G
         y20uuAO/qX79B64nYdkQHoC6vlG/UyjE1RV137xqd3a+xy67hgpZIsoQabNO0PxX1AYY
         We6Q==
X-Gm-Message-State: AOJu0Yw+d0Zxwl1Wv7GZu3BKJRldvYJo8FBX4uP0d3keIUOFerLfCBKh
	JF0cqQtMc3BCk6NQj1wlg3BDRSrMcUhUrbUCPZGJ1g2cdan+r5zFEeFKV9k0qA==
X-Gm-Gg: AfdE7cm1R81dFwu0xfSS0TO3muIw/y3azG9Jk9W2XtvOOTeARz4/Ue11ZtFhRUXr4+f
	iWNj9zTh1hiB0DO1aQvXVz1aW3ZjXS8YYQs1C+EjBxw6B25ETs6RR4GDiOEhdFQJJpZXGYRGJt8
	bcXbtB0r0vOuQgA6ydUTZqOZkT2R0UfP0ofSuWCC2W9Im3xjzOnQPmMg0sNrls58QwkEbDZ9xox
	SVEX0lvJSdlgI8ZAfL1DD7pSMHa4KjJOJqtB5goYhxmcpP8ss7RdbRa4tBoPIZwv7CoqByaXaWT
	WdEUEKIZD178BcaIkQUmO1J4e+nTUFBT4gaNhhcfU6v6Ci3Al1fvqij8YmKP6ERSRO6iFK2gs6c
	SYcqK8tERmjbWBTkuDIZVBTkWYjKmkWqrIPAY+bmQ+lDQOgIUseIiT5Kyra6fiDz87dxZxBGag8
	0lPKcnBfO9Aw9CETRegsri2K/vOkunvLx8XlBWeWtXhjO/ag==
X-Received: by 2002:a05:690c:ece:b0:7db:b027:6166 with SMTP id 00721157ae682-80133fc1a2amr103367647b3.22.1782013950529;
        Sat, 20 Jun 2026 20:52:30 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:2de9:628a:4b2:9b39])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025cf61d36sm17155677b3.11.2026.06.20.20.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 20:52:30 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org,
	mic@digikod.net
Cc: m@maowtm.org,
	gnoack@google.com,
	gnoack3000@gmail.com,
	matthieu@buffet.re,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v9 2/9] landlock: Add LANDLOCK_ADD_RULE_NO_INHERIT user API
Date: Sat, 20 Jun 2026 23:52:15 -0400
Message-ID: <20260621035223.2651547-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260621035223.2651547-1-utilityemal77@gmail.com>
References: <20260621035223.2651547-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wire up the new LANDLOCK_ADD_RULE_NO_INHERIT flag for
sys_landlock_add_rule().  Define the constant in the UAPI header with
its documentation, accept it from user space for
%LANDLOCK_RULE_PATH_BENEATH only, and update the path-beneath useless-
rule check so that an empty allowed_access is still accepted when a
flag (quiet or no-inherit) is present.  Reject the flag with -EINVAL on
a ruleset that handles no filesystem access, since the resulting seal
would be inert.

The flag has no enforcement effect yet; that is added in a subsequent
patch.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    Changes since v8:
    - Reordered ahead of "Return inserted rule from landlock_insert_rule()".
    - Reject LANDLOCK_ADD_RULE_NO_INHERIT with -EINVAL when the ruleset
      handles no filesystem access (the seal would be inert); documented the
      new EINVAL case in the sys_landlock_add_rule() kerneldoc.
    - Expanded the UAPI comment for LANDLOCK_ADD_RULE_NO_INHERIT: the
      conservative seal (same-directory renames and hard links denied) and
      the best-effort ancestor walk that is not serialized against rename.
    - Rebased onto mic/next.

 include/uapi/linux/landlock.h | 35 +++++++++++++++++++++++++++++++++++
 security/landlock/syscalls.c  | 25 ++++++++++++++++++++++---
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 7ffe2ef127ee..336b01dc43ec 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -123,10 +123,45 @@ struct landlock_ruleset_attr {
  *     allowed_access in the passed in rule_attr.  When this flag is
  *     present, the caller is also allowed to pass in an empty
  *     allowed_access.
+ * %LANDLOCK_ADD_RULE_NO_INHERIT
+ *     Disable the inheritance of access rights and flags from parent objects
+ *     for the rule's object and its descendants.
+ *
+ *     This flag currently applies only to filesystem rules.  Passing it with
+ *     any other rule type returns ``-EINVAL``.
+ *
+ *     By default, Landlock filesystem rules inherit allowed accesses from
+ *     ancestor directories: rights granted on a parent directory also apply
+ *     to its children.  A rule marked with %LANDLOCK_ADD_RULE_NO_INHERIT
+ *     stops this propagation at its object; only the accesses explicitly
+ *     allowed by the rule apply.  Descendants of that object continue to
+ *     inherit from it normally, unless they too carry this flag.
+ *
+ *     This flag also enforces parent-directory restrictions: rename, rmdir,
+ *     link, and other operations that would change the immediate parent of
+ *     the rule's object or any of its ancestors are denied up to the VFS
+ *     root.  This prevents sandboxed processes from manipulating the
+ *     filesystem hierarchy to evade restrictions (e.g. via sandbox-restart
+ *     attacks).  The seal is intentionally conservative: any rename, removal
+ *     or link operation targeting a sealed object is denied, including
+ *     same-directory renames and hard links that do not actually reparent it.
+ *
+ *     Inheritance of rule flags (such as %LANDLOCK_ADD_RULE_QUIET) from
+ *     ancestor directories is also blocked at the rule's object.
+ *
+ *     Adding such a rule seals the rule's object and all of its ancestors up
+ *     to the VFS root, so the kernel walks the path up to the VFS root while
+ *     adding the rule, sealing each ancestor in turn.  This walk is best
+ *     effort: it is not serialized against concurrent renames, so a rename
+ *     that reparents one of the ancestors while the walk is in progress may
+ *     leave the seal incomplete.  This is not a security concern: changes to
+ *     the filesystem hierarchy between the time a ruleset is built and the
+ *     time it is enforced are outside of Landlock's threat model.
  */
 
 /* clang-format off */
 #define LANDLOCK_ADD_RULE_QUIET			(1U << 0)
+#define LANDLOCK_ADD_RULE_NO_INHERIT		(1U << 1)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 36b02892c62f..b847b0be1cf7 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -361,7 +361,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 	/*
 	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
 	 * are ignored in path walks.  However, the rule is not useless if it is
-	 * there to hold a quiet flag.
+	 * there to hold a quiet or no-inherit flag.
 	 */
 	if (!flags && !path_beneath_attr.allowed_access)
 		return -ENOMSG;
@@ -375,6 +375,15 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 	if (flags & LANDLOCK_ADD_RULE_QUIET && !ruleset->quiet_masks.fs)
 		return -EINVAL;
 
+	/*
+	 * Checks for useless no-inherit flag: a seal is only ever consulted
+	 * for a domain that handles some filesystem access, so a no-inherit
+	 * rule added to a ruleset with no handled filesystem access would be
+	 * silently inert.
+	 */
+	if (flags & LANDLOCK_ADD_RULE_NO_INHERIT && !mask)
+		return -EINVAL;
+
 	/* Gets and checks the new rule. */
 	err = get_path_from_fd(path_beneath_attr.parent_fd, &path);
 	if (err)
@@ -433,7 +442,7 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
  * @rule_type: Identify the structure type pointed to by @rule_attr:
  *             %LANDLOCK_RULE_PATH_BENEATH or %LANDLOCK_RULE_NET_PORT.
  * @rule_attr: Pointer to a rule (matching the @rule_type).
- * @flags: Must be 0 or %LANDLOCK_ADD_RULE_QUIET.
+ * @flags: Bitmask of %LANDLOCK_ADD_RULE_* flags.
  *
  * This system call enables to define a new rule and add it to an existing
  * ruleset.
@@ -451,6 +460,10 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
  * - %EINVAL: &landlock_net_port_attr.port is greater than 65535;
  * - %EINVAL: LANDLOCK_ADD_RULE_QUIET is passed but the ruleset has no
  *   quiet access bits set for the corresponding rule type.
+ * - %EINVAL: LANDLOCK_ADD_RULE_NO_INHERIT is passed for a rule type
+ *   that does not support it (e.g. %LANDLOCK_RULE_NET_PORT).
+ * - %EINVAL: LANDLOCK_ADD_RULE_NO_INHERIT is passed but the ruleset handles
+ *   no filesystem access.
  * - %ENOMSG: Empty accesses (e.g. &landlock_path_beneath_attr.allowed_access is
  *   0) and no flags;
  * - %EBADF: @ruleset_fd is not a file descriptor for the current thread, or a
@@ -472,7 +485,13 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 	if (!is_initialized())
 		return -EOPNOTSUPP;
 
-	if (flags && flags != LANDLOCK_ADD_RULE_QUIET)
+	/* Rejects unknown flags. */
+	if (flags & ~(LANDLOCK_ADD_RULE_QUIET | LANDLOCK_ADD_RULE_NO_INHERIT))
+		return -EINVAL;
+
+	/* LANDLOCK_ADD_RULE_NO_INHERIT only applies to path-beneath rules. */
+	if ((flags & LANDLOCK_ADD_RULE_NO_INHERIT) &&
+	    rule_type != LANDLOCK_RULE_PATH_BENEATH)
 		return -EINVAL;
 
 	/* Gets and checks the ruleset. */
-- 
2.54.0

