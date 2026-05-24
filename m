Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06E22DF3EA
	for <linux-security-module@vger.kernel.org>; Sun, 24 May 2026 04:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779596092; cv=none; b=JQWAdCcpeEF0QOrWHBKmRGATwA0Y2jceUUQ/aJLmcNlUzzJiTnl6QpQKmM6jNr6i/bMfHw6e11NQHXpbtpTuoOtNJFvOouTwzFDGkprvwOq5QMGvqZH0axDVLpN/O9cd6rnlOmQW7pic7ioc1KOIaoDdmvapiJTdazjWcgvkOFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779596092; c=relaxed/simple;
	bh=TEOa/Iseq3bNDqxAi8ANzlQGhBUm4ry837taToh+6gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qvwdXq9kGLBArPQguT2FZYqMCWbynSsVo7IxjFgKvSMF4GMUNun74BH7Kw1fvL07vVU+/Isn3Ca6mKHW+sZNSm+nEb8D3mRLT3EjNvyUzTIbLuKOFOrFqW744J8YHqNmrUjtSJZW27bdbesSOWDXOnNJGIX+bueWYkwYyTVmXpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVBn0iqo; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVBn0iqo"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2f0ad52830cso11039028eec.1
        for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 21:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779596090; x=1780200890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qALrKcl/VHbNho7HBnjpVTkFJAqEJcLvpErXnBAKDNc=;
        b=YVBn0iqoVc4vHGoOW9n1LpeZtHcJ+8qKCEFpr2NfKUkjQ4ViScNXQDDSA0/MVXvh7M
         Huxj6GjwNUKM7xhfnVsoXg7ssxPYp1E7tJb7C0sjp42CSaInBTwPLLkRANkJJuR7PqdG
         DVKJIsfilgrcDAmH/C3MipN4yYdcraHcsX4C23fdFRS5QbEKin0MBmBRymFYYGsFfE1+
         F75BHQurnIuwDtuf0QaLxpGoIpag8+QoWX+yux8BMVN0ltsplzaVfNcfOn1IAhrPm8l5
         vZWMIzfbifejm+ea1SXaVSqH7XvhbzOG/PW6ynws4LFhYvkpqQCFqwhzwrwuvt8/U7u5
         bylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779596090; x=1780200890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qALrKcl/VHbNho7HBnjpVTkFJAqEJcLvpErXnBAKDNc=;
        b=jWOOmi5O4cmEECxDUucLPWsxuqUcJ7h1aNdp6AcHHcnPNUK/k9zYZbxMOAOkoMfhNx
         oGU7dpdSbvBpxeWC/9iQllI7KiV1jHwXAatQg7WNN9gWwsNSTl8XfwzNuqzUi7GEkEbv
         oo34quTqpjcQ36hIBPcGJ0hNELH0MBut1FN1syiuOE6ES3HzWPNp0E9HUALPT3TqYJcX
         LoXZmhro3sAFCpvXUZV5cEajaFFEYPtD+frFMygm1GVqiwHEiVt1SrzAyoCUZgUjxpg5
         J0XHlJnMCIxSI4fgkGYHh7o3fDTQo9/o+nwmpuJTS9jR0ixviGiQskSKTLn4zM3HV15k
         o7BQ==
X-Forwarded-Encrypted: i=1; AFNElJ/CSxcgt0cjKNSndE5ENSzzHPoG/tR5lhFlPydRkvU4ltR4oX/ZXpzA3b4KhfoEGvBAhgdoonvtAnAkNhhhC8JMGWr4gHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEbKEOwa7hlVYIF4WgYF1XiZUXXS4ymLNKFFnVrwLn8EeqWcmP
	GtDhZk+HukllPAuxUwkmWtqnyWW+IGTcMSqpFC23oLwRGv4re2weuj2O
X-Gm-Gg: Acq92OE5is0w+vD7slNoCMKZGITSM2WlWABe5vutuygWWPkufIaOpgMy3DZoQfS2iOC
	/pJPbdjiJGvghPln53YukdidsdvuGRQ4znfHhXwiyYOoO5mVDewaa9PgulPUS9SIfEqHAo566K3
	/gZ8oN6Alab/CHMzyyxhwmNm4LN+6gD6Dx7n1EuCvNd6nEOhsne008x1W0i2l4CEnkBbT8FIZfd
	T/N6OMtw90uH0jayy2UYijins9WuK4WdIeH51GKZOIvHzsOhduH/DafDNs7q39u9PU0N6TEEMtO
	00dptxh7VsqvKeEG3j3ZPsklIl3cwSfc0Mf3iwI9mulBs57limkElhjxIzUroIFro80UlhHYUtS
	vrLoZwjYrHO7L5xUSqEcAIpUMRvu34aPpnw96h/pJqW1tLk28BoibnZCoUqRZeijsU+VZncSlrt
	gba7AJLHR7L/wYnJin/Rxi1xQxyKakSqk1CaHHVde34qkl
X-Received: by 2002:a05:7300:6da7:b0:2ef:8b72:1b9 with SMTP id 5a478bee46e88-30448d6218amr4757606eec.0.1779596089593;
        Sat, 23 May 2026 21:14:49 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3045245d6aesm4522133eec.26.2026.05.23.21.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 21:14:49 -0700 (PDT)
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
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Huw Davies <huw@codeweavers.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH net v2 0/4] net: trust-after-modification fixes for IPv4 options + netlabel
Date: Sun, 24 May 2026 12:14:34 +0800
Message-ID: <20260524041442.2432071-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Four small bounds-check fixes for a recurring pattern in IPv4 options
and CIPSO/CALIPSO consumers.  The parse-time validator stores only
the option offset into IPCB / skb metadata.  Later consumers (cmsg
echo, mrouted report, netlabel getattr) re-read the length /
pointer / cat_len bytes from the skb body and use them for indexed
memcpy or bitmap walk.  An nftables payload mutation reachable from
an unprivileged user namespace (CAP_NET_ADMIN inside the namespace)
rewrites those bytes between parse and consume.

  1/4 __ip_options_echo()                40-byte stack OOB write
                                         (KASAN: stack-out-of-bounds,
                                         Write of size 255).
  2/4 ipmr_cache_report()                Up to 40-byte OOB read of
                                         skb head leaked into the
                                         IGMPMSG cmsg delivered to
                                         mrouted.
  3/4 netlbl_skbuff_getattr() / CALIPSO  ~232-byte slab OOB read
                                         driving SELinux MLS
                                         category bitmap.
  4/4 netlbl_skbuff_getattr() / CIPSO    Sibling of 3/4 on the
                                         AF_INET (CIPSO IPv4) path.

Florian Westphal's [PATCH net 05/10] netfilter: disable payload
mangling in userns blocks the unprivileged-userns side of nft
payload-set at the source:
  https://lore.kernel.org/netdev/20260522104257.2008-6-fw@strlen.de/
These four consumer-side bounds checks land in the same direction
as defense in depth, also covering root / CAP_NET_ADMIN nft
FORWARD payload mangling in the init userns and any non-nft
mutation path.

Changes v1 -> v2:
  - 3/4 + 4/4 return -EINVAL on bounds-check failure instead of
    falling through to netlbl_unlabel_getattr() (Paul Moore).
  - 3/4 commit message drops the "Smack" mention from the CALIPSO
    consume path; Smack does not currently consume CALIPSO (Casey
    Schaufler).
  - 4/4 inline comment explains the literal 8: CIPSO option header
    (type+len+DOI = 6) plus first tag header (type+len = 2) (Paul
    Moore).
  - All four pick up Cc: stable@vger.kernel.org.

v1: https://lore.kernel.org/netdev/20260514165139.436961-1-tpluszz77@gmail.com/

Qi Tang (4):
  ipv4: validate ip_options length in __ip_options_echo() against skb
    tail
  ipv4: ipmr: clamp ip_hdrlen against skb_headlen in ipmr_cache_report
  netlabel: validate CALIPSO option against skb tail in
    netlbl_skbuff_getattr
  netlabel: validate CIPSO option against skb tail in
    netlbl_skbuff_getattr

 net/ipv4/ip_options.c        |  8 ++++++++
 net/ipv4/ipmr.c              |  2 +-
 net/netlabel/netlabel_kapi.c | 32 ++++++++++++++++++++++++++++----
 3 files changed, 37 insertions(+), 5 deletions(-)

--
2.47.3
