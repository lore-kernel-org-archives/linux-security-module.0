Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACFE3B1B4
	for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776059545; cv=none; b=o/4bnx3OTPZx/njpbxkKu92YP+dLVcU9Ysdfzg1qUQrlBmq+VuHtilPjgoXhwCMGQ+TzT3M3JnM0kOOcRYXML5yv7Nt5BdHacKCzQv8KIoRsxA1KBhrmiUI1hrod2jkhbQIpWapb2zlH7LWHTJL+jgRIDbTyknEkdLUC7TxxAlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776059545; c=relaxed/simple;
	bh=hbr4ISGYDvR+f+i1OHR7sMhihtm8mo7YB2xFtr5I128=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QvzIRkuWc9Ubhwlf8dJgkU8xd32wA3wDMaSB/h7fNxVmNBdb8X0gngMA7N30hEAzzWX7GMgj27ry1WFpdwNYMJlGTZ3+iBbESKls2xVjSGMsa4U3bGZNFIN7eYkFrfdQz99e9m97YcBn3K7fImbqBAKKVDKQhGTgYre/sKMtYkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=yN/EXui/; arc=none smtp.client-ip=120.232.169.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="yN/EXui/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=yN/EXui/XoPBwWoSIJyBLc8rUk1D+tEDg+++v1AvBW2H1wB9vntmbdGO0TP6DYaGighSgdJmegcVC
	 ucHo7vJO+6lTLoWqSarwI5mskxNtgQIa5PyCmKVXIoVy0/5RxSOg3JT9AUvuS+Fu83hvPoo2/dTw76
	 c4Ao2JYQdm1Maj58=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-33-12047 (RichMail) with SMTP id 2f0f69dc83c3027-00028;
	Mon, 13 Apr 2026 13:48:55 +0800 (CST)
X-RM-TRANSID:2f0f69dc83c3027-00028
From: Li hongliang <1468888505@139.com>
To: massimiliano.pellizzer@canonical.com
Cc: john.johansen@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	qsa@qualys.com,
	carnil@debian.org,
	georgia.garcia@canonical.com,
	cengiz.can@canonical.com
Subject: [PATCH 6.1.y] apparmor: fix memory leak in verify_header
Date: Mon, 13 Apr 2026 13:48:53 +0800
Message-Id: <20260413054853.2244655-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>

[ Upstream commit e38c55d9f834e5b848bfed0f5c586aaf45acb825 ]

The function sets `*ns = NULL` on every call, leaking the namespace
string allocated in previous iterations when multiple profiles are
unpacked. This also breaks namespace consistency checking since *ns
is always NULL when the comparison is made.

Remove the incorrect assignment.
The caller (aa_unpack) initializes *ns to NULL once before the loop,
which is sufficient.

Fixes: dd51c8485763 ("apparmor: provide base for multiple profiles to be replaced at once")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Li hongliang <1468888505@139.com>
---
 security/apparmor/policy_unpack.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 17601235ff98..22cc968a01fc 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -942,7 +942,6 @@ static int verify_header(struct aa_ext *e, int required, const char **ns)
 {
 	int error = -EPROTONOSUPPORT;
 	const char *name = NULL;
-	*ns = NULL;
 
 	/* get the interface version */
 	if (!aa_unpack_u32(e, &e->version, "version")) {
-- 
2.34.1


