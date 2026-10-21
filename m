Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792621094;
	b=cpLV7w2YAUFHYD0gFvevQt/6jHiMcx4x/IyD0TFA3AwcG8zuabx1oArrkDOiMM58zSFh
	 KLbS6if5t4cyHTEg2JODjDeIPuMMVdq1x+UnlXhdzgO63vxjLnUV7NPKKktXmFJlJaueH
	 hHbHf7PXMs1G5vDb6EGJSuAfPIIzA+EAfzBDob6/JIFynVJFZxbIZ+561jiQjJem0gRML
	 eZkd0hTLVw7Cq/DRHQwf0BEYI5Y3qO02VXNHSp5Ijvy0r5WiroBP/yEPyG2j8LyM0Yi3B
	 KlBOiG5tRRjML08kxE8gRF7Rn51xq+hnLiGRd9PsUV+Xnb2oRHG70y2i32ykf0So+1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792621094;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version;
	bh=e9a0WZJQZGzq0hJzVGjFD3PS87eP7CJPfQ93j8ZKwqc=;
	b=VPEcLJWE359ExGq0O8qQtwmfPlldGbTo/+GMF4jYhIyL/K+lZPahPWEyED8oQ8Q1xQrd
	 FuoWTSLVi5rHtJUPZo7NtC4WWMmMwjX4n4gvneokN3+XFBo7/8QoAciiczFMGVZ+xaMEt
	 HZJlPVxpCZ4VILXOCf+73LOdEsZ1jL8qosWgEdy1xHs/Vo6OZj8wnFS/PGkrMgZlZxQFW
	 ZaBMrxgAkJbqLpVZYOuyqpaDAv0QXJHzqc2A0aqLtWLIatdDedO0DIsKWDgeDGeTRIoCN
	 mY+w4MJSAlvZQmY4vLTwkJ8HX43Wmh5yawhvp+Pa9kmxNz0Y2GPnDCgTNDbmH9CMPBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=hl6rBSvx;
	arc=fail smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32087606A319
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 22:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32087606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=hl6rBSvx
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LLEjtK2744540
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 15:18:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=e9a0WZJQZGzq0hJzVGjFD3PS87eP7CJPfQ93j
	8ZKwqc=; b=hl6rBSvxMeq8+98xTN4ebYhJn+jda/c7jxwYRKq/vmwKBCqLEFHpF
	JXKdeVTwTtemvmnlzEx1peNH5KqRs0GczZA1m+5RjjWjJJjsSCVuTwusHuYvtvZR
	qPZv9Yg/9aWd7uknedlIWvCF2hS1fzxj7hqFk2P6HZhfXqNGRrIWfyc7ZbsxQV/d
	5J0fs/mlIFBHSZceRgETILCFVaCyHmZNGCHtdcgwwt6iffDUTQXo6Q1RMX9KajpT
	RBtk40TxUiP+N58PKJlquOKfYWYQwF7KVyH+//KHOUh+Ko0Y9LXXchSDs6lLvUMa
	vdU6zyW0VxpcQuK44XGJnXnipWkwxFPOw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hf45b14au-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 15:18:11 -0700 (PDT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a05a4396d2so949013b3a.0
        for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 15:18:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792621091; cv=none;
        d=google.com; s=arc-20260327;
        b=HPvuPUy1Q4Xg8gKJpg8fwqHuyFgNpcFIwC4N2i3KOpbGgpktHowZuTBunAGyNFNn+8
         KsNMhfEV0u++hLLa8mBzihpK/aUX/YvkQQvZtC3oPLrmdjk2oRzbqD/kfFaZ73LNpCW7
         jLEVSXPiynEZ9Y/8bJXX/xybXJxR1W0y6urHa/BOvYRx4f08UmFumm2SSKuRKi5ddQkR
         OlQIJOEobPidHH2gCSVYFw9LM7c8OTqRdXbKrPr31qoKbPqqaARJu+w4Np/bILsBNjit
         GAVlcQIKCAIXiVoNMTQhUiUKZWJVzyiyiHeq26o/G7cQqJ7C8yblr81HP1R0lKN3Stkg
         O9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=idf8AtLSP3kQjHM4bosdvMYQUhX3daN1IRuhmi0WboU=;
        fh=Ho4bgFdoH+FC2JtRCMaed2xw3MWVdQ9dTHD+6k6ihv8=;
        b=LdSqYe9RrqoGf49xkHR4OOQinARkG7+kcGk+iOCE6keXQ+VH0z9EbvNTY3QSkZ8NC5
         QAx/kyX2cUEMPscgSF92GkPO4JGip04kAVN4curs3HG0xm8ZNO1nYN8s4IafGyW7oipM
         3SypSIG3kj+YmC51/1G3vdob8rFnQtCWc30E9lh3FTCxvZEb0c+e1m0pzBTYotNWjeQu
         FomRbJQH49ETc5wk5HnyDJFJAcCLSWIh0kkgOiojz50M/Roboc6FYJdIv4dL8vP+qnbo
         aHmy8NarM2jv08lnGZ/ugkRtwpNhYeIBYgg1wMa5DXrpYwcTbInSODuBJnrRU8Taniiy
         6WEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792621091; x=1793225891;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=idf8AtLSP3kQjHM4bosdvMYQUhX3daN1IRuhmi0WboU=;
        b=yV6tpDVW59MQlxoTuRd4GqtiqWYfe4v4nZBYW9rlqT6bqrL8k1rtqFs4xWYM8q5hVY
         6GetWD9CSqVOCaA8XGluspFob8dPF+gvktwyTLWn2urYDpdkOCr8F3J4SPyQfSjg0De5
         fkRSoiipEpC8l4wqWeKVcAYaDK6f3D7LGNwM1pIHUKui2Qql3MvlmDaLV25MQMqYlytO
         xsPXA92vmQZxrxxuBwT5VPPOOJyZVGKI5Jb52blmkgANX3tCaVPQ1h2OmH345oGUP02p
         q1K4cMFxt9kAVQxCAK5Car1+7RNOB2APl1uF83gE4k0Q3L/31vM5PTMLyEo+ZOsqyPh+
         iU2g==
X-Forwarded-Encrypted: i=1; AKwUvBw3Us2Ex6irBFikaF5P6F660633jIyFGPIFXJrPFUUIXYoagqBwITMh0lxOlvKJ/3JSW1KkLFa4RtxR4dTaO+u86pwMnIc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZ+dh4RikdTIr2QBxEEaktZKTYuEKC9zK/9kxmtfD7d5bWq3yZ
	vsV5Xbx2iTJrLjMxJFP+FbleFAqn1J+8ct/9Kc4Fn0rA/V9ZiDfgkltabaf87hnmEFPtZujNbMp
	NNV/1D7lZhEVF2a7d4nwuLq4dExWcKeRZDeXYmXeu1K84xJfm8t/HXMlpXrWjMtw4TUWH5Wh7LT
	dH8/Sf5PJVlZBhFKYGGDaIb73WTy31j1/ILXnD2sqKkQDPspzz1UA=
X-Gm-Gg: AYBFou0/7RQE+G5PT/i7sGs+9mSG4IDf0n4fVxDNvYSnJMaDn2BRjtJl5Wv0MpCnI3N
	jUdudLBkI3bwQPk8+fRr8s+78unLWCsd8GZApdiJ8gyyc+u65qAb8j8RejaT7liA3/Ab5QaHaoy
	cucZJPRLq/rQM+1+4uL5ZHgHWphB2Gq9SHA/v2ypKSvFXhu1HEG35O1n18RQxLWIiJUFix9kRe
X-Received: by 2002:a05:6a21:3298:b0:3de:55ce:75d1 with SMTP id adf61e73a8af0-3e287f24260mr2248661637.92.1792621090818;
        Wed, 21 Oct 2026 15:18:10 -0700 (PDT)
X-Received: by 2002:a05:6a21:3298:b0:3de:55ce:75d1 with SMTP id
 adf61e73a8af0-3e287f24260mr2248651637.92.1792621090227; Wed, 21 Oct 2026
 15:18:10 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAN8mxQpCCO3QNXb0pimRsNqfLs1qS0epZmB59q2sd8QCLhgOpA@mail.gmail.com>
 <atktw9TRy0UKsjOB@hallyn.com>
In-Reply-To: <atktw9TRy0UKsjOB@hallyn.com>
From: Nik Tsytsarkin <nikt@meta.com>
Date: Wed, 21 Oct 2026 17:17:57 -0500
X-Gm-Features: AclHuK_FmF8e4Nxgjg7RySBj9bMAc8OT_WI0hCCAv0C3KXFQMXGtnMgXjmuwkbw
Message-ID: <CAN8mxQo+NtJ7AqY01j4R+HrN-=fU_SdpbSypC3sEu96FpWnAJg@mail.gmail.com>
Subject: Re: [PATCH] apparmor: fix NULL peer label deref for connected
 SOCK_DGRAM sockets
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: John Johansen <john.johansen@canonical.com>,
        Georgia Garcia <georgia.garcia@canonical.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Dlinn <sledge@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA4OCBTYWx0ZWRfXyrpAUldPfbYw
 obTD2VTuhm6MwLhwNYkpV0yyO/MEttP4th5PiDL5M4FYNpaeb44VT5yeIsddL8+6fahx56PQ4y8
 +FgW+gFC+A7JI3Hq6gWZ3s3xoMOTqTcrxpzMV3xMk+dmo7RczdzGxLGTUF51CZAmY+YkVW0QFJK
 qm913FuoXrvkZEDedYKr3/HPEAVh9ULpBQkRLWERj8nAXODW4Ri4Y+Jyj21F8K/Zy5Njm8lz+XR
 y3K6RdSBjBo1qUhu9EE2rh6mljUxXo8oozZ+IAwu5xshZ9hdcaRXEhAC1fEPZyLtTtx/2JNd/Wh
 pj6O7SbV8qPpEEiHJM+tQonzcGzorVmjooWb0rC3XFInEj6ioIF//jKxtIwzI3/GgUaBVu/5Zui
 KN4+k/um1Q9dxGaxiU2eQZE3ITv6D1U4WZonya6kDqmuBfEamDd6KR4ZiOfrA4+5uENo/R6TFHF
 Vbvj8SkTHSJAJfskHtg==
X-Proofpoint-ORIG-GUID: Q9TvBwLwUq3KNkPjn2693iPhtWvrss0C
X-Authority-Analysis: v=2.4 cv=TdQDJhQh c=1 sm=1 tr=0 ts=6ad93a23 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=VabnemYjAAAA:8 a=hBqU3vQJAAAA:8 a=FOH2dFAWAAAA:8 a=Qfn3z1FVZM52wDHW1jwA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=gKebqoRLp9LExxC7YDUY:22
 a=WLjMIN4s_96MqnBbPenP:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA4OCBTYWx0ZWRfX025r/5J5QadZ
 aI6IRG1SKFvDNRZPIHGc6AJ7enBeRgCQUnaXKGEmtaFjg5JV/miu7JXXiMqfG9z9R6C5QzuNesA
 CkuSrG0DC2Q30/IYRBmXfS6zon4Yv/I=
X-Proofpoint-GUID: Q9TvBwLwUq3KNkPjn2693iPhtWvrss0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01

Sorry, I messed up the brackets while putting my email in into the
signed off field.

From 4ffed66a07d63db409ad272309fe4946ed758360 Mon Sep 17 00:00:00 2001
From: nikt <nikt@meta.com>
Date: Mon, 19 Oct 2026 15:17:33 -0700
Subject: [PATCH] apparmor: fix NULL peer label deref for connected SOCK_DGR=
AM
sockets

apparmor_sk_alloc_security() initializes ctx->peer and
ctx->peer_lastupdate to NULL, and unix_connect_peers() is the only
place they are set. It is called from the unix_stream_connect and
socket_socketpair hooks, but not for SOCK_DGRAM sockets paired with
connect(2): the dgram connect path only goes through the unix_may_send
hook, which does not touch the socket's apparmor context. So after
connect(2) on an AF_UNIX SOCK_DGRAM socket, unix_peer(sk) is set while
ctx->peer stays NULL.

When a confined task later triggers file revalidation on such a
socket (its first write(2) on the fd suffices, with or without a
profile change in between), aa_unix_file_perm() runs the post-check
cache update with peer_sk !=3D NULL and a NULL cached peer label, and
both update paths dereference the NULL label:

- update_peer_ctx() calls aa_label_merge(old, label, ...) with
old =3D=3D NULL, which reads old->size;
- update_sk_ctx() calls aa_label_is_subset(plabel, old) with
old =3D=3D NULL, which reads old->size via
__aa_label_next_not_in_set().

The AA_BUG() NULL assertions in those helpers compile out without
CONFIG_SECURITY_APPARMOR_DEBUG_ASSERTS, so production builds oops
under spin_lock(&unix_sk(sk)->lock). An unprivileged confined task
can trigger this whenever its profile mediates unix sockets (complain
mode included). Because the oops happens under the unix sock
spinlock, the dying task then deadlocks against itself in
unix_release_sock() on exit, leaving an unkillable spinning task and
an RCU stall on that CPU (and a full crash with panic_on_oops=3D1).

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
recorded. This lazily completes, at first revalidation, the peer
cross-referencing that unix_connect_peers() performs for stream and
socketpair sockets.

Fixes: c05e705812d1 ("apparmor: add fine grained af_unix mediation")
Assisted-by: LLM
Signed-off-by: Nik Tsytsarkin <nikt@meta.com>
---
security/apparmor/af_unix.c | 8 ++++++--
1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
index b908e744818c..e802538b0e54 100644
--- a/security/apparmor/af_unix.c
+++ b/security/apparmor/af_unix.c
@@ -682,7 +682,7 @@ static void update_sk_ctx(struct sock *sk, struct
aa_label *label,
if (old =3D=3D plabel) {
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
old =3D rcu_dereference_protected(ctx->peer,
lockdep_is_held(&unix_sk(sk)->lock));
- l =3D aa_label_merge(old, label, GFP_ATOMIC);
+ if (old)
+ l =3D aa_label_merge(old, label, GFP_ATOMIC);
+ else
+ /* connected dgram socket, peer ctx was never initialized */
+ l =3D aa_get_label(label);
if (l) {
if (l !=3D old) {
rcu_assign_pointer(ctx->peer, l);
--
2.53.0


On Wed, Oct 21, 2026 at 4:25=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
>
> >
> On Tue, Oct 20, 2026 at 12:30:41PM -0500, Nik Tsytsarkin wrote:
> > apparmor_sk_alloc_security() initializes ctx->peer and
> > ctx->peer_lastupdate to NULL, and unix_connect_peers() is the only
> > place they are set.  It is called from the unix_stream_connect and
> > socket_socketpair hooks, but not for SOCK_DGRAM sockets paired with
> > connect(2): the dgram connect path only goes through the unix_may_send
> > hook, which does not touch the socket's apparmor context.  So after
> > connect(2) on an AF_UNIX SOCK_DGRAM socket, unix_peer(sk) is set while
> > ctx->peer stays NULL.
> >
> > When a confined task later triggers file revalidation on such a
> > socket (its first write(2) on the fd suffices, with or without a
> > profile change in between), aa_unix_file_perm() runs the post-check
> > cache update with peer_sk !=3D NULL and a NULL cached peer label, and
> > both update paths dereference the NULL label:
> >
> >   - update_peer_ctx() calls aa_label_merge(old, label, ...) with
> >     old =3D=3D NULL, which reads old->size;
> >   - update_sk_ctx() calls aa_label_is_subset(plabel, old) with
> >     old =3D=3D NULL, which reads old->size via
> >     __aa_label_next_not_in_set().
> >
> > The AA_BUG() NULL assertions in those helpers compile out without
> > CONFIG_SECURITY_APPARMOR_DEBUG_ASSERTS, so production builds oops
> > under spin_lock(&unix_sk(sk)->lock).  An unprivileged confined task
> > can trigger this whenever its profile mediates unix sockets (complain
> > mode included).  Because the oops happens under the unix sock
> > spinlock, the dying task then deadlocks against itself in
> > unix_release_sock() on exit, leaving an unkillable spinning task and
> > an RCU stall on that CPU (and a full crash with panic_on_oops=3D1).
> >
> >   BUG: kernel NULL pointer dereference, address: 000000000000004c
> >   RIP: 0010:aa_label_merge+0x63/0x730
> >   Call Trace:
> >    aa_unix_file_perm+0x477/0x800
> >    aa_file_perm+0x434/0x550
> >    common_file_perm+0x58/0x150
> >    security_file_permission+0x22/0x50
> >    vfs_write+0x76/0x410
> >    ksys_write+0xb3/0xd0
> >
> > Treat a NULL cached peer label as "not initialized yet" in both
> > update helpers: have update_peer_ctx() adopt the checked label
> > instead of merging with the missing old one, and have update_sk_ctx()
> > initialize ctx->peer/ctx->peer_lastupdate when no peer label was
> > recorded.  This lazily completes, at first revalidation, the peer
> > cross-referencing that unix_connect_peers() performs for stream and
> > socketpair sockets.
> >
> > Fixes: c05e705812d1 ("apparmor: add fine grained af_unix mediation")
> > Assisted-by: LLM
>
> How did you generate this patch?  (It looks damaged.)
>
> > Signed-off-by: Nik Tsytsarkin (nikt@fb.com)
> > ---
> >  security/apparmor/af_unix.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
> > index b908e744818c..e802538b0e54 100644
> > --- a/security/apparmor/af_unix.c
> > +++ b/security/apparmor/af_unix.c
> > @@ -682,7 +682,7 @@ static void update_sk_ctx(struct sock *sk, struct
> > aa_label *label,
> >   if (old =3D=3D plabel) {
> >   rcu_assign_pointer(ctx->peer_lastupdate,
> >     aa_get_label(plabel));
> > - } else if (aa_label_is_subset(plabel, old)) {
> > + } else if (!old || aa_label_is_subset(plabel, old)) {
> >   rcu_assign_pointer(ctx->peer_lastupdate,
> >     aa_get_label(plabel));
> >   rcu_assign_pointer(ctx->peer, aa_get_label(plabel));
> > @@ -700,7 +700,11 @@ static void update_peer_ctx(struct sock *sk,
> > struct aa_sk_ctx *ctx,
> >   spin_lock(&unix_sk(sk)->lock);
> >   old =3D rcu_dereference_protected(ctx->peer,
> >   lockdep_is_held(&unix_sk(sk)->lock));
> > - l =3D aa_label_merge(old, label, GFP_ATOMIC);
> > + if (old)
> > + l =3D aa_label_merge(old, label, GFP_ATOMIC);
> > + else
> > + /* connected dgram socket, peer ctx was never initialized */
> > + l =3D aa_get_label(label);
> >   if (l) {
> >   if (l !=3D old) {
> >   rcu_assign_pointer(ctx->peer, l);
> > --
