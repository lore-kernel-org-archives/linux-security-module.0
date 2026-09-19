Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6E6339B41
	for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789851985; cv=none; b=UMEBpNJRbLrqIhcVT1QUm0WqD45CjfD6HiZjVNGIZ7CwIQGp5nhDMvS5Mc81oN6rVUBXgeYCr6l/XRb5ZSFj2dFMJXwIiROrcK2X2EfmKZ29qi6EZ6rzTqK2QOErsn2Tt9KeAQ1xZ1VXfToNhJBqDnCkKXIpVJ2bxV3pEigCKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789851985; c=relaxed/simple;
	bh=1mZsbngPmUGZlsAHxnckBzeOtO8Zwy79cpor2SauIBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ShRj9afrG97lnruYECGQPhutd5UPzBRDHA9b/KVX8NoZiZDnlcHtR//8odNFKGdhBmSdaRCW0T/JTL2mhlLxW7yboldqRIWKjEnlTPRxL09apLjnm8Bfbdxy+zDLvLt983VF2qNTLB4KsNKW70IE4ji38a9/w/3kllb0RseyvmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZLE9j54; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZLE9j54"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469b355ffso1131439b3a.1
        for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 14:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789851983; x=1790456783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ENqTX+NY7Ywqvs/LvA4+I8HL6U8Mdro5TSSkptMowFA=;
        b=MZLE9j54VoXoFO4uhGwdBXV+pdnQh5z/oFxoM1kcJ+NFz6FemvtH7Yx6RWJqZR8muM
         iEcB3zNwGUUkiiGgry1TJP1cCoyN4FU+JoQNIGwLvzbj2xsrKSwVzQYKoYES+O6RgTAj
         sqPofmGHeEF3QkPMrbq1KqnLslENNE0782Zzpze8OD3cqu3S6mIzAzjDLpEqB51gf4k8
         5ASHl6Gscm0uHbmUQt2jHodYfmral7PsuAx6CPY4FYcaY+L/DepDH0eN2x3BO8gGGIhf
         e8o0YA2WgIYLVno2E0a/bSV5rVjPvqwEce1YhjzlNrV/W5z1OSs0wyMh6zEiLbAH2VNc
         NSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789851983; x=1790456783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ENqTX+NY7Ywqvs/LvA4+I8HL6U8Mdro5TSSkptMowFA=;
        b=pZfpYBydFO4Ano6goGB1FWs3JhHc9JNNWa2+l/fNBzlrcOtSDTpAk7rdPnoqBUTOI9
         a+n//lwRBQ3Nes+aLJdBzSXmWNIy8uFak3K84Vcp5Y/CXp+NepjSW0Q3lyBHsPP+ZiY3
         sf8GPvnT6F+RCjjQrU9SQv041BVgFeXxwL823G3L0bFkfCmWSW9SNHMiXfO+ACPKa6Ib
         KIXvOwp+bnIQZ/uthiEkbO/s8+H3YMZ0wdHu5J96eA3TASZrmeLy/DU0H0HmRKdkkvHK
         9KIvEWa77tSc+4+3lHqaMysr5aVNzBjfLW5VYe3gS7ty+2vOvsP4Gx3NXVEKV8uz9oJw
         4AMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxM8rnetaBZA4QobrTxw2IDkCVevN0VFkdDrcPzkN43gmMFDUBE3AmTXUnDk1TlGilJJ+Zh6cz4H9+fVTyfNPoynxs9luA=@vger.kernel.org
X-Gm-Message-State: AFuF++nSnimwNAbAFj2/z22sh9QK55edWk4K9fKgoTE+LpUXc0Y7yzk0
	iw5OHZFiryPEI0/mFt1WYSqE5/NfP92i1GXiA6Kas/KkcqfwXgcq2UnW
X-Gm-Gg: AYBFou3elx6cWMO/488rhc9YA7C+XyWXAQYY8Y8QRcbXD6Ng+fdr4AAiA639wCX0jrl
	4lFB/nA40ZUVTdAfZz4sX3sPw5o06eSrNpHJON2JJDB5z080SbzIVmXfKgX9aWWE9etdIBw5A7S
	w+TEztOryfO8/YpdOoaUlPJjz1U1Cf+gYXO0SRHI7c+Cw2MlxCa6FmHCjrK3ofR7CIG9rxoV0JA
	t0a3y6WSnzq5eO3E1NdWmoGJT62F3+6UJFYgd3i1eLL6/+FuGd1gSLR8hLR92XpGndHlL44pMlg
	l1wonfOhhKvvJ+s6erBn0DlPwiTKm7p3K0HKIDDBUPKPw1J+72xYpqdN5DitxxWwzdEEsvAAoc3
	nDE54Q+XClmwY33EZEBsaBIodmWoUS2DndcJSk7MzjIRHIHClYazaNS4VAi/dqOC1fZGVHt43pC
	fgxvhLPp2c/E4B6EPUd0tSTr6aqVmHHKmh8LDdT+xbOOa7d9Z+uZFDD9nHLnLTT3aVihC0i8cha
	4diQ/0vELYqs1+ELCwvwfTGaCIYNkBDQnUtmwF+YCm844ewbS8DVZSOGO+cuR2XBom96YB6mFDS
	knjDAfzVKQ==
X-Received: by 2002:a05:6a00:4389:b0:878:37b2:df9a with SMTP id d2e1a72fcca58-87847134851mr2309234b3a.58.1789851983519;
        Sat, 19 Sep 2026 14:06:23 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a95f2abesm1297272b3a.26.2026.09.19.14.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:06:22 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: paul@paul-moore.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipv6: calipso: fix 8-bit hdrlen overflow and missing pskb_may_pull() in hop-by-hop options
Date: Sat, 19 Sep 2026 21:06:21 +0000
Message-ID: <20260919210621.3029744-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two bugs exist in the CALIPSO hop-by-hop option handling in
net/ipv6/calipso.c:

1. When inserting a CALIPSO option into an existing Hop-by-Hop extension
   header in calipso_opt_insert() or calipso_skbuff_setattr(), the
   resulting header length `buf_len` (or `ipv6_optlen(hop) + len_delta`)
   can exceed the maximum size representable by the 8-bit `hdrlen` field
   (256 * 8 = 2048 bytes). When `buf_len > 2048`, `new->hdrlen = buf_len
   / 8 - 1` (or `hop->hdrlen = ...`) truncates modulo 256, causing
   `ipv6_optlen()` to under-report the allocated header size and
   mismatch `opt->opt_nflen` or `skb->len`.
2. In calipso_skbuff_setattr(), when `ip6_hdr->nexthdr == NEXTHDR_HOP`,
   `hop` is dereferenced at `(struct ipv6_opt_hdr *)(ip6_hdr + 1)` and
   scanned by `calipso_opt_find(hop, &start, &end)` without ensuring
   that the Hop-by-Hop header resides in the linear data area of `skb`
   via `pskb_may_pull()`, risking an out-of-bounds read past `skb->tail`
   on non-linear skbs.

Reject Hop-by-Hop headers that would exceed `8 * 256` bytes with
`-ENOSPC`, and ensure `pskb_may_pull()` linearizes `hop` before
inspecting it in calipso_skbuff_setattr().

Fixes: ceba1832b1b2 ("calipso: Set the calipso socket label to match the secattr.")
Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff directly.")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/ipv6/calipso.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index c6a34334e657..b8b7451a16ed 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -944,6 +944,10 @@ calipso_opt_insert(struct ipv6_opt_hdr *hop,
 		memcpy((char *)new + buf_len, (char *)hop + end, hop_len - end);
 		buf_len += hop_len - end;
 	}
+	if (buf_len > 8 * 256) {
+		kfree(new);
+		return ERR_PTR(-ENOSPC);
+	}
 	new->nexthdr = 0;
 	new->hdrlen = buf_len / 8 - 1;
 
@@ -1323,6 +1327,13 @@ static int calipso_skbuff_setattr(struct sk_buff *skb,
 
 	ip6_hdr = ipv6_hdr(skb);
 	if (ip6_hdr->nexthdr == NEXTHDR_HOP) {
+		if (!pskb_may_pull(skb, sizeof(*ip6_hdr) + sizeof(*hop)))
+			return -EINVAL;
+		ip6_hdr = ipv6_hdr(skb);
+		hop = (struct ipv6_opt_hdr *)(ip6_hdr + 1);
+		if (!pskb_may_pull(skb, sizeof(*ip6_hdr) + ipv6_optlen(hop)))
+			return -EINVAL;
+		ip6_hdr = ipv6_hdr(skb);
 		hop = (struct ipv6_opt_hdr *)(ip6_hdr + 1);
 		ret_val = calipso_opt_find(hop, &start, &end);
 		if (ret_val && ret_val != -ENOENT)
@@ -1341,6 +1352,8 @@ static int calipso_skbuff_setattr(struct sk_buff *skb,
 	/* At this point new_end aligns to 4n, so (new_end & 4) pads to 8n */
 	pad = ((new_end & 4) + (end & 7)) & 7;
 	len_delta = new_end - (int)end + pad;
+	if (start && (int)ipv6_optlen(hop) + len_delta > 8 * 256)
+		return -ENOSPC;
 	ret_val = skb_cow(skb,
 			  skb_headroom(skb) + (len_delta > 0 ? len_delta : 0));
 	if (ret_val < 0)
-- 
2.55.0.1082.g2b9226bbc0-goog

