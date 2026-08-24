Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE70A45C6E3
	for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2026 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587116; cv=none; b=tW10FsLB67QmECBlERfz+fN5rg7kBt1zkfRAK5m8uWC6XS+pyqxTPseZNs/RBuydBtSiu+NFHKIZUVf2MOOwt8sU+3I4TqQoXgniCM76uTWB0nPRZChd+gJR4V0L3v7TI+a4W8FR3+oIcXFzaTH3rCcEaXURVQwyYaM/dFVcTwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587116; c=relaxed/simple;
	bh=xDhxSHoAQrumn6RVXH1fBz/d/6fYTAithaJkCXKM+uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PGHlH8ntK83wQ7lF/p9Q/4YNCTZ1f6Xn5xn9qx2BE+vElyTfHco61RU0aQbinIEW33bP7QEUuU7hmYFaZQ4amLJTPBbVPD0T2jZdjJxkkTVSL09rtJdpNCu+tB9pTaF/QF62bq2Xk+ZQ/NHWBzJzGL6OdLOTtzATQjqrw5pS3R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=e2HHkaRO; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="e2HHkaRO"
Received: from sec2-plucky-amd64.. (lfbn-idf3-1-218-1.w90-22.abo.wanadoo.fr [90.22.217.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5E46C430A7;
	Mon, 24 Aug 2026 15:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1787587105;
	bh=gfFKaQOi4Err3b+O31jqaEbp6xjL3umeFA0MRlnVOlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=e2HHkaROWI2YY1of+Tw4FQWUZkHzkvowXNixBngkPZH4URQwYBYbJZgk+pirkOvUA
	 p/EBfLC5mnFKBsJec+aqZ4jMVL8D3Sz5GsZyugdtMADLYWCD+YAw089pkyZnM0b0CF
	 STn3O9s4lQPO5g9ZmnyO7lu5+uihfpc2HKf0cXn6KLISZtVryKhIxshh3b8osfXqYY
	 VzuZhvd1QoAnubSlr6ASaA2U75kp3wI1OfFefeVFBwAKdn+XHCFpX5CJC9UJhrH8w0
	 qJZEsKJZTUmBEJ6AVNsqDEozi9AtFT4xLn2+z1vqJkynhA7isuj2ZCF40O5WRpECxY
	 7/R56sv5ywTd5u6/D4Yso1LPsW3BwNfZssE8Uh5Iu2BF+ljiqaOQxQ++LSw5w0xG6j
	 xgSKF3ri4VbKhJoKUlZ1ze7pv6ejDmq4ARemd5Y7yHDDRrzs9EYyxAcs0yhjNWN/cr
	 a2NWSGrwYDMiKwpwbpzgUrB3pjhjqVEijFJov7K5CPvnlqt1HxXZQ7am+UC+nOvQ4c
	 mlIicrHE/+YLX3OvCG6d3eKZYKwyP1VDVsbBMO5iLMG6XXH1BSfkMyu+ltojPEvFHe
	 sxXG6D2sgrJMZcOFOXlTfvNPZUHTUAOvR9qdNcPsmzjHG2pYA6vv00bK/dA5+X13rn
	 4qWOeBKdKCiwOteOkG/5O5pY=
From: =?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	Aurelien Jarno <aurelien@aurel32.net>,
	=?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: [PATCH] apparmor: fix NULL ctx->peer derefs in unix socket ctx updates
Date: Mon, 24 Aug 2026 17:58:02 +0200
Message-ID: <20260824155822.9214-1-maxime.belair@canonical.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

aa_unix_file_perm lazily refreshes the AppArmor context cached on a unix
socket. Two of the helpers it uses assume ctx->peer has already been set:

	update_peer_ctx ->  l = aa_label_merge(old, label, GFP_ATOMIC);
	update_sk_ctx   ->  } else if (aa_label_is_subset(plabel, old)) {

where @old is ctx->peer. Neither aa_label_merge nor aa_label_is_subset
allows NULL. So both fault on the aa_label->size load.

  BUG: kernel NULL pointer dereference, address: 000000000000004c
  RIP: 0010:__aa_label_next_not_in_set+0xb/0xd0
  Call Trace:
   aa_label_is_subset+0x3f/0x70
   aa_unix_file_perm+0x5e8/0x9d0
   aa_file_perm+0x45a/0x550
   apparmor_file_permission+0x44/0xb0
   security_file_permission+0x40/0x100
   rw_verify_area+0x56/0x180
   vfs_write+0x7c/0x480
   ksys_write+0xbf/0xf0

ctx->peer is only recorded for stream connections and socket pairs.
unix_dgram_connect sets unix_peer(sk) without going through that path,
so a connected AF_UNIX datagram socket has unix_peer(sk) set while
ctx->peer is still NULL, and the first write that needs revalidation
reaches the helpers above.

Both derefs date back to the Fixes: commit, but the update_sk_ctx() one
was dormant until commit 4483efe4f215 ("apparmor: fix shadowing of plabel
that prevents cache from being updated") stopped @plabel being shadowed,
which is why bisecting the oops lands there.

A NULL @old just means no peer label has been recorded yet, so install
the label directly instead of merging or comparing against it.

Fixes: 88fec3526e84 ("apparmor: make sure unix socket labeling is correctly updated.")
Reported-by: Aurelien Jarno <aurelien@aurel32.net>
Closes: https://bugs.debian.org/1145111
Cc: stable@vger.kernel.org
Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
---
 security/apparmor/af_unix.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
index b908e744818c..d04d9cd268aa 100644
--- a/security/apparmor/af_unix.c
+++ b/security/apparmor/af_unix.c
@@ -682,7 +682,7 @@ static void update_sk_ctx(struct sock *sk, struct aa_label *label,
 		if (old == plabel) {
 			rcu_assign_pointer(ctx->peer_lastupdate,
 					   aa_get_label(plabel));
-		} else if (aa_label_is_subset(plabel, old)) {
+		} else if (!old || aa_label_is_subset(plabel, old)) {
 			rcu_assign_pointer(ctx->peer_lastupdate,
 					   aa_get_label(plabel));
 			rcu_assign_pointer(ctx->peer, aa_get_label(plabel));
@@ -700,13 +700,17 @@ static void update_peer_ctx(struct sock *sk, struct aa_sk_ctx *ctx,
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
+	if (!old)
+		rcu_assign_pointer(ctx->peer, aa_get_label(label));
+	else {
+		l = aa_label_merge(old, label, GFP_ATOMIC);
+		if (l) {
+			if (l != old) {
+				rcu_assign_pointer(ctx->peer, l);
+				aa_put_label(old);
+			} else
+				aa_put_label(l);
+		}
 	}
 	spin_unlock(&unix_sk(sk)->lock);
 }
-- 
2.51.0

