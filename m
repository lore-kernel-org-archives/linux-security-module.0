Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794859451;
	b=Zb/+xHaiXM2TDqSa5ZDE5e4GiTEnyk+LgNLy46KrpkjcJvNpY0gBm1hmjErv7LfM9IVi
	 T1MpKIiez9AZya9jFaTDh88UKsjWAORS4gL+661RyEEnME9GFjumPtJstal2hIKaTn4eO
	 HLqBg45wM9rGH4YbIYxYX18oh4PJN7HiHjeijRB9Z6pIvudk1V058Wax13/YtZoqC3eOJ
	 ykC+Z5tksODS5GkviKmM7DYz8jXSSRAKoDlD1Wi8ynd+v4vh2D/mjBc2TgArMJBPodAzb
	 g/9MaRwmVwHEdrHG1XB8P9rTo9IADX64NwYxFoluNz4RdsC68gEIpvafCRk8i+w5ASw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
	b=NibkClpOpqsfsTDgl7z1z7JVd67CesWhmFNLge2zyW/j5hpAInvcMOQ1dh7iK7xhek30
	 ksUfFCv2LqTOkunx71woLeh1UjWISV9VraO8aprvpxeKtgHqnBrSTWw9CCAGSpMWSGg5Y
	 EM+Rw4qQ6RyuHd7UcUKJmG9ZO9wndv3cnL4y9cbbXTVOb6PqU2lHDsAZeQXcjaRieOoDw
	 kSjJcUpqzc+f1TQfFEq2g6rWltKTEBv4cB/zTcwjk9jcc9URkzpuOqtoJlvCCnJcLaW7s
	 TzGlUILl/z2MFA6GRqbe3Zakge1EL5K1DseETz55F2e9mVhMYgpT0eoHB0SZ2Igy/BA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hnqDx80H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B231606A338
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 20:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B231606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hnqDx80H
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-498f5fa5103so1736448f8f.2
        for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 12:04:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794859448; cv=none;
        d=google.com; s=arc-20260327;
        b=izHB5B/nqej00BwSa61RZtgpN2SE63HRH7GEHlyG3Uszl3zLa7pjpZmMica8ELIVS9
         iibIlAOFe3RVXB0juNuSHveED8OHW0xZH1PTc2ZVzwdL0yiaFmxXJQfdt5+kYO5vpJAL
         fSUYbPWu76RgdXy00rvdnN+O34o8fc0zPkH2doqCkHJieWUArBBJWLC/Z+iERd/HpVWg
         u9aFLIXi7gd4kDpNnYUknQh2xkVHm6dDQsR+8wmrn5fvgcHMutFkZ0s74ZyyWO5GSTTY
         8jpNAJc96SEKkdU0FxM98x5zxoutPtaHHYUfB4CQ2TNkLnf2ra3xuehA0IjSO6SGmSq7
         Pc4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        fh=wOolAOz3SPCZokzykQjDYDqwcaz1QyATGyFz8ILwNXI=;
        b=ba2l510mGk77OKmVAVVZuOl3iDTa3OvTOHBspxhZ4T+79i/dp/0iNBbuV0akkBVFLy
         wZAAfnYKx5N1U2ZNQilC7pnhpvSLZnACQ/lsxRb6BYMNJ0xmDjB3Uc+uMCmoTbcx1Eac
         dAVJEYqoTJSuS04vjH9p7VvMQN2CO6cM594Eg2kYrIh2DSwAhpIGqW4PF/mOgu8+RtZM
         vi0p9h3FPOxT9z2A88i3JT5n4Vq/0efG+8rnaIAISfrJzBu2eEeE0WtZsVAm+DRRE+hM
         EqGzJXpC67Db9266w+ZrqbdYLPthujp7CNpFE6pKsRcK0kp4RZZIQyoc/IQcOM/Mpnql
         WW2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794859448; x=1795464248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        b=hnqDx80H1BHGMZ+jCw863LQE2wm4hG6wTw//ziQNWkZpZIjdyNNCtFJNcbykSvuJWZ
         RrqgQGru9l+9Rlw9NCoAO7RXSeH6CHzRwb+h6TsbT77V+vTLtC7o5AslWzWJ8+7yhciq
         sbJxN7Yoz6y6VYO91QUyEDVlXVHt5e/uzOZriYhKEljZIduQH6pNfhdOY5sHlJFueOxf
         bN/uTLfuNBjnHaTZ+WukZQS/Wa30tWyiKsfqEPmOKtkcPCgN1gGIeLsa9pfco/3ZvP3P
         koo3Bb9/+esUnHdHS2hTd5qtXE/k/xctadMJUuU/zchcL0VDKvTRNofZgdIQ6mLOou9W
         X5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859448; x=1795464248;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        b=WTtlf0bTo3ULQxwVFHuz/xInl/TH7zN1CuLD8t7dqJ6B04tLUTsgAINWo89xXJxiWk
         DM51I4+KrFBIX6F+UZWtt1rwKv4bibn+fBLFy7GHkrQlfSJuS6lIGPhiN5RsfqlG56b7
         lwBxCOEtYTJRSI1QQavup2y+yUnmKLVB16Goqj4I0zf/oQMqJxSosvRw/j93FhRrUiMG
         nV5mICEv3fhec5AJ7wSInhi9QYJxBilvrTKjl0oX23WNiYXJm4PWWBU6rbc2jF7cR9Lp
         BAhe1WEgtzxBsvwZAGxUZZMHFjIDWBHM49697UIb4vuMTnlXkf4XUc3fpE7P35tLsIB7
         qHdA==
X-Forwarded-Encrypted: i=1; AL+hErEIn4fKbi2PuoEkNkzN0zLsJn40RqfpuBvOnaCPHWe1iZgnBzwqPSzX+zzJ0fYqo9b3yEQWnFK6N0Dds6ZxdgCI4coixwU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gcbj3bOVi6SLrnalUQnnaFXiBi8G5/9YG70de8icNwuEaoI4o
	d7b0M8dVERB4DeIrw5fT/izz9EB8tulH7P+rIQ4jdCnWpsRDATEaWTcDmB5h7Tw51UX9AlRz2TJ
	kfkNgsP6Q5+EYif4y4TZOXoitr9Nn92Y=
X-Gm-Gg: AZFdTZeC2UZBmyph27uXWD1tMcVIyezR3rp9cVKS/YZYcdANIkpcGrXCYfVXUmapzZg
	99WAgaZvIj7Ov/LEec6cun4XKDZjSCN0H6KcwTVodtbqa3BA5CDorkgNeM4QV/8gAvUbFdc3SZv
	6ZtxV58HQLmxC2RIpGrxXilkDhLMYLfqGjcusGuxIxAHJjpdYSWeXjgKg2BMtBTvmjL0+riWp+j
	7EH7DFhrdU7sWUNj0FtdkSULNBI4lnd+4069WC7F6vB23NXYI2ZdLEfQmNOyFoK3M2+GYaLW7/l
	I++PUU7LICs1yewEFrQ/2Aligt8hCE+SkH/MMtBKfekPg6zDBkBMmNEqvYQwdq0bodIEfhU3vMX
	CmdXg13nYesTr2fzDYbhCZ5380YGNoXPnuYLql+LSeaNz9vBCYmOBIvwHms69lB7pwKuPkaDe25
	mwQSmtU8NEieMGifDuPN8=
X-Received: by 2002:a05:6000:4692:b0:491:3fdd:af34 with SMTP id
 ffacd0b85a97d-49d61c80db3mr13343868f8f.36.1794859448335; Mon, 16 Nov 2026
 12:04:08 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org> <20261116-work-loop-pseudo-v3-9-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-9-8cbbea1cf34f@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Nov 2026 12:03:57 -0800
X-Gm-Features: Aa3M54q6P4M0RFDCKQ8HHGNCWJafItTSPdWR1qNwVGtToDAv2VOv8vDfWHzYR6A
Message-ID: <CAEf4BzbLFVawibuX0wk=8uzy0WZSYHbkgK55d7rqLab2qAM1Fg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 09/44] bpf: use fc_init_pseudo() for bpffs
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
	Alexander Mikhalitsyn <alex@amutable.com>, Chris Down <chris@chrisdown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 3:21=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Initialize bpffs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  kernel/bpf/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index c6f328e4752e1..57cf3775c0766 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -15,6 +15,7 @@
>  #include <linux/namei.h>
>  #include <linux/fs.h>
>  #include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
>  #include <linux/fs_parser.h>
>  #include <linux/kdev_t.h>
>  #include <linux/filter.h>
> @@ -1197,8 +1198,6 @@ static int bpf_fill_super(struct super_block *sb, s=
truct fs_context *fc)
>         sb->s_magic =3D BPF_FS_MAGIC;
>         sb->s_op =3D &bpf_super_ops;
>         sb->s_xattr =3D bpf_fs_xattr_handlers;
> -       sb->s_iflags |=3D SB_I_NOEXEC;
> -       sb->s_iflags |=3D SB_I_NODEV;
>         sb->s_time_gran =3D 1;
>
>         inode =3D bpf_get_inode(sb, NULL, S_IFDIR | 0777);
> @@ -1261,6 +1260,7 @@ static int bpf_init_fs_context(struct fs_context *f=
c)
>         opts->delegate_attachs =3D 0;
>
>         fc->s_fs_info =3D opts;
> +       fc_init_pseudo(fc);
>         fc->ops =3D &bpf_context_ops;
>         return 0;
>  }
>
> --
> 2.53.0
>
>
