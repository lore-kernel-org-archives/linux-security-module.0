Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6910317C7F
	for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2024 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059446; cv=none; b=Iu5LN1pvGT6RNAgHsFVQU3BsO0SENfcrBC/xJZXNt16bqMXCslXM5YuzPQwecNTX7k95AKiHfPEbfTbbuDHST7VXWiwxNiImjFVSTJllGn0DY91ABbStoJT6/zMucMrGeGseK3zMH4vEOsxWJ3vfY4pJuucvDD1nRHI11L1kQck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059446; c=relaxed/simple;
	bh=AlfGxd4/O9N1qNdUW7Wfiq5Ea1BCpEjyWf6T6cI/Jyg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OKBsgAoVMExlB0ztxiUq3ei3I0qr6HuS93fe5M6+Zr1MMlZlKib5tp/BEe/9jgdyrI68psQ4ceY8iEioRWwANxJCFFJ5/zqX6bfTnuL6s7uhKMe2e1iv+gGzuqbsIiTgMYANlbjcKF6LnAKImAg6+FrKUJlMOPJ+yvUnTwlxIv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ESbLITAz; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ESbLITAz"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a77f48f2118so653128766b.1
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2024 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721059442; x=1721664242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m8Esm6FVizLhC3e3wVf9MF0bJFSjiA6EJyNZff3YjPw=;
        b=ESbLITAzwptPXxqw4fMOTkgsnj0Q4h3zzH0QtfeLcFfs1Q1IpGF0iYcL3t3AKe5ms+
         xiJOsTeeWoZVJ7n/Zc9U3pOyJ9X04vkCUOWwswaKGETENoAHZhBI5/tStoK7r3VJ26fs
         e0S2aIj8tSwMH0HrsZMaur9Pr9hEfyA3UmGjf7BA+hrFMEPIW5X+GehAT7IR4CfoA/6v
         acv296C4Ki4xwP1cuJxDN+Boham1fdGlJlfvmT5+uo/qFrqoHJ3XHG3bv5AV7+k9YRiy
         yDppDY2zkr1gHn2a1j6+eIX0MH00EYi8Qg16a2colZkdwgTnru0RVkwj02O0gTSuHsK8
         FTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721059442; x=1721664242;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8Esm6FVizLhC3e3wVf9MF0bJFSjiA6EJyNZff3YjPw=;
        b=X3699koeuK1G+xLNny/phLCejeaozk8gk+buuD4fY85SGs8sHMwkcpCSV4ccKErfyg
         p6JFdOZ3cbJSMMuveQSYHVMXKnfuCRpKq8Bz4BjxvSjZD1JkerTteolibLeXmzmuzJIu
         Zi3Dg8m1lrGpdWMMdzjB6QKpuVpb4wJr/Wmd7kIJX6tCAYfhRx0QEgytLCOXFVUpqBFo
         lYSB+033Do2hDvruIGlmDt2Ip9YtPbSRxi+4Ajd16880waXyD651zX74bv6nkEbZe64L
         1IYp79odxI8HwQ97o9KEQ/Q3waDTNcCmuNeuSWE3vGfN1rNtIPlizKZatdn0PFNT9uJ8
         5O0A==
X-Gm-Message-State: AOJu0YxQTPwjLuezmvJim3qFjzTxTBmL+c6ebibHIs6gjMMrs9gCfnFk
	evoMHtztt7ccZAwmriOiYxwNSZOIPtyiUoLO6DvzrXv5W+C9oDd7pFayu3LdklAkefOvLJa++dY
	FpfNLucSBWy7kTVYqHouYWxuh/zDT1GZ6A7bxjHHDb7CXe2G8Gt6Jh16xBAHth5wodh7t/ChnNl
	UK1E+WdT64rFh8oFl0X3iTp6/ApsERzMGng7e1z/6TGQSNsU85RFk7
X-Google-Smtp-Source: AGHT+IHwN+QeJgP4gUOMSF5unfT0Ipn6jGY+txTnlJMv2FeGs5fWARzH8rvcGXOAEDowjqxEONlH7VTvozQ=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:907:3da1:b0:a77:c240:9dd4 with SMTP id
 a640c23a62f3a-a799cceb742mr882966b.4.1721059441239; Mon, 15 Jul 2024 09:04:01
 -0700 (PDT)
Date: Mon, 15 Jul 2024 16:03:29 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240715160328.2792835-2-gnoack@google.com>
Subject: [PATCH] landlock: Various documentation improvements
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Alejandro Colomar <alx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

* Fix some typos, incomplete or confusing phrases.
* Split paragraphs where appropriate.
* List the same error code multiple times,
  if it has multiple possible causes.
* Bring wording closer to the man page wording,
  which has undergone more thorough review
  (esp. for LANDLOCK_ACCESS_FS_WRITE_FILE).
* Small semantic clarifications
  * Call the ephemeral port range "ephemeral"
  * Clarify reasons for EFAULT in landlock_add_rule()
  * Clarify @rule_type doc for landlock_add_rule()

This is a collection of small fixes which I collected when preparing the
corresponding man pages (see link below).

Link: https://lore.kernel.org/all/20240715155554.2791018-1-gnoack@google.co=
m/
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Cc: Alejandro Colomar <alx@kernel.org>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 include/uapi/linux/landlock.h | 27 ++++++++++++++-------------
 security/landlock/syscalls.c  | 17 +++++++++--------
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index e76186da3260..2c8dbc74b955 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -104,20 +104,21 @@ struct landlock_path_beneath_attr {
  */
 struct landlock_net_port_attr {
 	/**
-	 * @allowed_access: Bitmask of allowed access network for a port
+	 * @allowed_access: Bitmask of allowed network actions for a port
 	 * (cf. `Network flags`_).
 	 */
 	__u64 allowed_access;
 	/**
 	 * @port: Network port in host endianness.
 	 *
-	 * It should be noted that port 0 passed to :manpage:`bind(2)` will
-	 * bind to an available port from a specific port range. This can be
-	 * configured thanks to the ``/proc/sys/net/ipv4/ip_local_port_range``
-	 * sysctl (also used for IPv6). A Landlock rule with port 0 and the
-	 * ``LANDLOCK_ACCESS_NET_BIND_TCP`` right means that requesting to bind
-	 * on port 0 is allowed and it will automatically translate to binding
-	 * on the related port range.
+	 * It should be noted that port 0 passed to :manpage:`bind(2)` will bind
+	 * to an available port from the ephemeral port range.  This can be
+	 * configured with the ``/proc/sys/net/ipv4/ip_local_port_range`` sysctl
+	 * (also used for IPv6).
+	 *
+	 * A Landlock rule with port 0 and the ``LANDLOCK_ACCESS_NET_BIND_TCP``
+	 * right means that requesting to bind on port 0 is allowed and it will
+	 * automatically translate to binding on the related port range.
 	 */
 	__u64 port;
 };
@@ -138,10 +139,10 @@ struct landlock_net_port_attr {
  * The following access rights apply only to files:
  *
  * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
- * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access. Note t=
hat
- *   you might additionally need the %LANDLOCK_ACCESS_FS_TRUNCATE right in=
 order
- *   to overwrite files with :manpage:`open(2)` using ``O_TRUNC`` or
- *   :manpage:`creat(2)`.
+ * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access.  When
+ *   opening files for writing, you will often additionally need the
+ *   %LANDLOCK_ACCESS_FS_TRUNCATE right.  In many cases, these system call=
s
+ *   truncate existing files when overwriting them (e.g., :manpage:`creat(=
2)`).
  * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
  * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file with :manpage:`truncate=
(2)`,
  *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` w=
ith
@@ -263,7 +264,7 @@ struct landlock_net_port_attr {
  * These flags enable to restrict a sandboxed process to a set of network
  * actions. This is supported since the Landlock ABI version 4.
  *
- * TCP sockets with allowed actions:
+ * The following access rights apply to TCP port numbers:
  *
  * - %LANDLOCK_ACCESS_NET_BIND_TCP: Bind a TCP socket to a local port.
  * - %LANDLOCK_ACCESS_NET_CONNECT_TCP: Connect an active TCP socket to
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 03b470f5a85a..352c34b327d3 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -378,8 +378,7 @@ static int add_rule_net_port(struct landlock_ruleset *r=
uleset,
  *		with the new rule.
  * @rule_type: Identify the structure type pointed to by @rule_attr:
  *             %LANDLOCK_RULE_PATH_BENEATH or %LANDLOCK_RULE_NET_PORT.
- * @rule_attr: Pointer to a rule (only of type &struct
- *             landlock_path_beneath_attr for now).
+ * @rule_attr: Pointer to a rule (matching the @rule_type).
  * @flags: Must be 0.
  *
  * This system call enables to define a new rule and add it to an existing
@@ -390,18 +389,20 @@ static int add_rule_net_port(struct landlock_ruleset =
*ruleset,
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot=
 time;
  * - %EAFNOSUPPORT: @rule_type is %LANDLOCK_RULE_NET_PORT but TCP/IP is no=
t
  *   supported by the running kernel;
- * - %EINVAL: @flags is not 0, or inconsistent access in the rule (i.e.
+ * - %EINVAL: @flags is not 0;
+ * - %EINVAL: The rule accesses are inconsistent (i.e.
  *   &landlock_path_beneath_attr.allowed_access or
- *   &landlock_net_port_attr.allowed_access is not a subset of the
- *   ruleset handled accesses), or &landlock_net_port_attr.port is
- *   greater than 65535;
- * - %ENOMSG: Empty accesses (e.g. &landlock_path_beneath_attr.allowed_acc=
ess);
+ *   &landlock_net_port_attr.allowed_access is not a subset of the ruleset
+ *   handled accesses)
+ * - %EINVAL: &landlock_net_port_attr.port is greater than 65535;
+ * - %ENOMSG: Empty accesses (e.g. &landlock_path_beneath_attr.allowed_acc=
ess is
+      0);
  * - %EBADF: @ruleset_fd is not a file descriptor for the current thread, =
or a
  *   member of @rule_attr is not a file descriptor as expected;
  * - %EBADFD: @ruleset_fd is not a ruleset file descriptor, or a member of
  *   @rule_attr is not the expected file descriptor type;
  * - %EPERM: @ruleset_fd has no write access to the underlying ruleset;
- * - %EFAULT: @rule_attr inconsistency.
+ * - %EFAULT: @rule_attr was not a valid address.
  */
 SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 		const enum landlock_rule_type, rule_type,
--=20
2.45.2.993.g49e7a77208-goog

