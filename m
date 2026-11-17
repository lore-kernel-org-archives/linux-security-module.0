Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.25.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910341;
	b=MLmc8kDZmPwoj7cYObX1MGI9W8Lp6kr1aXzRTtzUxcrM8mjW+IsszDI1Pm2HPDuolyHS
	 cP+mrXF71t5muAOrgmf7YxMAVetS7GxgroR/0/IUW0tiguzOZnXr2xMJKM64qKZ6z/x4m
	 0we+W5M/geg0TrfdFb6VGFdSBZ8W2yAjcryRZW8qeHpjZc/6g7i1lYTbvpgregunzDxl+
	 XNdqpDvQWrlkUPflVmHNFLoHNVFwL8z/tp7HlhrcNvCvQBzjFNQsgpUhztOSI7y0thWAY
	 KvtO53bw01xy1xlZct2Hv+mO5gakE3EeG9F5fAcfgg6od//Vuttl6F8ESN+SQPlE64g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910341;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=ALO2l5L3dmnzQe5I0HdYprJvsVUJ+NBqFA+9TSbMvPg=;
	b=aEiKx8SzjzaDOfDAdmuMPOkcEfj5Jv2iykqTKjXvZCZ7/1yNdX49OzGjfwpXWGU15ktL
	 1rBiV4oj9rjAE98dw+Xtyr4Cor3PyNVsVsnWxivlzpjTFBSwo3QW9i80ySMEvD6Ozbu+x
	 Y4zQMa/S4txo+FZGu1jYG5ztdZr4+OauuWPzUpVSMFIv+5Th1/vKbf9bm4Ch5VXB0Grot
	 RAevKtsS8PUAI60LM1NeBO45fGbPhgIhyKBWyKTSe/21rJL/BhUeJnxuTyFU5buCJEe3s
	 DW6li9OZElIDydDV+NwP4I90dAO/O3rf7OfMpJniu+Cw//6LIgnWJUPZSCGb2mENVpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=coh21boW;
	arc=none smtp.remote-ip=185.125.25.14
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C1C606A33F
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 10:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62C1C606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=coh21boW
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTLBP4pqjzv1h;
	Tue, 17 Nov 2026 11:12:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794910333;
	bh=ALO2l5L3dmnzQe5I0HdYprJvsVUJ+NBqFA+9TSbMvPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=coh21boWp9x87MrGcAo5rmkIJU/P8hEyjlwz7ZBI6etDOmj0aZUIHcNp/e3N+PU6D
	 zaA/s/Z9lGko13ASYK8dL0TDI8ZCNzWDI29JUwHHAFpGR7kHbSMdayBS6Bf0T+SRmW
	 SAxOboBqdor/6BAVY+yVFUwbGaI0KMxTbok50M3Y=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jTLBN17c7zCHv;
	Tue, 17 Nov 2026 11:12:12 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ada Smith <adasmithgt@gmail.com>,
	Hungyu Lin <dennylin0707@gmail.com>,
	James Morris <jmorris@namei.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>,
	Serge Hallyn <sergeh@kernel.org>,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 4/6] landlock: Mediate CAP_SYS_ADMIN for the admin memory reserve
Date: Tue, 17 Nov 2026 11:11:54 +0100
Message-ID: <20261117101157.2520463-5-mic@digikod.net>
In-Reply-To: <20261117101157.2520463-1-mic@digikod.net>
References: <20261117101157.2520463-1-mic@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

With vm.overcommit_memory set to 2, __vm_enough_memory() keeps the
vm.admin_reserve_kbytes reserve for callers whose LSMs all agree that
they hold CAP_SYS_ADMIN.  cap_vm_enough_memory() checks it with
cap_capable(), so a process in a domain that denies CAP_SYS_ADMIN could
still use this reserve, which is meant to let an administrator recover
from memory exhaustion.

Add a Landlock vm_enough_memory hook that withholds the reserve when the
domain denies CAP_SYS_ADMIN.  Like commoncap and SELinux, do not audit
this check: it only selects a limit, it runs for every accounted
mapping, and withholding the reserve can only make an allocation fail
with -ENOMEM.  As with the previous hooks, LSMs implement their own
policy in this hook: SELinux already checks CAP_SYS_ADMIN in its own
vm_enough_memory hook, so making commoncap call security_capable() would
make SELinux check it twice.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>
Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://patch.msgid.link/20261110202436.2408244-5-mic@digikod.net
- Add Serge Hallyn's Acked-by.
---
 security/landlock/cap.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/security/landlock/cap.c b/security/landlock/cap.c
index c89e8d76db8c..c9a900888f3b 100644
--- a/security/landlock/cap.c
+++ b/security/landlock/cap.c
@@ -140,10 +140,32 @@ static int hook_mmap_addr(unsigned long addr)
 	return check_cap(current_cred(), CAP_SYS_RAWIO, CAP_OPT_NONE);
 }
 
+/**
+ * hook_vm_enough_memory - Restrict the admin memory reserve
+ *
+ * @mm: Address space being charged (unused).
+ * @pages: Number of pages being charged (unused).
+ *
+ * cap_vm_enough_memory() lets CAP_SYS_ADMIN use the vm.admin_reserve_kbytes
+ * reserve, but calls cap_capable() directly, which skips hook_capable().  Check
+ * the same capability against the domain.  commoncap runs first, so this only
+ * sees tasks that commoncap let use the reserve.  Like commoncap, do not log
+ * denials: this only selects a memory limit.
+ *
+ * Return: 0 if the domain does not withhold the reserve, -EPERM if
+ * CAP_SYS_ADMIN use is denied.  An error does not fail the allocation by
+ * itself, but without the reserve, the allocation may fail with -ENOMEM.
+ */
+static int hook_vm_enough_memory(struct mm_struct *mm, long pages)
+{
+	return check_cap(current_cred(), CAP_SYS_ADMIN, CAP_OPT_NOAUDIT);
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capable, hook_capable),
 	LSM_HOOK_INIT(capset, hook_capset),
 	LSM_HOOK_INIT(mmap_addr, hook_mmap_addr),
+	LSM_HOOK_INIT(vm_enough_memory, hook_vm_enough_memory),
 };
 
 __init void landlock_add_cap_hooks(void)
-- 
2.56.0

