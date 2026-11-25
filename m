Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611199;
	b=U2NHOUy1VTp281XYpwPwFooTeVHQPHnIuSVI/PNwHQjdBB1uaekKi3cD8+sl7PoT7odZ
	 dDSU8iLQuSA55r4f15p8gvX/gU4WeZyHoQBhB6zPPUQNP7lWLB31V5PCnRAdCN8pWN/wY
	 8bKAzVGoKfSvVcu0Vm8IO6sesP2EqVWahNrDKOw2yX3KtWOWVOADGrrxps8WRlx1IRFyr
	 ENQG/cR/cMiLSl/oIJarUk15pqMbIi37IXk9H6s3l+nAKWJhZ2N/dpnx5NOHNLVW6fZ9k
	 6uu9gD50c5C1lGIx8BXyso7u4tiqZOfjjGRRwUoYpbckD5aiH02HWC8X28ok2Hyx8Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=wb5N99RF+uLplURkem29zNIHwOiV4iL5+6TcWsB08Yc=;
	b=P9TM5cXefrp4PJp4i/9wlwl97c719FNcRlXlGoGig6ZpBKTo7AxJ1vFaC1eSksYghRV/
	 JoELBqX7hHTuVVJR1sRtovD8ZqP5MlnAgxvm/BOMa5B7ce8m7gRiMe1cGXVqKSwfA4N7b
	 eoi13o573P/NcudZ/z3LRGcrDou+jjULtEF7Iuzr79EggE4Y1WGya91CwqlqPkIbOuajg
	 G0W9JLFuIFUN5Zsgbc4e/WTOHkTMRM2kJ4Klcjqp81tRdA02fiABcCwg2hymzv9DGa6tD
	 YqRdvHuAf+PdqHi53xIIGO0QGogk6aQnstDSguGLyOOYq52fwUR9Ipx3jki8PfMeckA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QOXEZ5Pu;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DD1606A687
	for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 12:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44DD1606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QOXEZ5Pu
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb77a462c6so49500255e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 04:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795611197; x=1796215997; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wb5N99RF+uLplURkem29zNIHwOiV4iL5+6TcWsB08Yc=;
        b=QOXEZ5Pu/EPca6q7kzgJRCmLrmsoVFR/ZRe4q5d58yeOdbJoHTuz9y0u/Nmk0CktwI
         CoxL971qgH9IAeYEJL9OV04KK9hoZrCZxCXphCDmaMaCEIiYAFkXm9z/Jipc+urQTX/j
         Fk8I31Tuids+3mCeGda6Q/7DCnEHSLo9OC+CFzZ1uqDLrPjUm6OialCUSj83o9zL6oVG
         iksZBRXktSiMRqpVyhlcQqbeKVyrA1zYnXNdKX3aSHnLNR56AH4l3EmMwrecUL/g6kYv
         65m48YXn1HMJU4OXkynxAivRZrQT+c7z3fBFxX7gT5o5ijKHn00slucTC0ZtqVCasBEY
         yyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795611197; x=1796215997;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wb5N99RF+uLplURkem29zNIHwOiV4iL5+6TcWsB08Yc=;
        b=al09ggZ3E/qgvSo6qn4VHJrJcn/+GEWHBpxHdqV/eS9Hh45C0uq8q0n2EcoQn7n/jf
         Bzz3J9JYyRf0MSX6Po6C/7AJ6afrF2+rKuIQ6ZqtufZ3ZyjFeJr2bytEncIKuD9c6x23
         BJew+Rz4SFYWQi9If0iA1nUk0mp5nAzLIHz/tXuuSgvBYLTZadbX/H0g0byxpllQlnU6
         XYx7hhU547w8uSYBdRpzH0baCxQwbBk+gola5s6N9Wfds3xXK/WXwBHARyeIeIdmXYqG
         v5b2C/hPJNR79VvNtfIGe5aAsfva6cjql6cpPKYVtn3y/auPzcz+e4pYDaBBNnLt2HNF
         tVkA==
X-Forwarded-Encrypted: i=1; AL+hErGdGRPxkwzqE5GXxQJdJK9lDxC3XL4IHxEPYkJOJEi/ZjtMoX50vj8pPDJF2WuHogIOqOMmiYsPxr0iCJ29Z94R6aVI4Xk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HfZA4I0+23dkzPIn7bKSjFTg4zyMr/n+7PjAO2eDNGVScp4Eu
	BPuvEP9FcrTVBIaWDEyNba18NmMXIT552soOlyyvz2uyEF/cEmCK0pJCCOSRXnyERHo1
X-Gm-Gg: AZFdTZdJ/GzzOvjwye0y55wEljzZDmhyeSbf5QLLxiJLT3NWw+7Co7qtIXzm2WWoczr
	blnb8IuM/JeJC6fQueqO6FFyFsDg/UJuB7Px0AY4g9UglpMvbIE6vPSSUmGzJrS3lpk+mLl7tmO
	R2hb4phNFKUwE2harUyBRjYi7JB3AfUnGiHG7cUHEFThYnjUZ+odzI+5voYr+yTl8uth7ZhJKDD
	x2+owxu/YNCWVU3M9gdHeDwp1FoezliCTj3Dp7fmemOCiAAByrNu6U9dYRwJtEQy8Gr2TzGuABx
	XZeEiBbHilO3E/LJJVnrYmB+tJq+u64ms2CtnL1EYOLfzSNSt2aTsreGyiqm6VCEYFVIqe3oecb
	yzqEFUndi0jhf3oKnsZJRtRyXOs3vFUi+Ll9y3Kp/OC6Zycz4GxIKjWUQmoty5QK/HQSuimskPK
	kuo5vgQWam5cphu/2/yYKsdACuLD7KNRWi9RoU1jJm14M4CCyT6rLd5rLkrnuRL4JcEZsB2QvVI
	miE3X3y8OWu0Y3R6ndv7lVuTmOTAqRmPGq/e3Pr1VxA656nTfrW+qbX5p8DzOixq05k/+VmLXl+
	oF3iQE5sDXvYhyVOce8h7u2OS6Nf4Ksz8ldVmiOZ5WKcQ3hHi2Q+U4n5A2+oxA+XblY9APWvDpN
	mq557i4Ncu0ORkjKRgvPDNedLbuDTzHgjJ7bOCYYSUTuJMRnFywyvf4R+AfHyc3UcSX0t6+QaxJ
	I=
X-Received: by 2002:a05:600c:b8a:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4bb88818156mr356853675e9.16.1795611196651;
        Wed, 25 Nov 2026 04:53:16 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:c235:97b:8b16:8928? (p200300cf572c2800c235097b8b168928.dip0.t-ipconnect.de. [2003:cf:572c:2800:c235:97b:8b16:8928])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm736573735e9.13.2026.11.25.04.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:53:16 -0800 (PST)
Message-ID: <45510e886330ade6013838f94cd84c688b263aa8.camel@amutable.com>
Subject: Re: [PATCH v2 08/13] ipe: handle errors from resolving the real
 inode
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, Amir Goldstein
 <amir73il@gmail.com>, 	linux-fsdevel@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Miklos Szeredi <mszeredi@redhat.com>,
 	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	linux-trace-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, Fan Wu	 <wufan@kernel.org>
Date: Wed, 25 Nov 2026 13:53:15 +0100
In-Reply-To: <20261116-work-ovl-d_real-v2-8-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
	 <20261116-work-ovl-d_real-v2-8-90564c4ae347@kernel.org>
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

On Mon, 2026-11-16 at 10:44 +0100, Christian Brauner wrote:
> d_real() is about to be able to fail for D_REAL_DATA. So switch
> ipe_build_eval_ctx() from d_real_inode() to d_real_data_inode() and
> deal
> with the error.
>=20
> Currently, if overlayfs fails to resolve the data of a file it hands
> back the overlayfs inode and IPE evaluates the policy against that.
> The
> overlayfs inode has neither a block device nor any fs-verity state so
> none of the properties of the file hosting the data are visible.
>=20
> Instead, leave the block device and inode state of the evaluation
> context unset if the data can't be resolved so the file is evaluated
> without any dm-verity or fs-verity state. IOW, IPE reaches the same
> verdict as today but without looking at the overlayfs inode.
>=20
> This is a no-op until d_real() can actually fail.
>=20
> Suggested-by: Fan Wu <wufan@kernel.org>
> Link:
> https://lore.kernel.org/all/4e9a39ac-9ad5-49d8-b0c4-09e665504609@kernel.o=
rg
> Acked-by: Fan Wu <wufan@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0security/ipe/eval.c | 13 ++++++++++---
> =C2=A01 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/security/ipe/eval.c b/security/ipe/eval.c
> index 4a7be96c84f03..a2366eb9a47b3 100644
> --- a/security/ipe/eval.c
> +++ b/security/ipe/eval.c
> @@ -102,9 +102,16 @@ void ipe_build_eval_ctx(struct ipe_eval_ctx
> *ctx,
> =C2=A0
> =C2=A0	if (file) {
> =C2=A0		build_ipe_sb_ctx(ctx, file);
> -		ino =3D d_real_inode(file->f_path.dentry);
> -		build_ipe_bdev_ctx(ctx, ino);
> -		build_ipe_inode_ctx(ctx, ino);
> +		/*
> +		 * If the real data inode cannot be resolved, leave
> the bdev
> +		 * and inode fields unset so the file is evaluated
> without
> +		 * dm-verity/fs-verity state.
> +		 */
> +		ino =3D d_real_data_inode(file->f_path.dentry);
> +		if (!IS_ERR(ino)) {
> +			build_ipe_bdev_ctx(ctx, ino);
> +			build_ipe_inode_ctx(ctx, ino);
> +		}
> =C2=A0	}
> =C2=A0}
> =C2=A0
