Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A10AD5A
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773792539; cv=none; b=Des3ggCy7Usnh0wC4tto+eWbHF32ndHldbmn2UnHznCMKPhVpYOaVtCTWLnPfR/NplGdtAs/wZxbSH7+7qcET2g3m3t+VwbeO/U/7rrFfgT+7s9JgH5ZNkWwThV5EkH1/jAKmoE5MSjeV7UgkBTZl0uAfkXzhWZgEUhNsd2/zNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773792539; c=relaxed/simple;
	bh=IqCJM3FjwfMNActdutaMiOyRmFhcucmB4ElZwJRaP4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KEY6mjTUI/v5kU/CRLmg0Q5+VaEbE2ZSYof8TL+AHthYyY2y3vTa5mydqkYZDQl1NWSNRtVHzIgUWkRJDumm/+dcndBowTYIhMIxHjMKnl8cljyVgPdMjmS7kStS1XFMtm9GOl5Nyib8cevo0cVUdDsin5Wjgy1WJ4yOp9LsYHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wOviO17u; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wOviO17u"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773792534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pqRHy8JbQicQsBHcZ+eKAi0Ca32HRah2sJYF31zlPKw=;
	b=wOviO17uEOQwip1j+OajqN6gz7c2gw18JxP3Qa3sbnY/3hzSx7kFwEuPzAAiiQeB1v+Bfa
	sN2CVcDMNOFk/D3DnVYpd2AlvqtfhHx6JBGdjoJpuS4yQKanrE46oZxbfXw2cuq1L11F3H
	RQqvPNWNCdMheDYVFdDBYQTE5EzTq8Y=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] apparmor: Use sysfs_emit in param_get_{audit,mode}
Date: Wed, 18 Mar 2026 01:08:00 +0100
Message-ID: <20260318000758.1568-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; i=thorsten.blum@linux.dev; h=from:subject; bh=IqCJM3FjwfMNActdutaMiOyRmFhcucmB4ElZwJRaP4g=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJk739xrD9n35MJmtlqH7weW1ZZz7f7ZGNBwMc8/LNG6V z/4jHxLRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEwkN5KR4SbPOfdZC205rLY/ k3vz7Z35Q+nu2dYMtlynX0hHMinbijD8L1lwWkOZ9U2nV/p7N90v38q2ySkH1n/8tXfxrT7epqI ATgA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace sprintf() with sysfs_emit() in param_get_audit() and
param_get_mode(). sysfs_emit() is preferred for formatting sysfs output
because it provides safer bounds checking.  Add terminating newlines as
suggested by checkpatch.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/apparmor/lsm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index c1d42fc72fdb..cdf19a5e7626 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -17,6 +17,7 @@
 #include <linux/ptrace.h>
 #include <linux/ctype.h>
 #include <linux/sysctl.h>
+#include <linux/sysfs.h>
 #include <linux/audit.h>
 #include <linux/user_namespace.h>
 #include <linux/netfilter_ipv4.h>
@@ -2073,7 +2074,7 @@ static int param_get_audit(char *buffer, const struct kernel_param *kp)
 		return -EINVAL;
 	if (apparmor_initialized && !aa_current_policy_view_capable(NULL))
 		return -EPERM;
-	return sprintf(buffer, "%s", audit_mode_names[aa_g_audit]);
+	return sysfs_emit(buffer, "%s\n", audit_mode_names[aa_g_audit]);
 }
 
 static int param_set_audit(const char *val, const struct kernel_param *kp)
@@ -2101,8 +2102,7 @@ static int param_get_mode(char *buffer, const struct kernel_param *kp)
 		return -EINVAL;
 	if (apparmor_initialized && !aa_current_policy_view_capable(NULL))
 		return -EPERM;
-
-	return sprintf(buffer, "%s", aa_profile_mode_names[aa_g_profile_mode]);
+	return sysfs_emit(buffer, "%s\n", aa_profile_mode_names[aa_g_profile_mode]);
 }
 
 static int param_set_mode(const char *val, const struct kernel_param *kp)
