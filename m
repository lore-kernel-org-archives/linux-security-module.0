Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904032;
	b=f9CkMDkt45cI/klLGAODEhhjJ1GDWLKsA4CQHr093ITOVPtSlyG8AYvc0mC8jRpC3+/r
	 KjqqBqJlZgoSa9Kx2+bDop5zYxFVfgZzcwr2YrpnCzkc799CpokXrcwmBP64wgJ9rLBRk
	 Kk6yg5lhApLNKbGzTJRjiouEYpPkcvgWLmpIxgTKwvQxnH1WZUyZRGgYyK3QuGBaXf4oj
	 yQCuU8s3XWyv94kgD9bTc7hACbiNbf7eRZtbI0qu2v7pr4P8KpVEYFYWt7piFJn+/YIYw
	 +Ctv9OAfl2VnYTEPe+UJSDCo9u4nHVL8xv04EIqVvktUyVVIVPXZM6CSri0JwVH0sZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=o7Ds5Sp5DChQJ6GHa3pEkVZuOErJkij7LbLCUPT9+Pc=;
	b=KE1a3jubJ4squ8W5D6TcXrgO00arK8agI5f1p2qyDhOEZWZdT8x/0bSdnah3Q93IJwNM
	 IL0agMdAZAOCvG74tUy+w398Hswy9XPmZV1eshes71JFvLPE4FnPtDN3Z37LN8A/Hx1Yi
	 JyveDFOc9uhB6E+A41OYuPF3MJfa5UlNQTvcQ0tN/yVtE6GZ/NnZUUEe9Hh51Yw5oQyD+
	 a2YEA5UD/E5A3lRX6PpvUoeakE30fIlMFbUvUR6J9oZWu2PwjKiSL/zlVzTUS9iBVmeNb
	 CXlHuBfFX2ozfZg06F8DaOITVzwH5eEyykMakEAEEF+iFq4PDj9xEJ/wWNZ1bSncb5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=m3Y+iV2p;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E99606A335
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 08:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08E99606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=m3Y+iV2p
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so21934105e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 00:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904030; x=1795508830; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=o7Ds5Sp5DChQJ6GHa3pEkVZuOErJkij7LbLCUPT9+Pc=;
        b=m3Y+iV2pelmutPYORVxza4CHQMpjq7iS5lmecWgDjvax6Coso4uWa+KMaCm+CB3bWY
         yM9xDjlaUDqClL2wfFs+3EgMKFX4Q8fuLgup7VSVEO3iDYFOyh4nyeN0Shri07+KD82b
         UFGbuWvBELdRnXkiKa1GIWjPRb4Wz8WRQUErt4eMboeCaxWHABbQwTZk6BuPw2NopAXW
         5935wwOL0Ggt8LD7VeJmtmL6iC6DgtiD4S4DRbEtkaj1swNFS1XEbe90cWaNyokAE8Lz
         Ulc1c4G0eNVUIpLzTdbViN3HgCOMoyHpu6hnCIZ+utcpbQY02w1kBKtCyN8iaUfGq6tI
         6sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904030; x=1795508830;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o7Ds5Sp5DChQJ6GHa3pEkVZuOErJkij7LbLCUPT9+Pc=;
        b=ETBxmxc6foRVhWr6oYMO/98gp4mngZxJNWGHTQ76I9xcfSKTlxnIcE1l9WZfO35uff
         fC4STseup/N1KQ4xPdVcY3OcZoVBN81Yvu+XSopiLx1xNNbgz6ZfcBPd2t8kL/grqg2t
         McLtnDM2emf+9ojT/kk6QfUhHKkX+Usz1lDNfeHM34LsMkxm/aaVE8bRBTiZ+voP2t0d
         hkz0KgZB1tswkgBPaT1m7/HDUc0hS4BMjkmdF0blzw8WVu2Jy1jj5q3HGE8jWdA2pa8U
         VfcBtEo1/GrwDg4Pcspb2UzY8ecVOFtEA0D6aJ8tnuoF3fivbYtocHxn/8++pNCmn9Ng
         RjrA==
X-Forwarded-Encrypted: i=1; AL+hErHPvd8btTmTcbuFKw9RYg4rD2n6SiYl0JwG215GsnrWrj+oeOlFL+7Jar9QCdMg62E3Aed5Pfa4KlpiUgr4j74VEACepM8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8c91JcFoMZZ1DmFh3hVfF9cBMCebhVRoe24xB+TsjAO8lex5CQ
	r4qmmS91Zcg9nklJjIbp6Ck9mYQ3GVEqrzSqKd0bC1xsjG02pQVqq78C0J0VdE1MZXTW
X-Gm-Gg: AYBFou2x8Bfwf1+SUJMcsrUCz1qs5UqavSfP+QXhGS2S6DpBmrqwGjLKsuRETY0ZQHS
	kiBN539MZQzsMjlGvHe8V13jQrUBtcHZnbi9Buqpu9OEVWYpVxmHt0b0C4ZLwD+Lla+lMtiIUXa
	iNClJDoN4f+CtCOSUwYzF88/s3TB8snIUvWzyC3P1mojhO7SCR0Vquc3yM9MCApgy9YYoQdmPek
	6+QVnA0vt0brGaPFCPxSQtsLtEkB6lTUhgouQvHf4s0OwFeHf3jIJWhe7akU6ryFycHxtom+zIV
	VqYE6Q4T77X/nCLdb6bk1okdbUtzZqbktITUJ8KpfoyO2OKRlntUZPHXrTfQKZwzDQIxGB4fqfK
	T8n0A070JthxY13b+B9yw1i0SfSRwSP0Wzit6nEzwVa8D6x4mfaxpdpk6gT88CQHq00Gq5spv2C
	nvvib8xG7BGz9C4SrejVZ+uDtfnJE4avBKNknwm+KM4jzyEBXpJFHjZSgQ0xQOJ3yTNmG8MN19F
	cGGXStPT/HlOwwAxuby4fImjVMK0ESqh066r2/Vw8JznvR5HtQ+M+BjkA7XWEx3SsWESxYudS8y
	hEw1Jqs2OJYZn2GrTcUJZfARE8V/EOIExZfcwpR5nRJwKwKERdWGwjh3J2Lj0dSbhgnKUluXzZ7
	hzqpthhGCz6ahUeWBEpEU5Iv5xYFlktqFdtZ+bqnW2W9/9KNsJo0AIsY1
X-Received: by 2002:a05:600c:3494:b0:4bb:6c71:b268 with SMTP id 5b1f17b1804b1-4bb6c71c232mr134135095e9.6.1794904030378;
        Tue, 17 Nov 2026 00:27:10 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7838c912sm45730155e9.4.2026.11.17.00.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:27:10 -0800 (PST)
Message-ID: <0ec7b8c90cc456b24e5b19c1db673d497ae43735.camel@amutable.com>
Subject: Re: [PATCH RFC v3 12/44] rust_binderfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:27:08 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:04 +0100, Christian Brauner wrote:
> Initialize binderfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC
> by hand. This adds SB_I_PSEUDO. binderfs_fill_super() keeps clearing
> SB_I_NODEV for the binder device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/android/binder/rust_binderfs.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/android/binder/rust_binderfs.c
> b/drivers/android/binder/rust_binderfs.c
> index 5f020226720db..04468c5b5c116 100644
> --- a/drivers/android/binder/rust_binderfs.c
> +++ b/drivers/android/binder/rust_binderfs.c
> @@ -3,6 +3,7 @@
> =C2=A0#include <linux/compiler_types.h>
> =C2=A0#include <linux/errno.h>
> =C2=A0#include <linux/fs.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fsnotify.h>
> =C2=A0#include <linux/gfp.h>
> =C2=A0#include <linux/idr.h>
> @@ -667,7 +668,6 @@ static int binderfs_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	 * necessary and safe.
> =C2=A0	 */
> =C2=A0	sb->s_iflags &=3D ~SB_I_NODEV;
> -	sb->s_iflags |=3D SB_I_NOEXEC;
> =C2=A0	sb->s_magic =3D RUST_BINDERFS_SUPER_MAGIC;
> =C2=A0	sb->s_op =3D &binderfs_super_ops;
> =C2=A0	sb->s_time_gran =3D 1;
> @@ -759,6 +759,7 @@ static int binderfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	ctx->stats_mode =3D binderfs_stats_mode_unset;
> =C2=A0
> =C2=A0	fc->fs_private =3D ctx;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &binderfs_fs_context_ops;
> =C2=A0
> =C2=A0	return 0;
