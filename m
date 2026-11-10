Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.166.143.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342662;
	b=JN1ig1CNkRrZUoUEZOCB2roNffmMPCJbm5yQ3INmGOHPOjsbnTycPMA1AkKygtQM4cQw
	 VSe/tMi2HKUhS78l6eH/xBmOLYgzkxLHPu7ISpZGQYjhOf0mDeE6N++3wOp/5MvBHMUfE
	 7Zsqr+BXar+mz4yUYoHMGgQF7PyW62j+KIqQXUhp6IXayskZap7TEgR6spetXEIXYTxOL
	 pZtpwf+xwps014o0vpwGJ34rZhXGAoxDcSdsXBDs+nv1v9pbox+/qhe0iNIRGIGYfb7GM
	 hUEASHQmdE25buhaKmlYJw7C5j3crNJonEhg3mVCL8EoomBr2OlSR8YyBlNBzUT2fDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342662;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=SM98pyL04tF+7b6zq1mfi19SPm3b/NbAbRakcCqfmR8=;
	b=XmxCTBHJpJzqJFHE2XQQVABrcLvtlfI74axa1X1o2mogHECXrbJyVhi5kKZGPOIJO7ku
	 qB9iDP4lFXl5S0t2jvrEsqPYpiSwJlwCy+QMx6MOlfQ1Hqka8oHMJRptr3nfZ5+pGULpH
	 hMy6Y7DE6hMhznHtY1ESH5wEmy3WqchBNT1I5hMR0XuVxYfvWE4u3d6BbKmNCfmyainjE
	 vkN/rRv/NU4pfzRq4D6dnuJfADlYK2ywLZpu7Kpiqk0rGOYBJFMQJwR3BHwywGSkW5oV1
	 Uq3IQE9RZEW6lhBdLlNAUr2OlQ7R+vftDJ0wo4ou4o689jx4aTtfwuqHQsa4XJLsi5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=rolKb3HK;
	arc=none smtp.remote-ip=83.166.143.171
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554BE60A2605
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 554BE60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=rolKb3HK
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPJFT6zx7zDjP;
	Tue, 10 Nov 2026 21:30:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794342653;
	bh=SM98pyL04tF+7b6zq1mfi19SPm3b/NbAbRakcCqfmR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rolKb3HKRqO39/Awloed/b8BWTVrX+LlFv0UTgeljSoFELAgAK9EmpYBA6u+3/ipZ
	 U89QZBuMikl4qHhAZ01ueYMjURr2omtc4MgRrm4D+WPwrSnlX7pJG+e+ToNEsGsASZ
	 jcgWTrbEETcfvShDXaloGnWTWqiuU9u2HLdmhVFk=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jPJFS1yXkz1WH;
	Tue, 10 Nov 2026 21:30:52 +0100 (CET)
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
Subject: [PATCH 4/6] smack: Use security_capable_lsm() for privilege checks
Date: Tue, 10 Nov 2026 21:30:38 +0100
Message-ID: <20261110203042.2410140-5-mic@digikod.net>
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

smack_privileged_cred() checks the capabilities that guard Smack policy
(CAP_MAC_ADMIN to change it, CAP_MAC_OVERRIDE to bypass it, and
CAP_SYS_PTRACE for the ptrace rule) with cap_capable() instead of
capable(), so that other stacked LSMs are not asked (see commit
f28e783ff668 ("Smack: Use cap_capable in privilege check")).  This also
lets a process in a Landlock domain that denies these capabilities
manage or bypass Smack policy.

Switch this check to security_capable_lsm(), as for AppArmor in the
previous commit.  The onlycap rule still applies.
smack_privileged_cred() may check another task's credentials (the
tracer's for the ptrace rule, the SIGIO recipient's), and may run in
interrupt context for SIGIO delivery, which the capable_lsm hook allows.

Smack passes CAP_OPT_NONE everywhere, so Landlock logs every denial of
these capabilities like any other capability denial.  This includes the
checks that some Smack hooks make before their label rules (e.g.
smack_syslog(), smack_unix_may_send()): the override is denied, and the
label rules then decide.

Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/smack/smack_access.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index fb85356266e5..7e282e0b716a 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -723,7 +723,8 @@ bool smack_privileged_cred(int cap, const struct cred *cred)
 	struct smack_known_list_elem *sklep;
 	int rc;
 
-	rc = cap_capable(cred, &init_user_ns, cap, CAP_OPT_NONE);
+	rc = security_capable_lsm(cred, &init_user_ns, cap, CAP_OPT_NONE,
+				  LSM_ID_SMACK);
 	if (rc)
 		return false;
 
-- 
2.56.0

