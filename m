Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771459;
	b=R1CKzt/G61e0hsfIrr9trhFP716eWxJ+W5kLyGsm4HA88mpURWQhxtPFSUeqdVfnPJpe
	 z0j7VuYVYiErPOXQTyild1j+5kmW0il/psVw9sEBFJ4iGZtxiwFGAAref2ZDmJeh7tBoi
	 Zx1RRHaRH6Dv+wVEOOPJYE+TXqsDFLl/6rMo9oG4M4go6fIMd4k3RaWV0kCGQD7dovn+S
	 6bEpbk7y3ql12inwcTgyX2FxZ1SDoI+nrPak8x4s3sGfEK49qwh+7/ORaticjfhq7Ka/1
	 cO3TEOF9eCc5mSj3+kjhQJRnSpSLO9KKUJ3KVGLvHuaStmMQWsCbskcYSi3v+jazLpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771459;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=7ty1iZfjrQRaq0ygLizQ45rXD2THgByLVqAbfFxEQJg=;
	b=ZN02c6pOaYNDRUYDD7M5qVNvY2qvy4l/KCcnGjHa1I8n+ZIGSfLon9JSSIiNXZI984GA
	 fhA3kxie2ji9eREiZUXvQK/JqChaqkzFnvHE+dvXKwlQ3ANWPSYkxeQEo4PmF/uMJIckQ
	 th847GRTOd1J+CmBPQgk4J/rhg7GlPnOORuzDBxUa0bCQbGkyO/IIUxlDaQnZHnyJg7eY
	 SPHeZ0tfyEsAOGHVOnUuw0pgG3hywea/DR62JOXBVxIVcXoWtS7gdo9boLqRofuerYGT3
	 NKerau6hdojVoBULiwPku4B0eH/vsdjyZFXwxTF4RSbxOQbVmQ4OLLmET5zfPIVgjqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b="IE/YnoAq";
	arc=none smtp.remote-ip=117.135.210.7
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0366C606A32E;
	Fri, 27 Nov 2026 09:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0366C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=IE/YnoAq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=7t
	y1iZfjrQRaq0ygLizQ45rXD2THgByLVqAbfFxEQJg=; b=IE/YnoAqLf4H1iGFua
	kEGA15gVI4wuOCjx1ToGPtkbsqq2ojIZVMqFC5SWuk6/sEbMYqK9HMYDm+hCpg3z
	crB8SyT01X5F+Bgnc4BDCcjYIeo1qOBVMMAEdzj2ziyjJyXzA+AqMeGY3cOgX5tA
	wuhvNmcY6MuhvMYQwXgq38jR0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3NzAPTAlrktpmEA--.64683S2;
	Fri, 27 Nov 2026 17:23:27 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: Paul Moore <paul@paul-moore.com>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH net] netlabel: fix a race in netlbl_unlhsh_condremove_iface()
Date: Fri, 27 Nov 2026 17:23:24 +0800
Message-Id: <20261127092325.3563681-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wD3NzAPTAlrktpmEA--.64683S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF1kWw1kXF45KF4xXryrJFb_yoW8tr1kpr
	y2qrnYkrykX3sIqa92vF4UGrW0va1UCFWUCr1Sk34FyFs8Xr13ZFyUGa9rZa45ZFs7JFZ8
	JFWUXws8Ww48WFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULFxUUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQ8zCmsJTA8GYwAA3b

From: Linkui Xiao <xiaolinkui@kylinos.cn>

netlbl_unlhsh_condremove_iface() unlinks an interface entry and queues it
for freeing without checking ->valid, so it can do both a second time for
an entry that somebody else has already removed.

netlbl_unlhsh_remove() looks the entry up under RCU, drops the lock,
removes the address entry and only then calls condremove_iface().  If a
NETDEV_DOWN notifier runs in between it takes netlbl_unlhsh_lock, clears
->valid and does list_del_rcu() plus call_rcu() on the same entry, and
nothing serialises the notifier against a STATICREMOVE doit, which only
holds genl_lock.  The second list_del_rcu() then dereferences the
LIST_POISON2 that the first one left in ->prev, and the second call_rcu()
queues an rcu_head that is already queued, so the entry is freed twice.

The default entry can hit the same thing without any notifier: smackfs
reaches netlbl_unlhsh_remove() through netlbl_cfg_unlbl_static_del() and
is not serialised against a concurrent STATICREMOVEDEF, so two callers can
each remove one address from the same entry and both find it empty.

Check ->valid before unlinking, the way netlbl_unlhsh_netdev_handler() and
netlbl_domhsh_remove_entry() already do.  Everything that invalidates an
entry does so under netlbl_unlhsh_lock, so the check is reliable.

Fixes: 8cc44579d1bd ("NetLabel: Introduce static network labels for unlabeled connections")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 net/netlabel/netlabel_unlabeled.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 47bae5e48db6..d73c27b0c9d0 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -582,6 +582,8 @@ static void netlbl_unlhsh_condremove_iface(struct netlbl_unlhsh_iface *iface)
 #endif /* IPv6 */
 
 	spin_lock(&netlbl_unlhsh_lock);
+	if (!iface->valid)
+		goto unlhsh_condremove_failure;
 	netlbl_af4list_foreach_rcu(iter4, &iface->addr4_list)
 		goto unlhsh_condremove_failure;
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.25.1

