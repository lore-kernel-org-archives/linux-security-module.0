Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193194;
	b=0geUADlWAUJU4MZW0zrj4ukHPIExTh80bG6JoUpG6kSjHNTeIjGFrMHoj7SGaXhA4mMi
	 nGmw4xhPl9XL0kZ7jscXTrXkAwLSkXhx/ah1OCNU3CxzSNCjrnnBmQsuL4SxKMqzx0D5r
	 tK43H96N2fswD9R+yr4ED26ijsEgcHsmnNU0ktFEHmZDG3KK1chvUcA8pQENX506KtJ+s
	 qCWFIsuoXwvlS3+1lQ4XriO9GrfeNAXb2Z9Oo/vgUqGjDvJdUrP8Lh0H5sMSOFPeMh98X
	 ezItBpMdFACSmqoofxgwL1Fb0Yqca/MEnpewC3M4GxPg2rJPfLjwqtT9MOkS/tcCpxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193194;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UezxR/RVhvOuKMLfKYFtEXdNaCdMZDx1R+ftmuecF3o=;
	b=Te8rAbVs29Q/6+og9xFOKys7UK5t8z/vxff6bQ0HNA3v6ox8WZD89vxx9Y95S1+u3nN8
	 STKq+6QXqZ/OM77T1b3hvxaOf5xcwx5l+QhImaJGX7k+TlN5pLhqXwTmHWKnXpQNTzIqV
	 CEGXqhKb0OR7dp2SAFruoWXvYMspKBauUmb1n4GGsuN2hG0FSdGw2hnSPG4cdwT1vs1q1
	 5xIABRqJBhfw/CZCURAxiWRmRAh3VHKdYqVwkAW2poQLIk4nwFPfRP600ig+lyCbaD4/v
	 jVRpwoxwdCa6470GbfsQJQebbtsmtW44TUvYY28oPWFpfp0YV6MmU3dKQRzLt75EOog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MoPa0baO;
	arc=none smtp.remote-ip=95.215.58.225
Received: from mta1.migadu.com (out-225.mta1.migadu.com [95.215.58.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304F2606A320
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 02:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 304F2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MoPa0baO
X-Envelope-To: linux-security-module@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wx43d8n0K+8YSmZ04mpxkSU8au8Gzn0GNnkK1AtjfNw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794193192; v=1; x=1794797992;
 b=MoPa0baOVxNIrfh9CrrfPmCMAMIBoUMHjj7mObHSlKRGquE4KgSzpsPSSjycYUCbHcn2S2LK
 lVK/v/fc2+Pul9bBumA+D660lPoX4LNd1zXWsOTFxjSHIrpC0JFdH4FiWSWr5NdMiGowJToXxHe
 vU0xfxL3UXua3ZBHCwjt3CJA=
X-Envelope-To: linux-security-module@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e327f1cd4dbd98e8;
	Mon, 09 Nov 2026 02:59:51 +0000
X-Mizu-Trace-ID: e327f1cd4dbd98e8
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Paul Moore <paul@paul-moore.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Julian Anastasov <ja@ssi.bg>,
	Allison Henderson <achender@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-security-module@vger.kernel.org,
	mptcp@lists.linux.dev,
	lvs-devel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-sctp@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH net-next 11/14] ipvs: annotate data-races around lblc_expiration and lblcr_expiration
Date: Mon,  9 Nov 2026 10:52:10 +0800
Message-ID: <20261109025425.328445-12-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109025425.328445-1-jiayuan.chen@linux.dev>
References: <20261109025425.328445-1-jiayuan.chen@linux.dev>
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

sysctl_lblc_expiration and sysctl_lblcr_expiration are read without any
lock while their sysctl handlers update them with WRITE_ONCE(). Add
READ_ONCE() to the readers.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/netfilter/ipvs/ip_vs_lblc.c  | 2 +-
 net/netfilter/ipvs/ip_vs_lblcr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
index e1111c3b27211..21bb820e02914 100644
--- a/net/netfilter/ipvs/ip_vs_lblc.c
+++ b/net/netfilter/ipvs/ip_vs_lblc.c
@@ -249,7 +249,7 @@ static void ip_vs_lblc_flush(struct ip_vs_service *svc)
 static int sysctl_lblc_expiration(struct ip_vs_service *svc)
 {
 #ifdef CONFIG_SYSCTL
-	return svc->ipvs->sysctl_lblc_expiration;
+	return READ_ONCE(svc->ipvs->sysctl_lblc_expiration);
 #else
 	return DEFAULT_EXPIRATION;
 #endif
diff --git a/net/netfilter/ipvs/ip_vs_lblcr.c b/net/netfilter/ipvs/ip_vs_lblcr.c
index dfb5bf83750db..33d6e30968a95 100644
--- a/net/netfilter/ipvs/ip_vs_lblcr.c
+++ b/net/netfilter/ipvs/ip_vs_lblcr.c
@@ -413,7 +413,7 @@ static void ip_vs_lblcr_flush(struct ip_vs_service *svc)
 static int sysctl_lblcr_expiration(struct ip_vs_service *svc)
 {
 #ifdef CONFIG_SYSCTL
-	return svc->ipvs->sysctl_lblcr_expiration;
+	return READ_ONCE(svc->ipvs->sysctl_lblcr_expiration);
 #else
 	return DEFAULT_EXPIRATION;
 #endif
-- 
2.43.0

