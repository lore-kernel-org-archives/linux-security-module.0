Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D4F175A96
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 00:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773793353; cv=none; b=ab8FwO0B1bM7xSiw/KT9haFwrTx4C4vj3Ac0/KCE+kqAEOKy4jnaPDRsFG9d1zrOUJSBR6cS/7PczWiwSEg8aa3L3vxPStYYAMDdhZV9C7JKtlPDMHynX1x9a5TW+tfsY5gNKTYiHzCtrD67qxja8TmPzfw0XjBqxmBMXw5API4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773793353; c=relaxed/simple;
	bh=Cfqb+dT+sV7Drhf0B62x56MjyNJAVQHkRuZsqES+AAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VBCQDMIbaXPpsjiL2fLELWl3XRwCEOfUe4vhYP1hx3DVgBKGE0A5DmTHKQMuYmP91s9a+dFDtronQIPVFfaPuWS6+fUCrxt0hWXngVJRClJJTHOIye9K/8ZBdl03mLXTOTnKeXbqQWY73cyyVKHHxHxI92UKl1z1svCgHCSyAJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KUcn6oU7; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KUcn6oU7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773793340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LYrTWkMGCKrpA8IrsJjMpH8fxJVD7iCjwytC6Lqm7Gw=;
	b=KUcn6oU7qb52hbAcj3i7M+X/dJDQ1QuCRHTKI7yGIOd04Qijqw/QyyDUjnNIx9MfSNtcz6
	TxoXDZSCGVQDe06lKBCHl8T87OvsFJFchxcmEHtVeR+LWZ6py8bsMNojmThvrOTL+OsctT
	fUzeA7AZj1ez5TGwTdQzZcn2y/hakFY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] apparmor: Remove redundant if check in sk_peer_get_label
Date: Wed, 18 Mar 2026 01:21:42 +0100
Message-ID: <20260318002141.3362-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=thorsten.blum@linux.dev; h=from:subject; bh=Cfqb+dT+sV7Drhf0B62x56MjyNJAVQHkRuZsqES+AAU=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJk7P4jWnNSeOWlS+5SzjLbvOn58UpzSu6uMTUT/Dff3/ 1sbljT1dJSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBEWiwZGWYcevJNYotPxrzX UVyp6wwbixzum519vWbeZ9Ubni5dRXsZ/sq+9TAJO3p+s5TntIUR2zbpz70Y/MDrZ+096+rDrI8 +5bIDAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove the redundant if check in sk_peer_get_label() and return
ERR_PTR(-ENOPROTOOPT) directly.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/apparmor/lsm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index c1d42fc72fdb..f7bcfed40222 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1528,15 +1528,11 @@ static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 static struct aa_label *sk_peer_get_label(struct sock *sk)
 {
 	struct aa_sk_ctx *ctx = aa_sock(sk);
-	struct aa_label *label = ERR_PTR(-ENOPROTOOPT);
 
 	if (rcu_access_pointer(ctx->peer))
 		return aa_get_label_rcu(&ctx->peer);
 
-	if (sk->sk_family != PF_UNIX)
-		return ERR_PTR(-ENOPROTOOPT);
-
-	return label;
+	return ERR_PTR(-ENOPROTOOPT);
 }
 
 /**
