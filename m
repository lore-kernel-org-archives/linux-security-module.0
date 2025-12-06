Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F89222127A
	for <linux-security-module@vger.kernel.org>; Sat,  6 Dec 2025 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765010315; cv=none; b=HLWGqQ0C5ipBDSUZILaSSM9+pT1PdbPLzri5SOWiw5G/dVKEqmLZ+WJ0oFVtNzr2jTIVSbyaH8FqNsamEmwp7rAakeV/TygfJxhj80BJqqkQxTrL+g9RSPM50nKx69YQMGQcXmjiIgtfToQIrgroAVRsh31gXT29ajCXdFkqleQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765010315; c=relaxed/simple;
	bh=Gwa4FW/HF6dVnO8PL32pmwPWh+CCm+aVOn2ctJfUxXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/CEJpU1nAAo80iSTTs4ON57f7bRJGVjS+6KZ2X53Kpq5psGscrYLNOr4psqpThRkyHMhuRpKTx9dohaSN8iKERY8Nkqw0iei8ipW9vxZCl1jXm/cCXbTm07JbhxWBIRy9DzYpPt8qyhM/UgefpKiiaVoLM8zseU70E4Had2x+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTEB9xG6; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTEB9xG6"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29808a9a96aso30314235ad.1
        for <linux-security-module@vger.kernel.org>; Sat, 06 Dec 2025 00:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765010313; x=1765615113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=prycVSRPOk07rpwpu9tCdC8skh9cM21gBKGRU0XWKEQ=;
        b=fTEB9xG6NVQ8CZ5n1ARehRV9WHM/VE+y7NT+2trj5OZnLFyriPyBmDM45jSPrfcoxm
         dpy+GV/oSQCw2RmtHLtouT8gqfSLxbTOnneRZbbA0wf4Mimgo+qYwrMLVrDj9RBylPfh
         df3W7OMt8ixKBlwA3a3LyB9MfFtBhsDKDFxeg0ak0B+uJrDs0hFH8J7qF9mQuR/MYWQK
         zmgb1h7YLJ0DmguF5XM7ZcC4vqrfHEemL2NXc7ZPfHgOO3yzgMwmYuPJBks3jFNKgGl+
         KpLn3iGiDDEgIHCdYNjZh45kCsqiaXUNkBpLuJ4ZtpraSn9B2dG9dqtJ+goq19XRRn1a
         y5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765010313; x=1765615113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prycVSRPOk07rpwpu9tCdC8skh9cM21gBKGRU0XWKEQ=;
        b=S6XD+D2DX3Lhu5ZrBLer3NcXY6/FoDSJPtMp26lOqIe1PJBTc7cLIc31JiQLgcm3Sy
         U0Qll5h+B76moJlbqiRCa5ihkD+ZjkrNNXQLU23t5G0V86UyRhP0F0Q7PD17Jme3SSNY
         D8LTs1eMDORWsCv6Xww9E5bbcnuoj1Hr493Kl1618wDWJDQ3Q3bvdTdnUl7tWYg8BAv0
         lvM9Jx4kGNzaHZPSl+NvdtQldfV6E7qo8WEFJaB/kgXWuuMnBx2cS2V7pUSF9I90ZN4F
         kGknpGr9ylHOMP58dpc9WUfvB8Fjo3PdOySrs6lFE1O0w96Ksw3NnbZO4C6AZGl7fqQZ
         +kDw==
X-Forwarded-Encrypted: i=1; AJvYcCU5MFKSeSFhCQsyPDI+LgbTk71w0vSjoEWqC2TijuCvpafke8aFaOOONEo8SvtzRFXdzj0YJ+xi62lkeb6970MBXkgWQzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiS028qAHdWyzx6p8+voye7vVJD/XIKrgeSgz7b8YGYgDGDyqT
	C1mY4yje4efFTymXBcdnljBL4n8NP9HSK7G9mJ5SNpiWgupIESWQB9vscKWfpg==
X-Gm-Gg: ASbGnctotDWCFXC7cZRIybebIX0m2NkqUn4lbxE+PaLRn/KlBmTGAuVgpVeyEkFy0tH
	aofl0Oewxv6bDC1UXKnrYjZ2a/PZpFlTRlJ52bCpsqCGlnYNOb0m4QXUooQmHahJ5UTSM2ESdns
	adG1oZV5MkW1pJCFWfg/Y3VhI31X4LbvcIJHpunMJ45zxChAb3To4fBc74LdcU+SxT+1YuXLn3U
	Y+0dMVF/jO1XTSB2fn3d/P6jBLrECjOqggUWuPgfd30BnZ48OsZsoQ+ILCqTV2fk8OFFpQX/IPL
	JPxIuvXXOqhZPGG9qek7H3PnwsQPnaxMoAraRyEgg+0Bf5QLUXW0iLdvBP0dU1dXok17B0ciLLA
	cc5JE2Bx96MUvaBzAynbknHhbewmM8lPfNj9ENWxJUwfJpmUqC3tXqVhR5s2WsZF4xF/ovKMEIN
	5UfRRsUIK2UAT7
X-Google-Smtp-Source: AGHT+IHKcTubNpp//XKbNtvzZsY9GNFbXVUHT6icYP+A+7ynbahWDBjnLZ6Mh0QvhvT3OxZ280hfBQ==
X-Received: by 2002:a17:902:e752:b0:295:98a1:7ddb with SMTP id d9443c01a7336-29df6326100mr15811075ad.61.1765010312599;
        Sat, 06 Dec 2025 00:38:32 -0800 (PST)
Received: from fedora ([110.224.242.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4cf9c3sm68834905ad.26.2025.12.06.00.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 00:38:32 -0800 (PST)
From: Shi Hao <i.shihao.999@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	herbert@gondor.apana.org.au,
	horms@kernel.org,
	i.shihao.999@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	pablo@netfilter.org,
	steffen.klassert@secunet.com
Subject: [PATCH v2] net: ipv6: fix spelling typos in comments
Date: Sat,  6 Dec 2025 14:08:13 +0530
Message-ID: <20251206083813.240710-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct misspelled typos in comments

- informations -> information
- wont -> won't
- upto -> up to
- destionation -> destination

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---

changes v2:
- Rebased on net-next
---
 net/ipv6/ah6.c                          | 2 +-
 net/ipv6/calipso.c                      | 4 ++--
 net/ipv6/ip6_fib.c                      | 2 +-
 net/ipv6/ip6_vti.c                      | 2 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c | 2 +-
 net/ipv6/reassembly.c                   | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index 95372e0f1d21..92e1cf90a6be 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -169,7 +169,7 @@ static bool zero_out_mutable_opts(struct ipv6_opt_hdr *opthdr)
 /**
  *	ipv6_rearrange_destopt - rearrange IPv6 destination options header
  *	@iph: IPv6 header
- *	@destopt: destionation options header
+ *	@destopt: destination options header
  */
 static void ipv6_rearrange_destopt(struct ipv6hdr *iph, struct ipv6_opt_hdr *destopt)
 {
diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index df1986973430..220dd432c5bd 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -43,7 +43,7 @@
 #define CALIPSO_HDR_LEN (2 + 8)

 /* Maximum size of the calipso option including
- * the two-byte TLV header and upto 3 bytes of
+ * the two-byte TLV header and up to 3 bytes of
  * leading pad and 7 bytes of trailing pad.
  */
 #define CALIPSO_OPT_LEN_MAX_WITH_PAD (3 + CALIPSO_OPT_LEN_MAX + 7)
@@ -713,7 +713,7 @@ static int calipso_pad_write(unsigned char *buf, unsigned int offset,
  *
  * Description:
  * Generate a CALIPSO option using the DOI definition and security attributes
- * passed to the function. This also generates upto three bytes of leading
+ * passed to the function. This also generates up to three bytes of leading
  * padding that ensures that the option is 4n + 2 aligned.  It returns the
  * number of bytes written (including any initial padding).
  */
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 2111af022d94..bd1107eec89b 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1010,7 +1010,7 @@ static int fib6_nh_drop_pcpu_from(struct fib6_nh *nh, void *_arg)

 static void fib6_drop_pcpu_from(struct fib6_info *f6i)
 {
-	/* Make sure rt6_make_pcpu_route() wont add other percpu routes
+	/* Make sure rt6_make_pcpu_route() won't add other percpu routes
	 * while we are cleaning them here.
	 */
	f6i->fib6_destroying = 1;
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index ad5290be4dd6..cc8d0b142224 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -435,7 +435,7 @@ static bool vti6_state_check(const struct xfrm_state *x,
  * vti6_xmit - send a packet
  *   @skb: the outgoing socket buffer
  *   @dev: the outgoing tunnel device
- *   @fl: the flow informations for the xfrm_lookup
+ *   @fl: the flow information for the xfrm_lookup
  **/
 static int
 vti6_xmit(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 64ab23ff559b..fcb17308c7e7 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -251,7 +251,7 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, struct sk_buff *skb,

	/* Note : skb->rbnode and skb->dev share the same location. */
	dev = skb->dev;
-	/* Makes sure compiler wont do silly aliasing games */
+	/* Makes sure compiler won't do silly aliasing games */
	barrier();

	prev = fq->q.fragments_tail;
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 25ec8001898d..13540779a2c7 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -187,7 +187,7 @@ static int ip6_frag_queue(struct net *net,

	/* Note : skb->rbnode and skb->dev share the same location. */
	dev = skb->dev;
-	/* Makes sure compiler wont do silly aliasing games */
+	/* Makes sure compiler won't do silly aliasing games */
	barrier();

	prev_tail = fq->q.fragments_tail;
--
2.51.0
