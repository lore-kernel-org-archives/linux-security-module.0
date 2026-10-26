Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008650;
	b=SFI4gzH+S+pfZJTepDLgx7NEMse3I3Q8GywJ62m1qyJ8Vmk8lM88B0Wzhs5hHdVD1YbN
	 QGVN+Mjs+msiwRPKYJpSutPgmVwJsZ0wH67DjDEiuoTA2JlRjm5xh8iznmAn9jT/Btx4R
	 wkEZPS3wC47LnUBQXqN38ZcvmbARSygu3xmR0XnEfsW07OJR9h4bMSQ6/f4/BRq0su5mT
	 bL79L+VaqlF2unTBY0S3Gd9PubFzutHjkTiA0MLr+9vgsC+QBZuMI7U8ofBovpmWWYVTa
	 rOuSmLILprhHyd7woDSWdkil+ZXTQvo2gT1YIRar9abw443dPHMx4VZYlXdlw/vfbpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008650;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=vZbI+36cuLWKSblKMENitfEJ+yoA6aEpBQf4/oO9DlE=;
	b=mwAqnBODCUonBlxs2hnBIE6zpbvHUOPWFiR+lx5vGLqx0D86MsrVoLKw0TYLG6Nw7tel
	 il3VZYmMXkTWaui/xx981q2qPTeJghdubzmiBIkiZPLy7e9c0duejNjjKY1JiR5mtdqio
	 t5JI6m/pCnbI82kuJWQk0HZwc28oJjtKvN8Y5GJfaNoO5uWADmsAfI+i0wSQSIVdm2uBg
	 FDYauXAQCxnBVU4mb6aMKm0HUA2cdpGUfP8+ONxTlg5ESp2qXnuS7Lhvz5hldWRrZNEr3
	 TOpKOGSwRZKxeCGGH4vzWKJPJcjsOaZhoI20pXH99Am3KRNpKwUIlhIGF/e25scXXnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0Sq3nJa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778FA606A31A;
	Mon, 26 Oct 2026 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0Sq3nJa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCF11F01829;
	Mon, 26 Oct 2026 09:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008650;
	bh=vZbI+36cuLWKSblKMENitfEJ+yoA6aEpBQf4/oO9DlE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=o0Sq3nJaIGTrjslbLGLcqnd8GPwnDlz0xCnvjLEp0i/i+axxAaa035NKi395WU1Xg
	 hDRVsuKGFDY2xbAsWfPHhhMUD+tmWCaGPykq6pdC4Jv4CeiwtNrQWXl15NqOYWFUGz
	 kVRrjJWt9BCAfaqEd2Fxkz7FDmeS3LY60h66pvafTuDyTJaljvKsvPN8BJ/5CflJja
	 BM8jHg/Em2FadQNsECWj6rWK8zTGh7w6lnh65LE2xpkG+hhcg9XMiOqj/a3F0p7Y9b
	 OzHrg72jVKoAGT+iqyNNyLA58AIx1hvy50oRqPVigC305acGqMwORQ6ze9gyA2BChR
	 1UJwGe1/aVDKg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 26 Oct 2026 10:57:09 +0100
Subject: [PATCH 1/8] lsm: always call the namespace_free hook
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-work-security-namespace_free-v1-1-ffa3ebbf71bd@kernel.org>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
In-Reply-To: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
To: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2360; i=brauner@kernel.org;
 h=from:subject:message-id; bh=C2BO3VYPrmNUuuCqz/uwcSrR57rLhf95j9OE/k19Z48=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdV2HKM6t3aJrDJvJ0gWz+3FfXjLVifxb81lUQOB1/c
 uNLlXuzOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSXcLIsMejKkgs42SX19mI
 LT8DHmR19y9fpGErbcz580FnEWNHACPDsp479mV/mX2CXY+V3PvKeeqbbPy6Pxfy8+L4ZDpPla7
 mBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

security_namespace_free() returns early if ns->ns_security is NULL and
skips the namespace_free hook. But ns->ns_security is only allocated if
an LSM requests a namespace blob via lbs_ns and currently no LSM does.
So the namespace_free hook is never called at all.

Landlock only uses namespace_init and namespace_install so it doesn't
care. But the bpf LSM attaches to every hook and a program attached to
namespace_free never runs. We want to use it in systemd-nsresourced to
get notified when a user namespace goes away. Right now it has to kprobe
retire_userns_sysctls() for that.

Note that a bpf program can't work around this. The size of the
namespace blob is fixed at boot and the bpf LSM doesn't request one.
And security_namespace_init() allocates the blob before the
namespace_init hooks are called anyway.

The check isn't needed. __ns_common_free() is only ever called after
__ns_common_init() succeeded and security_namespace_init() only calls
security_namespace_free() after the blob has been allocated. So if an
LSM requests a namespace blob it is always there when the hook runs.
Call the hook unconditionally like security_sb_free(),
security_file_free() and security_bpf_map_free() do.

The bpf LSM attaches programs to its bpf_lsm_*() stubs so fentry on the
stubs shows what a bpf LSM program sees. Booted with lsm.debug, which
prints "LSM: blob(ns) size 0", and created 100 user and uts namespaces:

  bpftrace -e 'fentry:bpf_lsm_namespace_init { @init = count(); }
               fentry:bpf_lsm_namespace_free { @free = count(); }' &
  for i in $(seq 100); do unshare -Uu true; done

  before: @init: 200 @free: 0
  after:  @init: 200 @free: 200

Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
Cc: <stable@kernel.org> # mainline only
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 security/security.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/security/security.c b/security/security.c
index f6583d507395..1e76c097b28d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3412,9 +3412,6 @@ int security_namespace_init(struct ns_common *ns)
  */
 void security_namespace_free(struct ns_common *ns)
 {
-	if (!ns->ns_security)
-		return;
-
 	call_void_hook(namespace_free, ns);
 
 	kfree(ns->ns_security);

-- 
2.53.0

