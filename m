Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70382FF675;
	Tue, 28 Jul 2026 03:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208257; cv=none; b=U8rsxB0V/CjoNAMHAKDCVkPOnwKlNRlqU8ZVJLlxcMXSymQfMFxt79XOkEpt5d0dyPY6RIuXM1P8oQImKfcbPRNOCE8nleggK47fY4vyMo7bxoGEpd4tb/3+VV4mASp3xMCc9ety9ggMpigISTmJ8GvxzywJMIx3IJVN6A97qfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208257; c=relaxed/simple;
	bh=zrG1RdNNGSxI9T3yhkH5dV5kNVwg4+sQdxl7ljLH+BY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t78KSFD+xDV3WdtXf+2SY/d4yvCOC/Pk3sgK0W6yyx5ur9YJAOuQytLl22AmkBXegciPuEvBPbS2R1HkTR61WczokZAhp08rWnaMU4ldDRWEaEzxqPZdl/4fv+jelgO/9KH1S6brXPGxt3FGA5nAt8CsA4mxbCn9tQRA8C0WR7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: efba61d68a3111f1aa26b74ffac11d73-20260728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:47ea0dea-bfe5-4d84-b5bd-77b28e6aa841,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:02b4a51e17288904b0765b21b61e8fcb,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898|915,TC:nil,Content:0
	|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: efba61d68a3111f1aa26b74ffac11d73-20260728
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 492294208; Tue, 28 Jul 2026 11:10:50 +0800
From: Minhong He <heminhong@kylinos.cn>
To: Paul Moore <paul@paul-moore.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] netlabel: check register_netdevice_notifier() error in netlbl_unlabel_init()
Date: Tue, 28 Jul 2026 11:10:43 +0800
Message-Id: <20260728031043.76586-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netlbl_unlabel_init() installs the unlabeled connection hash table and
registers a netdevice notifier, but ignores notifier registration errors
and always returns success.

Check the error and unwind the hash table allocation on failure.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 net/netlabel/netlabel_unlabeled.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 47bae5e48db6..34704f6eb1d8 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1397,6 +1397,7 @@ static struct notifier_block netlbl_unlhsh_netdev_notifier = {
  */
 int __init netlbl_unlabel_init(u32 size)
 {
+	int err;
 	u32 iter;
 	struct netlbl_unlhsh_tbl *hsh_tbl;
 
@@ -1419,7 +1420,16 @@ int __init netlbl_unlabel_init(u32 size)
 	rcu_assign_pointer(netlbl_unlhsh, hsh_tbl);
 	spin_unlock(&netlbl_unlhsh_lock);
 
-	register_netdevice_notifier(&netlbl_unlhsh_netdev_notifier);
+	err = register_netdevice_notifier(&netlbl_unlhsh_netdev_notifier);
+	if (err) {
+		spin_lock(&netlbl_unlhsh_lock);
+		RCU_INIT_POINTER(netlbl_unlhsh, NULL);
+		spin_unlock(&netlbl_unlhsh_lock);
+		synchronize_rcu();
+		kfree(hsh_tbl->tbl);
+		kfree(hsh_tbl);
+		return err;
+	}
 
 	return 0;
 }
-- 
2.25.1

