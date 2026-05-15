Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BC4315D33
	for <linux-security-module@vger.kernel.org>; Fri, 15 May 2026 05:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778821296; cv=none; b=NjYn98erJIsOU53CoT9Ve1CxerdYOqGoQuM1/pNB8oASNLVePHQoL8M3gG76nhhaz5A7BXrskmPl/OZt6zBQfbX4vRBmTzacZKFKz6uNFwxCGPoSLF+aH0PtVrzpO0Jp7E8GlUSbLLyD5c5zb+3F+R3zezZ++tUlS7plQlvAUQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778821296; c=relaxed/simple;
	bh=JNY1W3dItPtvZ7Cceml3Tw2uFnJbYV/RyiE34VbFyM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nnuB5C8MQL5d2YpTGzNlmuNxsVP5wlBd0g8pbZ8wP+Ui05Iua2NbnHPj+oYcwc52YcaDFja/ZvpigJn0e+0cFO5K5E/NfXVCDjycfzfjRpjGBhCf+pcZsx2xACwhVv46z09cSo6v7mamrWF9WYVVE5zF+29eJANaRwVrlTOITnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1CsIjdD; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1CsIjdD"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso87420345ad.0
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 22:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778821295; x=1779426095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gqboflgAQ/qafTTrlWTn23PBzb00+Q5WROmi07sXKXI=;
        b=m1CsIjdDWxH1lwqhAEbsBMX/hX6Vo3eFnFTfM37VWsRJ3xmYf16WOkCAxzD0JiEQT9
         YBbUWP/a20IZJuz+2j/t3E+U+EZ+VgTi7yGsalEcUYc3xtj/T/5XtTxjqxrYruK8ytPu
         xiqDxEMlFMsRIV+DBynHx5AEchGsbzFxE4SdHITfZyCNbsUT+m2DvxTqA7JloNcyzH65
         upsb15B8nXEyF6nQ4G96uYg31B/t2WSqz+f9TxJcekCr38eVdjVC0+3DCc1TFP86JP4b
         NZrXAQ+rjrNJMvr7QlWCecNDZExhn12enXpBq05WbFZfiKLall6T5PX4IcLpB5/kKPa/
         HJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778821295; x=1779426095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqboflgAQ/qafTTrlWTn23PBzb00+Q5WROmi07sXKXI=;
        b=Q0ke9nyY8/i4vnOUfeXUSknaEuTvcoDuzz8Qya/5FElLpmx5WfjE6RnDlnEtS5/iyS
         UqPx/JZsHF0Zg6pIotJ5vKKzRMsgldmZRv1MyC7IKbLE8JTTWh+1bUVCcA5mkh2uaSUZ
         ZbBHJKwvrypbsvU/AqSSzyOeAkTgKTzm65MTjPSLL8QKERsn6LQMzEEJMe+otljn4rqM
         zloG6/rICdLZEWrpsuGgqsNAYi3FFGU3tcK8FPKgJqAD2hdKk9OPiEGO2Mz/TPq29Ook
         69eH2HWcBCzyJEk3fRNwY63gn7IjUb2RLZkf3fqAiD6Ru4aKxSkU6Vdt7gtSLOiDeQak
         g1gQ==
X-Forwarded-Encrypted: i=1; AFNElJ+sxArooi0LC9L4FwrSijpvtLa4DYPPbdCS+64Uh+Asxv3oZDSa444VjBr0KtZIv6YARKcWWSxwGai0PAUKeyAO1+Cf5BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYJbwhLQilIeE5P+fvFnbMDD0UY9esAkBzjwo8KFZA1bVcbSJ9
	vJzroXwCzkMm1Km6YytoOayMhkPhQZCEK+VBHrQOH/+w/sdNSnsnF3yp
X-Gm-Gg: Acq92OHqIEJzz53DN1OfO8g/EcHz4lftLblguMulkelep+5uTo9i2nKF5VK2Ga2t/HR
	q2RFwL9zZrtnAEiPsmg/tLGBt3B2I9H+Zwl1tt9WmnFwaTHixSZUIXuNUAX+AEtf8R/yaTTe5wb
	VR/EQPKO0rfnzFOX/y4m94rY0CFrFQiR5GP1TTLTFVBrdHPUmLJ7pmpsBOnrLawYyQdsEXqc0N0
	Y63QU001a4qDZbY6T2mwfDh2Ylmyphxd9YsDB4s9pzH+CK+DB/xKECUBx1eNoEZkSRip9XdZsZc
	hTqZn2Xpf+XiDWCp8UHUMCSHCLX0ihTZFwZ5jsjzrvT8fsHl8lVC8veBCvWaaxzY7lhfmB9qkn9
	005nTZHUn4BciY42EtyqF5KAsdWB8fNhzvi5CJAyeBFAY+MClOp/6O5yqiFe1bc5BZfdpfK76Nn
	Cg5hf67HEwgp4NylNN0PlieX1b4TJ5PkwKFQvcRT0E9g==
X-Received: by 2002:a17:902:b181:b0:2bc:6784:5260 with SMTP id d9443c01a7336-2bd7e966018mr20182025ad.37.1778821294496;
        Thu, 14 May 2026 22:01:34 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5ef1bsm55532965ad.4.2026.05.14.22.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 22:01:34 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zerocling0077@gmail.com,
	2045gemini@gmail.com,
	Zhang Cen <rollkingzzc@gmail.com>
Subject: [PATCH] apparmor: hold peer path references in aa_unix_file_perm()
Date: Fri, 15 May 2026 13:01:16 +0800
Message-Id: <20260515050116.95754-1-rollkingzzc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aa_unix_file_perm() keeps the connected peer alive with sock_hold(peer_sk),
but it then carries unix_sk(peer_sk)->path outside the peer socket state
lock without taking a path reference. That copied peer_path can race with
unix_release_sock(), which clears u->path under unix_state_lock(peer_sk)
and drops the socket-owned path reference with path_put() before the final
sock_put(peer_sk).

Take peer_sk's unix_state_lock() long enough to snapshot peer_path,
cache whether the peer is filesystem-bound, and path_get() a non-NULL
path before dropping the lock. Drop that path reference after the last
AppArmor peer path check. This restores the ownership invariant for
peer_path without changing AF_UNIX shutdown semantics once the peer path
has already been cleared.

The buggy scenario involves two paths, with each column showing the
order within that path:

aa_unix_file_perm() [borrower]:        unix_release_sock() [peer close]:
1. unix_state_lock(sock->sk)           1. unix_state_lock(peer_sk)
2. peer_sk = unix_peer(sock->sk)       2. Save path = u->path
3. sock_hold(peer_sk)                  3. Clear u->path.dentry/mnt
4. unix_state_unlock(sock->sk)         4. unix_state_unlock(peer_sk)
5. peer_path = unix_sk(peer_sk)->path  5. path_put(&path)
6. unix_fs_perm(&peer_path)            6. sock_put(peer_sk)

KASAN reported a slab-use-after-free in unix_fs_perm() at
security/apparmor/af_unix.c:46, with the free side in
unix_release_sock() -> path_put() at net/unix/af_unix.c:730.

Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>

---
 security/apparmor/af_unix.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
index fdb4a9f21..7a1562f6f 100644
--- a/security/apparmor/af_unix.c
+++ b/security/apparmor/af_unix.c
@@ -716,7 +716,8 @@ int aa_unix_file_perm(const struct cred *subj_cred, struct aa_label *label,
 	struct sock *peer_sk = NULL;
 	u32 sk_req = request & ~NET_PEER_MASK;
 	struct path path;
-	bool is_sk_fs;
+	struct path peer_path = {};
+	bool is_sk_fs, is_peer_fs = false;
 	int error = 0;
 
 	AA_BUG(!label);
@@ -724,9 +725,8 @@ int aa_unix_file_perm(const struct cred *subj_cred, struct aa_label *label,
 	AA_BUG(!sock->sk);
 	AA_BUG(sock->sk->sk_family != PF_UNIX);
 
-	/* investigate only using lock via unix_peer_get()
-	 * addr only needs the memory barrier, but need to investigate
-	 * path
+	/* addr only needs the memory barrier; hold a peer path reference
+	 * under peer_sk's state lock after sock_hold(peer_sk)
 	 */
 	unix_state_lock(sock->sk);
 	peer_sk = unix_peer(sock->sk);
@@ -749,14 +749,18 @@ int aa_unix_file_perm(const struct cred *subj_cred, struct aa_label *label,
 		goto out;
 
 	peer_addr = aa_sunaddr(unix_sk(peer_sk), &peer_addrlen);
-
-	struct path peer_path;
-
-	peer_path = unix_sk(peer_sk)->path;
-	if (!is_sk_fs && is_unix_fs(peer_sk)) {
+	if (!is_sk_fs) {
+		unix_state_lock(peer_sk);
+		is_peer_fs = is_unix_fs(peer_sk);
+		peer_path = unix_sk(peer_sk)->path;
+		if (peer_path.dentry)
+			path_get(&peer_path);
+		unix_state_unlock(peer_sk);
+	}
+	if (!is_sk_fs && is_peer_fs) {
 		last_error(error,
 			   unix_fs_perm(op, request, subj_cred, label,
-					is_unix_fs(peer_sk) ? &peer_path : NULL));
+					&peer_path));
 	} else if (!is_sk_fs) {
 		struct aa_label *plabel;
 		struct aa_sk_ctx *pctx = aa_sock(peer_sk);
@@ -772,12 +776,12 @@ int aa_unix_file_perm(const struct cred *subj_cred, struct aa_label *label,
 					      MAY_READ | MAY_WRITE, sock->sk,
 					      is_sk_fs ? &path : NULL,
 					      peer_addr, peer_addrlen,
-					      is_unix_fs(peer_sk) ?
+					      is_peer_fs ?
 							&peer_path : NULL,
 					      plabel),
 			       unix_peer_perm(file->f_cred, plabel, op,
 					      MAY_READ | MAY_WRITE, peer_sk,
-					      is_unix_fs(peer_sk) ?
+					      is_peer_fs ?
 							&peer_path : NULL,
 					      addr, addrlen,
 					      is_sk_fs ? &path : NULL,
@@ -785,6 +789,8 @@ int aa_unix_file_perm(const struct cred *subj_cred, struct aa_label *label,
 		if (!error && !__aa_subj_label_is_cached(plabel, label))
 			update_peer_ctx(peer_sk, pctx, label);
 	}
+	if (peer_path.dentry)
+		path_put(&peer_path);
 	sock_put(peer_sk);
 
 out:
@@ -796,4 +802,3 @@ int aa_unix_file_perm(const struct cred *subj_cred, struct aa_label *label,
 
 	return error;
 }
-
-- 
2.43.0
