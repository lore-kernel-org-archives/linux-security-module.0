Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564338;
	b=H/vk5PLCI3eWOIBfYnt6H8BHHmjGw3B/mlPapne8bjseKt5q4P7EeYayWHCyxyAz5IMW
	 MFahaslVH/A9C9Usg2jhZ3Y9OYyfR/h8QDiQ9tP6I5uOgvK8CGEa93x+KNRrASHWzzLp7
	 /kEo9TM79gEGkn9+kiUy3pRVlZmacefgAYwNcMtVFjGjhh87ax6CVQjGbJGx61ggh6QJ3
	 9jKrvNTYFVvsGfA4aGiRlEjIGx3qmtD/fTK12kTxlPKt/Dh1Nvpnxpkj8CUygb1NmN/mH
	 YVSmn/fNS/UIO+eepz0p3g02pQus/CuAwu6mqClYsSKvcjp92Wzs50pU4ds0oTUoQiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=/ZNAGjGCHSUHK/hbpNrctHFuArQcFUaSPHFuYTd8W2k=;
	b=Cd++aeTk5pK5eJV42bIUrdZaSkTRn5n1LLqQulFg33ZF4NbPdh9dwoevPwVYSoAGGb7P
	 +ARVshy3FzkJfuFyyDkNm9gSGY3gByEa11ZRD6GV8qvwKvpyM8xtAT36/C/21zMW6ZZ4J
	 /36xKbA9Cyd8d935C6l3RtIBt6q1n8sYAacMV/5i8D9vE//VOOBqC123WHH/d/CGdXr3a
	 sknPyGQoN9LOEG1FU8B41ERPAP+Miq2EtXvUFPL+05fXQpAZrGe0eGlSesgmN+fZqYfdo
	 V2cFhXw5dFlgwtLe5ipHn/soyhooFWODZ0zTQ0f0ai9ZETPAy2DFB9DnMaeewCmIX3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="BcN8/JZ3";
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01452606A8B3
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 10:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01452606A8B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BcN8/JZ3
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c50a2efbe1dso79590966b.3
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 02:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564336; x=1795169136; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/ZNAGjGCHSUHK/hbpNrctHFuArQcFUaSPHFuYTd8W2k=;
        b=BcN8/JZ3o8G8RngOszXG3JTNOcmRF7Y5HhcgHfEFuj8bd59D6/ZB+k5Qh/rpeFRCcR
         ddACGgLLZgU5b3f6uROOjMlLzNHxLpnDWTvmFTIG7dNNkaJHDW07G6TO1gom3Rvc3G6a
         phj31A4a6/nEoCYWD8i1KXLteYhy5qLcfDwMY03tf9yOOPsaa+sC0St/LDVgowIEHsk0
         tZO/CMI2RrlSiK2F32OSWBbCdipxonxIIN0DBtho56nDsRF+fFDKa92VHmnJVt2oHACg
         qH7hz+1dQBsoiVIgFoQGohYiLAIIKP/PCGAm0hHsixZQutOWB167lk9DbkeNw+vQ2Hrh
         L2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564336; x=1795169136;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ZNAGjGCHSUHK/hbpNrctHFuArQcFUaSPHFuYTd8W2k=;
        b=wKTsnCRmuQggvz+kMJSSk9nHpixcCMV+k8NlBu0IsAM436RqniBG3LqcCB2lkcaXTZ
         3J1Qu2Fq+tJvPubJgbcnoPkeXnsqSKx/miYqB0WTEF7OBucUufe6VUbX+iVstKDCyS7T
         T6ulbu4ZSDnZwd7LTmZopxxNOzieEXIJE6GzcxAl6qxeQEMEMABEx/BClfGOyYIbU87I
         mj6DfTukmAhRWAdDE9iBmT2iHm1banQIU1ALIwZqR0QUewq8TieB1B7RC7wbHRWfJWQm
         DGM0vaqeym00cFBEy7h/XbTu4eS9gl6Cb1+G9ZoklpHMzOMwpw2LhXJKBXMgG3T1Wlep
         nuOg==
X-Forwarded-Encrypted: i=1; AL+hErHBKqxAxOjdmtmVzHHmRbq4XshIMi6iX1+93Mr1sxrR+OR4UQBZntNai2RFDjM7Q9Iibwa3C61LbVauiG5vAfDgSGhISg0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9C+Ju71TQwJkQSUyOXv4SwojfQTxs2aSSCKrqNgpVYaM6j19Ph
	UkjF6Z3lcQZiLm8HWaV1QgCMapQj9UQ1sEVWwIBpNckwe5i6+3LXbxWWWutFhjoJIxpD
X-Gm-Gg: AYBFou1HkRlAieXtIUFSbt6NCT23ZEjDhXvt4A0HM6RgOBYb3enE5K8FsRL5TqudmoY
	qG+tne6gbp406cOo9Pm1K9dnYoPRistNUdjmUutiy0MeOJPNprnJm6zZoD08JGXnbcV1kRobodB
	b6HS7GiXpWz2u9rmrNiMRmBt50zRDlp8Y33rSJxA+yj/MeMfmVWUC4Ngn3kttR15OuZ/xVkDKfA
	P8pXWQoNjCQutoIUN5688a9ZhcrZYseXOfCjRMSln9cEKVCXzcx3fujBgf3r6MXZS/RqoffQziS
	RpeSBRTpqCpj+telYYasLSReI/atEzmcsw8bctcAudlZDncoigl2NVoiNQscw55rCEW+mCr2hoh
	qGZ4Ie4YUuebjZ+ty0wZmI8iK+WyieidE0xWDBmXLEpusci69jdcHIevLF0S0S8aX18lyDVdfVy
	o2p2KsXLg5AgHUlu5JLI2V8ltnj/TAbthuWnOCYXdqRNv4CmwVbJnosoRVZN8hYKaCsnvAZ+hB6
	g8fCl1R2EiTFkEPsz56SsvfCBTUAjJhLrzDwnxBmRtVtw5DXrv0ziKx3/eyVo1nWf30xYAGRY+M
	9OOu0A0yvMrqRNfyKFb99NRcer0BR8uSzJKQYGz9jqHwWJ8DgR2JfhyJnIR6CTY=
X-Received: by 2002:a17:907:94cb:b0:c2e:3a72:ffbd with SMTP id a640c23a62f3a-c5096389759mr162937766b.41.1794564336347;
        Fri, 13 Nov 2026 02:05:36 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095a5b93csm75365566b.5.2026.11.13.02.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:05:35 -0800 (PST)
Message-ID: <8f532a01f6cc2eb73582864343e25be4ec990919.camel@amutable.com>
Subject: Re: [PATCH RFC 14/41] debugfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:05:34 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-14-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-14-4c998976c6c7@kernel.org>
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
> Initialize debugfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. debugfs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The debugfs files that
> can be mapped, kcov, relay channels and powernv's memtrace, map data.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/debugfs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index b4915551ad31..f163f0bc5703 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/init.h>
> @@ -317,6 +318,7 @@ static int debugfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	fsi->mode =3D DEBUGFS_DEFAULT_MODE;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D fsi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &debugfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
