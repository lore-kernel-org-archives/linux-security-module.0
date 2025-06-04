Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F3328FFC2
	for <linux-security-module@vger.kernel.org>; Wed,  4 Jun 2025 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749044320; cv=none; b=HUnDnzuYojum5segOydKTdAAR2YHHijC6pfToxBW5pjP7kf2dmPNwR2hSkVn9aCcuVsa+Qkrt14XmwffJ4CnCVAVlBef1Pc89lQqm5ncYc6IydowfHzGsUAvM8+oViMrwrSpJHPuVKqSPCqBh0fC6AxOelRJGpzqDCDKN+UQ2Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749044320; c=relaxed/simple;
	bh=cGErVJ4bmTUQIicSnO7KQhivuRsnuHBrKz4OD/rUbh4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uFcoIqsZi+KsUqJL+JCX8mPLXfnpTXO1DZ30R5xm8U3BGddgfNASNJWPFrPT2onw0ARr4kX+mfzQOR8OgSa7cQufTykQyUXIYuwWmoJ1jew7e97tCcOClTQz1GZBlpT/WInU76yngfFiYrpRN7bUV5MoJDu2c47GwXUmk9AN2QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ihgd5vuM; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ihgd5vuM"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2356ce55d33so53789945ad.0
        for <linux-security-module@vger.kernel.org>; Wed, 04 Jun 2025 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749044318; x=1749649118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=POMSTg6GJrne9/5wXc7WtA5ZTG+gDotXCkvMvnEGUlg=;
        b=ihgd5vuMVxI/gwPLRxKwKXSIcRXv4fA+gZ+5AiMEYXRfvI5vc789btaBl1t7mgpwaJ
         YTBC0Q5nSyOqiaILmPW3TKuhakbSRJbih99hkQEgbyl4ykuEyMxNPTg7qI7JVvuJHy+g
         63x5Oxcb4wt25pFLbfxO9pyUElc/yra88uf/sNyTry4PRmf3EnyDAyga2Cszx+PJfsph
         0lr0Mk6Dz4xI1qPnDEyg7aiMpqk6BbOKz6iH6JiCEBO0NH7G3K2llzepSkYNpg7cf+p3
         I+ksYlfodIeKM8Fu3j5tf4Me0POEQIC9XmGiUN589zyIigvqYVDt13jWaL0SDDLyZKwg
         hcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749044318; x=1749649118;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=POMSTg6GJrne9/5wXc7WtA5ZTG+gDotXCkvMvnEGUlg=;
        b=o1lZ5OBeGTQHwWtFdZV8TmyJWm1qbaUqhtYKoJX1m3e9QXsjh47fiMQnxaHScdFJof
         lXQLAGMfT2hF+kv5xL4dL1kVgpWmEfWaHEvi1gI4Aiz8jOy+fTFPf7Hng1br3jNiTzF8
         mFX6RUmmj2Dw8uPrfB09QyPLqnNZowljFGLP9JBCsjjoF8W89PmPvr+sAsAe0xNyh5R0
         wiqCCQvVvgEqMvk47K33K7ixezY65274LBUXFUnFJKzGy8mnG1yxO+f5MhvY9kUmJGkw
         zpZiN6FbHSIJfD8hBdvLcL/G2eeZfC+jjfR8SKfDuyKCI0Ix5MKTA5bmsjcMgtIajAuk
         p4bg==
X-Forwarded-Encrypted: i=1; AJvYcCXwZOAHxDPdlPikHJJ7/zig6twJAyGFqbvLIpTVSb+EyUeRH5OwDboa2vJceZITIjk6ZXOxIDDE/aApV6F71PvfL8RBxAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq3aKHj1KWPutwiOyRZ6nqcfoRoqG/Aplmi6H6YmAvUWztKNpA
	j7PITREWr/tLQFS34r+ulNeyi5bFdVLmPRcJqRpE8+3Wx6jeh7o2XbbuGazlhGlkbwMT6Fk/qKk
	pnWxBNXj1S2YkfQ==
X-Google-Smtp-Source: AGHT+IF4vNgBqWuqwN249CIMQHd9G+lKks99KaKviFeWr4MDQkTIvS3MGZ7G7Qa3Isdk0xrtzD7k4gXdR3NpcA==
X-Received: from qvbnh10.prod.google.com ([2002:a05:6214:390a:b0:6fa:a797:22e5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a0c:eda9:0:b0:6fa:fdb5:4a9d with SMTP id 6a1803df08f44-6fafdb54b14mr7053036d6.44.1749044307524;
 Wed, 04 Jun 2025 06:38:27 -0700 (PDT)
Date: Wed,  4 Jun 2025 13:38:26 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604133826.1667664-1-edumazet@google.com>
Subject: [PATCH net] calipso: unlock rcu before returning -EAFNOSUPPORT
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paul Moore <paul@paul-moore.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot reported that a recent patch forgot to unlock rcu
in the error path.

Adopt the convention that netlbl_conn_setattr() is already using.

Fixes: 6e9f2df1c550 ("calipso: Don't call calipso functions for AF_INET sk.")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org
---
 net/netlabel/netlabel_kapi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 6ea16138582c0b6ad39608f2c08bdfde7493a13e..33b77084a4e5f34770f960d7c82e481d9889753a 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1165,8 +1165,10 @@ int netlbl_conn_setattr(struct sock *sk,
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
-		if (sk->sk_family != AF_INET6)
-			return -EAFNOSUPPORT;
+		if (sk->sk_family != AF_INET6) {
+			ret_val = -EAFNOSUPPORT;
+			goto conn_setattr_return;
+		}
 
 		addr6 = (struct sockaddr_in6 *)addr;
 		entry = netlbl_domhsh_getentry_af6(secattr->domain,
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog

