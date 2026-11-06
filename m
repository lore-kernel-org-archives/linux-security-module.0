Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972364;
	b=FSXL4P2i+REiHgYDxFXJyv5Q/J0YB4AggBn/c+8zXkqi/zByt0pZWYWBYdNtN25u4Ycw
	 Ncnzg7PxRwu8Ir5ZoWFrPai59D6dS+jOp4Yxfh7MPp9tfy8EO1ITTcMp+UnDp6WietD0g
	 mz3cAups8qSpstplpib2pShQMQ3riRatpQsrnLrqDCRuvwfDJJPNmzDwQn/GJS9tBpaZ2
	 YccHbk+19+qg76/J3FhAdzm7HnzTwZ8ajYZpSHeLjpvi1ky8k0/DzkNiTOmckyc5MjRLo
	 fYsVBOpqqluZZTrJLeu+2K2L2zKOmi0bdmguCZ+tP4K5SU+FiyJsP/z2flnVZCnSNDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972364;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=ARUfe0oRvQLpktV4/IX4ouOJ+p2Dyv2XxPz/WvTcyHM=;
	b=jQlhDq3axyRe0NxOApIX4gFV2cR08TVft3gMfMRgc9GpO0SjJ09CSCNfHVARd9DBjEAj
	 txdHkxX5iBPQngrVpNN9nEeStWDxrdACPR8RmLHgQKrQCrPmwgsGHg2WapW48Kjg3Cy+y
	 Fxdy6mIdHdK4b7PL7pEqy0WbuVsmegXDpI+32UX0PYbXATso/2NkU+qn2TEzWVtzhTBJ8
	 YO+E1m20I0kTBF3HzWDnu0HLazYKR4jgHvh/SJ1y0Cc6Hjxz6/gJPn8+rfh7owP9X3e1G
	 ftBdR4snpD4843Fp7pt0oLjs9GqXnn9aKVq/lpkMvtDSRdWRSph/lcvii86OIDy+B9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=roblab.la;
	spf=pass smtp.mailfrom=roblab.la;
	dkim=pass header.d=roblab.la header.i=@roblab.la header.a=rsa-sha256 header.s=fm2 header.b=P0kS3mNE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="n/C6BrD2";
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE8D606A333
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 13:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBE8D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roblab.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roblab.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roblab.la header.i=@roblab.la header.a=rsa-sha256 header.s=fm2 header.b=P0kS3mNE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=n/C6BrD2
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 89A097A012A
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 08:39:21 -0500 (EST)
Received: from ams-imap-01 ([10.64.2.21])
  by ams-compute-02.internal (MEProxy); Fri, 06 Nov 2026 08:39:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roblab.la; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793972356;
	 x=1794058756; bh=ARUfe0oRvQLpktV4/IX4ouOJ+p2Dyv2XxPz/WvTcyHM=; b=
	P0kS3mNEpBv/rTDf6A2rJVYOCsq0JXdjzgKRygbulwUQXO+MoLCAfHN/dQHtCbT1
	tgnm0g3xOeVyg/BArdxYzR6cD2kdIS7eUOGsnSN9+SifKP8ZCiLQW3XFoeFKoNQ5
	PAsT6/O7Wc42pJQfqcActKug3PlUDbFvdFvtf0OhCzTv0sO1dWk1w87QLgAXvm07
	73PtvsfKS8UnjGNw8nWprzM/LkMGXgAsOIscSEi+e1KCh0g++FtppBoUm4Fv6qu6
	pzKgTZEmsiOCvrpdK4JD8qxP73q1NUwv6pQUi6mtDYdUhx5yXimZJqnLaTAmt15m
	0zXvBspnaBUU7bY324yFmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793972356; x=
	1794058756; bh=ARUfe0oRvQLpktV4/IX4ouOJ+p2Dyv2XxPz/WvTcyHM=; b=n
	/C6BrD2TaoAut1HnY1Yh8dc9SLFd65ISP+6xpMI6H2kGmpmoMGyIG3vVr+KmbLdO
	8KT/HLGUiekOyAWptxqFxygA/2GwYnrC60CkE9ntLXNVVFBa4OesbvRsmVeZtiT1
	IYRbVD2OSpdaS2wuDdUnpPy6RP+wmSGY2WL/zBUCKg22WGXDcmubPU8fb38QC2DT
	2C2QXkckhmHSFXYL9msMObq+zf46sC0bnA5iKNAJ9bLcLxo1Mo6vIVKVAv2afYO5
	1chg/uU8jXfJVzW81yFJinyYTyvQ+OniVrpBPaOZEzEy8TxGUbvEkDjDqUk0nAUM
	vbSvUVe6/d5dCbn6JCByA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=roblab.la a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793972356; d=roblab.la;
	mf=PGxpbnV4QHJvYmxhYi5sYT4=;
	rt=PGxpbnV4LXNlY3VyaXR5LW1vZHVsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:e73TbcGpqKiRhHJhMkFhoc3whANlF9BY5YlUp+UzEiOWvZs
	eaMgZCl8BzWefFq56bl/Q+RLXaPpITNwmZ7Hoj41c4wDqC4q3yWyfv2Jm1YpDDyt
	V7BD76C1cSEg6kCRESqAfTlUenRP5q4+VAgrsyJswIcSzdJjxPyty40s5wTEG5UO
	s8LwSY0rqAKd8+sb1DoIZL+tfbvy3EccZbMhW+S2Pf+kjYsvbUDUswpIH+PzctKi
	ZfNG1DTi10EaS3pf6U4tDoj0CjUQxcsxERVET9YAr7roUb1xlao0l0dpid55j+ES
	q7LPrSCQGX1mHZULYkXuGYhmSV9M6WTYcMWWg8g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:yagw9MK1qx/FsQKMSDEscldkfDLlqZ19o3fNMlgXkAE=:bJ1TY0gyHdq6noIDh4uRoIHjnYHwd2Uk1WKpsqxUygA=;
X-ME-Sender: <xms:gdjtahRgaEufYkRDWH8tDPS8VfuAogvHN3EUfHU40gdXFV5eFLkzCg>
    <xme:gdjtalm0wacst6RgzAs8I6cCRdarfR3py1KoyWyohv5HzLxlkHFjldY7EBjLtfVz6
    yYvfBd6bH9siAps8oSJs3OjkySyf9UPs-pMewR_4G5dU6ECao6HkdfN>
X-ME-Proxy-Cause: dmFkZTF+FnxZiQiMq7uXLveifAn/SqqWr2J1X2I0ezX+IiJkA5pWaZj1lD5uHJxz5pAlqV
    09pZ35PV7/ljghZUqCK8RONDe3322gTBYLFE4q3i/14cg1rV7vyCnwYlRQ/f7bGY/Hdzif
    ZEtcDiGDzezmzLwjqapQHKTtR6EY+cICJ7lvpdmWo3X+PLFwdzwd/Asj2kwkgSrRYrT5LZ
    odLpIxJ/MwIYrXTy+GaQFG9hgFHvfAdQ5abFbTXZrsTnkfYAQOEFWotTXizzUSEdvZgnwv
    qG11XFX9Iyu86r0H6dJ6dDNBPQhBDdlbVM1KjIJgdTb9iQ399UB0/1odsYNttn05nohJf8
    x8aAiQWMOzLYYNpscPd8nBMy7qiOadoSpV5elqgNNWYBX33GvJB2zzl1FJcGPyCjCNCFcY
    XQ1xBEKTU9bbh9wyHcRR65/v76xKl2KR6O1TFoA++WhP+xrLHCwoPuPFwMS/ou4vi++0sx
    YFRUNRNUuVijT6O2PPdZwHLqboysKihlyCwPW7799gSmU3fobcotGmVmbejfX/tFuUlKAW
    KVujFyuBdRsZ9AdC3TiLPUAxEX48YjlNkrls5WfaC8cx2PWUHxOtdUu0qrAICJsABPdbNo
    Q+tRFd8se3YLK+0VBrke1pekjrWDjNzeGmQVHEsyeFFY69L+iqL+JQVKY09g
X-ME-Proxy: <xmx:gtjtalVE9GkhLOtvIDdGp388pTemU5ZQ5ZPotnB5vGcPp5swE4BNBA>
    <xmx:gtjtakpxKtUiNOpB6t85z7v735ntrT8T21dRcAf9odowC8AnGVIw4w>
    <xmx:gtjtanl2nxSLYLii7Ptk9Ggl1l-OS3YU8vnzlVj22YhpSpBK4K38sA>
    <xmx:gtjtak1Fy6bX5WGRz7AwswawIsxUClcttmiPfYYO6yXC2XO-wYRSbQ>
    <xmx:hNjtakBWlnyAmiB8ysLtjowLqEcZpBCWpDuy8tehkxrRhHflQzHbALPZ>
Feedback-ID: iddd147b3:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 054CAFA0096; Fri,  6 Nov 2026 08:39:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AgAAt5wBJ-mw
Date: Fri, 06 Nov 2026 14:38:49 +0100
From: roblabla <linux@roblab.la>
To: "Daan De Meyer" <daan@amutable.com>, "Paul Moore" <paul@paul-moore.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 paul.mabileau@harfanglab.fr, linux-kernel@vger.kernel.org,
 "Andrii Nakryiko" <andrii@kernel.org>
Message-Id: <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com>
In-Reply-To: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com>
References: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com>
Subject: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently breaks BPF LSMs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Resubmitting as plain text. Sorry for the noise.

Hello,
First of all, I'm sorry if I'm sending this email to the wrong mailing lists, it's my first time reporting a linux issue ^^'.

In commit 16959c469f232f5c76cfb628297cafbf6dbdba79 (lsm: expose mount idmaps to inode hooks), merged in 7.4-rc1, a new argument was added in position 0 of various inode-related `security_` functions. Specifically, it added this argument to inode_create, inode_link, inode_symlink, inode_mkdir, inode_mknod and inode_permission.

This has the immediate effect of breaking eBPF LSM programs relying on these hooks that were compiled with BPF CO-RE and using BPF_CORE_READ. Those programs don't simply stop loading (which would be fine enough) - instead, they will misinterpret the argument from one type to another, which can cause them to behave erratically. This has already bitten me in the past, when inode_setattr got a similar argument change in Linux 6.9. This caused our eBPF LSM to misbehave and deny actions that should have been ordinarily accepted, leading to huge production outages on our customers' machines.

Here's a simple reproducer that shows the problem (full repro with the loader, makefile and run.sh is at https://github.com/roblabla/kernel-7.4-bpf-bug-reproducer):

```
#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>
#include <bpf/bpf_core_read.h>

char LICENSE[] SEC("license") = "GPL";

#define EPERM 1
#define NAME_LEN 32

static const char forbidden[] = "forbidden";

SEC("lsm/inode_create")
int BPF_PROG(deny_forbidden, struct inode *dir, struct dentry *dentry)
{
    char name[NAME_LEN] = {};
    const unsigned char *name_ptr;
    unsigned long dir_ino;

    dir_ino = BPF_CORE_READ(dir, i_ino);
    name_ptr = BPF_CORE_READ(dentry, d_name.name);
    bpf_probe_read_kernel_str(name, sizeof(name), name_ptr);

    bpf_printk("inode_create: dir ino=%lu name='%s'", dir_ino, name);

    for (int i = 0; i < sizeof(forbidden); i++)
        if (name[i] != forbidden[i])
            return 0;

    bpf_printk("inode_create: denied '%s'", name);
    return -EPERM;
}
```

Compile it under a kernel before 7.4 release, then run it on mainline. Here's the output:

- run on 7.1-rc7:  touch forbidden: DENIED   (dir ino=59 name='forbidden')
- run on 7.4-rc1:  touch forbidden: created  (dir ino=0 name='')

Before Linux 7.4, this program will properly deny the creation of any file named "forbidden". But in 7.4, the name_ptr BPF_CORE_READ will read garbage, and the check will fail. This is a bit of a contrived example, of course, but should show that there's a real problem in the way we handle eBPF loading in the face of changing signatures, that is prone to causing big compatibility issues.

Now, I'm not sure how the Linux Kernel treats eBPF LSM hooks - if they're considered part of the userspace that shouldn't be broken. My understanding is that kprobes are not part of the Linux Kernel stability guarantees, for rather obvious reasons (they allow watching the internals of the kernel) - but I'm not sure if this extends to the LSM Hooks. I assume not. Still, this kind of breakage is really painful for us, and I hope we can find a solution.

Could we fix this type of breakage by making sure new arguments are only added at the _end_ of the LSM hooks signatures, such that eBPF written for an older version of the kernel do not start misinterpreting arguments? eBPFs don't care about having "too few" arguments in the hook, so this would solve the situation.

Separately, I think the current lack of error handling in case of argument mismatch should really be improved. Could we perhaps have a mechanism such that the kernel (or maybe libbpf?) could check the arguments of the eBPF program, and refuse loading if it mismatches what the kernel expects?

Thanks,
roblabla
