Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560CB2BEFEB
	for <linux-security-module@vger.kernel.org>; Sun, 24 May 2026 04:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779596113; cv=none; b=TGoKgYlMZAgHxHdlZUsXqU65TmZVy9Yw6nAOHKbNCUFx5MQQHSN4kK4Nh/plKXZOHYXN1ukw5OXvi6FXaYCuPFLzXeWXoKarKnG+k3U5/D0IPdQJv9vDJbshiWv7Pyvf9c/ZD4jeQ4HPJgX+aBe6hzZMIOVTJt0t4VfXeGFou/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779596113; c=relaxed/simple;
	bh=KH3T/whTjIb1nZ/b0yTDsfG9KkcuwAxRR09DzkU+xNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iz10lSaG6l+BPUct0bx4aHyIyNBNV91xHxPTnNNBYmG1k3aHBM0O9320ALj//CFPeSxey2PPHi+6TUJwt5Wv3/WVoreTM7kkgBCd2MgDo9WFjLJjShTKK4PqZ8JJIXWZ3mAkU0QvKhL+wigBNhtkKEeGVbcXeGykw8iq9qKLgB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7RoGsNK; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7RoGsNK"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3044857f09aso3540135eec.1
        for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 21:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779596111; x=1780200911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9LtOZi90LiMAb4rReSd7b/FTuCWT41FjVk4dArDYLo=;
        b=H7RoGsNKfHksixA8fGglZ21fsi0pPZayRJANuBU/FgXkN29yOahhFYOQCuUZYo6YMr
         1imFmsl++Jc+UgZnhOsg4qz4aBxJbWqJeIOAGtP9d+Ik4ELufuThbu6bU/1MR6gt4cJb
         ouSZMdF/HnFAfZH0PX2px+eb++y4cCzDtM9oQxK5JXUTH8QGgfgLmFlaURz2sU3ewyv2
         fD2O1sVsQfCVa3C6wKtqvC9ZiVxfZXCwl0LWcGOzMLNObiMA1BUERsqOVsSqsZBLuBhN
         vQt1p1uhprDRHwxxLHdLY0ZhBmksbiuCs3kKY2EMxaRK1jLpBaxD55TLjxzs1Xvq4SFI
         kVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779596111; x=1780200911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A9LtOZi90LiMAb4rReSd7b/FTuCWT41FjVk4dArDYLo=;
        b=b52t9CL2/0MQdGtxY5qVc8DO0Zh7yZndBainrmh56C6KLT32m0wzx8pdb7BI8tfjeR
         8PtXJ9iYaH70t9923MfWTBwtN/ca4XPyMblrFbJieQy4UiaIpxNNKvYHODV1CyVsSDUz
         T/OBS4EucPET7+amcEjG4Y2V+Ge+oL/cI1yUwJ60GOQjrX7n9r5k7OjJcwhVALVcF9rb
         OXCFvG1Avmbja/OftHaY9Cr6oucr3bCfqw16g7elzdJllgL4kPJ+NkMdESjiwbTeMU0k
         PY0suvueJyhwpPFDs/T2QDqRNXRnjnXRcNxF1LRob45OcpYwjgUyVheOx6kjql2KfjRD
         ehtQ==
X-Forwarded-Encrypted: i=1; AFNElJ9m313+D567DWDmmbEqbP4CxoGq8NOtZtZydoaQwmDuz3tj2S/JL4mYWUUiqcJD+uBGcP2u1IjSe+agQEmGsO3XHDkWuuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTpBrKUb7YQS8OQrg6yRq2C+/x0aVoYsN1idSbF8Skb052V3iA
	6rFJtjlG77m8srL+5VWv8zd/LRKSic4Foz+nNGKTX9hZoCcJ3HFOBhFb
X-Gm-Gg: Acq92OHRRjqRCrCCjtDKsMFVZFArlNgIBrLgFackFK3ZTwiF0OQaM/L38dv3oeKF6oT
	xqS95Cp4FGtHueh6h0Fh2fORgxkcpCotKnzI8u99dPkfvfFzUE33VKVTLRe/rUJ7B6zo0IJ2yhw
	F64ztLXREj4mTBm3TFq7Jlkj8aq0KQ89DLOTJdy4dh3qEufLwU/ePUT5HlqfAF8aMHsrhp12uXS
	TuRUjQwJ21mIyvGcn+GoH+i9odG49tNmJSmoPr2q8sSicyV5tazRsaFg2lptGVmVoT2Z406Rowe
	b/61TvNiq4Vnp1LMi6hDj1cN0V2GH259ZhFJwpjqHuiHKYsYGHOqMyPWA2rSKKYRJDcR9XLeTnu
	LNdI9LvlsmLfdjAesesZaYydbaRuOjZ4TRwXqS5LZywHmcLUCetAWP91VCsi5N+cWnr8cTNAXL1
	2kH0hYCWZ6SeOJCbRjjp23S/sT9fvJUhc0ROYf76Hr1iN0
X-Received: by 2002:a05:7301:608e:b0:2f2:b544:2fca with SMTP id 5a478bee46e88-304490e65femr4581119eec.33.1779596111441;
        Sat, 23 May 2026 21:15:11 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3045245d6aesm4522133eec.26.2026.05.23.21.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 21:15:10 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	fw@strlen.de,
	lyutoon@gmail.com,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Simon Horman <horms@kernel.org>,
	linux-security-module@vger.kernel.org
Subject: [PATCH net v2 4/4] netlabel: validate CIPSO option against skb tail in netlbl_skbuff_getattr
Date: Sun, 24 May 2026 12:14:38 +0800
Message-ID: <20260524041442.2432071-5-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524041442.2432071-1-tpluszz77@gmail.com>
References: <20260524041442.2432071-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netlbl_skbuff_getattr() locates the CIPSO option in the IPv4 IP header
via cipso_v4_optptr() and hands the bare pointer to cipso_v4_getattr().
The consumer re-reads cipso[1] (option length), cipso[6] (tag type),
and then cipso_v4_parsetag_*() re-reads further bytes from the skb.

__ip_options_compile() validates these bytes only at parse time.  An
nftables LOCAL_IN payload write reachable from an unprivileged user
namespace can rewrite them after parse and before the SELinux/Smack
peer-label consume path (selinux_sock_rcv_skb_compat ->
selinux_netlbl_sock_rcv_skb -> netlbl_skbuff_getattr).  This is the
IPv4 analogue of the CALIPSO IPv6 trust-after-modification fixed in
the previous patch: the tag parsers walk the option using attacker-
controlled length bytes, producing slab-out-of-bounds reads whose
contents feed into the MLS access decision.

Validate the option fits within skb_tail_pointer(skb) before invoking
cipso_v4_getattr().  The pre-tag-walk guard "ptr + 8 > tail" covers
the CIPSO option header (type + length + DOI = 6 bytes) plus the
first tag header (type + length = 2 bytes), which are the bytes
cipso_v4_getattr() reads to dispatch on the tag.  When the bounds
check fails the packet has been mutated after parse, so return
-EINVAL rather than fall through to the unlabeled path.

Runtime confirmation (Smack peer-label policy + nft LOCAL_IN
mutation of tag_len): UdpInDatagrams increments to 1 and recvfrom
returns the payload, showing netlbl_skbuff_getattr ->
cipso_v4_getattr -> cipso_v4_parsetag_rbm -> netlbl_bitmap_walk runs
end-to-end past the option's true bound; with this patch the
consume path returns -EINVAL at the bounds check and the counter
stays 0.

Cc: stable@vger.kernel.org
Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Tong Liu <lyutoon@gmail.com>
Fixes: 04f81f0154e4 ("cipso: don't use IPCB() to locate the CIPSO IP option")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/netlabel/netlabel_kapi.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index d0d6220b8d59d..c2d3ea751f4e1 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1393,11 +1393,24 @@ int netlbl_skbuff_getattr(const struct sk_buff *skb,
 	unsigned char *ptr;
 
 	switch (family) {
-	case AF_INET:
+	case AF_INET: {
+		const unsigned char *tail = skb_tail_pointer(skb);
+		u8 opt_len, tag_len;
+
 		ptr = cipso_v4_optptr(skb);
-		if (ptr && cipso_v4_getattr(ptr, secattr) == 0)
+		if (!ptr)
+			break;
+		/* CIPSO header (type+len+DOI = 6) + first tag header (type+len = 2) */
+		if (ptr + 8 > tail)
+			return -EINVAL;
+		opt_len = ptr[1];	/* total CIPSO option length */
+		tag_len = ptr[7];	/* first tag length */
+		if (ptr + opt_len > tail || ptr + 6 + tag_len > tail)
+			return -EINVAL;
+		if (cipso_v4_getattr(ptr, secattr) == 0)
 			return 0;
 		break;
+	}
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6: {
 		const unsigned char *tail = skb_tail_pointer(skb);
-- 
2.47.3

