Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CC531E830
	for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777530; cv=none; b=ZrbTtc10QBeTIloDNLpRO3p6XFOh7DifMuOhz4dU11xLuUidR2jTtw5AB8lHe/ljzXbyUU6V1Ogv3V/M0kqPMxNxUt0doX371NVVancJxCh9Hsy5LzD0OpUAjAAwM25qJkU479e2Jfn3nO1jUsYouDnS+cg7ey3DFvIZEpAmv54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777530; c=relaxed/simple;
	bh=3EPvR1ScT1B0f5NL80yDzKu7nP5JRSuTf0PXBGwV2lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lP6VCH/+npR98tteDXmBITSGr284hNVgAAZP1n25pTlegIgbY9yVoYQD4+s8Obg2Ifktcd/KjnH8CQEB+kS48xu0Q8WczUaV4a2wh8IlJk7k+ciQgjY/tfP6lBs9rPkNjcYSIDX6riqwBhb1p9JFsldMX7cn8OUi1BzEpjGbcls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXAkRKMd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXAkRKMd"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b45cb89f7eso52731275ad.0
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 09:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778777528; x=1779382328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GwRQjyq3ZOtr85xXuZw5Nv7geOh6ncaBN6Zn+7ncG30=;
        b=lXAkRKMdHAhoZ0VoElce6HoTabmLMhQ6cyZSgGmude2x4xovzRMmk8+BYDOsXuipBK
         oekH0NCebx6pFss8Ap0vV0LyWCQ/4YGrWtL/pKKAHWaBpepdxhYMVJBja/rxQMDfKNYe
         /xQkZ6ARfR/AfXG3z28OG1md0CLTySY9L2dWa+GTvBEuv5t1BRsc3b446KHRMmKXGr9D
         hhUvoqzN5Sz5PqIsjFObX756EyRQNuMTm9CxvAh52SWUZG1CdaedjlF931LUd8B/Z+Dw
         sLaWzjc5XTlAEw/ImEMm6K6wTBqVCQQGIlef65pjBIlI7NdSAJecEhp4GxRS+5l5mW+6
         Aaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777528; x=1779382328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwRQjyq3ZOtr85xXuZw5Nv7geOh6ncaBN6Zn+7ncG30=;
        b=LJDvdT1d5Ktrk9T7j6tvhyTYII5vMCGMr75nC4EglYw5nxAlSGwj0iM50YNzyWX5gC
         WfVMtpbtsz6cpLiTS+2liHNbPE+nCFT1oP0Hu//UK6NHLwx8FZVRIUWUAISgWJ9ohbfL
         1H7+AOYDvcTu/sjYbmLKdtzTgWeoA1qsmxXPQsepEZ8QRFLVvbHTrneu63c2qjpwgLZ3
         quQD39GeuWaTJS371tHh769L8XV5V7ZeRlyXti+5UVm8im0cIH0Hp0hIVfeHVCND0ALt
         vXEeekQl5cZtoD0ICxR+6xfV0S2vkDtIC3PK3hxlnoUoa7GeMSChhOkN9UrLahELq7XZ
         w/4A==
X-Forwarded-Encrypted: i=1; AFNElJ9gO1YdY290uMoByO5rUzmReLBM8QCaLZZtLugppBPG/WpA+X+QVgPmZw5++B025A2CH0GDys0MoKo48oqzQR4ghHIG/js=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEYcGhUxSA/gNLsp50xhTDbXoHbEZOcDU4lLkmasarDp/qt7e7
	5w4ogBliTuwzYWeBqjDZo+4pt76lA4D4in0cxZTZFxdeFxdWoh7P3fLK
X-Gm-Gg: Acq92OGRn+ASrvvKJw4owXoUThvM8gXJveoT0mw/MF3/+BUSVC+gMY2cbj+jgmXXnXG
	oyz23UMyodmuwglLTo5v3tgHi9o9ssrIKY3cdt4AXqLl2y92loW6eLpNu2UacrNrV8UVg+yMd0n
	WY1ghuCd5QayTaE3BL3oZJ+4ZHeTTp2EAv3S1HMRiYM2g3kq/90/czMTrdFecgQDI7hIjDe1ETB
	4NajPWWsqVjK8jMQ9c304h290AGRFY6QnplP3M3PeweHqFVMC1dxFf8veQcvBZ3v41a+No5hSuV
	H9MlrXKiH2CXmHcSwOi4ZpQeY2WTIZtZnXCU10169iTtQBQ/pls0oNcMZ/cEJARXnzH9SRTSgkF
	lUhpgvuRlk41C3gpZqhqT3Cw7dBRs9le9acLh2Sr0XRxZ+ZEtDTtmGHLHMQf95H/vrIPVigjBWb
	UPqwBuWA+zdUw4odqThnU3LYsupXUQKg==
X-Received: by 2002:a17:902:7d95:b0:2bd:3bfd:22c3 with SMTP id d9443c01a7336-2bd7e88ee80mr2444355ad.24.1778777528083;
        Thu, 14 May 2026 09:52:08 -0700 (PDT)
Received: from Tplus.localdomain ([114.243.117.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c2631basm27937825ad.34.2026.05.14.09.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:52:07 -0700 (PDT)
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
	linux-security-module@vger.kernel.org
Subject: [PATCH net 4/4] netlabel: validate CIPSO option against skb tail in netlbl_skbuff_getattr
Date: Fri, 15 May 2026 00:51:34 +0800
Message-ID: <20260514165139.436961-5-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
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
cipso_v4_getattr().

Runtime confirmation (Smack peer-label policy + nft LOCAL_IN
mutation of tag_len): UdpInDatagrams increments to 1 and recvfrom
returns the payload, showing netlbl_skbuff_getattr ->
cipso_v4_getattr -> cipso_v4_parsetag_rbm -> netlbl_bitmap_walk runs
end-to-end past the option's true bound; with this patch the
consume path short-circuits at the bounds check and the counter
stays 0.

Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Tong Liu <lyutoon@gmail.com>
Fixes: 04f81f0154e4 ("cipso: don't use IPCB() to locate the CIPSO IP option")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/netlabel/netlabel_kapi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 4af8ab76964e0..ace561a2904a4 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1393,11 +1393,21 @@ int netlbl_skbuff_getattr(const struct sk_buff *skb,
 	unsigned char *ptr;
 
 	switch (family) {
-	case AF_INET:
+	case AF_INET: {
+		const unsigned char *tail = skb_tail_pointer(skb);
+		u8 opt_len, tag_len;
+
 		ptr = cipso_v4_optptr(skb);
-		if (ptr && cipso_v4_getattr(ptr, secattr) == 0)
+		if (!ptr || ptr + 8 > tail)
+			break;
+		opt_len = ptr[1];	/* total CIPSO option length */
+		tag_len = ptr[7];	/* first tag length */
+		if (ptr + opt_len > tail || ptr + 6 + tag_len > tail)
+			break;
+		if (cipso_v4_getattr(ptr, secattr) == 0)
 			return 0;
 		break;
+	}
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6: {
 		const unsigned char *tail = skb_tail_pointer(skb);
-- 
2.47.3

