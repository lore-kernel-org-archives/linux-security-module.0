Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517F83370FF
	for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777509; cv=none; b=kcnWWjLw5eWw8KOdzXpqWEuz5gGpv/tSoHmTvOsP+L7hJjlQvHPmphMGbBVIpjhXdErXazS7CkWs8+DzHdisCvz2zv+lUJ9nI+vN//vlDqmJp9G5h5Q9zKUDEe0AHqZD/lM+TI46xvLe1Z0/vY6M4fyt6mGcpLMdG9KGH1o8svE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777509; c=relaxed/simple;
	bh=hYXAA7aXalALRkWgfGuP0w+RQxSmZCydDdMOcZxX1/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BopHU7mjIKEM8ZIDTvNESayKoAOc+pJRO5Q6XWozLOg6AfpkpMC8EKFRcZ5fcH/flnvC/jiyHa9Iht9C4sMEafoayq4K+AShqcvmSOOcvlh/YD8mGrgVXL8lZJEL5OxvDbHp43urx7s44aQjvSKViV3FuN6To3i1n2qJ9NcQj3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3/xM5B6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3/xM5B6"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba21d32776so55869085ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 09:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778777507; x=1779382307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G/6G3puYBsYAiupv27jIvciILYQ7U9jFSrjzR1wNOqo=;
        b=m3/xM5B6pG2NR5nomGt3ZmTwYSS3wPcf0QyCE0vtPz9LK/9lv/CztxkWi9paUxO8FK
         eCyeJ8/pNI2q2SVBED/isBR8aOb8V3dG8/6JFJLzdngLizZnpjIi+ZOAf1YKiFnCm+PN
         LL/WeeY6kTdkBtwHwqcW491WeHdbnwkYDJ8JE/Zqf5UX4/6vCGjkqAJZ2xp8usoRUYiC
         jOiREK4U6MBShmtgHym0WSnAqk+XINlKuSyIcJK5jTtMwKk2EzOmvd626nb4cSyTSKuX
         bVAXGGQBoTglP+Q1Xc9os4xh5pc9bJ5BvwqcoRsj6IQhNY4zXH61/9xVGu7ZhIy2zROT
         GAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777507; x=1779382307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/6G3puYBsYAiupv27jIvciILYQ7U9jFSrjzR1wNOqo=;
        b=pldBnfNFxC6kO7Lo+KpaETGZqTw1H6f46tPv5CcfwC6loDrBUKl2tGbO1mCxD1rF7f
         Bi/ubH4XM1Hfu/39HCy+ti2kNIxNmp/511jaUZ9xYcz4LaTB3gxauJavgcDUPqcI04xz
         JalN1O87fMp5qIKFabdaW2fAFQKLeYA1toMEm2qunNAy3pHxnpzpyaaMHE1CfulX44Ba
         yPF+B5i2aR+H9lqXGrEis8CMYBdKu6fn4yi2UG81E6X7smvaEPAf3GlBoTiFAbkmofDy
         UtkVcS7T7B8BigMqrqZ/56zX95pTfrpkVTF1bXIPkdQETKMhurrZwHsTHUJrBCAF5OMq
         hHrQ==
X-Forwarded-Encrypted: i=1; AFNElJ95tbJ7iXC36TabBXfdUnGjkxGMKjyahIcDKU4F81lmeluIuinsiZxprbnLIqaM//wl4DJ0ZSK266lI34SNm9ey/QrjPC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz44xtmuQbDxPIPSFXyoVqE7me993I9z6mk/FevUhPXLvw0gyxi
	X8mBQUSZ5/wZXWKQgvNRQUP0gOZV/eUuXy7VgGQZEZQfqGecbVd5WdGb
X-Gm-Gg: Acq92OERpNp0wxWgCux2xRg1OH9ehjpPNMj3n7DpFuXc/HTLt2Z0KK4Ts7mNWg1e+gJ
	e3/FONAolCbZDEpVa6mBlJAUgw9PvMnvYIp0jUvuZUEJ1gcnGKIDyfAJkuQ0nUGnSCsqSMiKz2d
	xhnWHY4mvUN3EYhpD+pH3yDQbk8sZOEQkQkSXzU/JgAHJXpCrvzhqMu+sA4WfB5gKR9J8psMjZ0
	VHGG1p0/f0y7vhCk9JJ/fN7kEkfFWdGP4N94MK+urFccynVdICWsDn/fpa/U+Cipm64ZRCtbgpB
	4heWs2UHidd8wxG9XNQrvcHYKTk9gv+DTAleqZXIS/ShLbsziVnIUeshV5T3QoUZRU6Zy0iXo/I
	78XrqEBWuEA9frjY8bwt9RJe5ZXAhV5/+dslTzkAeqpPVu3Mpl0JtNIFvt2SleUOdmhjIzyjukr
	/UIIXR3skMlogyKiTN323UZRncZ2CyDkbmS37b/3f9
X-Received: by 2002:a17:902:c94c:b0:2bd:2de3:5181 with SMTP id d9443c01a7336-2bd7e7c7ad0mr4187315ad.9.1778777507059;
        Thu, 14 May 2026 09:51:47 -0700 (PDT)
Received: from Tplus.localdomain ([114.243.117.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c2631basm27937825ad.34.2026.05.14.09.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:51:46 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	lyutoon@gmail.com,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Huw Davies <huw@codeweavers.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH net 0/4] net: trust-after-modification fixes for IPv4 options + netlabel
Date: Fri, 15 May 2026 00:51:30 +0800
Message-ID: <20260514165139.436961-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
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
                                         driving SELinux/Smack MLS
                                         category bitmap.
  4/4 netlbl_skbuff_getattr() / CIPSO    Sibling of 3/4 on the
                                         AF_INET (CIPSO IPv4) path.

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
 net/netlabel/netlabel_kapi.c | 27 +++++++++++++++++++++++----
 3 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.47.3

