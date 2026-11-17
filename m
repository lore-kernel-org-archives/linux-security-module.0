Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.166.143.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910737;
	b=TDMIbR2u3y1KDr4kgt1BRwYR95yTFF3X16Hm6Yzc3u9d22zy1oE2HM72c6mIStD0Xc5i
	 XsIYyn9jxjlilOZD7LAm5JJ0SUGf07x6jOPByh7N6WKEvuE/YIbx3thdJkMFR7Itp9zqT
	 inaI/tfLK/KUidS9FzlhhjFjsQJ7giLQ5nSSsNaTmueh1gUww6wmhJSZk9mmsltWQMJqp
	 WViIhafydBrj0Uz/9fkDPTHfF3ihoX6PLDSdkSqlr2KzjSCxKFtXfNf99bPj4omNOjPTB
	 Ef2PrCTjoOPxZm9GX14FqQsP5q8jnTxpYf0K2V8kzcfvydMTnNyemS5m399zWQ+w5zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910737;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=SM98pyL04tF+7b6zq1mfi19SPm3b/NbAbRakcCqfmR8=;
	b=voqTrlwXebyDbERB24aLRGnFkIX85mBTMl1Zi59qEqYMlQBOpW+6tlV98Wmros1ZQvbj
	 ohNmcUoM5cPeYrQ+VbhaUtXeZtosdbmWvGuXeO9d6k5EFNVDH+wxIdbsQ3NJJ7eJKV2Mp
	 Bv9ZqP8unSGIANn1uWfK+nzlZMatebkUsz619l5AYbCix3S0T991K5t6amnDqP443LTwM
	 Aj9XYmPdsrpkYgs2TG3pO4zJUCgqK1aP2sSz9H73s8F35J0nULyr11WR1ofIb0NHXFsXR
	 +7dpGed9p1JNRxqcoNXTEQbYBt7nncKn8PiYNhoMKKNbR1eJlfg8AsseV9/bB1irq4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=SjFKGUlu;
	arc=none smtp.remote-ip=83.166.143.170
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5E5606A8A9
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 10:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C5E5606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=SjFKGUlu
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTLL73Qg2z2Nh;
	Tue, 17 Nov 2026 11:18:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794910735;
	bh=SM98pyL04tF+7b6zq1mfi19SPm3b/NbAbRakcCqfmR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SjFKGUluc0mWbdOF7dcy07Hu50NXL7eHjEODgDiTraUHpQeykPnfTkaB6oEDsXDLO
	 6+eInyAxQexu5hO1ODiMqJ24WKVgLTcgJ5vgtl9t1HKW/6k27aRL3ddX6rR/akn2Tu
	 zvRs/68AdtTtLCvwJGBqZLhjhylqsa5WvMxQc15U=
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jTLL61NFLzWnG;
	Tue, 17 Nov 2026 11:18:54 +0100 (CET)
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
Subject: [PATCH v2 4/6] smack: Use security_capable_lsm() for privilege checks
Date: Tue, 17 Nov 2026 11:18:41 +0100
Message-ID: <20261117101845.2523770-5-mic@digikod.net>
In-Reply-To: <20261117101845.2523770-1-mic@digikod.net>
References: <20261117101845.2523770-1-mic@digikod.net>
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

