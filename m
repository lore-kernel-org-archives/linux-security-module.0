Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB09729BD91
	for <linux-security-module@vger.kernel.org>; Wed,  4 Feb 2026 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770242890; cv=none; b=HZUeJgHSfgWEh/NJwMwWMhZo75lioPUhKnWsaJcNqv7vBYA0dCbSm+lUsC5FoNlMAT0MVDDoopsPcGH9X8+RK43yrpHUvc9APZv4wxH6FqXB1Bc9wTZPI+6Iew1VWxAIY8B8O+Mdh577Mc2q8GEF+NhyZPMKwCKLRzJbLN0Uuhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770242890; c=relaxed/simple;
	bh=647rGwjOXpJwhyN1vJ2yZKJed42sXu2X52KTrViuaug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kpp/rOEp3i8ZZ3R1Z02WkkHUsZsYcgnOhxrPGKZWeqd94TP7J4vzZItCxQtcTCHla42GkkoI8jkyfE6Xr+sxqoIbRB0F5b6e3gaVY8FUynvXh11+yJRa9fgj/PV83n6ri1jpNsLmXkbszCrwrY67xuGxqMfa5h8tMh99/lUhZJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C0pl4jKc; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C0pl4jKc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770242877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CMdWLbGopHdmAWXfApiWvJeoEIG/Kf/gE4BeKnetrTY=;
	b=C0pl4jKc5TrcFulz/iNhVam2ArH1y1QJMpDibw8I8opH4NSDNXPOkLjczA3FwzecMchazS
	Bg6ZJchZqFkZaP2ESc6UAlQmuuuEdjNlctAe9gzQwx4ozVp5yVqlm97Y/PyYW6ey4mnqdJ
	lppFt7hbqSIt7JYrYTFEyAjoFpuTvPo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: Remove redundant if check in sk_peer_get_label
Date: Wed,  4 Feb 2026 23:07:35 +0100
Message-ID: <20260204220734.1008069-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove the redundant if check in sk_peer_get_label() and return
ERR_PTR(-ENOPROTOOPT) directly.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/apparmor/lsm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index a87cd60ed206..54343f7c96a4 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1536,15 +1536,11 @@ static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

