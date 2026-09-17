Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EBC37E316
	for <linux-security-module@vger.kernel.org>; Thu, 17 Sep 2026 07:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629352; cv=none; b=ARa1PnLXLZgH51q1I4fNztLVe5eddqrGJe4LgfqN8/Oczn4fK2IIFmo86krCD3CejFJYbMGlFypNcKB2rlNqcYqz5sUyxRPqNx0oKEChI8oBNZ0IHcG/pYmVdjT5pT+RI9sjTiZ2kj259x8gcdo2zBbwO5OJbehWal1bTRSp7tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629352; c=relaxed/simple;
	bh=HnHrYyIVv2s470HtUwrwJM+7+qpKzMXxhqSqUbVn/Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AIoK/bW2Zsu5KIwnYuHi8r3bWAB5e8KMusu9nSnFS3OzuZwB/+qhIVr6HKTqhX5XS5onxQMD+lU3pSuXJd2f/3ipKPr0WbU4PaEMObw6P6J3KLJteuHnzJy/kQAmS/1074Fovk3wbnWEg4r9UmMtJL0ULMK8iy/Md2q5yo2EQx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpmlHyfU; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpmlHyfU"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f7dbfso63060666b.2
        for <linux-security-module@vger.kernel.org>; Thu, 17 Sep 2026 00:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789629349; x=1790234149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HohI1Z+vAbMN3nzIgElLiEIYWINf1K/wsHdRKuRWdGI=;
        b=XpmlHyfUCzgur5yBek2B+SJjedFfqwxdsO2L3GIrREGozuXGEWeFtze0y110D2NXNA
         vFJUQ///DWoCQKv0oArCYTtahDp2Mx3T19EY2tVhhFj5vT068oNoMmOzED8hwC2rvF9p
         BAbV9/NsPg+SqAOLttSWOnYaOwkLdknbTHeugh6oKDe2K+EL3CDAS2GpZ3vZTTTo0r3e
         Pn0JVsu7jI7POJaXZqNJj4jyec8/Yvs3/lVFYMXS7t+c/x6l+SsqggIlyYTwMDF2dNBU
         lP8MUGUcMXWItZ8gTV9tnqJCZNPhBSL2xGWtpvBzlnoap56M13wFgF+z8lMR4WpD4ZAA
         nCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789629349; x=1790234149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HohI1Z+vAbMN3nzIgElLiEIYWINf1K/wsHdRKuRWdGI=;
        b=YJXHFGVIff+mek4rrXCJt0xTJPqQ5OLhxcMiitLnnXRCtYH4ENTLv5jlotyeaSwBI3
         t/nKsYnRw5SYjCbpJAe5QzvNn11UNqpgiMvUc9lBxj1t+LJ0/lWZ5TjpqQT7pwrwMssL
         hqLreo7adWd4tq1l49Zsa9QkHTL109omsOcpgXTakiO5ZJb0w2QtqAbKXzhaPgoOvIFG
         oEvdVNY0hN85fRLOhmNGCRi3Il+9IqhMj/MF7kIDpgFP103RN36cE/97xsMxSUNLrhg2
         Y25ISLRfpK7z3yCz7XDHtc8cX+Y9eX3TFCntzruzX1//1aJWY2JuFsM3QRUDPxCdX8rA
         Zepg==
X-Forwarded-Encrypted: i=1; AKwUvBxR2Ea/umSVSyZgluL+YssKs0Wrj3lZ6uC0srKFaupX5R955O0tYil1cSawNw1Q9fw0geIuKwmlt2dMxSBpBsBi3KDNMDM=@vger.kernel.org
X-Gm-Message-State: AFuF++nR/egNWYXFfClgjSPdmj/dX23xLDBLoWUwhQ7f72NrGhUzJyBx
	ESmCRazToiDim9YUA09CBS3/R98g9jliBLr7VgJTIFzvw9pjiimyB0eQ
X-Gm-Gg: AYBFou3XjHF3ENjFMHxuFJ+2xVl/GtvW5N2/HXBWSdRV1rDolWZN/uNe/6zF7J4OSli
	nni3neeBIeQflH79lYRsweG6BmOG3Auxs1n0cgi/ZRWKrYdK9XfBNlPP/xJkT69jrf+5gAymEki
	Z42ZGq3bUf5if67R8CDW+UQRUlPoRNJBLmcWh1suTwUwwA7gvzDfSOLzKXdEwmHX0lfErcrPcjG
	G3r/vSdJiN/kZ/WtOmoC10I6Y7i1OnSDSCck1UA4j2V9W5YWCKWLzbZ7HH5aDMjnwbckjZIPZk/
	OxqcGsKUFmm+j8yLqRd98TtdsMPFEHfsfIp45LED/HGXFx9ENrxV5G7QyB4stPIvd/dNsVabfJR
	xr6w887WiA5qkVDfrDRX2b/0rt5B63b3/z4L/YvejalVEa7hf2pgyNgPXtTBD0PGeYizhlKQMiY
	2Yby1Rd7FCK9U7HdkjDx7R9aS5193YE4NPd6jLWqOSsU9wcWtKDOkBdbQrLfb8vzuAd6tOL5U3V
	e4uFIvfW8ZYb3CHpErWG62Pg1v/vkmyEyr/XoBU1KRJ35F6Z1oH3jIZYeuuaANKSerTTyAkaw==
X-Received: by 2002:a17:907:961a:b0:c29:4b79:e41a with SMTP id a640c23a62f3a-c29e52ce1b4mr372118166b.20.1789629349019;
        Thu, 17 Sep 2026 00:15:49 -0700 (PDT)
Received: from galeon.localdomain (84-40-221-93.cgnat.inetia.pl. [84.40.221.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29e801cdfesm194725166b.58.2026.09.17.00.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 00:15:48 -0700 (PDT)
From: Maciek Borzecki <maciek.borzecki@gmail.com>
To: apparmor@lists.ubuntu.com
Cc: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maciek Borzecki <maciek.borzecki@gmail.com>
Subject: [PATCH] apparmor: handle NULL peer label in AF_UNIX context updates
Date: Thu, 17 Sep 2026 09:15:13 +0200
Message-ID: <9a2d420a1757516f1e9ad4e9a0e9f17b9ba92c72.1789628002.git.maciek.borzecki@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a confined process performs the first file permission revalidation on
an AF_UNIX socket, both update_sk_ctx() and update_peer_ctx() can be called
before the socket's peer label cache (ctx->peer) has been populated. In
those cases they pass NULL as a label argument to aa_label_is_subset() or
aa_label_merge(), which immediately dereferences label->size and causes an
Oops:

  RIP: __aa_label_next_not_in_set+0xd/0x110
  CR2: 000000000000004c
  Call Trace:
    aa_label_is_subset
    aa_unix_file_perm
    aa_file_perm
    apparmor_file_permission
    security_file_permission
    rw_verify_area
    vfs_write
    ksys_write

Observed on Arch Linux kernels 7.2.4-arch1-2 and 7.2.6-arch2-1, triggered
by snapd unit tests writing to a connected AF_UNIX socket. The issue
persists across those stable updates.

Why this can happen:

* apparmor_socket_socketpair() calls unix_connect_peers(), which pre-
  populates ctx->peer for AF_UNIX socketpairs. Because of that, simple
  socketpair() tests never exercise the NULL-peer path.

* For an AF_UNIX SOCK_DGRAM socket that is connected explicitly (or via
  any path that does not go through unix_connect_peers()), ctx->peer is
  still NULL the first time aa_unix_file_perm() runs. The permission check
  succeeds, then update_peer_ctx() tries to merge label into ctx->peer and
  update_sk_ctx() calls aa_label_is_subset(plabel, ctx->peer). Both
  dereference NULL.

The following reproducer profile demonstrates the bug:

    profile aa_unix_server /path/to/repro {
        #include <abstractions/base>

        change_profile -> aa_unix_client,
        file,
        unix,
        /path/to/repro rmix,
    }

    profile aa_unix_client {
        #include <abstractions/base>

        file,
        unix,
    }

Run a program that binds an abstract AF_UNIX SOCK_DGRAM socket under the
server profile, then forks a child that changes into the aa_unix_client
profile, connects the DGRAM socket to the abstract address, and writes().
The write() path reaches the context-update code with ctx->peer == NULL and
oopses.

Fix all spots in update_sk_ctx() and update_peer_ctx() that can see a NULL
ctx->peer:

1. update_sk_ctx() RCU check: only call aa_label_is_subset() when
   ctx->peer is non-NULL. If it is still NULL, an update is required.

2. update_sk_ctx() spin-locked section: treat a NULL old peer label as
   "plabel is a superset", i.e. populate ctx->peer with plabel.

3. update_peer_ctx(): if ctx->peer is currently NULL, just store the new
   label directly instead of trying to merge with NULL.

Fixes: 88fec3526e84 ("apparmor: make sure unix socket labeling is correctly updated.")
Signed-off-by: Maciek Borzecki <maciek.borzecki@gmail.com>
---
 security/apparmor/af_unix.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
index b908e744818c9bfef1638c6abadec75c241dc9b9..4762b70cdc43b5dac87f079067eca0ca74d5dd52 100644
--- a/security/apparmor/af_unix.c
+++ b/security/apparmor/af_unix.c
@@ -659,7 +659,8 @@ static void update_sk_ctx(struct sock *sk, struct aa_label *label,
 	rcu_read_lock();
 	update_sk = (plabel &&
 		     (plabel != rcu_access_pointer(ctx->peer_lastupdate) ||
-		      !aa_label_is_subset(plabel, rcu_dereference(ctx->peer)))) ||
+		      (rcu_access_pointer(ctx->peer) &&
+		       !aa_label_is_subset(plabel, rcu_dereference(ctx->peer))))) ||
 	  !__aa_subj_label_is_cached(label, rcu_dereference(ctx->label));
 	rcu_read_unlock();
 	if (!update_sk)
@@ -682,7 +683,7 @@ static void update_sk_ctx(struct sock *sk, struct aa_label *label,
 		if (old == plabel) {
 			rcu_assign_pointer(ctx->peer_lastupdate,
 					   aa_get_label(plabel));
-		} else if (aa_label_is_subset(plabel, old)) {
+		} else if (!old || aa_label_is_subset(plabel, old)) {
 			rcu_assign_pointer(ctx->peer_lastupdate,
 					   aa_get_label(plabel));
 			rcu_assign_pointer(ctx->peer, aa_get_label(plabel));
@@ -700,13 +701,18 @@ static void update_peer_ctx(struct sock *sk, struct aa_sk_ctx *ctx,
 	spin_lock(&unix_sk(sk)->lock);
 	old = rcu_dereference_protected(ctx->peer,
 					lockdep_is_held(&unix_sk(sk)->lock));
-	l = aa_label_merge(old, label, GFP_ATOMIC);
-	if (l) {
-		if (l != old) {
-			rcu_assign_pointer(ctx->peer, l);
-			aa_put_label(old);
-		} else
-			aa_put_label(l);
+	if (!old) {
+		rcu_assign_pointer(ctx->peer, aa_get_label(label));
+	} else {
+		l = aa_label_merge(old, label, GFP_ATOMIC);
+		if (l) {
+			if (l != old) {
+				rcu_assign_pointer(ctx->peer, l);
+				aa_put_label(old);
+			} else {
+				aa_put_label(l);
+			}
+		}
 	}
 	spin_unlock(&unix_sk(sk)->lock);
 }
-- 
2.55.0

