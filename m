Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243D44F30D6;
	Wed, 16 Sep 2026 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559610; cv=none; b=t4rQb6Khb4xmILFWwqE2CSCabq4Hq+7TogWxSXU/E+dgJr+/vrhYGnZsvfy6wCfBKg4e3Vtnxyf5I9s6nMNaYA3mjda5WIBtpkPkv036/oSWmUZhfc7m0Y7bllRw4fCEY10xhuPNcGzhlaD/hjOFyxLpe50mTG6NQCw/hp1SA2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559610; c=relaxed/simple;
	bh=NlO9jCqCwr8FDguvIAbf8yb0HzDUi9hyY+9dUChy9Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K6zzDJHGWlzOUxGv5dj1J8AzN+dr0e23TNtSxzPIQZkmVjD3xPCmuMxyLKBDRhuXwxKMI259vUWRxGX5tPIqEw3DV74jJpRDwG3vt8z3Xq8AkwnWc0dA71dYAcZjMsRL6PV4wQQn9rkrl3eBjtRCTJ30C43cVCf6wI+pMN7du/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=HzxeJAnK; arc=none smtp.client-ip=115.124.28.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="HzxeJAnK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789559588; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=fy/mxmIjJ7w1MoF3yLvzybTgG1U8D7JPb41tBTx98Ww=;
	b=HzxeJAnKg1GvWCCG3eOOrMxSQNoGEfhVtZuHvQGEC5+/skME8vJuiVOlJDQ+StmzCe6V6lz1ZV/Zc5Kwpl3/R+V8St/Qf86gm+hHZwNzGP6YCAe8fatQFnA0cXiWqb/G4Rh4QuVv26AiMcTVajlFY2uWNpnI9w8ihwKmEh/ruI0=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08687898|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0115228-0.000282178-0.988195;FP=4460677476019412727|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jF2DfAu_1789559587;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jF2DfAu_1789559587 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 19:53:08 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: check accept index + 1 is in bounds
Date: Wed, 16 Sep 2026 19:53:07 +0800
Message-ID: <20260916115307.454593-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aa_lookup_condperms() returns perms[index + 1] when an accept entry has
ACCEPT_FLAG_OWNER set and the subject uid does not match the file uid,
so such an entry consumes two slots in the perms table.  But
verify_dfa_accept_index() only checks that index is within the perms
table, so a policy that sets the owner flag on the last entry is
accepted, and the runtime lookup then reads perms[index + 1] one entry
past the end of the table.

The perms table is allocated by unpack_perms_table() with a u16 size
read from the policy blob, so a crafted policy can place the owner flag
at index size - 1 to reach the out-of-bounds read.

Check that index + 1 is also in bounds when the owner flag is set.

Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
Found by code inspection: aa_lookup_condperms() reads perms[index + 1]
for owner-conditional entries, but verify_dfa_accept_index() does not
bound index + 1.

 security/apparmor/policy_unpack.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index f1fc48e72..1ea89e9c5 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1489,6 +1489,15 @@ static bool verify_dfa_accept_index(const struct aa_dfa *dfa, int table_size)
 	for (i = 0; i < dfa->tables[YYTD_ID_ACCEPT]->td_lolen; i++) {
 		if (ACCEPT_TABLE(dfa)[i] >= table_size)
 			return false;
+		/*
+		 * Accept indexes for owner-conditional permissions come in
+		 * pairs, so the non-owner entry at index + 1 must also be
+		 * in bounds.
+		 */
+		if (dfa->tables[YYTD_ID_ACCEPT2] &&
+		    (ACCEPT_TABLE2(dfa)[i] & ACCEPT_FLAG_OWNER) &&
+		    ACCEPT_TABLE(dfa)[i] + 1 >= table_size)
+			return false;
 	}
 	return true;
 }
-- 
2.43.0

