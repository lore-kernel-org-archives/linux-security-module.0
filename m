Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.16.66.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342299;
	b=kNk2DMsrvjTYnVhbBH0owtRiFH6P16c5wwHi9/SvNLU6O6K1XLB3+EIOvasR0BMn/bul
	 xHHzGEBfN9MmeXkHWZfg9gp/U39qMo4m1bLR/TQq/mCVOn7Norxe0xKooD0fuI25RYn/z
	 w4ERl/hVcDC3Hcy715eyf4QPMcaL02Q7Kv/S7IX4OTP46adCzGRZWdgKyaRLf/wpRWxva
	 HB3GRvdJy1Pz6wOwTifpmgltbx+2a3UwO/PgvS7af6xago4Ii7bQXJ1yF2IAdYeZbG2HS
	 b9CsZG/gX8mMwXUoTUI2ks9DiN3g4h2RyKphclzVLCVWS6zlP9Md3gJTO8daIkjLNqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342299;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=y7c4fIL4gSW8PDO5l2OSFy/lYS99kdWGNxYQCXw1evE=;
	b=JNXwskvQFpScpVNRbiryJju3kVgZgYSRVPoBhC8fziuVyYzFHxIq4L8Zw34ltoh4XdKM
	 rTRpZ16AWs169EwjjiM49MdmvzF+F/1vaYds/KHgBknBRgUnk3SW+zVeX9xtvFitzHwCr
	 bkrvF/hHB13d9AjiL5Kk8ptO9UyGIEZNdOn5AuCTyp9WnQHHbzrshQV6z6qqbDNFqoeNd
	 Dy7JRkOd6EISGtwNRFBb2cjzVPVX6LjlD7vsdErREidJ7wDa5oFnF8coLtYii5mZ3C0a0
	 gYTOKjdZUdogtQXez3X7UoKtbx56ArqvHSp7oM0HbeznGZ6P4Isoh17jvja/3c2SZhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b="cEvuAr/u";
	arc=none smtp.remote-ip=84.16.66.175
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9AA60A3822
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D9AA60A3822
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=cEvuAr/u
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPJ6W0MwlzFD9;
	Tue, 10 Nov 2026 21:24:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794342290;
	bh=y7c4fIL4gSW8PDO5l2OSFy/lYS99kdWGNxYQCXw1evE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cEvuAr/u4j+a5dAhjK61qDNq3NYBOZpXuGQdJlK9/7NnFOlfy2syQI7y3lmGtOcvD
	 grDj3mnqzSgc5JJcWgKgD3ThJezBuVcHyfiX99wT7DJiRrVpuJP+xKvlpv1HwjH8mM
	 7d3WeRBIvcv6dMkrIJCttc9sO35/gGmflDCY1+24=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4jPJ6T6K20znbp;
	Tue, 10 Nov 2026 21:24:49 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ada Smith <adasmithgt@gmail.com>,
	Hungyu Lin <dennylin0707@gmail.com>,
	James Morris <jmorris@namei.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 4/6] landlock: Mediate CAP_SYS_ADMIN for the admin memory reserve
Date: Tue, 10 Nov 2026 21:24:32 +0100
Message-ID: <20261110202436.2408244-5-mic@digikod.net>
In-Reply-To: <20261110202436.2408244-1-mic@digikod.net>
References: <20261110202436.2408244-1-mic@digikod.net>
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
Reported-by: Ada Smith <adasmithgt@gmail.com>
Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
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

