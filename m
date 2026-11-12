Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521323;
	b=Ix1qFD47e4V40hgqsrJr8qCZycm7dTAWop8pLga4HL6QF6SdosHm9Ja/TRfA2zozjLMq
	 ZhF4VSC+HkSeEEXEFmhpKwaKZir/OgBCOToL2qSJpHQ2pIqq3/9oAC7kdlLMxGkaY4Qu1
	 T1NH2V4QdbD8vPQ3xxaDTN7B7kuo8Mxl9FCrsh9sLBb7zKTG4rkkHprHqxPXC89a1X+NH
	 BwBeeb8lD+C9P+L5cFtNRd4HFpdWDFFXlcK+IYQI5YllDpJdmlJu6Hqa48nl6gTRHKOmK
	 /SC1xwWI/UYDUW08Zp0/Cm4+jlCTYJz7i17v1BxSmahH0+FA35Mk4ZYKIJtEcpXMJ9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521323;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=EGz6t+nadkIYsChXWmYseOA5mfkYKT15SuVuIDD9+dU=;
	b=E5ZT0HZFmHBeMC8x6NJbmgE7IREt0geY7Q+1+VQXsOn0CUYwrVNDmOfxULmIr99ddE6R
	 LtHgJPcRwY3PpRAl6fX8/ki4MOv05v/Y0ulEW56HAcsnoXp5kTDPjDqDG8q6vFdU0rlFV
	 trPZNYvSVj/ljz5gtBgIXzRdg/Nd2yZXqrHd9MRkMMIhjnEa8LplEoQBUCOxQ8O9kTwhK
	 ZKC/gyjRAsp2hvsJDEcgRJzdVdJh1qcHb/cY5sF82Ak9eOfZUCmvSPY4hL4PJ+Agm+bAY
	 /woDpTbGnx/yed5kC+2Y0w3v1CutyGmJYXgB53nVwE5NODn0DXoLtRo7RJRbQhUTEkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=FOEkVr0W;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BC4606A894
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 22:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23BC4606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=FOEkVr0W
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f3c616c84so32617185a.1
        for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 14:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794521322; x=1795126122; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EGz6t+nadkIYsChXWmYseOA5mfkYKT15SuVuIDD9+dU=;
        b=FOEkVr0WbYBthIcM9gohDEiRWLPmqrVx8j/mybaA2Lnd9dVdwESHthVXTLRcRHgLMa
         Mi2menhOhNlhQsX4CSSXE4MzcojD7W6iFEnsYknkWi68V+kGeVEcX5mq2APJmGmL2q7I
         J4vO7NJIcYE1Yp1OHwSqwG4RKsui5qbbdRR6LjNJGVmhs7Q8Wbou4SLYnt2/CARZvkJO
         arKryryHW1I73Z3CzPCqkr1b54XxAbq0dMpNLqnAdY39na6U8KxZIwrNvYKfhaFwf2eS
         9krFaTGm+1wX3+lZ8XQe/WxsFbL8F7ZwpsFKCzZ7VqpLzzPOz82h01BebnQqyXR9JV13
         YyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794521322; x=1795126122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EGz6t+nadkIYsChXWmYseOA5mfkYKT15SuVuIDD9+dU=;
        b=gxM/im8f78Qg13De6JbyFa+1wjmvzSFSr21oEy9kWCe8zRcmUNxkOhrzk9TQTZdTWr
         QyJu4uojtPdu066PBTu9fzp4Org+gF//9fx6DEp0xulnWfuTqsRwNp7cItt3VymvWizS
         acSIYNfFgADAZtQklZsErKAvDYFEov91Q8c4/laykUe5zFg9C4w9EX/IVOkrrqwk8Ueo
         6g2pZEL4PFTEc6TkeLY8MlG4YSaZpdqwqjpG/YHpg88vos/8sFnbyUVmlgQ0E371RvPG
         98hxIONIVLTUUaNCfQKaYiYNMpCLEVH4LJRfQOcCkFG2cH+Rli3fPU50o8Ougp3bDeHR
         2msA==
X-Forwarded-Encrypted: i=1; AL+hErF2kYQNgN+HNXW7NGTK3rHnmRkdwEy7UKCqUjoxRQ6PbJ2QnddbrqCkoUnl7n17w4nVPLHq/8uHoPQUmdfk7dk302RX35Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EupA4VaZPDsCvFXL1J66YNA4IjgXo74mokhgz3BUqQiXBxb7a
	Ul+TOZK8bJC7KTvegzUr+zKHyJ8GHrBwimZZTkGyuzdo8i1jlcGr/QJcQ0Z31/tcC0M=
X-Gm-Gg: AYBFou2D9asJAxLFdsSK31wtYJZgJ0PiYD+NzCiGmVvh1rEY2sm7Ndsv5ovfvmQw7OD
	ZlfzUCga+HfplMzusvbyom5zDOH9ylDrazcEjv4rgRSdi1kQlwjNh6u0yHynRXFOS6sVApDoZy/
	IHzU7b8VQ1QzUIjFW6ZX9jW0x0YnFGeOGZp0yK+gg7HV4DzzfVPICG5b4D8dwp3fYjJz9oQjQFJ
	REE0QvFEz2B/vOya1bzUIHp1loiJLizjGzowYowhmqrFkBRQK9+kXKI2oVGSdHTl18iIv49od6U
	Sp3LCEZhlzxWTHXx9sht2TA0L4ut25+g9n8Yn3whAK2A04R6ail9UTuXQuse61PEj44teqKBMFA
	cTTd54Cu7Di4Wj2f8+A7nmWCy+6CYmL2HVdkN3rMvInnOtMObfmzOi/uRMOKXr8Cp241O9eWjXx
	g8cXeBE2Vyjfeoh+sBwzefMU+KujOJGVUzXw+bWyzToVHFyibN2kWkD5CzBor0shpmvgFrJjFn5
	xJw7s4YB4Vuml3/ElFe1/0bHufW8krs+egc9P61X7BOjTZ2L6x6DzYLuOp2RjC9dc5ASrl6S2iM
	gWya16Q8/Ja9RMFL5up2nvENR0U6oPAyCjDcQiU5hhXpnA==
X-Received: by 2002:a05:620a:439e:b0:93c:7e9c:3bba with SMTP id af79cd13be357-9494bbf688emr136728885a.41.1794521322104;
        Thu, 12 Nov 2026 14:08:42 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c836156sm38473785a.19.2026.11.12.14.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:08:41 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 12 Nov 2026 22:08:23 +0000
Subject: [PATCH v10 2/3] capabilities: don't let ptrace borrow CAP_SETFCAP
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-b4-setfcap-userns-v10-2-84f6f7faa903@toxicpanda.com>
References: <20261112-b4-setfcap-userns-v10-0-84f6f7faa903@toxicpanda.com>
In-Reply-To: <20261112-b4-setfcap-userns-v10-0-84f6f7faa903@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, Bradley Morgan <brads@mainlining.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1794521317; l=5767;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=pN+dVl/hfA+qMnI14kUgrGQzM5lAeve6StDgdvCYdTE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKTLy8hC6+/9/deEqTY5K0cP+1keUNCXeQBITpMeOW+PE7b+QuRTRFd7xZf5j5QvGBZGs4eC2hj
 jo372E3RVKAw=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A uid 0 task that gave up CAP_SETFCAP and CAP_SYS_PTRACE can still
attach to a task in a user namespace that another root task created,
and have it write file capabilities for its root user.  For a target in
a child namespace cap_ptrace_access_check() asks for CAP_SYS_PTRACE over
that namespace, and cap_capable() grants every capability there to a
task whose euid owns it, whatever it gave up:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP,
  unshare(CLONE_NEWUSER)              no CAP_SYS_PTRACE
                                    ptrace(PTRACE_ATTACH, A)
                                      euid == ns->owner -> allowed
                                    make A write "0 0 1" to its uid_map,
                                    or set file capabilities

The same goes for /proc/<pid>/mem, process_vm_writev() and
pidfd_getfd().  setns() refuses B now, so ptrace is the way left into
the namespace.

The target's own capabilities are no guide.  A target that gave up
CAP_SETFCAP can still get it back from its inheritable set on execve(),
take it from another task of its namespace if it kept CAP_SYS_PTRACE, or
write "0 0 1" to its namespace's uid_map while there is none yet.

Every PTRACE_MODE_ATTACH check is refused, so reading /proc/<pid>/mem,
/proc/<pid>/stack and process_vm_readv() of such a target go too.
PTRACE_MODE_READ, a tracer and target in the same namespace, and targets
in namespaces that setns() lets the tracer into are not affected.
Within one namespace the usual rules apply, as for every other
capability.  A tracer with CAP_SYS_PTRACE but not CAP_SETFCAP is refused
as well: whether CAP_SYS_PTRACE lets it take CAP_SETFCAP from a task of
its own namespace depends on LSMs such as Yama.

Fix by refusing PTRACE_MODE_ATTACH and PTRACE_TRACEME across user
namespaces when the tracer doesn't have CAP_SETFCAP and setns() would
refuse it the target's namespace.

Suggested-by: Serge Hallyn <serge@hallyn.com>
Link: https://lore.kernel.org/all/fd159e68-c613-4c7d-bfba-8af0a3f3a96e@hallyn.com/
Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 99a77fe459e9..c43abf4f148b 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -184,14 +184,31 @@ int cap_settime(const struct timespec64 *ts, const struct timezone *tz)
 	return 0;
 }
 
+/*
+ * A tracer that setns() keeps out of a namespace mustn't take control of a
+ * task there either, whatever that task holds itself: it can get CAP_SETFCAP
+ * back on execve(), from another task of its namespace it traces, or by
+ * writing the uid_map of a namespace that doesn't have one yet.  Within one
+ * namespace the usual rules apply, as for every other capability.
+ */
+static bool cap_ptrace_borrows_setfcap(const struct cred *cred,
+				       const struct cred *child_cred)
+{
+	return cred->user_ns != child_cred->user_ns &&
+	       cred_borrows_setfcap(cred, child_cred->user_ns);
+}
+
 /**
  * cap_ptrace_access_check - Determine whether the current process may access
  *			   another
  * @child: The process to be accessed
  * @mode: The mode of attachment.
  *
- * If we are in the same or an ancestor user_ns and have all the target
- * task's capabilities, then ptrace access is allowed.
+ * For PTRACE_MODE_ATTACH, if we don't have CAP_SETFCAP and the target task
+ * is in another user_ns that setns() would keep us out of, then ptrace
+ * access is denied.
+ * Otherwise, if we are in the same or an ancestor user_ns and have all the
+ * target task's capabilities, then ptrace access is allowed.
  * If we have the ptrace capability to the target user_ns, then ptrace
  * access is allowed.
  * Else denied.
@@ -212,11 +229,15 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
 		caller_caps = &cred->cap_effective;
 	else
 		caller_caps = &cred->cap_permitted;
+	if ((mode & PTRACE_MODE_ATTACH) &&
+	    cap_ptrace_borrows_setfcap(cred, child_cred))
+		goto deny;
 	if (cred->user_ns == child_cred->user_ns &&
 	    cap_issubset(child_cred->cap_permitted, *caller_caps))
 		goto out;
 	if (ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
 		goto out;
+deny:
 	ret = -EPERM;
 out:
 	rcu_read_unlock();
@@ -227,8 +248,10 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
  * cap_ptrace_traceme - Determine whether another process may trace the current
  * @parent: The task proposed to be the tracer
  *
- * If parent is in the same or an ancestor user_ns and has all current's
- * capabilities, then ptrace access is allowed.
+ * If parent doesn't have CAP_SETFCAP and current is in another user_ns
+ * that setns() would keep parent out of, then ptrace access is denied.
+ * Otherwise, if parent is in the same or an ancestor user_ns and has all
+ * current's capabilities, then ptrace access is allowed.
  * If parent has the ptrace capability to current's user_ns, then ptrace
  * access is allowed.
  * Else denied.
@@ -244,11 +267,14 @@ int cap_ptrace_traceme(struct task_struct *parent)
 	rcu_read_lock();
 	cred = __task_cred(parent);
 	child_cred = current_cred();
+	if (cap_ptrace_borrows_setfcap(cred, child_cred))
+		goto deny;
 	if (cred->user_ns == child_cred->user_ns &&
 	    cap_issubset(child_cred->cap_permitted, cred->cap_permitted))
 		goto out;
 	if (has_ns_capability(parent, child_cred->user_ns, CAP_SYS_PTRACE))
 		goto out;
+deny:
 	ret = -EPERM;
 out:
 	rcu_read_unlock();

-- 
2.55.0

