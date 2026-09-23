Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F97853D0B1
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182675; cv=pass; b=UKET3D1jSPiSXBxa1SwhusM26reulI48DBUHv6r32Gy/52iRf0uXDyoz0PTxP4Ve/3WsZDUudoyyRUVhNhQ0zLqHrsKx8vE9Pw7Uv/j8xFqDDQoJoRmBKMHjqDRo24cEQ31nan9vBqR6xqm4QTXYB1NGzoWAFzX32gmC4VfYl28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182675; c=relaxed/simple;
	bh=McqDOGf5r1CnE1bN7FiRiYswkQTi90pIdMUmOHjlXZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=no9gtNCLFWsCcV7RTRG13UifJKWzxNcZbo6AESqaho6SHTqsCc3LgiQ22ekxAuu+2n09W8zCq1/iT0BsHk9vZqe195x4L7XMN3qndMVpgsfRv3X35kZURGVcDffB1aTm7QJrm8gw5dFWlUfdPI5TTj/B81MEMg/f3xJiOMU7CfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JjkYbBrz; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JjkYbBrz"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469d249c4so926772b3a.2
        for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 09:57:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790182673; cv=none;
        d=google.com; s=arc-20260327;
        b=Gn9FN/x7M2QzbtqRmK/UVFV5KBqCTnR32XPWk3yCQyNKnATZPX/Xt6IT+4BzfxM/Wm
         48U/JOvYHSiZ79BI5hNEhnjTjUI7drafDQDBY5wYd07wxwuh7g9MQrcsrcBRu1E0WbRi
         xE+NC9CSblmiavF8tGaWTCpLh39wsZGe8rQuhjhNyojdjnnwbSFBfK/BF5bRpV62/xmM
         fnS11H9J2I5OBfQy5iT3ammAUzPvYVdHEiF/trqsqXrFtd/L/gAvvu/27nW4vuQr0sk7
         Z85p3pN/7xUU7nr/oXzqxxjHJxuvBc6kSv6s/ANa+MXANjFDr3LWoHZgSK/I2b72MWlb
         SSCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ijs+6l1Z4Lnz2cWqooyvDNYk6B/Cjo1CnXBD1Ikc0Ww=;
        fh=JGfU1OHfN5kyytEprdglVRpQ4PjICJnvgDJD1G5kTso=;
        b=qaX3fS9adRBafY2AYSrKMtg2hYxlWNMChIQVPd/uwV9Y1qxdHAXHtg731QpVnyrJ9J
         zU9Sw68a0WW8sOnX4d/EWs9jrFYFY9dqqWu+bNPiILYn/FLwF+GL0SrftwcCtHqgEuE1
         TWqydSTAOWEjdtW4Qowzon4a+HqAG2GAMAL3nXqqQsWERn7+8u2RPhqcX8yj/XqDMDGU
         8WclQCfK9HFvMcLl3uOktDtGBDgGb4G6IFvhiUH68/tRJ1hWm6DoIIx4tvmciZrBJJN8
         nx7TIOMoZYyoNVmjCXr9PBd+sWI+zlEpVM7hNJEiFq3XYWQCFC8GlxhP1UMdS1rjJkoA
         4/Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790182673; x=1790787473; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ijs+6l1Z4Lnz2cWqooyvDNYk6B/Cjo1CnXBD1Ikc0Ww=;
        b=JjkYbBrzfIpHFHkcivEd1rTidlNFx00ArknNboJSZP9Nyth6ClIwumGeYFLEHnok80
         bfNrZQx4b/eVJgy3ezqlkuyPjwF1qqQfZSYxMvp+smJufFKk3sa4Vm4W7QJXp7KlhkgF
         QJ9qM/J5IkqiPjPNZI618VQT+4y4CNlv/sTzC1mR7RZuKTk6djaHgcndC3MGRfI/7pum
         QgOvt2A5uv59QxbJiGvSbKZwjWcjkHylEMCVRbwSofk7ibvkO+O9gjGzktpRC68n70C8
         b3Dwwin/JhXzLvtlswLPf59ARMM8w5kD2/xpOeu1ttgweQZHuQVoWguYKmSeppzG4Lvd
         fvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790182673; x=1790787473;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ijs+6l1Z4Lnz2cWqooyvDNYk6B/Cjo1CnXBD1Ikc0Ww=;
        b=IWBwnfRfGGbZ0l+xi2bUnAFcg+RA6V9Hyq7vs6ZM6rQE+tTXr0Qq31pSgbuRI5PFyW
         kIVrov7v0V0Iyqw/W7uOVcS1sdS3H5TnJ0P4QDcSdcQ79+3cWS0nTn9MMCIusM7Xnf8F
         v//9QK4mTsipoyZ0RdnAnMD9B76TYDT/pyoteL9lGaag54DOkZmDAlpvf7VmshaJc3dY
         Soq7kDABoR6+iUDCbfskmJvZXo7NcnQURYA3jYy7s6WqpMV5qLF2bACyNJLsHvqlpQIt
         ZDFoFVBGz2jvVa1jrmRKvT+QmmUHBVQO5jT7psqkpdA+TDRIEux6vFUserqikIcO0k2H
         fyUA==
X-Forwarded-Encrypted: i=1; AKwUvBzmzk9mod9jsW8VGgd+r8iq3P1cURmq3sMm0mJS09/YtIcqFgHKSETJMOq1MMKtahCEkIiQpAtMDiy+Z5gRb8ASpCLDZoc=@vger.kernel.org
X-Gm-Message-State: AFuF++ldXm7rstyc/Yl1tBuM2cillyYeK6yXQWdE3q0Jv+pHM3MM4BkR
	mtGW0xRsS0diaZ7CqX4A62/3lu/nhQC4xgb0Xgfo62pbaT82VckyieRynZfVVzCy/zjXKdOEVM9
	j5QYDhPuQnNSL65pPtQxEQ8SDs+rptMy73jwxdkqQ
X-Gm-Gg: AYBFou19a4cKgg9NheiHUmqXYsd9JB2htb7WcRBxAzZUh7JPeJjgdZg0UGCPvKlntYm
	D0n7R93LmCQDXBykcCg4INsoWuMFiaWUlb0sqW68fBKkhIReM9CcywtwvDhoGJOOmIICRw9+apB
	FL163JIaW7xWQNB2rGAUMztsPqdhEj4SfbTq5FR8ZYOC10foswxsLkiVqN2YxciA1zGvUOUbiGj
	P5QaqAhjW4NjAwklSppsBqNXPfa3OlTJwRe98R1hv+0IFToCy7284AiqrKyBvt4ZOK69Ip2tC6d
	4cARFsVkoVmRr3Dit7rDesFztiGTBjQV2Dxr009M/E3FsjkFYvOKRq9HxmmSwM9VnlbjhM2hn0U
	6h4mbxXawxZA=
X-Received: by 2002:a05:6a00:2d11:b0:878:3783:8a83 with SMTP id
 d2e1a72fcca58-87d1d0b7a7fmr2881163b3a.53.1790182672888; Wed, 23 Sep 2026
 09:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915150739.284189-1-daniel@iogearbox.net> <20260915150739.284189-5-daniel@iogearbox.net>
In-Reply-To: <20260915150739.284189-5-daniel@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 23 Sep 2026 12:57:40 -0400
X-Gm-Features: AcwNN1XZMabSPPsGaBL7S-QH7qLqXRrYdrHmvEhiaqbQfwf82MsfQqNIw9dalxc
Message-ID: <CAHC9VhR2Zp9LzDRwDOZoesOC7o8hretfgRH-PRqQRXA0EES2vA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/8] bpf, lsm: Let BPF LSM provide xattrs at
 inode creation
To: Daniel Borkmann <daniel@iogearbox.net>, dwindsor@gmail.com
Cc: alexei.starovoitov@gmail.com, brauner@kernel.org, john.fastabend@gmail.com, 
	memxor@gmail.com, kpsingh@kernel.org, matt@bobrowski.net, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 11:07=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> From: David Windsor <dwindsor@gmail.com>
>
> Many in-kernel LSMs (SELinux, Smack, IMA) store security labels in extend=
ed
> attributes. For these LSMs, atomic labeling during inode creation is
> critical: if the inode becomes accessible before its xattr is set, it is
> briefly unlabeled, which can disrupt LSMs making policy decisions based
> on file labels. Existing LSMs solve this by setting xattrs in the
> inode_init_security hook, which runs before the inode becomes accessible.
> BPF LSM programs currently lack this capability because the hook uses an
> output parameter (xattr_count) that BPF programs cannot write to, and
> existing kfuncs like bpf_set_dentry_xattr() require a dentry that isn't
> available until after the inode is accessible.
>
> Add a bpf_inode_init_xattr() kfunc that takes the hook's own xattrs and
> xattr_count arguments, passed through from the program's context, and
> claims a slot via lsm_get_xattr_slot() on the program's behalf. The
> xattr_count output argument is exposed to inode_init_security programs
> as trusted read-only memory, so programs can pass it to the kfunc but
> cannot modify the count themselves.
>
> Reserve BPF_LSM_INODE_INIT_XATTRS slots in bpf_lsm_blob_sizes the way
> every other xattr-providing LSM does, for the life of the kernel. The
> framework keys the collection off the reserved slot count, so a kernel
> built with CONFIG_BPF_LSM=3Dy now allocates the xattr array on every inod=
e
> creation, whether or not a program sits on the hook.
>
> Give the hook a strong prototype in bpf_lsm_proto.c so that its qstr and
> xattrs arguments are marked __nullable. Both can be NULL for some callers=
.
> Without the annotation the verifier otherwise hands the program a trusted
> non-NULL pointer which it dereferences. Also, keep the hook out of the
> sleepable set. inode_init_security runs inside the transaction creating
> the inode, with a journal handle held on ext4 and btrfs and the parent's
> i_rwsem down, which is why everything on the path allocates GFP_NOFS.
>
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  fs/bpf_fs_kfuncs.c         | 99 ++++++++++++++++++++++++++++++++++++++
>  include/linux/bpf_lsm.h    | 11 ++++-
>  kernel/bpf/bpf_lsm.c       | 22 ++++++++-
>  kernel/bpf/bpf_lsm_proto.c | 15 ++++++
>  security/bpf/hooks.c       |  1 +
>  5 files changed, 145 insertions(+), 3 deletions(-)

@Daniel, you were CC'd on David's previous patches, so I'm guessing
you saw my objection[1], but just in case you hadn't please look at my
comments where I requested that David's proposed LSM kfunc be located
in security/bpf_lsm_kfuncs.c as opposed to fs/bpf_fs_kfuncs.c.  It
would be really nice if we could sort this out now and avoid having
this drag out or escalate.

@David, simply for my own understanding, did you ask Daniel to do
this, or was Daniel operating on his own with this patchset?

[1] https://lore.kernel.org/linux-security-module/CAHC9VhTS7rSnBqg00ZxNkcZy=
h_=3DEeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com/

--=20
paul-moore.com
