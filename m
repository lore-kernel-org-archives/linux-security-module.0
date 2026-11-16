Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.108.3.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794795753;
	b=Z1DFVe+rYIhRJ/155cm9RfVT78omj2gKBPrUNhnsd9xJeXSytWMAGltdbhlouqGg5aEW
	 Tc22QmrxOiyughqagsEkdCLNYQEC4U6x22E6z62Skiuan8A2S6eO5gItmqM7aOi6Aa3bf
	 z6olAwtzxkOIZioG5RRETkGRdRFsGJB03pDatf9GXt3U+pdtmV+00Gsqw8eiW/Zjn2rac
	 N0T6SAnxr2242qNMasAEe8aRHNQaIJxhZXf10zqjztzSHpV4hJrpHq6PmOkTLDOKq7Iy9
	 s+g5/z/4aeQCO277nQ4QR6jH3feE5B6aQ2uEAI3Emgnc5trTuUPUX/Adqz9RrqS6YcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794795753;
	h=DMARC-Filter:DKIM-Signature:X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:
	 X-SMAIL-MID:X-SMAIL-UIID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RtW2dBjA1dd0k2AQ1XupmFm+SRcYM/xk80j+fcFlJmc=;
	b=oFFQoCJES/yACU8NFMqgPKJZrycBWM5PILA5oYu/ZT4OlgfcemAmtid4lDZm8hMQQgGS
	 IbW2okQPVjU3nzFifZbM9r6J/DakuDl1YIhH31zCXyjhW0WUIXds3L6J4k3cyd/uge25j
	 DBpaItc8TYA5Hz6NO67MPYYHsedpN5qhYjMv1nrUgpq7fTssV8w2sshvRQbFvXDEt3HIr
	 Ug5kPkhb1kNy4LXd27821bPZMC5jFWyygVShfxCTT92jIj9l4htPP0G9/u6lzLWDjuywy
	 R5P9ScFa7dus5cLAwa0f1l4d4S4imlB1kDCqZlbENDKdgzlVyHltktX/e9sLMMwdOEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sina.com;
	spf=pass smtp.mailfrom=sina.com;
	dkim=pass header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=MFPWEahS;
	arc=none smtp.remote-ip=202.108.3.11
Received: from r3-11.sinamail.sina.com.cn (r3-11.sinamail.sina.com.cn [202.108.3.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5C3606A31C
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 02:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E5C3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=MFPWEahS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1794795751;
	bh=RtW2dBjA1dd0k2AQ1XupmFm+SRcYM/xk80j+fcFlJmc=;
	h=From:Subject:Date:Message-ID;
	b=MFPWEahS9tGGsxdWlQCBIXwf6P28Eu2OxsmoSUxPLDFjVv94shjkw7wLFrCcniZrx
	 vCI2xw05JHS46Qd28D7mnP5hMvGa1fgjmefmBOkxyaBLQhaTT/+vCgNGkuv851qSz6
	 yE5kFJaP2GCrt54FiMqtg52GUce/amRaiok879bE=
X-SMAIL-HELO: kylin-pc
Received: from unknown (HELO kylin-pc)([221.217.162.53])
	by sina.com (10.54.253.34) with ESMTP
	id 6AFA68D7000026B1; Mon, 16 Nov 2026 10:22:21 +0800 (CST)
X-Sender: sig_cloudnative@sina.com
X-Auth-ID: sig_cloudnative@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=sig_cloudnative@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=sig_cloudnative@sina.com
X-SMAIL-MID: 3128166292008
X-SMAIL-UIID: 1DC55D182FFA4024BC60BBFB87EF7576-20261116-102221-1
From: sig_cloudnative@sina.com
To: John Johansen <john.johansen@canonical.com>,
	apparmor@lists.ubuntu.com
Cc: Georgia Garcia <georgia.garcia@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xu Chen <chenxu@kylinos.cn>
Subject: [PATCH 1/3] apparmor: fix capability chunk walk in aa_profile_capget()
Date: Mon, 16 Nov 2026 10:22:05 +0800
Message-ID: <20261116022206.174459-1-sig_cloudnative@sina.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Chen <chenxu@kylinos.cn>

aa_profile_capget() rebuilds the kernel capability set that a profile
allows from the policy dfa.  Capabilities are broken into 32 bit
permission chunks with one dfa transition per chunk, but the loop that
walks the chunks stops before the last chunk, CAP_LAST_CAP >> 5, and the
chunk permissions are shifted by i * 5 instead of by the chunk width of
32 bits.

The permissions of the chunk holding the highest capabilities are thus
never read, and fixing only the loop bound would place them in the wrong
bits.  The capability set used by apparmor_capget() to intersect the
capabilities reported for a task is therefore wrong: capabilities the
profile allows are reported as missing, so for example a task confined by
a profile that allows CAP_PERFMON or CAP_CHECKPOINT_RESTORE sees them
dropped from its effective and permitted sets.

Walk all chunks up to and including CAP_LAST_CAP >> 5 and shift each
chunk by 32 bits.

Fixes: ce9e3b3fa25a ("apparmor: add ability to mediate caps with policy state machine")
Signed-off-by: Xu Chen <chenxu@kylinos.cn>
---
 security/apparmor/capability.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/apparmor/capability.c b/security/apparmor/capability.c
index 2f3c6c84358d..14f9e0f87f51 100644
--- a/security/apparmor/capability.c
+++ b/security/apparmor/capability.c
@@ -201,16 +201,16 @@ kernel_cap_t aa_profile_capget(const struct aa_profile *profile)
 		kernel_cap_t caps = CAP_EMPTY_SET;
 		int i;
 
-		/* caps broken into up to 256, 32 bit permission chunks */
-		for (i = 0; i < (CAP_LAST_CAP >> 5); i++) {
+		/* caps are broken into 32 bit permission chunks */
+		for (i = 0; i <= (CAP_LAST_CAP >> 5); i++) {
 			struct aa_perms perms = { };
 			aa_state_t tmp;
 
 			tmp = aa_dfa_next(rules->policy->dfa, state, i);
 			perms = *aa_lookup_perms(rules->policy, tmp);
 			aa_apply_modes_to_perms(profile, &perms);
-			caps.val |= ((u64)(perms.allow)) << (i * 5);
-			caps.val |= ((u64)(perms.complain)) << (i * 5);
+			caps.val |= ((u64)(perms.allow)) << (i * 32);
+			caps.val |= ((u64)(perms.complain)) << (i * 32);
 		}
 		return caps;
 	}

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.56.1

