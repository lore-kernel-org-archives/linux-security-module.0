Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522FC37C109
	for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2026 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683177; cv=none; b=PpIK4b/gN/XFmiSFvy6BkW6L8TSqDhyOCIWOevvDeAz41e+klLb6WTFIFbB7rH7lynygT3BHYr5xxw9ONDHSfLO7SCD2PR2M8wNshLyqUlqBa3AaOSTWcmB28S2sVan44x95+aJDq1QUPRx3T2kYH27muhaNKfDx4xPdqYEcF2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683177; c=relaxed/simple;
	bh=Ns+udTpi8SWKloYkKMw8Din2oarGSCfqpMuFm48xRLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jd02+WOowcu6XX5fNMJORv775Y8OSoWgwln5bAOvGWf/cYEC/yB5UgB2fM+bj4SrXnxgEdLEqrbFcKFYXUFX8wN2amMh6Qf2XIUvF8YuRKkPtcf6QJ1+a9jqW0q/oQEh/LZPlxBjnT8UvPSBCMRzL1QlW2eLab5Cmql5oB3IYGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FIny9rHC; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FIny9rHC"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69fec8b4638so2214a12.0
        for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2026 11:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787683175; x=1788287975; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RPvPgg8WrBS502z3EqfWF3DM7etFQasO/Hjw3jKjTbY=;
        b=FIny9rHCeTlRYb6dB/mMb0NboZ3DLg3scK8a+v7Rcfl+NY1ePYlW1uEqPbBNzc/XMZ
         W0JSO8Y9/MZ132kcuz0zr98QgSR295AU3jXrz0TJsshFdpx2j2K/Ht246ttPwpQzksRZ
         7KghSep0qNAxzRCJxpxSag7Dm8mPhNsY+yK3G6GDANRlNFUWhHoFxLujrQQ4nX222SP2
         q6G2aYlrxCuFaA8l8VvtpXbt4Gcenq4FBIN33yFhCY57UnlS/psHhke+HgjMB/iF2og0
         r0scXN6bA5mWRjkBIs5LjfD6PfvUoSc8LMzCPj7HHGbXxIIqExWo5FyDlBDbz/yOyCEX
         NjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787683175; x=1788287975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RPvPgg8WrBS502z3EqfWF3DM7etFQasO/Hjw3jKjTbY=;
        b=l7sRWtqCZ3w0rp6oMJBvNWx9bfItyhKOLkLaLzgDjvFj9mJxL9m6piUgJYCvXqktjT
         dyoPjj/pAaP+jto1rV0ABDtQLQH6UQ3Rhu2t03L2GQ3/VVm4JbblTNSZxbjx1pbBdsuJ
         efGqoEIWN8FXPMcywh4GbDWZ0ZH7/q6wXG+WKIkxRiVJF26Ijb54iAjGI21jHMuTmeVI
         BPovAdgNOr/3vI2cM4KLWA7VB/XQNuyhJj/nOmx+nmKv24u1zQm2CrD9RP2PPjUf5k8U
         fyQfA4+u2HqoBQ5X+mayVoxTlxdIkCt3Ede9Pb+KifZJSF2jc/BaXOYEQRAgGhIuNh7P
         JNew==
X-Forwarded-Encrypted: i=1; AHgh+RrsdlUM0MKvil8tM6Y70f+7AZQDLOBWhYAa5JXBBLcZ2qSWkyO7Ip/BoaC2d4uaVAqmPpYe/kBJs+KP6osE5yAA6RFW410=@vger.kernel.org
X-Gm-Message-State: AFuF++nQvZfzudnlNzwcZkRcFijTznH2BE+AQFVoHKrzseNY+0hOSRsy
	QoK/l0lmU71meZo6ZdqRetPWrkUOL5b1Ur85MZm2l0I13MQ96tEu0ZMJrP1bD45r5g==
X-Gm-Gg: AR+sD12xZ59uMqeN+csXtzKgaIpoA3bNHT8KGVZUFb7sYlzEKU08cMO5sumyHhjMgKM
	UFQMQbMl7+q5vJhYNxbdSnC33LUbX8Ga9Fusej3NxjNugrgDLJ4gG2W/KCcuGqY9Nan2v5Dmg0R
	g2fT2ho6A+mnVFOtwym8EFq+oh9C0CSmgM+dsbwll8CajhPjVDsXtOxkViZuzEXsYZMkYDO0GXz
	+lhRlm8nedh0cCu4xEiGQw97BXQ9I5RKi7FHey8EeViY3snamt007FmQMphDTV7xPbCnBZt7nnc
	bIu7532hSOob5rTErqCJrcA49wW9cGDVOUG5AzKIbmna50aQTc8g0wBTlMm0U4+cVcSSQK+Dk7U
	iCIT2etc6kh7lvWkubFuXyr92HPXAmx7V63RfFtBcOjek96RnOvBPMaurrousNvSTk/MNyaZAza
	kEwRZRNZl5fns45H21NF3nSKHDSJcBdrwDPF4L+Voqj3oPZ9Lq1XuPHuOFJx6biA11MIq+QLLpQ
	zKEK+9Ktkuwt/a2Rll6gslZ24ek9cInj3tsr9GXTk3RQwk=
X-Received: by 2002:a05:6402:2023:b0:67b:7d05:60b8 with SMTP id 4fb4d7f45d1cf-6a5c4a423a0mr72402a12.10.1787683174081;
        Tue, 25 Aug 2026 11:39:34 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:980a:b43:2df6:51f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a702c7asm82067566b.19.2026.08.25.11.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:39:33 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Aug 2026 20:39:19 +0200
Subject: [PATCH v2 3/3] selinux: require PROCESS__PTRACE for FOLL_FORCE
 introspection
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-selinux-pokemem-v2-3-b46bc64916d8@google.com>
References: <20260825-selinux-pokemem-v2-0-b46bc64916d8@google.com>
In-Reply-To: <20260825-selinux-pokemem-v2-0-b46bc64916d8@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jeff Xu <jeffxu@google.com>, 
 =?utf-8?q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787683164; l=2509;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=Ns+udTpi8SWKloYkKMw8Din2oarGSCfqpMuFm48xRLo=;
 b=zeD7wBrHYoqhVh6HblaO+73EuAz1CQeVXst7AZwlAE/ssLvvQw8Ia6UL9q7TkXPnVftUvkutA
 EZh2GLrwyjZCNMAdQM0EcaCQZx1Tr+oTA0Tv+2dWEkEGth/XbX8l9/W
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process can
only create anonymous executable memory via /proc/self/mem if it has
PROCESS__PTRACE (like when using /proc/$pid/mem of another process).

This closes a hole in code integrity enforcement that Project Zero has used
in a remote Android exploit chain:
It was possible to use a memory corruption bug in a service without
EXECMEM/EXECMOD/PTRACE permission to overwrite executable code via
/proc/self/mem, which made it possible to load and run shellcode containing
a kernel exploit.

Signed-off-by: Jann Horn <jannh@google.com>
---
 security/selinux/hooks.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 18dd28b2bb13..2c2c60e9e0fe 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2157,6 +2157,27 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
 			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
 }
 
+/*
+ * Decide whether it should be possible to read non-readable VMAs and write
+ * non-writable VMAs via /proc/self/mem.
+ * This only applies to systems configured with PROC_MEM_FORCE_ALWAYS, and only
+ * triggers on accesses that are not visible to selinux_ptrace_access_check()
+ * because of the introspection exceptions in may_access_mm() and
+ * __ptrace_may_access().
+ *
+ * This allows a process to overwrite read-only code in its own address space.
+ *
+ * Creating an audit record on denial doesn't make sense here, since we can't
+ * tell whether FOLL_FORCE matters for the accessed VMAs.
+ */
+static int selinux_mem_foll_force_opened_by_owner(const struct cred *subject)
+{
+	struct av_decision avd;
+	u32 sid = cred_sid(subject);
+
+	return avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, PROCESS__PTRACE, 0, &avd);
+}
+
 static int selinux_capget(const struct task_struct *target, kernel_cap_t *effective,
 			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
@@ -7558,6 +7579,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
+	LSM_HOOK_INIT(mem_foll_force_opened_by_owner, selinux_mem_foll_force_opened_by_owner),
 	LSM_HOOK_INIT(capget, selinux_capget),
 	LSM_HOOK_INIT(capset, selinux_capset),
 	LSM_HOOK_INIT(capable, selinux_capable),

-- 
2.55.0.860.g4b6b3295ed-goog

