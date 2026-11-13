Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564336;
	b=CZr9DkW5g4LwFvs5uwrljOeHKostrvpQaf5l8id2UBTiX57Lhn+9IpkM3UosWCIZZ4EZ
	 74elC51+P7WhiZDCpcH2XN+Te3/XLg04SLl58ak4I2ANMkHfBw6c7VdHnTxwNfy9CEQ7d
	 XXnpo3A2jS4MolFgplLZh1o1FBfHKV7jWn2/KNdc/l/oUUz4Z/NW2pViivhTOVGkh95oE
	 X9QfxExeT4SfovT5ks47qIHmK12CCxBOT80UsSs7ygDirsXaJjnM65g0DOngVV2kSb/hK
	 x65nzvf8LZZ5SBxwe9HoYXFE4JPhx+uU8rmMO/Zf9ooYoGTU0r4KY9eUKhW8KsdCCow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
	b=bYV/MxlTcuPozLylAyol1FFL8yDYCIx1Adr1pWCUHF/TCzCqKYoWTyrfYT0K/LhmBCDY
	 XniUfBQs9jH1INNprYcGhPtxwMWNhVmKqzs1MOVj5Rn7Wj9W9JBn0ap5EAsARNT1zTPno
	 z/lByocgvkNjTuo53vzXUzO9QhLmoMxzo41alf14YHh6Ijn1riRhj+sMiUKPq14QpXehB
	 v4eUQFbhj4oF2A9zw0gu133jx0mrJhOmOP+TQuDzh/Os4nSPcqY6LJXwRiOwA1JO7jaED
	 PMz7bkgozbMw0z//Cke+oCmZ6iS4bMSTmjYi0l7BsvgiDsutMa9VLPGWObQqg7lEpSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nUCLd8f0;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDB6606A8AE
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 10:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EDB6606A8AE
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nUCLd8f0
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b7bfefba55so1543278a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 02:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564335; x=1795169135; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
        b=nUCLd8f0G/K2fMNIytq9u2LWpw8l5XbCSUxsIs6+S5nVG1T3fI5ErIjnpvRMTRJ1g3
         66+hupjWTQxex7ntfQ08B69tN3G7DYFzu+MIzI3GxWcQnqgZu7yay01l+4mpEhy0Ef02
         xbNHIv/PH0KitW7ZH+pZK/qyW26JriIVV4HRgFAXvls3DDajVpT9R5cy9rfpfJ9qOhH/
         quuiU6KaH+bd+1MNp1oe0tS5lHpOu5FifqraRZhGcQQrLcBdrSt8hi6RHYJpJDDneT+2
         609Jb+e8BW/fqMWXfEgOdGZ8nZZS6I2LapQ01HWyupMw/vLrZIn5Q4gffAveGLQARYQM
         rrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564335; x=1795169135;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
        b=b5NTwq2tMmL6JPE/JboS3YBmzyYUV4kqCJ93HEZ+TPkieiVu4fX2USPcvG8nNLy+qT
         CWBZlOfFWNLDzwGSiTQPVGtpi0zAr3eZiWK9ZmzfMGuGg/2DThASz71L4dc4Hn2sAXuu
         pFCs8bYfk1JJalMJBi6eHpERLcUjOnST8QQIWx8Ds7yz2LuiTK5R1B6WCnZkVh0PDc30
         +VWaES8e9NZ+LzMAixJEY4rXflrUdLJ2Jyw6IHHvHEDsA/6WNqXtaX9qSF0T8dWBHA+O
         nCAA/R5hxa+jZntrVF+7EsBOiofyGc8UbT2dsUwMUGnlvUpBZHX0MbU8rb50wIJUjB2R
         ATNA==
X-Forwarded-Encrypted: i=1; AL+hErEfNxzlowdmuSS3WMe/LdtS5KVG+RCTsDp6r/vs1uuGy29qDg23pr2B1ZECBt7QIMsx4K/2lDlcPxBQWFI2gj13fpy29N8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8x7fiKyMdQsZlYIjcTDP0oxZsnX2raFp9+GJ2oPxFEdbpeqPqZ
	Wf9abNChy1yLzWXqRSA/+EoMkJBSF7spcTRslktoryFKrDLMIRrtsbinKOj3C/grAbAK+EboFgu
	jhsLhx+gJhyE=
X-Gm-Gg: AYBFou0sQ0MtOo7Z3o0mCjLUACIu7ZHUf7KEGi1NTYWI/Sla4cufTnWVoUgmxEDBsQx
	YB24QMs1O6GvnNvYm730OsKGV77Z4OfYMzJYyhRlDYBsc0ujcOQ9fZuQl9auIUXGWUJ9LHPWT0U
	0lqFRyaAjgzGLNYToGGqBEVMCzFFigtFQVLs7UqqOBpde8+SmKHLAsjxpIAj6Y55dlTPNyQHoH6
	eTEGGKaiVc2+WXb9scGNHG5pdLB5rFiBKSjJNpzNBrz9HDhr2dIn4RQn5WseJIkzy0/lxew5ozU
	YZHqX2SkQZk8MKN6rpHjWLLrUeuiYSJ1QaBj9fSWzPnlH33lRWbPQaTQutimLC3vZ0GweWoO2Ve
	m4gqJCWoszlC2GVWoqa68xtx/5aZsa+jm4PuHFNG97rbc9U6zrlbRG9sZuxAvEoSxh6cjF1jpAC
	GJC0eNKOEzu6xaS7o2xLuJiEQAP7dbcjLpn20bVMkTSbnXbUn2NYHjJcM2zUuurLlb/vCjUd5SG
	dKokLlEyoBKRNticRMs3Z4eeiMRjSglwzK8/Mp/xt0SYkSMo1ErxAtxaHb2dZWfKlsyzP10sgT7
	9uPIIfuy7rBmOozRKBMJUSscsmnwArpmG8MO5HD8gxGxmMNhHpag2MI2YwBbKjumYIj8t4Bv30D
	eFR+Z9g3w
X-Received: by 2002:a17:907:608f:b0:c43:eae5:ee80 with SMTP id a640c23a62f3a-c5096398b03mr148720566b.17.1794564321873;
        Fri, 13 Nov 2026 02:05:21 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b7b2c9sm75811766b.73.2026.11.13.02.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:05:21 -0800 (PST)
Message-ID: <08fa1be263cf4a3db6b3e5ec2847107fba7acfba.camel@amutable.com>
Subject: Re: [PATCH RFC 13/41] devpts: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:05:19 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-13-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-13-4c998976c6c7@kernel.org>
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
> Initialize devpts as a pseudo filesystem. This raises SB_I_PSEUDO and
> SB_I_NOEXEC. devpts never holds executables. devpts_fill_super()
> keeps
> clearing SB_I_NODEV for the pty device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/devpts/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index bd1e8eb26edb..47ef12241d92 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -13,6 +13,7 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0#include <linux/namei.h>
> @@ -438,6 +439,7 @@ static int devpts_init_fs_context(struct
> fs_context *fc)
> =C2=A0		fsi->mount_opts.reserve =3D true;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D fsi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &devpts_context_ops;
> =C2=A0	return 0;
> =C2=A0}
