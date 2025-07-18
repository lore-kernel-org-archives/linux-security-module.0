Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AB41D5CE8;
	Fri, 18 Jul 2025 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828462; cv=none; b=fNbDElq+paxTRv2BBady4wu2+7hu+VNn7nzzuB1E74myWDLmb1eaDm4yZRKe2lq3bnKWiAFX82MNTr6NyMLzXhaXAtqZ1aT+UeFdcYcfAK1bPJifdkFyQZFDqxY6BnYExfmPuMFgkLsoyZq5HY+xrv3rcqIRiIPlTfnLgiBm8Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828462; c=relaxed/simple;
	bh=Yq9QXz0Ox7cbIpsb70CwWDGtHtjD0R+7SW0AdUkFj/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tPG9H3wSHKbTFFRs7/poudOULDrjhVjX1NkF8qyG+tM5fAWWZ/9jvXMxJWd7LybNPMQEfD68ID54rarGjoaxqvE0uhOU+6Miyg5Mk2A+y78iHW4Q/SIaTF4tU8fXkVE5ehwc0XhsaEoqbuhDA4DM/Hd8tFn2EfyWJgMJ1YZDqM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=ngGkpEEK; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="ngGkpEEK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q4bpDP16sdxgAoqUdqyHFHkOWXzJgH0nvWgY+I/2VYQ=; b=ngGkpEEKhc4e8r2fTG6OVGqBJC
	5i8FgWvD9kQd5MCupE70Ft+/ORQxHrPNMaVvJN4Cy6LU5pX7dEo6n7F9piEV4AWyMj5iZ0cHA7El5
	NgKPw9uqcizH9zE/8MbUM33BlKIquFUYLIe36LO+4gAldBm+zi3rZB8di2k31ezfj3duW9DzMoD03
	4Wqk076oX1ddXDoNsHcSt6IJ2VrBJJKRxQmYVscQs1R1ChlEwlI+jLF5j9H7uEKVZSq+b7dlR3lSl
	9K8d1E2hph63vGsXM84ZqCyNV2AONnnQTr6BUmGb9UJ8uj2wL/2vet+u7gIdXmexnsnyxwnfM8AG2
	zZm+V/mg==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:16149 helo=archlinux.local)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1ucgkk-00000009z0B-0LNH;
	Fri, 18 Jul 2025 10:47:38 +0200
From: nicolas.bouchinet@oss.cyber.gouv.fr
Date: Fri, 18 Jul 2025 10:47:22 +0200
Subject: [PATCH] lsm: yama: Check for PTRACE_MODE_READ_FSCREDS access
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-yama_fix-v1-1-a51455359e67@ssi.gouv.fr>
X-B4-Tracking: v=1; b=H4sIABkKemgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0ML3crE3MT4tMwK3dRE02SjZJMko7SkVCWg8oKiVKAw2Kjo2NpaAAy
 vx4haAAAA
X-Change-ID: 20250718-yama_fix-ea5c2c4b2fbe
To: Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Olivier Bal-Petre <olivier.bal-petre@oss.cyber.gouv.fr>, 
 Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
X-Mailer: b4 0.14.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

Currently, yama only checks if the `PTRACE_MODE_ATTACH` mode is set
during the `yama_ptrace_access_check()` LSM hook implementation.

In cases of call with the `PTRACE_MODE_READ_FSCREDS` mode, nothing
happens. Thus, yama does not interact properly with the
"hidepid=ptraceable" option.

hidepid's "ptraceable" option being documented as follow :

- hidepid=ptraceable or hidepid=4 means that procfs should only contain
  `/proc/<pid>/` directories that the caller can ptrace.

This patch simply add yama a `PTRACE_MODE_READ_FSCREDS` mode check to
enable an interaction with "hidepid=ptraceable".

Combined with hidepid=ptraceable, the following behaviors will then
happen while reading in `/proc/<pid>`:

- "restricted": A process that has a predefined relationship with the
  inferior will see the inferior process in `/proc`.

- "admin-only": A process that has the CAP_SYS_PTRACE will be able to
  see every processes in `/proc`.

- "no attach": A process will not see anything but itself in
  `/proc/<pid>/`.

It is important to note that the combination of "hidepid=ptraceable" and
yama "no attach" also makes PIDs invisible to root.

No access reports are logged in case of denied access with
`PTRACE_MODE_READ_FSCREDS` to avoid flooding kernel logs.

Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
 security/yama/yama_lsm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 3d064dd4e03f9eaaf5258b37ad05641b35967995..63b589850a88d35dd6a08b23c14ba1a660e6f1b3 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -352,7 +352,7 @@ static int yama_ptrace_access_check(struct task_struct *child,
 	int rc = 0;
 
 	/* require ptrace target be a child of ptracer on attach */
-	if (mode & PTRACE_MODE_ATTACH) {
+	if (mode & (PTRACE_MODE_ATTACH | PTRACE_MODE_READ_FSCREDS)) {
 		switch (ptrace_scope) {
 		case YAMA_SCOPE_DISABLED:
 			/* No additional restrictions. */
@@ -380,7 +380,7 @@ static int yama_ptrace_access_check(struct task_struct *child,
 		}
 	}
 
-	if (rc && (mode & PTRACE_MODE_NOAUDIT) == 0)
+	if (rc && (mode & PTRACE_MODE_NOAUDIT) == 0 && (mode & PTRACE_MODE_ATTACH))
 		report_access("attach", child, current);
 
 	return rc;

---
base-commit: 5d8b97c946777118930e1cfb075cab59a139ca7c
change-id: 20250718-yama_fix-ea5c2c4b2fbe

Best regards,
-- 
Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

