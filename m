Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.16.66.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342652;
	b=loBKN/1bLy7W+Zz10P5qbUCWU4dc6WpWaJwoWM7W1Ooyp74G8OANJkcA7Oow7ZpXgYh8
	 PnJSNvfCZO1e7iB6cW2NFa7ZI4A9XBZi1IBh0b8M2Z9bHm/UyR7hJ3n0+S+ZG+t3tmKIh
	 sRw9WnnhYVDKbhmV0yAJg5sx+AcAFHnnclRg8al2CB4oxNYEghBisOX4V2THt4nK397Cj
	 tKLCzwrneETS/qeYCM0T/OeCn9va0P6CJ/P7bPfh/Sd9/qMPSSwDpzoUcOiPlAy3TitUo
	 Q4aDFP60n7Dexmjf8eFgXO6mzr4+CnDNjL0Tk/AqnpkQ6hoJldyrXg2n0xV9KgYij8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342652;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=SLTuo8Bf8VesaAkT6DczV4E9wggKp8EAHDqnPASoGtA=;
	b=cznRvQGNJeshKa06bvyj4h4MkwJYxyGcdx0BZeknhPzSsQt3vIenFcjdXQABSZ/7iN/G
	 Eni6cn83AoxSF+hCtpBzVQ1EkIAoAa3MyzTmwor/tqAC3i2N7uctErw5Bft/WsDSlH0gY
	 cuRirYiLVzWxJoDOxhvt8I/z44rFWY31hhzs2C7G+LhLrSDU3iwQFBbPmNrdpRTazqvOA
	 c9mGTOR6GQ7WXOl6Pzdd8D6H/wurDdTMDdi1QfhJOaGtxsGF9QZ3jor6JP3Ds3MQMy32C
	 U+LINAC+9rJWs1+ygODShJCAgFio1K8RjGMVB0KjtvcsLEV7xWEULufdCPshyGu2OvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=smJhIW3Z;
	arc=none smtp.remote-ip=84.16.66.169
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD591606A33D
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD591606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=smJhIW3Z
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPJFQ34JbzGWD;
	Tue, 10 Nov 2026 21:30:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794342650;
	bh=SLTuo8Bf8VesaAkT6DczV4E9wggKp8EAHDqnPASoGtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=smJhIW3ZiKdcSt4kr0Z4Nr3AHa2wf7l+F+SUlwNRZg1toAtSo1Zw35GwKCmVWnDC4
	 bmBKoGh55a0w4d/GAgxCJ0vlek9GdMfSQiKwjbWbDJSEQlo7ViX/1yV0iqm2Y17J8E
	 pQNvy4Xb/7ts4BXdHXMt+73mNuAQPA9Ukel1kJLA=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4jPJFN6pDRzxBr;
	Tue, 10 Nov 2026 21:30:48 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Casey Schaufler <casey@schaufler-ca.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	James Morris <jmorris@namei.org>,
	John Johansen <john.johansen@canonical.com>,
	=?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH 2/6] landlock: Restrict capabilities guarding other LSMs' policies
Date: Tue, 10 Nov 2026 21:30:36 +0100
Message-ID: <20261110203042.2410140-3-mic@digikod.net>
In-Reply-To: <20261110203042.2410140-1-mic@digikod.net>
References: <20261110203042.2410140-1-mic@digikod.net>
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

A process in a domain that denies CAP_MAC_ADMIN or CAP_MAC_OVERRIDE
could still use them for AppArmor, Smack or SELinux policy, and
CAP_SYS_PTRACE for Smack's ptrace rule, because these LSMs check them
with cap_capable() instead of capable().

Implement the capable_lsm hook with the same check as the capable hook,
so that such capability uses are restricted like any other.  The
following commits switch these LSMs to security_capable_lsm().

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>
Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/cap.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/security/landlock/cap.c b/security/landlock/cap.c
index c9a900888f3b..162edf689f29 100644
--- a/security/landlock/cap.c
+++ b/security/landlock/cap.c
@@ -91,6 +91,28 @@ static int hook_capable(const struct cred *cred, struct user_namespace *ns,
 	return check_cap(cred, cap, opts);
 }
 
+/**
+ * hook_capable_lsm - Deny capabilities guarding another LSM's policy
+ *
+ * @cred: Credentials being checked.
+ * @ns: Target user namespace (intentionally ignored, see hook_capable()).
+ * @cap: Capability number (CAP_*).
+ * @opts: Capability check options, see check_cap().
+ * @lsm_id: LSM_ID_* of the LSM whose policy @cap guards (unused: Landlock does
+ *          not call security_capable_lsm()).
+ *
+ * Other LSMs check the capabilities that guard their own policy (e.g.
+ * CAP_MAC_ADMIN) with security_capable_lsm() instead of capable().  Restrict
+ * them like any other capability use.
+ *
+ * Return: 0 if allowed, -EPERM if capability use is denied.
+ */
+static int hook_capable_lsm(const struct cred *cred, struct user_namespace *ns,
+			    int cap, unsigned int opts, u64 lsm_id)
+{
+	return check_cap(cred, cap, opts);
+}
+
 /**
  * hook_capset - Restrict inheritable capability changes
  *
@@ -163,6 +185,7 @@ static int hook_vm_enough_memory(struct mm_struct *mm, long pages)
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capable, hook_capable),
+	LSM_HOOK_INIT(capable_lsm, hook_capable_lsm),
 	LSM_HOOK_INIT(capset, hook_capset),
 	LSM_HOOK_INIT(mmap_addr, hook_mmap_addr),
 	LSM_HOOK_INIT(vm_enough_memory, hook_vm_enough_memory),
-- 
2.56.0

