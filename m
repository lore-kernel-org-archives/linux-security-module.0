Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06322F12AE
	for <linux-security-module@vger.kernel.org>; Sun, 24 May 2026 04:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779596109; cv=none; b=foGvVPukAcb9vHsSk1ZceevlnZiS4TIccXnIiGLV0i60qUvx1wY5vAXpCHHPdBOVqo9XABDo1ugiD4coBLeY2QNZD9O3FZ583J3F8HiHTpjWGkZUK67a6QmFMa0OiNFqzE4lskZzUp6lusm9N+3epD5wDBCgKJR0V+2YI9CLFVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779596109; c=relaxed/simple;
	bh=zlROHpspN4svB9VHuRgW/RNOHKabtQok9h5ytT2jjOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdRc213CRWCxEHJ/P9Skph/Kvuo/om23l0huy3zfvP65oCcC+JOJpWBQcLZ9c6X1D85Jsf91XklzHZciyBWSOOvN+tcEP3UNr3cKxoTwg+1csdJSoBbYUfb5MkBO0oU60RTCBrcIKoF0cUsepcKJWfU7CdohBeg345DW9Miu8jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXklRN6E; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXklRN6E"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30455f77e0eso2949267eec.0
        for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 21:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779596107; x=1780200907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7xIC92IytMwCoIpp3F6gfBN1+ahv97EwLManb72nZc=;
        b=DXklRN6Ero41d1ZWvZEgMh+V2QyLzI0NY6IjduXNOqGEDbVDKqx1p48d1GBRvnNhGk
         JRoPkGexU4TxAjJgtQDCXf7m2zKKaCydXLdNiItRGpYnBCrzmJyJSZt/JFOI8OQlKH2p
         JNwHzu+9+iJXGpdZQGn0mA10LWLCU6k4FvCw+kMHLKR4P4HJSBmsOqyE17HgiROdei/m
         WnP7t6EJdd1194jGABhu4YWoyIeggXuQUrLtmrnF7gRXxvpGujWD4sAm1Uzts9V8c+5L
         LFLaIQ0xrxCgKjF9FszNz4MReVjoEVqmvXrCDnG2HooW5JAL8zX4+hXtl5X7YNNwSVda
         +g6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779596107; x=1780200907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y7xIC92IytMwCoIpp3F6gfBN1+ahv97EwLManb72nZc=;
        b=BXkgGJmz0SiXgVKd0LfXCvzXKC/dDon3/MmktqMVj5B6xBe1nel9X6VmMi1VRz7B/k
         eZC8wXaZNoAeS67foUIvW1T26UErY8VJg63beUr1xSSU819hYzDg172HdKAX5TQ49296
         jILhefOBG9GiKZJ56cTGIybuHR21LKQf4A3LAkfGYWJje0i6nN/K3EMZwZghxeqL4kTY
         xhVevWT4Lhz5xQcVgLVzqXGNNemTeLwKUNWCurjTdiJL4Vd+bVreUeQABklrqjZHD4GN
         wi7DPXYlgioiYo3edoS9vG+6BjYjBdaRhBrT1WxYUc6GmUJWocxyYJSsbJi6h7eUgm9C
         y3Eg==
X-Forwarded-Encrypted: i=1; AFNElJ+L5qalhZcVXnot+oudHVovDSrwHZZ+HYPAS2roU3jB7wamsxtzuCg/0cMbCF9aOkdEF+LTKoMZ1OL6QYyNR5a1h60Yick=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXxJQys1LRe5tm/b+I1Gmln6dbyC2Kj5p22/Wu0oLiN8B5iJ7p
	dWrhc09x0puQ2iK8PcIDoAu5der1Eizp6gTCMH1fol3Bi/1HJ0eudX99
X-Gm-Gg: Acq92OHxfoKi03NbXFha+5lDMhiZccS86dplOR5cutzwxaDvUW6+WKb0T80w6WCS2M7
	mga4sY/qZbgrAL3MGeYGIovDI+gqVQiAcc7DWgimZAaLeHg0PAMEc/vQW7qJXThscZ3a10cMn86
	XnC/gWbx4f9wXDOW/2wKmli9Khp8s6ZcWh98t9eIg2RaNIcrFVK/Ku9TvfR//P+inW8eKcWehOL
	GWhFLbDQEjjf588vT5L/wYoeJALBY3AfzZUcu/KBifEAcllmCAo4afbKQaajOmTr2bILlNy91bb
	H1FkazS+2anZjx5HpgbeyjiF67vLWPWHBHe10rNz+OXOcScejjHAcE5xtyDyAB7GmEXbKYAVHje
	wyJqI76JhwCqzVumT9PppulYj54OE2UckFTR957BqTepjk2rFDYx6FOrY4JWynUsUQ2CG0UrgD9
	gPH+dzHelc6j0IZXJHIWLnvzG+04Ewt4NUaQ==
X-Received: by 2002:a05:7301:19a5:b0:2df:919f:ce59 with SMTP id 5a478bee46e88-30449149c79mr5024715eec.19.1779596106994;
        Sat, 23 May 2026 21:15:06 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3045245d6aesm4522133eec.26.2026.05.23.21.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 21:15:06 -0700 (PDT)
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
	Huw Davies <huw@codeweavers.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH net v2 3/4] netlabel: validate CALIPSO option against skb tail in netlbl_skbuff_getattr
Date: Sun, 24 May 2026 12:14:37 +0800
Message-ID: <20260524041442.2432071-4-tpluszz77@gmail.com>
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

netlbl_skbuff_getattr() locates the CALIPSO option in the IPv6 HBH
header via calipso_optptr() and hands the bare pointer to
calipso_getattr() -> calipso_opt_getattr().  The consumer re-reads
calipso[1] (option data length) and calipso[6] (cat_len/4) and walks
calipso + 10 for cat_len bytes via netlbl_bitmap_walk().

ipv6_hop_calipso() validates these bytes only at parse time inside
ipv6_parse_hopopts().  An nftables PRE_ROUTING payload write reachable
from an unprivileged user namespace can rewrite both bytes between
parse and the SELinux peer-label consume path
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
bitmap.  When the bounds check fails the packet has been mutated
after parse, so return -EINVAL rather than fall through to the
unlabeled path.

Runtime confirmation (SELinux compat path with selinux=1 enforcing=0
and a CALIPSO DOI added via netlabelctl): Udp6InDatagrams increments
to 1 with the mutated cat_len, showing
selinux_socket_sock_rcv_skb -> netlbl_skbuff_getattr ->
calipso_opt_getattr -> netlbl_bitmap_walk runs end-to-end past the
option's true bound; with this patch the consume path returns
-EINVAL at the bounds check and the counter stays 0.

Cc: stable@vger.kernel.org
Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Tong Liu <lyutoon@gmail.com>
Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff directly.")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/netlabel/netlabel_kapi.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 3583fa63dd01f..d0d6220b8d59d 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1399,11 +1399,22 @@ int netlbl_skbuff_getattr(const struct sk_buff *skb,
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
+		if (!ptr)
+			break;
+		if (ptr + 2 > tail)
+			return -EINVAL;
+		opt_data_len = ptr[1];	/* IPv6 option data length */
+		if (ptr + 2 + opt_data_len > tail)
+			return -EINVAL;
+		if (calipso_getattr(ptr, secattr) == 0)
 			return 0;
 		break;
+	}
 #endif /* IPv6 */
 	}
 
-- 
2.47.3

