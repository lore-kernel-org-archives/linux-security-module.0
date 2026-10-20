Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792517457;
	b=hhC4IVJ6LXVHIBcpsrMiHc7lkmyXNkpU7xexycGqhcO3iKatcdF+j3v8CTHu/46IvPzq
	 GFbVIRuDWs1E8EMjmDkSRxu9DenAPa/HVE9EKV+umCB8M67Vqii2eAAbvhG+lsRBhcH3K
	 BHa3XoazzDPHxP0jpuN5BH8HT68TDN2O8YpJifIW30kfHePibtb1gSXzxuRkMT655oC1T
	 X+yaCj8xXQHxzvRMuLPBm/c4hIfntJZskh+HnpBMwbNGR8zHko5stSSmx4ZwTsTE9lnui
	 lrw4BGWvUqBfpA810fJg1LnVqfnygoC75RM1pK+WTE6vKyT3BLfkxGs4PwkQq9rxqKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517457;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=a9BuPLHKc6kCzFZ4JleiDdHGiHn0vB31Xy2WnAwd6zM=;
	b=mZlSqfOiJaQPhbrxLekKg0jz/dxD5dGRlyXUco8J13fTliiUjmqerrz9dpwnt3nR/TwN
	 pGu4wZIBlpnWyqx0z4lUV2McMh5vtVTqtKUsGAz46MbRByBONAok123LUd6Fe6bPdTMpn
	 /aP6yHLWaH5aRl9aSoroufvRBlXx1fVEyZvLjlQrUGuRSfAUlwSHWx1pE2x+Lz+TNdCl7
	 fAsq30bc9E/tByJQ9R5K+J2WB5wIj+NcLZcDCFzDq2h5cEVjqYso9AKT5IEZKbCBot/d1
	 xdm+YMn6MBnVSXaHCJu1hBCiP98mCDG4RK84YlDbNuDWiDMK14eUIZAwgDw6ax/GiyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Vw2hm14t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24403606A31B
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 17:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24403606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Vw2hm14t
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KGuI954175454
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 10:30:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pps82601-s2048-2026-q3; bh=a9BuPLHKc6kCzFZ4JleiDdHGiHn0vB31Xy2Wn
	Awd6zM=; b=Vw2hm14tvzG/9NN24U2W3mhwY88Cvn41XDUQx1OaUdq2gaxJqDpyA
	eFhSvx+1MxW1HdHgF+brD7m1NpFNFIhaxWgK/8QqfnDf53GfcU8VGcKM0dZz2sxS
	pRQmA+XrQoxMB7H+Xk6aPQyfU4AxbfFJtufZhPDL5u0j3UVmtp6EYwtK4Kc6Zb1H
	cR6q1JJYTsykqWpnUGdvXEBKmNKGWdF+z0+dy2fyFItxL7+IEL8v4sUv6yeM6ejv
	GpebGIw2P5hWqb8ao3uRAXxFDQ27ktRs+BjJMxZ28yo1vQdWNmNX9/X8H4ET+y91
	njk2x2Ei+2QzV5+tn3KX9mfogKYt8oyYQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hdw5ddbnq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 10:30:56 -0700 (PDT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a086f5d91aso261150b3a.1
        for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 10:30:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792517455; cv=none;
        d=google.com; s=arc-20260327;
        b=N2WMgTc2uRRY1cyly2Ik6lV5ajna/ASeFqFPfsWlLZSI6aOZ6cLF8bKRsoeeAYGZc6
         mVmAPU2fWJZyszG30bMoS+ZFpZWIf8XrzuJ2wunVm42vtrP6Xw+Pod15zbX8EUtMqDRo
         j3lHYJnBMRhxJMuudyh2L8BhWU3oG0cF0jiCm27QLBmpngIoTGS9P7a7QriGZfxCUk0G
         4vNyW4ZBgAzebJWDg4MFsoFktaBjV9A31d4dXKFEgJRKNv2uwhbdZClXZIl7ws420P+v
         pdLTH7E7BtMkJRvDoOBMKHdEUcwch9pAgCfgd4ofJe0sLSyLkea/PYMV+2PfxEqJUTw5
         qMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version;
        bh=a9BuPLHKc6kCzFZ4JleiDdHGiHn0vB31Xy2WnAwd6zM=;
        fh=Kio5g5DI4uyNuP4ZgFXrM1LH/nVULZKHHds+O3KSTmo=;
        b=L6uFnWjdnRG7MoCKXl+0CYXIJW4EZ52il18xqDU5eBodEjp6tiWtDJxPBxXkUra9DJ
         zyubfp2zbSoxO2fdHLGak26IOPRtYHdfrkt6sHY5mxHh0koe9BaWqzcXiNIIYAr3x92t
         VczeM1/T4+M0KOpiWdl+KBZNyBClYyslz144yMg16MqlLOOzrnf2ItGLBYFtYF9Lmets
         IL5jqWCzlp7nOl87l4YIevVtjCmm2pXvgfo5fGijLFLP0XkzthNluohr6aH/czVVFrSQ
         zCrxcaazlDqVPoHQnYA/6w3WUnMQNv59uS/4pGtxlzA9aeIXS3Asc/CeL9D4c/AmoIAI
         5kvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792517455; x=1793122255;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=a9BuPLHKc6kCzFZ4JleiDdHGiHn0vB31Xy2WnAwd6zM=;
        b=qc7MxNc6bdxlvwdLLBScsh7vtRP+5FNfGfvf5CC0mW1vl1vLkMD8zEJJpq+/er6apD
         +V0ASv8eZbIZIIebiMjv+2XPh2B0RezxPkHD3e65YXUEu5N976cUh26Jdi58OGxz84zS
         UXuN1/fS5Kgdpdy6VB3M+M5TfrMdQlzio2Ludxa/6sB/DzuEOWxkc7p5p3q6RzBH6DS3
         Tfdwzl0vJRvP13S6G8TisV6B2VCQneCUB/HONtjhj72PIqUZmIiKtF0bTw7aDe35FFbd
         pTGDx1zVx73ohGCxOj0DUc3D4ij2L+UtrfalPKxIUfpMIP8DaI6FmAOtw9BqXsMcjbwx
         xqQA==
X-Forwarded-Encrypted: i=1; AKwUvBxHzXMEWO3dywrQXljNjxG1/BPcg6NcmD2h7p1w9GuJz7DLdzzszpSqnGp1/7esH5CX2Sa8ug2lBfr7c9mFKYRVU0Cx6NQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIux9S52TCeNiFr/WAkJhJmRBxI+jEqTUI3sOBfoya1bNvyQm81
	fG+i4VBOUpftLpgmZhtRw4FHEuzbpewp05bi+vBfTPuqJGZw/KIlCZsA1noIC+qW7O5d7xQHhgF
	nF2x+vK60HGjcVM59tyegcVJebu+XIdpMiQiEAhtXnGlBDcjgIBhM3B3XZvvDEo18pC+LLcE5HQ
	19IrsTLNa/287awNTsC+GIabdTjmehi5q48PH+HLyrTN0j6YIIOjs=
X-Gm-Gg: AYBFou1ja51t99fIFI4kaWQGGPfyi3CsUu8HAuq2gWlaeBLpGM5La76Ra6qRTTU2rYl
	rjC/6g4XymmhI1PfkGbmNbNcwrzmyOE+5/fdasa59mRwmWyz60dlP7M5hmhF+5zAJidUp80CV2Y
	rG6vZx1EJLrlygM3h30mBTg6b2ZQ66gayPi9ZDk58V5QzaCA71ikIKnbCtR8TfCvT+k2i9kHwr
X-Received: by 2002:a05:6a00:919f:b0:8a0:5d6f:8a9d with SMTP id d2e1a72fcca58-8a05d8e44bemr6708418b3a.35.1792517455247;
        Tue, 20 Oct 2026 10:30:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:919f:b0:8a0:5d6f:8a9d with SMTP id
 d2e1a72fcca58-8a05d8e44bemr6708405b3a.35.1792517454846; Tue, 20 Oct 2026
 10:30:54 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Nik Tsytsarkin <nikt@meta.com>
Date: Tue, 20 Oct 2026 12:30:41 -0500
X-Gm-Features: AclHuK9WyYINhPFTJ0qkN5fmOJVLbIYzSD_8ziE-c0sB8ayjG2TnMNx8s0uCK68
Message-ID: <CAN8mxQpCCO3QNXb0pimRsNqfLs1qS0epZmB59q2sd8QCLhgOpA@mail.gmail.com>
Subject: [PATCH] apparmor: fix NULL peer label deref for connected SOCK_DGRAM sockets
To: John Johansen <john.johansen@canonical.com>,
        Georgia Garcia <georgia.garcia@canonical.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sam Dlinn <sledge@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=JuNkP84C c=1 sm=1 tr=0 ts=6ad7a550 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=FOH2dFAWAAAA:8 a=sM3mXklEuYsKxauXXZ4A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: Rln0mzlYP34XeQKG2RbMd5MR5A_u83Pc
X-Proofpoint-GUID: Rln0mzlYP34XeQKG2RbMd5MR5A_u83Pc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2OSBTYWx0ZWRfX8Z/Nm6FgORnN
 vuPg5Qm9NomENlUxKlsZoPV33T1W37Kv2qbNU8QgFrWUx41DTuvKhRHk6MYEBcGC8TXBfZRyTb8
 7SOqiR1d1U7JRvuRBxDmMA/Pq5TQ6JRaKM3fK6RdnsD/oyzTK0dnrPeQJuA6Dwj1sZ2j5e3riBv
 VIFk3eFe1lbmKCqZOfY5XYpmaqXw7ULMsq/zmN6rH7bIjb9KxokA4gLLwmG4ptyPZuE7QDsIjI1
 3F0HUuAqSPp/Rnnt0kLadw5blnmwMWfVvzzqPO5NpJMhb7Ra1SVWR7n3HF1H27E+GFjjZzWAwfK
 cl2kCmvHw7bOMA5ebNhs3pMWXJdEKxaqkB9z3Gp66swZ7/JaQ1Td7nCojk3DWks0+/XxczKBVvd
 r8P5SHyqAQe3+a52bTFZRENWnA7qjWHFUI3jbBwxS7Xplw4B4PGZNf0PC0eqQpaa0k9US62GB4G
 cCVRSv+q+7rd7Ripv1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2OSBTYWx0ZWRfX/bB9AU2bPm9i
 WenrsvdHpbNvCNQyoK3lMrmRMNKfsXJBBg3ljYiwtKmbSCky1KR/pHOjF1KO8DcXgwcZYoNRUw5
 e0VY5YcL0X6VlAXLqruf/7e4fty9OXA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01

apparmor_sk_alloc_security() initializes ctx->peer and
ctx->peer_lastupdate to NULL, and unix_connect_peers() is the only
place they are set.  It is called from the unix_stream_connect and
socket_socketpair hooks, but not for SOCK_DGRAM sockets paired with
connect(2): the dgram connect path only goes through the unix_may_send
hook, which does not touch the socket's apparmor context.  So after
connect(2) on an AF_UNIX SOCK_DGRAM socket, unix_peer(sk) is set while
ctx->peer stays NULL.

When a confined task later triggers file revalidation on such a
socket (its first write(2) on the fd suffices, with or without a
profile change in between), aa_unix_file_perm() runs the post-check
cache update with peer_sk != NULL and a NULL cached peer label, and
both update paths dereference the NULL label:

  - update_peer_ctx() calls aa_label_merge(old, label, ...) with
    old == NULL, which reads old->size;
  - update_sk_ctx() calls aa_label_is_subset(plabel, old) with
    old == NULL, which reads old->size via
    __aa_label_next_not_in_set().

The AA_BUG() NULL assertions in those helpers compile out without
CONFIG_SECURITY_APPARMOR_DEBUG_ASSERTS, so production builds oops
under spin_lock(&unix_sk(sk)->lock).  An unprivileged confined task
can trigger this whenever its profile mediates unix sockets (complain
mode included).  Because the oops happens under the unix sock
spinlock, the dying task then deadlocks against itself in
unix_release_sock() on exit, leaving an unkillable spinning task and
an RCU stall on that CPU (and a full crash with panic_on_oops=1).

  BUG: kernel NULL pointer dereference, address: 000000000000004c
  RIP: 0010:aa_label_merge+0x63/0x730
  Call Trace:
   aa_unix_file_perm+0x477/0x800
   aa_file_perm+0x434/0x550
   common_file_perm+0x58/0x150
   security_file_permission+0x22/0x50
   vfs_write+0x76/0x410
   ksys_write+0xb3/0xd0

Treat a NULL cached peer label as "not initialized yet" in both
update helpers: have update_peer_ctx() adopt the checked label
instead of merging with the missing old one, and have update_sk_ctx()
initialize ctx->peer/ctx->peer_lastupdate when no peer label was
recorded.  This lazily completes, at first revalidation, the peer
cross-referencing that unix_connect_peers() performs for stream and
socketpair sockets.

Fixes: c05e705812d1 ("apparmor: add fine grained af_unix mediation")
Assisted-by: LLM
Signed-off-by: Nik Tsytsarkin (nikt@fb.com)
---
 security/apparmor/af_unix.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
index b908e744818c..e802538b0e54 100644
--- a/security/apparmor/af_unix.c
+++ b/security/apparmor/af_unix.c
@@ -682,7 +682,7 @@ static void update_sk_ctx(struct sock *sk, struct
aa_label *label,
  if (old == plabel) {
  rcu_assign_pointer(ctx->peer_lastupdate,
    aa_get_label(plabel));
- } else if (aa_label_is_subset(plabel, old)) {
+ } else if (!old || aa_label_is_subset(plabel, old)) {
  rcu_assign_pointer(ctx->peer_lastupdate,
    aa_get_label(plabel));
  rcu_assign_pointer(ctx->peer, aa_get_label(plabel));
@@ -700,7 +700,11 @@ static void update_peer_ctx(struct sock *sk,
struct aa_sk_ctx *ctx,
  spin_lock(&unix_sk(sk)->lock);
  old = rcu_dereference_protected(ctx->peer,
  lockdep_is_held(&unix_sk(sk)->lock));
- l = aa_label_merge(old, label, GFP_ATOMIC);
+ if (old)
+ l = aa_label_merge(old, label, GFP_ATOMIC);
+ else
+ /* connected dgram socket, peer ctx was never initialized */
+ l = aa_get_label(label);
  if (l) {
  if (l != old) {
  rcu_assign_pointer(ctx->peer, l);
--
