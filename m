Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792632430;
	b=I4ot8DBG2ui3zk4QGK8fb7IVjNmmnxr+t3p9Ql1DuyxmZA7T1pyQBzN23xaztSxpyiwB
	 FTXTLvOSPnYAK9UrGFaozQdpdFYjbPMSQZtyt0maJsrSikwga/WubRaoYKQr+3v0HqUH3
	 AcPf+ZWwYg41Myla+Zes4wFSow7CCPb0YspaESCFL/x0HFbiZaJtXRugdqrqRxsDyFYlg
	 k6Pqs330h3lFdxlEyim2/up51vDH4He6A0xnbmtsDrPkkD+nCg4SRWLhCR0Se1fUvy0tT
	 yv0dEpOa32byf8BrHVpFqCnx6PeRNPu9kyUSwbNpyoHUwSZB1DEdh5ZWGxmVMpmkgFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792632430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+X3yvDTSD5hI+jNMsXuYnRkCqrJ1z+mJffRqRDhw9VM=;
	b=rRuxuKSFErov9ayonTYbJbIUJZC65AdaFSp9uBFVYRF7sETl2/gBK2ULAiN2rSRt1bdw
	 tmn/VNJTvuMFpxMfeiukbmirJNhgySFosZueqmZOXN9i9thWG4PSsgeM3B+QGTeRzKL5o
	 iDgj2lgxdLK40tXGajNLfv+Gh07rQUQRj8kR6WDH4CtB7iBFAz20GnmzzTw+pYXe/hL1T
	 +/546irwuXzf4KyAgpqVwHACOO8hc0wmTzDIgHlGDYP0ch0a2llsqOGIfC1+W3CfK7FMe
	 E3/T7j1H0sHAy6ZQy3azvopuVmoYo/wP4k+Xqe8S0LYwNKo0o2ZJQKgQecKr5r9BQ9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=cgW0Biqe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDC3606A31A
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 01:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFDC3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=cgW0Biqe
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a01cac8733so768228b3a.2
        for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 18:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792632428; cv=none;
        d=google.com; s=arc-20260327;
        b=oMshdqBNG6NL/ICeZnS9N5xpMFZp8WtOeXD1DBJzL24hpPuVSwqpRh1tVPxdkfUYED
         DJ74JBF9oYLOXNxLHEQ6oM2iWcdJGW9pRumPmmpZq6jNyvwHa6uN2P6/cwou2tMi6FAn
         /+YUoOuT86bA4naKkCs7JKMBjBs0gps3CnBn0xxDQe72jabxqHqY9sCFftNsFR2ddssR
         rT75Ret2myTetDcOHKR33tiH6ZOjeKxYx5wykylNLFonmFsHqCNDC6DQp362SbUSB2o3
         T5UT1W1q89q6gkDutBfvJONEfM/YnEuHkSEi34aTKzDI+EP3rTmmer7uK4K/SJYVcbK1
         VEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+X3yvDTSD5hI+jNMsXuYnRkCqrJ1z+mJffRqRDhw9VM=;
        fh=VvR//XNPAEdUOT/sY1slfoHTKfexBTU0xHsVK/zgwdQ=;
        b=SGHDV/ImudrnWxc+1EQMMlrqd+7XK0PhOD2vId+L5LvOpbK+/mztcpLLiR6NaWv3dX
         kTYUTH8FNauTrg9zoqIK39EQuhMhm3SEU1+vRtLW3NH/R4YGL8v1XQsCIseCZgVdvttg
         PcTIxKIUWhZVyaIOeqH9IbOoRJOrldfVd9gHb/9jQdfIkxxwwM4HVGwHpcFQOnYjHlXC
         QQyF7JfPdn35QYDc88NqvNP86ua9pqOWOtBlx/EGLccwThvQluoXJ4an/Uoy5xbLP95u
         0ECoJVtkUnIi2juPo69k4JaEKZUxcnH0SVo3PF6nTEPbegodgma34RwDC8fhORdvtOKu
         gS2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792632428; x=1793237228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+X3yvDTSD5hI+jNMsXuYnRkCqrJ1z+mJffRqRDhw9VM=;
        b=cgW0BiqesHjWNFuOJfEZwBvGqp5fc+2/z9c6DR8FRq7OW4NzwVtiUUqyLUlayp8DvD
         /Kg11ZSUPiNAfV2jt8+0HKIFXgk19RQt3AwATy9WdsTxSb1boweVq8pKDRT4fJmNLFFs
         R9mtHqMqzMPZf+wjfRSHaNQIqqA2iRrWgDUgYGmvZMGqM76De4yNE3Swfjj/VNUk3rMu
         Fr3X9TiFEndEBllfoCkC7ttuCnWr8JoeQQGumDhgG2DmVyfIOB9WL9mQrCztjtNm8Xgr
         v6THPxO64u2aJxxs5u4BkrVFbb/wu8bPg5ix389rp+2tZYYeayGFRb9guBydtFUa3d1V
         Iv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792632428; x=1793237228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+X3yvDTSD5hI+jNMsXuYnRkCqrJ1z+mJffRqRDhw9VM=;
        b=CAvVqfiCcivSM/fjgqkwaNwCGu3knkClVbKoLBXEZYfYm5lnkFALeNWVRTy7hMefXu
         6wJlu8sRFIDurKBkjzOXXXNVonQpMIsZ2/+iFG+iEz+qtC86TUQaNMlqCvdpHbYBQZIL
         U7yFFaYA373ZueRJmM4qpWKqV9oaU5foSGTxys8RBFatGvGcDc0/RBH+srZS/X2e9pEC
         YlIoccHI3pdqSpfcVTF5K+26s3iSD76YAlNjrpGq+RGxWKJieilfa+25OGBZ4FK3Sp7Q
         mr+q9UpDHYNjV9uS0b3gsoYu9jvEMSZ9XHPsQ4+8njMQF345Z/XZRfePnNXVXZo8mdZo
         vQ7w==
X-Forwarded-Encrypted: i=1; AKwUvBwXD4rUmpKGfSdh1IgO4KcvZt6kjPmgHVOujSjKHkwdCRamNOdWn9SjWtfWBaS6ozg2cQQ33cz7iJwj2p0ff4qT98Mqlpw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPLLMKxBKCNsuE1GQ6WW56EjW1WqRRfmR0XtTkctfESs89Ns/p
	ImXEQPILh7ZBoiyY7nO2ipUBDKwm2nfsQe/HV8ZJ2vw5FkPRABDX9x/G9bIp/YaJlerpekrjwsG
	UkPvWY9Tm9ngPhAZPPmT/rLLEA5zJfSVtgKG8G5w/
X-Gm-Gg: AYBFou1v4SCmEZD1329OiXhqj8NffYEAWmnerQ89NzWsOWVzHl5wa2Ld9zmAuvviMHH
	ZEWLmKjTi/rVqNqry0KaVES93UCntAgOzfPwcWVrKgFKgqiA2J2ew+mG5XHXPeFtY2bQvcoy0fb
	z9A7bI94a3e6rPT1cldMllhiCjuxSx9OmBBkRdJzFhgJVIh+VlfRZkSZDJpm44CvdPGMIeqnLW9
	qhsGtQCkYxVcCfTiaiuoHmi/rA8Kv6KezcAAXBEOand2mqkPbWRUAhNP/o+a+mkVh7jev2agA3H
	g721Mz+qFXSeAAXZki5/gfavTIl7K/1bgzP1D5uSAVxlaPPTJHyZ6nyZNHP8yjXBdztOfMQId72
	DeNqL57OAs6NI11VB3nMC8icHNDvmb66Egu2CtusHIEPn+DVxMDlKm5K/GXUmrbIl5M8Y
X-Received: by 2002:a05:6a00:428e:b0:870:c2db:da2c with SMTP id
 d2e1a72fcca58-8a089de70e8mr2794770b3a.25.1792632427984; Wed, 21 Oct 2026
 18:27:07 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021210147.3450677-1-alexei.starovoitov@gmail.com>
 <CAHC9VhQGeZtDLKZ7iLYx-d1ua_CojCN03uSG25oVDqOm9GKFag@mail.gmail.com> <DMAVQ90EWW3Q.44GJKDHWOSFC@gmail.com>
In-Reply-To: <DMAVQ90EWW3Q.44GJKDHWOSFC@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Oct 2026 21:26:56 -0400
X-Gm-Features: AclHuK-bAbwE_NBMaWg6hMgjd_8AiVgfixRTO-O8tlD4QGvoKSvNs8HFVoRlx-E
Message-ID: <CAHC9VhQz1aam-P+xh8CT=3V9fNtdrcFSZ6VEOWUGx1cKWV+WYQ@mail.gmail.com>
Subject: Re: [GIT PULL] BPF changes for 7.4
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	linux-security-module@vger.kernel.org, brauner@kernel.org, dwindsor@gmail.com, 
	kpsingh@kernel.org, matt@bobrowski.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 6:45=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Wed, Oct 21, 2026 at 02:26 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > The primary reason for my objection is that the bpf_inode_init_xattr()
> > kfunc, despite its name, is a LSM kfunc and should be located in
> > security/bpf_lsm_kfuncs.c.
>
> Linus,
>
> there is no such file. The ask is to create it

Exactly.  It's not a new ask and I'll be happy to create it and move
the kfunc if doing the work is your only objection ;)

> ... and to give it to LSM tree:
> "We would need the maintenence of security/bpf_lsm_kfuncs.c to fall to
> the LSM framework"
> https://lore.kernel.org/all/CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=3D1q=
XK=3Du-x-Q@mail.gmail.com/

"... just as the maintenence of bpf_fs_funcs.c falls to the VFS." is
the rest of that sentence.  We're not asking for a type of
cross-subsystem relationship without precedent.

> fs/bpf_fs_kfuncs.c has six xattr kfuncs already:
> bpf_{get,set,remove}_dentry_xattr(), bpf_get_file_xattr(),
> bpf_cgroup_read_xattr(), bpf_sock_read_xattr().
> bpf_inode_init_xattr() is the 7th. Same "security.bpf." names,
> same check of the name.
> Christian's answer to the same ask in June:
> "For xattrs we have it all centralized in the VFS and in general all VFS
> related bpf kfuncs should continue living there and be registered there."
> https://lore.kernel.org/bpf/20260625-schnabel-rennmaschine-parieren-bcb35=
2c3cf59@brauner/

As discussed previously, the kfunc in question isn't really a VFS
kfunc it's a LSM kfunc populating LSM managed buffers and calling into
LSM private APIs.

One might question the placement of some of the other BPF kfuncs
located in bpf_fs_kfuncs.c as the file is conditionally built based on
CONFIG_BPF_LSM as opposed to CONFIG_BPF_SYSCALL or some other generic
BPF Kconfig knob, but there is no sense in worrying about that until
we settle this.

> > The bpf_inode_init_xattr() kfunc does not call into any VFS APIs, but i=
t
> > does call into an LSM internal API.
>
> That API is lsm_get_xattr_slot(), a static inline in
> include/linux/lsm_hooks.h:
>
>         if (unlikely(!xattrs))
>                 return NULL;
>         return &xattrs[(*xattr_count)++];
>
> The kdoc of security_inode_init_security() tells LSMs to call it.
> selinux, smack and evm do. BPF LSM is one more LSM.

Yes, that is what I meant when I said it was calling an internal LSM
API.  The lsm_get_xattr_slot() function is intended for use by LSMs
(it's not an external LSM "hook") and the fact that the kfunc in
question calls into it (and not a single VFS function) is one of the
reasons why I'm arguing strongly that this is purely a LSM kfunc and
should be located in security/bpf_lsm_funcs.c.

> > it weould appear the decision to locate bpf_inode_init_xattr()
> > in fs/bpf_fs_kfuncs.c is due largely (solely?) to a petulant policy to
> > never allow a kfunc in the security/ space:
>
> The kfunc is in fs/bpf_fs_kfuncs.c since David's v1 in April.
> That email is from September.
>
> On Jul 1 Paul was ok with the kfunc there as long as LSM bits move into
> security_lsmxattr_add():
> https://lore.kernel.org/all/CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_e=
GX428g@mail.gmail.com/
> David did that in v5 and v6. On Jul 31:
> "I saw the v5 patchset and the nature of the kfunc became painfully
> obvious to me so I changed my opinion."
> https://lore.kernel.org/all/CAHC9VhQ24fp7_sy1=3DNiWkfzPLSM35ugSCOKDKxnm6H=
9W-pDa6Q@mail.gmail.com/
> "this puts us at a stalemate and David will need to find another
> approach for his work."

It's worth reading the discussions from all of David's patches, but
for those who don't have the time, I would at least read how I ended
the email Alexei references:

"I've been working with David and providing feedback for a while now
(perhaps before you started commenting? not sure on that), and I'm
continuing to engage with David, you, and anyone else who wants to
comment on this thread."

> > I can't support the BPF maintainers actively circumventing
> > review/oversight from LSM developers.
>
> v3-v6 were on LSM list.
> The last series is that other approach. Christian, KP and Matt were in cc=
.
> LSM list was not. It should have been. Fair point. Will cc next time.

It isn't just about CC'ing the proper lists, although that is an
important first step.  It's about actually being open to feedback and
working with other subsystems to arrive at a solution that everyone
can accept, even if they do so begrudgingly.  Forcing something
through like this against the wishes of other subsystems is a last
resort and needs to be called out in the pull request so Linus is made
aware of it and can arbitrate as he deems necessary.  You can draw
parallels to the Hornet LSM debacle, and while we never got to the
point of sending a pull request to Linus, we definitely made you aware
of the work and believe it or not, we did incorporate your feedback
and tried to work with you as much as was humanly possible.

(As an aside, for those who only casually followed the BPF signing
developments of the past several years, it is worth noting that
shortly after Hornet was rejected, Daniel proposed a solution eerily
similar to something that Blase had previously proposed and which the
BPF devs had rejected.  Despite the odd about-face after all the
mudslinging, we did continue to work with Daniel on his new/old
patchset because we genuinely do want to see the right things happen
in the kernel.)

https://lore.kernel.org/bpf/CAHC9VhTA7tOp16wGzb1QYnkJsVz1X3oNcmT6bb_9334=3D=
B2smEw@mail.gmail.com

--=20
paul-moore.com
