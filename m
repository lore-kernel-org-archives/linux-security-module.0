Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95523208BE
	for <linux-security-module@vger.kernel.org>; Fri, 26 Jan 2024 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294739; cv=none; b=dKaBs+KiFuhWaVkCR51ka9OgHxCmNuD2TUUB4rdvb2lE6/ybibDLFcVmknxPjnRezcCPVLbpf1BqevHy7odbOyIXxqiQhm/H6E63YtXII8k37cdo2UuOg31jaPugnVj4PCGdPe/GRVP1ISZWNvdB/MWHgkrtiHE4IdQKy1ZQzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294739; c=relaxed/simple;
	bh=iugxUc//VB+4fCt5nF+twx71qeqd8rZVc3h9NZ/wDR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mUaVSnFKDf/4HIjm4ovUpferTmFCFtUkpgZYYqNSwL4iNYhoLtvvMM9gk/N1Uy9ULbotZ2lDZt4C1z1QKqPm3M6mJtNoi2gAr6NQtGNzR4JDpiuPthDAKVMWz83BpNFx2E7g9mmmH3upiBW6mxJifei7evkV5CJOWc9tQzIZqo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cSfShswL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSfShswL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706294736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zPwOkU9NQD3w9RIGp6Z8HeMeeH68hR451yY+m+zjj+c=;
	b=cSfShswLRtGyd0T5zw3CoXFXo5ZrrBo1R9MkJ9LbBbGJKwYiGlbOnkFu3gdd0bvyW6qt4/
	zrQg9vMCkYKVWgm209Jf9CZRq4KB3w7vqzD+CJr80Cql0XxqwKsF3EbzUVXA9F0ZcwVc6f
	+hYmm7EAyYkIaEfD5PfrT4U8MWSG1sU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-PvU1tW6lOFSw0Q0LhwLlBg-1; Fri, 26 Jan 2024 13:45:34 -0500
X-MC-Unique: PvU1tW6lOFSw0Q0LhwLlBg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-339250f6515so381381f8f.2
        for <linux-security-module@vger.kernel.org>; Fri, 26 Jan 2024 10:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706294733; x=1706899533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPwOkU9NQD3w9RIGp6Z8HeMeeH68hR451yY+m+zjj+c=;
        b=VTcVe+6JMUzcA0x4JA2hORg5HBzTtiohNJX61rDXeKQAFBTNeynDqf08NdUWALTULS
         LUxdcQOui2QOPQl5IRmEfekD7ELXCQJ9cvjOSJVLqDXy8f3JApHkFW/BpAaLvymG10TO
         Yb3w3wvta2qhLMXcKNpuPf7nU7FBTp0KSfv5JleDxa8AbUxgl2+5w8A5yDj7i2aI1QeY
         dw9VDGMOLhWlN0wIjDaFuwLQjYGuzq2JGeNE8ttNbFZ5G9LBQPt48Pv+Ma/zfXgh60m4
         2pIPQ5uJkvJx9aPaFWnaHGMd59g3HEEDuulWObU31nd1lMZO+YtEh6hfdhdPm/O8lPbT
         HAvQ==
X-Gm-Message-State: AOJu0YyR2IF0yjhso6XS7hJI6y+XP6zRplTLmj2BlPdWXofNGbNxXYhQ
	bXKQkYLxkZEqq8TUog0UJ/Jz5S/kS6cGiZjNhpR2+Bc9wqptADI1PniaHFbTOlWrmHS0NMydj+3
	GjThoqG/PJkO/kfel7WQjtKIOPDwxhe/aPnmrK5K/PGSxHgwTWtvrwQfN7L2kb086Mh6ZKCQyTg
	==
X-Received: by 2002:a7b:c414:0:b0:40e:c2da:1b2b with SMTP id k20-20020a7bc414000000b0040ec2da1b2bmr169545wmi.179.1706294733787;
        Fri, 26 Jan 2024 10:45:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtAsQqCCgt5cm+lp5q9fntCHG7c+2YFRMsZAKoY9e7KI2Wbom7URjQJ8wprLCN//3XcOVbeg==
X-Received: by 2002:a7b:c414:0:b0:40e:c2da:1b2b with SMTP id k20-20020a7bc414000000b0040ec2da1b2bmr169542wmi.179.1706294733475;
        Fri, 26 Jan 2024 10:45:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id l1-20020a05600c4f0100b0040e549c77a1sm6607265wmq.32.2024.01.26.10.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 10:45:32 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH] lsm: fix default return value of the socket_getpeersec_* hooks
Date: Fri, 26 Jan 2024 19:45:31 +0100
Message-ID: <20240126184531.1167999-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

For these hooks the true "neutral" value is -EOPNOTSUPP, which is
currently what is returned when no LSM provides this hook and what LSMs
return when there is no security context set on the socket. Correct the
value in <linux/lsm_hooks.h> and adjust the dispatch functions in
security/security.c to avoid issues when the BPF LSM is enabled.

Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/lsm_hook_defs.h |  4 ++--
 security/security.c           | 31 +++++++++++++++++++++++++++----
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 185924c56378..76458b6d53da 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -315,9 +315,9 @@ LSM_HOOK(int, 0, socket_getsockopt, struct socket *sock, int level, int optname)
 LSM_HOOK(int, 0, socket_setsockopt, struct socket *sock, int level, int optname)
 LSM_HOOK(int, 0, socket_shutdown, struct socket *sock, int how)
 LSM_HOOK(int, 0, socket_sock_rcv_skb, struct sock *sk, struct sk_buff *skb)
-LSM_HOOK(int, 0, socket_getpeersec_stream, struct socket *sock,
+LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_stream, struct socket *sock,
 	 sockptr_t optval, sockptr_t optlen, unsigned int len)
-LSM_HOOK(int, 0, socket_getpeersec_dgram, struct socket *sock,
+LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_dgram, struct socket *sock,
 	 struct sk_buff *skb, u32 *secid)
 LSM_HOOK(int, 0, sk_alloc_security, struct sock *sk, int family, gfp_t priority)
 LSM_HOOK(void, LSM_RET_VOID, sk_free_security, struct sock *sk)
diff --git a/security/security.c b/security/security.c
index 6196ccaba433..3aaad75c9ce8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4624,8 +4624,20 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
 				      sockptr_t optlen, unsigned int len)
 {
-	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
-			     optval, optlen, len);
+	struct security_hook_list *hp;
+	int rc;
+
+	/*
+	 * Only one module will provide a security context.
+	 */
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
+			     list) {
+		rc = hp->hook.socket_getpeersec_stream(sock, optval, optlen,
+						       len);
+		if (rc != LSM_RET_DEFAULT(socket_getpeersec_stream))
+			return rc;
+	}
+	return LSM_RET_DEFAULT(socket_getpeersec_stream);
 }
 
 /**
@@ -4645,8 +4657,19 @@ int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
 int security_socket_getpeersec_dgram(struct socket *sock,
 				     struct sk_buff *skb, u32 *secid)
 {
-	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
-			     skb, secid);
+	struct security_hook_list *hp;
+	int rc;
+
+	/*
+	 * Only one module will provide a security context.
+	 */
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
+			     list) {
+		rc = hp->hook.socket_getpeersec_dgram(sock, skb, secid);
+		if (rc != LSM_RET_DEFAULT(socket_getpeersec_dgram))
+			return rc;
+	}
+	return LSM_RET_DEFAULT(socket_getpeersec_dgram);
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
-- 
2.43.0

