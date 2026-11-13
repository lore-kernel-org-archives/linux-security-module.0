Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564237;
	b=3T6gGO7PL4P8ybYq+2OdWdhjJi2nYjH59w/FuIYD/kwwM857L/bN8py5MJ2oV0la0Udf
	 whAerjrv+JXVffyTowh9yvlMi/cXKExUkjZqbZTozxxCa7cjuj88L/+V0hTwEShg7823s
	 6CQL0i9CpjSuYmRMIICns13AlpW1ZHnEK+ilLXKtSyJnuIfoyEvKCUdFofC2raTNXdGHF
	 Ucmdm6Z9/eFaN7qbX5QV7VcWrytwrPgygGyWDznd51GzdQb0KJ/TKeu/UWBpy+6mMzTEq
	 Ovz8b5cPPpkpv69HV9FuRx2yHhmtfVMFIdl8H6IYuhnd6GUurIoBwwRFMc4o+x8WLZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=isfwHOSFEU1THdAtyjNR/BymwB+TGu4CpGjFt5oul8o=;
	b=asr4ExN13MgslnY1kcHL8+vS/Kb97L1WsrG6Ku2BkhahA7xtK96E9ScuF10ybDPyp2l+
	 9boP98blWNOpt8mPPTiXVuGkKHKXqEp6BR7Bd2ERqR3jHk2ZQqkc8eIvj9i/XhmV024wa
	 s2W5C7LDWdA79lCgQ2jWt9FqzdrubU7v2IiC5qVvF2suIXvGYMnKVKK8XdKDcKaj9F865
	 lNyS6cb+z7ylcYf5sFycc5b4XTgJSW8D8mz+CiaY2/kg+CSfImQeA0DNU5LuB7hyUp+bd
	 AsQi371DOuTG0vs1GwfSfo92tC+P85sYxxfsnQFLiFrIwfDZMi7xr0Wi1TcP8DOOSNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HmOhZp1a;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D860A60A261E
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 10:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D860A60A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HmOhZp1a
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b6f42095bcso1441618a12.3
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 02:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564235; x=1795169035; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=isfwHOSFEU1THdAtyjNR/BymwB+TGu4CpGjFt5oul8o=;
        b=HmOhZp1aysVRSGcApaAZDLI81xyeSldeu7ePLUPKkH54FsFfnK+QDVFY4+VQQZDD5I
         H2HloBZm5LZmO+0yz1W9rfEhaL+YICMUwpLNmuFaGXNfAv5LYB2fsAN36refSeHGX9fO
         cryYVQ+kM2KCw8u+OcP3112ltvgpCHGvfl9d9GfdLtqmNcwNDmKz3KTPAT46qO03zj8M
         uuWZNkUaGTWe7Ooua9eiEAKQiiHx3qf0rn/l3lNWMOa2sfege5hzg+R5XNTSj8AN0bpY
         dCBAZCrR4vjcQdomnF2hzC3FA98LaruL1WYTiCQ1DC9kzlEXZqoLyeQdM7U6VrMRD1VV
         Lr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564235; x=1795169035;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=isfwHOSFEU1THdAtyjNR/BymwB+TGu4CpGjFt5oul8o=;
        b=uNv/4Zqoy73DHe9MdQVdETpuoresA60AWTsW08ukKe7DPmWGSlobn+GVXxr4XRFdBv
         g+sT66h+ElOCixaeeX24bWbaR1KBzHL3JY1FtT5mmEWhpPua5HKgeoWBlduwoqo79lx9
         KJgMcLN8jwR/06oTgvzfebdxGjldXIQMY1rCp/FfZ6Bh0ryRegJF/7JBqmv/oej0ENQx
         s7h68mCkYG8uwKxoXJRlv/AeAxtfFB70s7enlJ+Hum0RlgQVArSBPb4zr/rGsh7ucg5E
         SfCkRFY/ofkHbNSAvDxwPLRfxsYb0VzyvwdLCz+7Ckv8M7Ov8OCXLuHIDY+stcvzLZLh
         sK/Q==
X-Forwarded-Encrypted: i=1; AL+hErGueuFcpyF7rMjPeSZOA8xcr/Hpj9Rt9W55HRsP7Qio8ovCqU6dP+IdbYJ6RmSWrKF0fZe+c/EbiK/+eDNRuIzR7+Q0H/Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1UdqCuxwEpaXhtmSORnZh8kCgP6v7eSzc1dhQMbx/H11kRXXe
	JCqK4l3nl+SzDabTKMqcVfiqqFHkmK4Sn3rudzfaccHkJa/cKvzem2TzOsla7sEMw1bW
X-Gm-Gg: AYBFou1SdB9IYTCD8p1AHCkKMVlUIEJlkCIbSQjOjQ0mYhwqWdx4q2GX57vBai33FFJ
	zngcpRiNTUU0yBnJSL4hz98CQ/ks+wn4n8fvnZXZmwbjNg9MpS74yaMdrGmWmAZ9BF7aSBwzUhW
	5jB7worcH4Hd9lgs8TvnYIjBy7oh3SbU3TWCx02XeyVQ+45e4Gl8ex0XzOIUy3hxxMTGlOtd1hU
	XbCVITyyKmEi6lWc3HWA3L6B5evQ8Ky6ICCzksvLOY7wVIWlBl7sw8dZwHnnWtzMGI8O5pIzcHh
	Sv7kXnM4zUL8gBnMIy+m6SbO3VExxuolt7seh4pHX7OyUBQ14PgfZxBTNLwEc5SFlCwOSzTqpcp
	sBPNSIX7tP0bCdvzmjyxqpiMbqj3MP7aUGZemtWqLJX0cmcHmfMskSk65fkG/QJotZd1pz4yw3R
	Z57Omu1cSnLkueEIb7JOO8BEZYdJbAs+IATZgOLRwfcJFydBriPR1EUni8jk4nAkt+K1yu7su27
	198U5LhlGJuj7XbThdz97uycbzs/4XIfT0WuB0TNhw98JQCdgExYueIbD38egYflt21mmoaliNd
	sEBeSLW6jMjnSu3rPZV7fZC6NGshPtEhVZH8vfD2nd68G/34tevyZp2QQgueM5Q=
X-Received: by 2002:aa7:d556:0:b0:6b5:96e9:ae97 with SMTP id 4fb4d7f45d1cf-6b7c0ccaafdmr1234919a12.34.1794564235160;
        Fri, 13 Nov 2026 02:03:55 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23611casm766458a12.9.2026.11.13.02.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:03:54 -0800 (PST)
Message-ID: <16dbddeb5cbb9613dc806b43fc681eb26aa3b0dd.camel@amutable.com>
Subject: Re: [PATCH RFC 10/41] nullfs: use fc_init_pseudo()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:03:52 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-10-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-10-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Initialize nullfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/nullfs.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nullfs.c b/fs/nullfs.c
> index 319c2f5c5a67..2fe24cb97160 100644
> --- a/fs/nullfs.c
> +++ b/fs/nullfs.c
> @@ -2,6 +2,7 @@
> =C2=A0/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
> =C2=A0#include <linux/fs/super_types.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/splice.h>
> =C2=A0#include <linux/uio.h>
> @@ -174,7 +175,7 @@ static int nullfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0{
> =C2=A0	fc->ops		=3D &nullfs_fs_context_ops;
> =C2=A0	fc->sb_flags	|=3D SB_NOUSER;
> -	fc->s_iflags	|=3D SB_I_NOEXEC | SB_I_NODEV;
> +	fc_init_pseudo(fc);
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
