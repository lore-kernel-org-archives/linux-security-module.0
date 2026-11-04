Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804603;
	b=VO9y6sdESb/wxilPsZOXwOLUtoEbl1qHOOqOl/5ZmsWL7jIaufCRRNbeHlrhVgYEzya1
	 cBRXWtTWZBx0z5HaAslEylla40XPr8CoRycaiEmTcFm4FMygiB/hSP2o9lHQRCl9h1I8C
	 b4Ovtph+0Lv47c20BqRu82bFfEa/4H+wGRZq+XuwZYmfCKajkpcDw3++KqKYUIfgn2Mme
	 L19SHSafwdxLGxNgR/e5GM/YNFpCl2RN5zc0XAj99R2JclA83XfBNTQkpl/wkuOeIFjvG
	 KZMqjLa9f3cxXEEKJKxi+C/cyNjJ1s3iph0MugOZFbKcoNe8FAIlCC2ql4N3wyFzXpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804603;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Uni+Z0T4SG7Ioi2p7Z8tCIIKHZdX5aBt+e2ZhlFRtYQ=;
	b=lT/1qWcoRxIWKom3+VFlgBOnSa0tugrvjmuFgh7wAbjEZ0i0oq10e+3Y+c/5vdbdPNqP
	 mJQ1d0UYLEudlPpM8UN1RCgXM3mVkSEIKfgTNqLXG3isOVN2C/CSGp/JAx/SrEf8YyTfO
	 LjDoFfRC4eys3Bwm/d4aOBC2QwvLIbWibDw/93fXUPUXF5sl1HCyBUuSYuEAoLD2aJpy4
	 RS3DrFbJq5TOegctvkWNbkUZAB++u4qMnn7JKi/BvRmNk/89TYCoqERAMkacHtowrq4Os
	 caU8nQ7cUrgFJ/qeor1qzVaOZqareRnh78mmKCVS/YjfXqz20M+gfUK64VzY6JKGZ7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L6+AT29Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B9F606A33F;
	Wed,  4 Nov 2026 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L6+AT29Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9E71F000C1;
	Wed,  4 Nov 2026 15:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804602;
	bh=Uni+Z0T4SG7Ioi2p7Z8tCIIKHZdX5aBt+e2ZhlFRtYQ=;
	h=From:To:Cc:Subject:Date;
	b=L6+AT29Q2hMXIGbLQ3SdGfAHeSKWx7zIYPZU+DJhmWtpmvWX5E5PW4HnIn6nr39GP
	 VTqP51a8+UYN7MGcKxBmXsszzx9brRfmQz9vH3rFSyNKyvpdsjNFNyoTN+w0/3dw0X
	 Wu9YQMvteQ7DyQWyUsf+6xFQc11ZdHqODiaKTM5CgNMZC2vbtwY0AZSu0cP2Q7wZps
	 2tDoKMEhoLTYQZisrnMbgGj5rOwS8LBB1jTv+JsU08/N8oyOBO1sqPyV/j43A2SDF3
	 4/OPCfJhdO7NuxGUnnpmLIBQJ2kqfVlnuC1Rk34SJY9xTsuW3FCMSrmXRcC9/tXbbS
	 v/6T6aZREyCQQ==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH net] calipso: do not charge request socket options to the listener
Date: Wed,  4 Nov 2026 16:03:18 +0100
Message-ID: <20261104150318.1156620-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
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

calipso_req_setattr() and calipso_req_delattr() allocate ireq->ipv6_opt
with ipv6_renew_options(), which charges the listener sk_omem_alloc
through sock_kmalloc().

tcp_v6_reqsk_destructor() frees ireq->ipv6_opt without uncharging it,
so each request socket leaks its options size from the listener
budget. Once sysctl_optmem_max is reached, sock_kmalloc() fails,
calipso_req_setattr() returns -ENOBUFS, and tcp_v6_route_req() drops
all subsequent SYN packets. __sk_destruct() also reports an optmem
leakage when the listener is destroyed.

Uncharging in tcp_v6_reqsk_destructor() would not be correct: after a
migration, req->rsk_listener is no longer the socket that was charged.

These options belong to the request socket, there is no reason to
charge them to the listener. Change ipv6_renew_options() to use
kmalloc() when its sk argument is NULL, and use this from
calipso_req_setattr() and calipso_req_delattr(),
like cipso_v4_req_setattr() which uses kzalloc().

Note:

After this patch, calipso_req_setattr() and calipso_req_delattr()
no longer need the listener. Commit 10876da918fa ("calipso: Fix
null-ptr-deref in calipso_req_{set,del}attr().") could be reverted
in net-next (also removing the then unused sk variables), so that
CALIPSO works with SYN cookies.

Fixes: e1adea927080 ("calipso: Allow request sockets to be relabelled by the lsm.")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/179378292255.488856.6917577451813010963@kernel.org/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org
---
 net/ipv6/calipso.c | 12 ++++--------
 net/ipv6/exthdrs.c |  5 +++--
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index e399a42e30839a1ceab2dfcd2b29beaca13f2dc1..4cd0ae9313b322204f03b010021ab6ae005f05fb 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -1219,7 +1219,7 @@ static int calipso_req_setattr(struct request_sock *req,
 	if (IS_ERR(new))
 		return PTR_ERR(new);
 
-	txopts = ipv6_renew_options(sk, req_inet->ipv6_opt, IPV6_HOPOPTS, new);
+	txopts = ipv6_renew_options(NULL, req_inet->ipv6_opt, IPV6_HOPOPTS, new);
 
 	kfree(new);
 
@@ -1227,10 +1227,8 @@ static int calipso_req_setattr(struct request_sock *req,
 		return PTR_ERR(txopts);
 
 	txopts = xchg(&req_inet->ipv6_opt, txopts);
-	if (txopts) {
-		atomic_sub(txopts->tot_len, &sk->sk_omem_alloc);
+	if (txopts)
 		txopt_put(txopts);
-	}
 
 	return 0;
 }
@@ -1260,14 +1258,12 @@ static void calipso_req_delattr(struct request_sock *req)
 	if (calipso_opt_del(req_inet->ipv6_opt->hopopt, &new))
 		return; /* Nothing to do */
 
-	txopts = ipv6_renew_options(sk, req_inet->ipv6_opt, IPV6_HOPOPTS, new);
+	txopts = ipv6_renew_options(NULL, req_inet->ipv6_opt, IPV6_HOPOPTS, new);
 
 	if (!IS_ERR(txopts)) {
 		txopts = xchg(&req_inet->ipv6_opt, txopts);
-		if (txopts) {
-			atomic_sub(txopts->tot_len, &sk->sk_omem_alloc);
+		if (txopts)
 			txopt_put(txopts);
-		}
 	}
 	kfree(new);
 }
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 96c8402a27a549a5001b42e9402c41acd2a4f49a..ccc549de3c8a07e605f5a27a7c8cb251d83b5f4e 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -1281,7 +1281,7 @@ static void ipv6_renew_option(int renewtype,
  * not copied into the new set of options.
  *
  * The new set of options is allocated from the socket option memory
- * buffer of @sk.
+ * buffer of @sk, or with kmalloc() if @sk is NULL.
  */
 struct ipv6_txoptions *
 ipv6_renew_options(struct sock *sk, struct ipv6_txoptions *opt,
@@ -1309,7 +1309,8 @@ ipv6_renew_options(struct sock *sk, struct ipv6_txoptions *opt,
 		return NULL;
 
 	tot_len += sizeof(*opt2);
-	opt2 = sock_kmalloc(sk, tot_len, GFP_ATOMIC);
+	opt2 = sk ? sock_kmalloc(sk, tot_len, GFP_ATOMIC) :
+		    kmalloc(tot_len, GFP_ATOMIC);
 	if (!opt2)
 		return ERR_PTR(-ENOBUFS);
 
-- 
2.53.0

