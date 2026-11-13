Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564378;
	b=NwWANH3eg7L/ZO2sLTVp/l+vbLlUyyFYwQwU34pX1G1dx+rI34lPuasCZ7s7a7GSO0LT
	 uYoQJVaPM5bdkJRRQRiN+rmfhHWiP/buYvXkC0UylU04wzO4IUdd3lq0y5vUV8aMrJaT8
	 K1ybslHa1IRBclZUqAVduONtXMA3mfSF9MkwnIpULuGI1sfIMeV9yByWAix1hljiDdD4c
	 h9cU1sZgwsHYcmWfuvWv4cWTiUrukBPmcuGArNss8OJbD+/7RaFn5ruK2DcwR5t5H7HvT
	 MYkzbXOgQJ0qTzCXToyLpElwQQgAI65LqoUej72wRl0WgKBuUi0KaewTfRZXJqvRoWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=oBVCWZMOabVq55k67Q8GIm9NBAOJHOxllLRlvncSbis=;
	b=aW8Gi1dpj9bKv2DHGa+wmyApZAidvlt2lYF0jw3TzfxDkrYSdMPHNrVITkN3nIlSy3yS
	 TsdCzMKUKIJssIo2e4dgmxjHrnz3KCT9w0PMrxeqMg+IsJ7zAYJVfqEEACCsoBWTrYi5u
	 Det7jDDDZmDMT1bH2h4dUJxj3SQCs4Z+I+o+BNlAhaIp76Itnsbhrsr1FGHuBGk82HhXk
	 lEFqQeHHMibAlC2IzFpS8wMuDr5Ahf0cPhPuiMW7Cwk6+r6IuIVJlAsvjH0ieZlbuHzC8
	 AxllawBvA5xlG94AvqUf0J/nYioFU7qfuDxx5f6KFN0KXZTTKI84NXomOYRWpDVLSsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WDdVkHgl;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4BC606A331
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 10:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA4BC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WDdVkHgl
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b4bd3d98bfso1517180a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 02:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564376; x=1795169176; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oBVCWZMOabVq55k67Q8GIm9NBAOJHOxllLRlvncSbis=;
        b=WDdVkHgloKbBDmiudlEZ3ZWe+zg0BVZ0Jxwgdy+X6nc8ZJ9FIVi7F/SYJVqBRxNf3G
         3Gnq29xgDZdSKYiYaDVmU8W0xCuGm4Eu82rb/A8U6D5iLEOgHTmlDog4vSfdCU82B9rm
         qMGycG7Kl4j8h61zt+kqUkohzwqy0DPARMdjq2hKw51hdb6jylA1cwqwSD8nreSBsEB9
         DkDXk5ueYK99P4pH+jY8EwMoZnNW6BehoecLG+1JSq6wWJXsZMYgAdKGybKKFJkxuO0p
         O8Ri4u2My3QdIqEe8fwKAquZP0382+IuLTCd4KpBNa7znuGAHwPb5rxafjOggGTtG7Td
         r9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564376; x=1795169176;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oBVCWZMOabVq55k67Q8GIm9NBAOJHOxllLRlvncSbis=;
        b=gd99L1HMznhCBFZdHnetxF/3BUPO8S5ldBqmpASCD+GfTYw6M34WFmtrxs9BLEGn4q
         crJy3fz7yjyAe2JRcDWmRw+NWvU1+tsz8oStYMSycsyUmmXnSuD2MDoSPxDf0rIih56s
         fUG/WDWyLdnMyfC3o+7VILWy6KHXH/CSTba7956kNgmwxIMY+hzZrPT7FaJM43cUM721
         R/kb8b5O5jZuBRX5Q0W/rlGQMVresJ8XdhngyHJGcc6lTVwFs4KXGmrN85+N4ZmBG1tu
         Oq/ZE5KDmTa5hEVCSr8XIG6TgweekG6i2ACieB9SAgWMwjUsTlah5zAdaCGQFpUK1L1q
         9w4A==
X-Forwarded-Encrypted: i=1; AL+hErHOcHxz1+1nF5ey31mxJrzi52ENMEs0iFkZg6k3iLGPqZwIr2Bji7oHtkBO4D7TX6UJDJ998Tisz9aTGIRoRCDt5tFQodc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YmrSHE05V2HSmWDC6iXI5cvGq0etRJ0GAsbPXbQTPzRiy8LrD
	cg0uMyt15G4IR53AxThtckvcWiiSRb4+nRLl56DghkqSRjOXHyjTb5e6KosiPZ6Yf0t3
X-Gm-Gg: AYBFou2jC+Wu3nHYBDliOcm+wjXVyr/EcSx+fTeXUQAE6nzai5C7UY5AOEz22l3V1a0
	XxAV9jtwISZ8PlKPLeUvUGe3Vrko76XsnBwXBjINq63YB4zOncAEuRLa4MmjcIQtlErp1LeCl18
	RZ97ObhgmC0l+osYtAe0WMDAocBqy6dfDa+XetucIRvbfIPamRTfJ95vR2rgn89EwJeSIaztyq2
	NJHnenbF1Rd0NtjDoYQUZMhPkr2G9Oj0T8M0XdZbV6Rw2qoWlwAjqjiPxyYmKGqaBmIVu17v52n
	4ZfWE0HOGhaptd5skEkzLuVQ5z6yKoftn/M0C6ZUVl7D+ppDxSrukY/XuhdAqU/A8X0mCO/Nfbw
	Kw9Std/fLYwpaVdr9bf/viVDmv44YYqtL37IjtBKwCoNLdDghmPRQodvaHEP0QQqZ0VUt7L5KcQ
	pfC0ukPf4jkLquYFPRUV7TMRSg1PY1VyhDCSQ2QwcHlmng3QSH0jfYGAYCUQ/xVhPPctI4kG5pz
	EJsPX2sQtsNCwS/vIN2phz0JojGOY/ap7F19/ZnxpCgNbyvW8gux/UPEvp9leh9tP2JqBriKx8Q
	t69d+eCdAdfQH/26NWAMvGzaxuRPKoLD33sxa1RfO5ovFwXExEaZ05Vmk1Ih7ps=
X-Received: by 2002:a05:6402:280d:b0:6b6:4dcd:967e with SMTP id 4fb4d7f45d1cf-6b7c0bbc394mr1685420a12.20.1794564376161;
        Fri, 13 Nov 2026 02:06:16 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c21b1b5asm706711a12.4.2026.11.13.02.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:06:15 -0800 (PST)
Message-ID: <4dfa19dd41ec1a202182284d9617926a259288a7.camel@amutable.com>
Subject: Re: [PATCH RFC 16/41] configfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:06:14 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-16-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-16-4c998976c6c7@kernel.org>
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
> Initialize configfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. configfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/configfs/mount.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
> index d8cac1cbf3bd..60ba24e7ae2b 100644
> --- a/fs/configfs/mount.c
> +++ b/fs/configfs/mount.c
> @@ -13,6 +13,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/slab.h>
> @@ -106,6 +107,7 @@ static const struct fs_context_operations
> configfs_context_ops =3D {
> =C2=A0
> =C2=A0static int configfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &configfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
