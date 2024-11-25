Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550DF192D91;
	Mon, 25 Nov 2024 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531835; cv=none; b=afoBWcW8gh0OAKvfHmC4UhvPq/avQea8ElBVpyjEdc9QPkUsvd639vnaQbCxDxcVrUhRs5BRLWMRNiYEsfYtPouDcZC59Ji3wd4r1aR59G18wsk0pq0JsPTCowoNf686goEoQyYl7490a0wqYb49H06mVIsLzhh6rM+4qE3TB78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531835; c=relaxed/simple;
	bh=aUW89A+cMdYHpkt+oiZdLB+dni4vxT9wWinfiQBYBPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rZn+ufbeiEti+uUHZpomVVKiZlQwFhvkrM8OFjwgjSigXEr2RIQSqDR4YjD451y5G7x5ikO8xVzT12xkk9GQtQvvIz4EBPUch9X8KivkcwtVyeRkKfvd21E3miAxPTu3vYif+ve8OROJV7NWXLJcBIcZzmDU8XHzPzq0wlXTtdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=SavjqTM1; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="SavjqTM1"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531832;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=dzS3rptQpBOYwpq3ixwqSK/AVNS+4t/jVRKj+6wTiiE=;
	b=SavjqTM1fnGwsO0LH8q7sS8uuh6zvh5BCPYzfvx4b4tkBkdUZc/RBoflAVT9o0MJX+bL3D
	wrdP5gJpVbflM24qtzzozxmVdEEFEUXY7R00xUXQsmJ4fVDn8XoQ8j9H7UAca4Bq0TTvmR
	Sjc58f8OE6umSRjPdQlpfloYoqiqICVSlo3+3B3JJNvIq/TKCS8mmKnpj6F44v/IiSqtm1
	i7t1ZTHk6l7NtVuWndh5Re3cu6DoIdKeMZikornUmOkW5SLxltbjPgNZjDCU3RXtOFlPqO
	H3no0I7ukjdOZZ3178Ha53Y0MWneKlQq1z8c6S2XorSEftCqNSIcCeoPugN8ZQ==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] trace: constify string literal data member
Date: Mon, 25 Nov 2024 11:50:25 +0100
Message-ID: <20241125105028.42807-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

The name member of the struct trace_event_call is assigned with
generated string literals; declare them pointer to read-only.

Reported by clang:

    security/landlock/syscalls.c:179:1: warning: initializing 'char *' with an expression of type 'const char[34]' discards qualifiers [-Wincompatible-pointer-types-discards-qualifiers]
      179 | SYSCALL_DEFINE3(landlock_create_ruleset,
          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      180 |                 const struct landlock_ruleset_attr __user *const, attr,
          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      181 |                 const size_t, size, const __u32, flags)
          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ./include/linux/syscalls.h:226:36: note: expanded from macro 'SYSCALL_DEFINE3'
      226 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
          |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ./include/linux/syscalls.h:234:2: note: expanded from macro 'SYSCALL_DEFINEx'
      234 |         SYSCALL_METADATA(sname, x, __VA_ARGS__)                 \
          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ./include/linux/syscalls.h:184:2: note: expanded from macro 'SYSCALL_METADATA'
      184 |         SYSCALL_TRACE_ENTER_EVENT(sname);                       \
          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ./include/linux/syscalls.h:151:30: note: expanded from macro 'SYSCALL_TRACE_ENTER_EVENT'
      151 |                         .name                   = "sys_enter"#sname,    \
          |                                                   ^~~~~~~~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 include/linux/trace_events.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 016b29a56c87..423104db6f93 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -359,7 +359,7 @@ struct trace_event_call {
 	struct list_head	list;
 	struct trace_event_class *class;
 	union {
-		char			*name;
+		const char		*name;
 		/* Set TRACE_EVENT_FL_TRACEPOINT flag when using "tp" */
 		struct tracepoint	*tp;
 	};
-- 
2.45.2

