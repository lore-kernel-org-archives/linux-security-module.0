Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245196;
	b=XPlHUsyntXB5y5ChcQEcykM6k4TcQCOkKRrXtETd/4sMU9xw2ShzNLsxNxX/06js7XH8
	 dSFZ11Jw4HU9/9ebmvXAAWn8B33uYg+QlNecKqdyPGU7/SIf3wdJrjsgXNoxNY/YPkhX0
	 o+/gHKWovuhYPodgzV/tgR0Zl2zMDjW0inVZx5YQd8vwomIt+FEYh6VDIWhUkwoq7HPlh
	 SNOw7BOKIzFHLt0ysMbQDLYnlyX+bv8oxAjqhmTS3voJZYLlQ+NPy5ZTGdudSOV8rT8we
	 AjTyGzoZ4/ElhI8vaY4YQQrMDow0g4Bu31kklwnxX8tSLPMRlOCa6FvO/lH7kPBKbcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AvvcKCfPVMD1PO+LNtg/bz0+Kp3wL3PLnEl4pzf6prs=;
	b=cqbx+l8gnyzdlhAPFEHapPEDX3YW6c/F5NqXSgl2j5USaDJBWWOuM8/tdKRBmuF390X3
	 ygQucgbSEIhN0SG4LXVRkT+9GX5hijqtyXB4z+KzSnxf8p/6GQjUf9/sny/NWIJzt4TUp
	 6mHRaXFxwSELAAmgO2WpSdxd0oiamaZ1hFvzVkNy6sE/xJx12lhR2vSZVZHSFQEclxMyu
	 B0jpkvNCItl+ybnAu75j736L87OCxHZJUQRfQINYI7UvEbZiyj9ag3NTiKDky7Jx+icLE
	 qW2EaPdrEhIpB32+ozYCll4im76c5pfVqEiHRhzJeHSsGlg02L2jJtNvxVN2aq8CmDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yv1xaFV1;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20F8606A325
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 03:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D20F8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yv1xaFV1
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e74a32a07fso2554645ad.1
        for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 20:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793245195; x=1793849995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AvvcKCfPVMD1PO+LNtg/bz0+Kp3wL3PLnEl4pzf6prs=;
        b=yv1xaFV1JgIdj3pYONuZXPUadEphqo10zclxkGanXVfIo1jyBv5EDPfAKGxTzrG1UU
         ClbtYmODiH4rju8A5h/c3AZiV7oydd459mCTJP0AC4BHZetZctvozhsB3BEhRt2SmgUs
         WB0em3YY5qnPuKbGraNIjXthL/JiNBCKVBF5dqymbw0I428l68G+CNNCdmI0ojCoVlgQ
         fD2QfWDNzpin9QgdOqT8eYR6hIkKYpb3e+LS9OFMa7L7WD6cKRvFmnAmkS3vqtCLlbCO
         lKEyOuD9XflPiplp8/VmKqF18yluUuypt6WJt+MCfJ6m1aInpV9E8N7BExXK31e8Zbvb
         TcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793245195; x=1793849995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AvvcKCfPVMD1PO+LNtg/bz0+Kp3wL3PLnEl4pzf6prs=;
        b=Hu3ks79CTAji0zEhSoC1i27spEPukN57kEL72kA9aaAQ6vrHbnbiZKmTmcNFwiDR5X
         93uJc3g/yPyxB2rDXYxle0YU6nGh6qiRNvQPLKrPKW08a3U/jB/ejTFz0vT9aqlj0egn
         g0F+Te/uQ6c6uopKfeTyRx7AZj8aqnFWfdtvf2jbzHOKOTVUpXHEgDbbbB/HrpUQBwNX
         O0GOn8gmkcmSd8iyaiLGAWIuXrRC6mKNCFYdeHFvJdp23RUeOZc0t0YDlsFugLN8AHXm
         OB+w1BETIA39ttKywW4b+bejDGKH3cX/mLvwuGkoVL509RHSe1Fit0KQhezYMJALUjeM
         oQMQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxIJEpHYrYC64Ywpyf2QT1afaO7lXzZ85IP3sc4Be1T5YiPXOZK2hht++COQ+dlmukA+qEMckusy79VHknd2vPV4vGLpg=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+yr0kMEc0r/qI/t/h6tfkmR864516W5MnDJcg6LxlLOtzoOM3
	DtiRsaUyoSyRP5e6xJN+BJcJixyvzf+EgD8SanFwTtvyXHmh5lgXqzcC
X-Gm-Gg: AYBFou2seZ9erWzvqneMRNCNB0QyvKB8uVj9cdzlCJ7aFX/XwOcqqqXDT/jf/4y/APo
	Zfe/CtePTmOSpK7M6awz2e6HupNZJBMneVOyrnUq8fccRTib6crOogtS7tNuJhTnnbzcSPdwRWy
	npTYYf/GBn7AtiZ3Mvwv4fH+AE7S/qtVPHh0y19iwKNEO6//c47Y63QXJFs4APmQ9iU13J2rinS
	tKAiYKY4+hYNy+qdgZrXa5k/FpthIVeAl/uK08gX3/O+sGg1gWgW06GSt/LAHZm9DPpa52h+wOJ
	TQIByfGI6/AxTTfebkvNkNRXvOnuotmgTaHNjIlgsovYMDjGfwX144YMsJzisNinFjIgbhjYWuA
	rDACC47HKm/4fe4eyghtq6yxR59vdX46Ar6MmWOER1nvInk0mjzBYgHf6YDnoITEpwUYvDF6ILy
	oOktT9UdNYd2Uu7qgwfWMHIBt3nKpTU8lmN7UdY5YU17CTCIUfg/BiQwRW2p5FVAbHy/WsH3Pyj
	tGMMWmK7hr5BtbWfFLvobNprmVPaZ3+YxIp/VS/irzVcDlsbEIP6AdWy+/62+bMlBWpho4+6nOW
	m2FkZSGl3eA4og/zLvgjr+AIPVlvNZS/wm0etaAxtaFBJhEugnzD5KjqfH7wZMUkVkNSsQno9ld
	iondhea6ffR2vsgKdQQzVOvInRS6UG1qDhcR30w==
X-Received: by 2002:a17:90b:2f10:b0:398:bad2:c10 with SMTP id 98e67ed59e1d1-3ae58316577mr6084276a91.6.1793245195196;
        Wed, 28 Oct 2026 20:39:55 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae57a2a053sm2311009a91.4.2026.10.28.20.39.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 20:39:54 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?Lucas=20Dupr=C3=A9--Rabinovici?= <omniameasunt@proton.me>
Subject: [PATCH net v4] cipso: fix optlen corruption in cipso_v4_delopt()
Date: Thu, 29 Oct 2026 11:39:42 +0800
Message-ID: <20261029033942.3644-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
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

cipso_v4_delopt() recomputes the option length by walking the option
buffer after the CIPSO option has been moved out.  The walk then reads
the stale bytes at the tail of the buffer as option data, and a crafted
setsockopt(IP_OPTIONS) buffer can make it treat one of them as an option
length, increasing opt->opt.optlen beyond the valid option data.

The corrupted length stays on the socket and is later used as the copy
length by getsockopt(IP_OPTIONS) and by the udp/raw/ping sendmsg paths,
where it exceeds the size of the buffers they copy into.

Compute the new length from the intact options before the move and
subtract the CIPSO length, and fill the padding with IPOPT_END.

Assisted-by: LLM
Fixes: 014ab19a69c32 ("selinux: Set socket NetLabel based on connection endpoint")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
v4:
 - rebased onto net (fcc00b15cb21a)
 - reworded the impact paragraph only, no functional change
 - first public posting (v1-v3 were reviewed privately)

 net/ipv4/cipso_ipv4.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 1aacbbeffbc64..e65a3f29d2caf 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -2013,6 +2013,10 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 		cipso_ptr = &opt->opt.__data[cipso_off];
 		cipso_len = cipso_ptr[1];
 
+		optlen_new = cipso_v4_get_actual_opt_len(opt->opt.__data,
+							 opt->opt.optlen);
+		optlen_new -= cipso_len;
+
 		if (opt->opt.srr > opt->opt.cipso)
 			opt->opt.srr -= cipso_len;
 		if (opt->opt.rr > opt->opt.cipso)
@@ -2026,11 +2030,12 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 		memmove(cipso_ptr, cipso_ptr + cipso_len,
 			opt->opt.optlen - cipso_off - cipso_len);
 
-		optlen_new = cipso_v4_get_actual_opt_len(opt->opt.__data,
-							 opt->opt.optlen);
 		hdr_delta = opt->opt.optlen;
 		opt->opt.optlen = (optlen_new + 3) & ~3;
 		hdr_delta -= opt->opt.optlen;
+
+		memset(&opt->opt.__data[optlen_new], IPOPT_END,
+		       opt->opt.optlen - optlen_new);
 	} else {
 		/* only the cipso option was present on the socket so we can
 		 * remove the entire option struct */

base-commit: fcc00b15cb21a6de76826e5012b2c758505f5e65
-- 
2.54.0 (Apple Git-157)

