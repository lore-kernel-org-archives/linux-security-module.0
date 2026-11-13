Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564728;
	b=rjTDghYmIhJo7P3gilA2ReUp4VvLgQbhSMvJv67hNTSP50voKDhB73mbXBjvdI4esc8l
	 L9gZWeqRtWbIhEKvnxKGojvQE83R+o7kgiRmzh2m9PHXcGiBRhAeYPwKmq31z35VgAOry
	 MWOB4BQg6InzpIzYfcYXcNPrjhWAuusBOxsP/RS3xaNion3kiL2vseyW/mvbELakflXho
	 /OgjYwct7S3Kw/OUnblQin2QrRE5w4vufmD3GgHofFQhgCf4igAnBzSJRkqO3aj6+ZKeI
	 blJQdybqiXpwz20vt+r99MUlD57t+Y+sXWANaLXeTX9l0exrYCEHFpIrPBrI5NvT3IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=C9TZKYRayQVC7UyXoancZRI4bPIYIHY06/n7s/4tB9k=;
	b=zOxCr462vr3jzYrjB3Pj8+24/NlIDgu2kr86HBf90jH09WK/Z5MfgXbWIQ/Wyv56Ed9h
	 oc1dLeYXLt6BxDLJMc/A0NAVZ5c4kZQprviEK/Sp3tWK/PKPNkX0eNY2tWaPUYpHQnFrw
	 iF6lJ0Kk9FaP8AnaSHshcfkok3L8iyfFEcYJ0Z9BSZJTsAzkrFX0LFVirckP6AV4rPbCF
	 8JIoE7lV4Jn4HJopKK2ZHq0phegyJQZz8A2tmZPrkI2bWbnYqLLPiFBPRiryfLWpHhZ6T
	 zfdbYPigV0U64Muf5JSUbF2omYdwQsq2z9NSxtQjis4gez/6fB22ECVejypPKVmBYNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JofFrwon;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3BA606A335
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 10:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB3BA606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JofFrwon
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso13097855e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 02:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564726; x=1795169526; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=C9TZKYRayQVC7UyXoancZRI4bPIYIHY06/n7s/4tB9k=;
        b=JofFrwonLml2YmEXhdcViuKQhdgodt9TPfkjQoH5bRE5MuhkX9eapeBcuLoN9BMOMG
         mg62x7tr1NIo2ce3//xfxGBo2Glw1JnMwrRUE5PKg9cgXRmANAsmerUzgfn4I+APSoic
         nLUkrr6h7Ej/6ZnsBOEx8OEPXrCx3CvMaGkTszs9w9WOs3gF62hftbL3MH/tr8iwAkM5
         IEqdn+20vI39qrHT5Lu5B20ux21tBPJwfptIyU9tNUhlU5QyFDk51k8ZhbiJowoQswf0
         13eatahih0uhEB44iQMwucAarD0vNvZBAG3aTkRmepVuKD8cgol5N6Bgv+DPTP+kX4Yt
         YdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564726; x=1795169526;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9TZKYRayQVC7UyXoancZRI4bPIYIHY06/n7s/4tB9k=;
        b=VymsR9zFPlqaA+cyCduR06IYEjHTisH90vVysp5OMIqtrq/Y40T58tQPYcXJV3+e01
         G9/LeuXib/pQCkIa2xQKPFvaXF6EIl5KomR18i9h6NY/xlze8Ojzlw+XnR3jYf9Qt8Rh
         PNBMHLQoPFCfYGezsr1t89RRqh4NI3SCcMXpklPX8BE4joU1WdrNH5k6klBOwnwmODjx
         suqu3dUa6KrqjF1mzJv9jM9VZ7QGCconayE+uDAezK+Qt6IFu3Dd+4T6mQw1I7n83F3/
         nNLDbUBT6f815CiXcSBnGmAjIv7z05dSiyowYpy9GEx3BFZUcpcP0RBHjcdXhK602VMy
         iXLA==
X-Forwarded-Encrypted: i=1; AL+hErGndwrW+byOOleoOQhLUereWGfc2f3/gOAZwDJGHbeJEp8O5KUWLw2MtQgkFkjXFdn/kVRdedXBPCEVZsNkNu56DBgNgqc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OUr89BICWjGTtY87iezKJrG1BnLvk+yonVCIJhD6hilUyJN+8
	yLM7dYLToBnozOPAzWUeLm5dx8zYqP8eT3bOzJTbZDl7SfVcUcNfn4gR2SeWg9Cd3Hfp
X-Gm-Gg: AYBFou2jfTxAN9Ye5e40dNVToctf/yQD0oy9xwHtSsbQKqAuPC68a95gRnjbR7lvFVK
	DOKZnfrrv4Bx9gxM+MocaYh31zWmfAmGARZH06fhy/nTPL8xnvRMSFNno4XbwY5idT8r4Srv8va
	xeHaCAwU05CKTJZZH4IAYG+LHMWacihFRPXzw+xZaCqPUXYI2GIBYLSGbCYct2m87hPrubrb+Wi
	wdv1O+RhV1rVhV+KppjRmH8a11PraT5n4J6MhunlYENFsqHL9MJW4f3LbL3NYt4kKoLz2+v2s5e
	TDSZPRwmvXX2FuODmM4PKRz1z3J+1oGT/CKi83G80JUNLCSk2mcZkMSSfOw1108cbX6sNWvVb2x
	ChOoCfiX3zaEVfL3zrO8fLtaCqQs60Ovsbn19gjytB/mAHuTdLN1d/NO5paKqnNoM1GCxMrx8GX
	CJu8gklABTI1hGbhWUx+b2B5DOxC7vyP+XcZKI7nBHO9Qpwxz2RxJVWe3WWAY4JA10icFed/Mzz
	5qD2u8C3JVoMhyde0K7/DN4kdsAQ4H/Zt4XcM4zvWtmmA9ekUemP0Ryo3ropnNCdFJs0sscw7D6
	f76S0theS5O14ZUeZosudTkwPmj8NUK0zFP1CpOpiv0KJ8pch8maGaYFOU5rrzluQjAtOgj5bB4
	i6DWzXwS5
X-Received: by 2002:a05:600c:c4a3:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4bb55a02932mr40317635e9.1.1794564726124;
        Fri, 13 Nov 2026 02:12:06 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2842e6sm142085915e9.4.2026.11.13.02.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:12:05 -0800 (PST)
Message-ID: <82d691d2db7579d9630bf89f73132e36124bf74e.camel@amutable.com>
Subject: Re: [PATCH RFC 19/41] smack: use fc_init_pseudo() for smackfs
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
Date: Fri, 13 Nov 2026 11:12:03 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-19-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-19-4c998976c6c7@kernel.org>
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
> Initialize smackfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. smackfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/smack/smackfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index a72bc7fabea9..4a56bbeaeca3 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -25,6 +25,7 @@
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include "smack.h"
> =C2=A0
> =C2=A0#define BEBITS	(sizeof(__be32) * 8)
> @@ -2880,6 +2881,7 @@ static const struct fs_context_operations
> smk_context_ops =3D {
> =C2=A0 */
> =C2=A0static int smk_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &smk_context_ops;
> =C2=A0	return 0;
> =C2=A0}
