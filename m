Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB7E33A007
	for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777525; cv=none; b=MyeaI2NJVJ6uD8+9qIlW3eRWaPySAu1lBdx+56xfUhcTa0RTyQKKM9axgjowMQsfwe/GRdilfr2EXDwBTdKCm+80ywuQ2iYBJowcoCBG2VEdH1tBksaKcGIF+HXQgwk1bJa3rAkRekQWyt60DJxQqs1iamY0xY6q+uIKDv3/E7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777525; c=relaxed/simple;
	bh=EEBJAfZmjfkpZOGOEVFX0CZS3rPpON7xamOmHMjuQC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJN3FXgfcNF2IMv9mYi7dHkgxScGnNHgMoAO/Q8MGW60NX6FM8D0J1WQD9v26UgV7WDgiJL6lxnyBPnopf9D/zDvVen4kEmG4k9HrpAKKVELzMKsz3B0M9j5R+RpeyGLUEiPXUoSPxKOiSxXhgd/RqBTj9kglujT/D2HKKy5xs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTvNdvcK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTvNdvcK"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bd266f6fc0so12990435ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 09:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778777524; x=1779382324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fTws1unEaZCkPMbtIVOShoAmXukkkseioq0bAhEtMn4=;
        b=PTvNdvcKk4OaAc8TIqBV3X2sinIU5wSnc/QXp4vNj5farp7xXeSCO6EJa5suKEmMgT
         twlqv7gFncd3GEGsYUV2izXLCqD8fRawZcQ+wDMiBy4z+5d18UIQezJ1qWoZKvDg8bjD
         ac0Eyxn7VV2E70X4m0N+GMxglcO4Dd60AsGTO27wpA7df6AkCfws9/x4u8PGA9Rq+PKW
         0dAquRkj9T5JDxbE2aIrsOI25ycDllEdtGFHtuadPKc+J+d6SgDrLG8OHqpejkZ1IuYC
         +UjDf58zZzDjs0oTYANWcViMIUPFlcitjeUAT6hRalkkwqZYj5oazeQzW48wA1h45hzP
         I+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777524; x=1779382324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTws1unEaZCkPMbtIVOShoAmXukkkseioq0bAhEtMn4=;
        b=bvOWZimj4BIyP7vEIt6ZtrVurXbvmS1vXESKPFE7tyepVoGlkJdvDXaIkrlXaYZrpq
         SIJhlwmHgURLdGj8QKDOBbausPIG+xge0xQwBQ9aOr4pVaIbh6w4ELYbu5uHMmtjiG+e
         Uo3G6u8iR4W47uTi3Z2kunGavetxfsUuMH1r17weXSEZt1Q+TBJHCSK7yrtfRuXGyAr9
         ws9hEu/oaVruUQi1TQhiHfSQcj2pRWpo6hbROK85w+AmuT736+QzpSrLN1FfTmnDHcAZ
         ff2+fGpM1UpmvZcbvtL+fcDCYqyVKCsqeO58Wb0EO7h469rYAZCMbgdKIKl0pYDeNtJT
         SLhQ==
X-Forwarded-Encrypted: i=1; AFNElJ9uVCNJscVUJRBZoIpvk1/2FSEfM3SbCran4hjmsGroq21dqdNfSVm/FdIXWooH4nyiCAWPrJg7yTzZ5pR8xf/IWcC9ZqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Uytw/v8a52Et4TiIOwj8haLHYrB41cq8LDJVeTFRus1AD2si
	M136W8dPL+JrDc6A6PoXQf9ywNNti72B2VeR0AYRMIK28o0vEXQoH64+
X-Gm-Gg: Acq92OE+GhlKkr6w7MXDTANO88DergY9nIy11Yb8e8k0qeRm1k8ExX35IHKKrvOGNlw
	g+py296pLPii3ya0yzgk+mMMwU4ls3wrooHrgj0R6KNlv7V+WSZvgx5zeLMzIgRloc8XiZk50hf
	ZC6Ax96MuOM6V6qZHRz34z/SDgT2+zJcFJv6MeAmc967XtIhUH+W4HUOVaQU86PjfLhqR9ZiEsE
	DK9z4XvPITskOu/iEIIKu0Hg6AvBs+YeW4TyPwFTm/mqubjurN0AeVlePK6TlmYqqQghxn8MP7U
	TKX/Z9hadQ2LyGTng+NYqAyo2tH2jW9I5FkzqMVt8DPYRXnwxYr9rpk0mVmGxwarL0J8BEltrpj
	SMLDQSLgB64yPiuHSZLz5rYJPD0PUpdpF1nAuapROcf7JWrmMvvKKpam9KOxF8SlUX32z2vj+cr
	r7wuCdi1O0CLOHvbxylu0lYiWI8ffHww==
X-Received: by 2002:a17:902:d512:b0:2b4:5f96:184d with SMTP id d9443c01a7336-2bd7e86c6a4mr3703895ad.5.1778777523797;
        Thu, 14 May 2026 09:52:03 -0700 (PDT)
Received: from Tplus.localdomain ([114.243.117.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c2631basm27937825ad.34.2026.05.14.09.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:52:03 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	lyutoon@gmail.com,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Simon Horman <horms@kernel.org>,
	Huw Davies <huw@codeweavers.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH net 3/4] netlabel: validate CALIPSO option against skb tail in netlbl_skbuff_getattr
Date: Fri, 15 May 2026 00:51:33 +0800
Message-ID: <20260514165139.436961-4-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netlbl_skbuff_getattr() locates the CALIPSO option in the IPv6 HBH
header via calipso_optptr() and hands the bare pointer to
calipso_getattr() -> calipso_opt_getattr().  The consumer re-reads
calipso[1] (option data length) and calipso[6] (cat_len/4) and walks
calipso + 10 for cat_len bytes via netlbl_bitmap_walk().

ipv6_hop_calipso() validates these bytes only at parse time inside
ipv6_parse_hopopts().  An nftables PRE_ROUTING payload write
reachable from an unprivileged user namespace can rewrite both bytes
between parse and the SELinux/Smack peer-label consume path
(selinux_sock_rcv_skb_compat -> selinux_netlbl_sock_rcv_skb ->
netlbl_skbuff_getattr).  The self-consistency check
(cat_len + 8 > len) inside calipso_opt_getattr() is defeated by
mutating both bytes consistently, allowing a ~232-byte
slab-out-of-bounds read from calipso + 10 whose set bits become MLS
categories driving the access decision.

netlbl_skbuff_getattr() has the skb; gate the consume on the option
fitting within skb_tail_pointer().  The IPv6 option layout is
type(1) + length(1) + length bytes of data, so requiring
ptr + 2 + ptr[1] <= skb_tail covers the option and its embedded
bitmap.

Runtime confirmation (Smack peer-label policy + nft HBH mutation):
Udp6InDatagrams increments to 1 with the mutated cat_len, showing
selinux/smack_socket_sock_rcv_skb -> netlbl_skbuff_getattr ->
calipso_opt_getattr -> netlbl_bitmap_walk runs end-to-end past the
option's true bound; with this patch the consume path short-circuits
at the bounds check and the counter stays 0.

Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Tong Liu <lyutoon@gmail.com>
Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff directly.")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/netlabel/netlabel_kapi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 3583fa63dd01f..4af8ab76964e0 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1399,11 +1399,20 @@ int netlbl_skbuff_getattr(const struct sk_buff *skb,
 			return 0;
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
-	case AF_INET6:
+	case AF_INET6: {
+		const unsigned char *tail = skb_tail_pointer(skb);
+		u8 opt_data_len;
+
 		ptr = calipso_optptr(skb);
-		if (ptr && calipso_getattr(ptr, secattr) == 0)
+		if (!ptr || ptr + 2 > tail)
+			break;
+		opt_data_len = ptr[1];	/* IPv6 option data length */
+		if (ptr + 2 + opt_data_len > tail)
+			break;
+		if (calipso_getattr(ptr, secattr) == 0)
 			return 0;
 		break;
+	}
 #endif /* IPv6 */
 	}
 
-- 
2.47.3

