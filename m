Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771460;
	b=Q3TbwUtuBvfldPxDsc2/AmH4UjthUSEXY72TY1xcMgkPPLg1SYomkS9YD8VINreNGkHo
	 mmtfUaRtuiLQyVBMkEMuzpD/W+4BiamypOSFrkPH7ODa3QemZUatrmnZxCzHgh3JEHsLC
	 fEaILmM/A4u1Vqb06tGWmqQxK3vOrLojy9+lqNtzDmWoLnZdg3Ej9Av/TB2M/h2eVEjYC
	 EYGS8m6w9Yu4XsvyZgMHrXtsTqxZGYV9nf5rVZAhfrPsAjuYx1VdhmHKswtzKmPCsVZvG
	 KuvdMISWrZP9EB2y7+xseZmjlLiqTmlP2FVHCxw4x9LHBJVAmUKRToM8JSBafWopv1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771460;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=mB51IxuF3LEr3pFiFZdoQIrJE8RPv845/UwJgfZGhcw=;
	b=GKwCOGksKO46CdY42ucs8ww1CMvibYzer4HA+vyzHA5FyrnTloqP6veFyKw7q7iaAKes
	 PhBIfOEYgsAET5Kt/Wi16FYt6VH9TFQ6ellpqc7Howu23aP5VwpzBsF/SqEm+rdRI6PMm
	 xp6wQBRo6OsQOza5Bk/LNhzTwN92HAjLal3nhSHDoCqQDaMurukRxF3c/lsuifaOET8Gu
	 6kxL0tD6k+NCO1WWQDSsZTQPnH7Qa4sTZKUYXsxolriwU1kynZ9Uhnm3oYuRRfaalTGpX
	 p8tXAOkeqxz2VUY48tJJsADIjpFuHoLw+lauzaVk3cmqqMN2MtrVorhKR4nPfrt7cGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=eCZ9w4Q4;
	arc=none smtp.remote-ip=220.197.31.7
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF26606A321;
	Fri, 27 Nov 2026 09:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABF26606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=eCZ9w4Q4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mB
	51IxuF3LEr3pFiFZdoQIrJE8RPv845/UwJgfZGhcw=; b=eCZ9w4Q4yAwCLuoOQo
	OktOi8JQdVVOBEK8ms4GE1D3eP2ixfJAySfD+iur68jbRfyCAsIg9AMhvtsqohFV
	5PW/gUQ3SaBHVarn452zARO5nrECPX+x+E3cIf5FnUg0jyHGMlv76aPM0QVurZs2
	eRQKJmWBBrNBEu195QlXTcGrg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3NzAPTAlrktpmEA--.64683S3;
	Fri, 27 Nov 2026 17:23:29 +0800 (CST)
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
Subject: [PATCH net] netlabel: fix duplicate IPv4 entries in the staticlist dump
Date: Fri, 27 Nov 2026 17:23:25 +0800
Message-Id: <20261127092325.3563681-2-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261127092325.3563681-1-xiaolinkui@126.com>
References: <20261127092325.3563681-1-xiaolinkui@126.com>
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
X-CM-TRANSID:_____wD3NzAPTAlrktpmEA--.64683S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFy8WFykXF1xGF1kGFWDtwb_yoW5Jw13pF
	W5J398JF1vqrWrXa93Jr1kurWjya1DGFy7C3WIk3y0yrnxJryaqFy8KrW2qF98uFy8JrZ0
	qrW5Zws8Ww4kWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1Hq7UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlBE0C2sJTBHXKwAA35

From: Linkui Xiao <xiaolinkui@kylinos.cn>

netlbl_unlabel_staticlist() keeps its dump progress in cb->args[]: the
bucket, the offset of the interface in that bucket, and the IPv4 and IPv6
offsets in that interface.  It clears iter_addr4 once the whole IPv4 list
of an interface has been walked, so if the skb fills up while the IPv6
list of the same interface is being dumped, cb->args[2] is saved as zero.
The next round resumes on that interface and dumps its IPv4 entries a
second time, which shows up as duplicated lines in "netlbl_unlabel -l".

This needs an interface that carries both IPv4 and IPv6 static entries and
a configuration large enough for the dump to span more than one netlink
message, but once it does the duplication is reproducible on every dump.

Clear both address counters when an interface is started instead of when
it is finished.  The skip counters still have to be cleared only after
their own list has been walked in full, otherwise the offset saved for the
interface where the previous dump stopped would also be applied to the
interfaces that follow it.

netlbl_unlabel_staticlistdef() dumps a single interface and never resets
these counters, so it is not affected.

Fixes: 866358ec331f ("netlabel: fix our progress tracking in netlbl_unlabel_staticlist()")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 net/netlabel/netlabel_unlabeled.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index d73c27b0c9d0..a5ebb8872946 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1171,6 +1171,12 @@ static int netlbl_unlabel_staticlist(struct sk_buff *skb,
 			if (!iface->valid ||
 			    iter_chain++ < skip_chain)
 				continue;
+			/* Restart the address counters for this interface, the
+			 * skip counters stay until their own list has been
+			 * walked in full.
+			 */
+			iter_addr4 = 0;
+			iter_addr6 = 0;
 			netlbl_af4list_foreach_rcu(addr4,
 						   &iface->addr4_list) {
 				if (iter_addr4++ < skip_addr4)
@@ -1186,7 +1192,6 @@ static int netlbl_unlabel_staticlist(struct sk_buff *skb,
 					goto unlabel_staticlist_return;
 				}
 			}
-			iter_addr4 = 0;
 			skip_addr4 = 0;
 #if IS_ENABLED(CONFIG_IPV6)
 			netlbl_af6list_foreach_rcu(addr6,
@@ -1204,7 +1209,6 @@ static int netlbl_unlabel_staticlist(struct sk_buff *skb,
 					goto unlabel_staticlist_return;
 				}
 			}
-			iter_addr6 = 0;
 			skip_addr6 = 0;
 #endif /* IPv6 */
 		}
-- 
2.25.1

