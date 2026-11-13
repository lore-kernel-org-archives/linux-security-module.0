Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564657;
	b=mGU5W1xizK6JHGJa/dRyKuzfQQ11T4bM4e0OYX1Co5HfJVrinRM2gXMoF8S6ZZn9HZ4B
	 gR4h+PUvjtITYiT1bomBNwvjEDuiJdn9wLZo+GaT7igB6YfJ+FCxU6jIqtwjwdjAe7V+0
	 esLNNB2RNkCeLcAw8V5izohaeZ/Vf9/LoswEewH6LvB/i4h6exxXOgwy621tpWA93ilYD
	 7yafNSrK6t/bKZd2KWezO5Kh7gNCDJyLUq6FVjg48zO/ot/khVVDzt+gnx4ve6qI0hf4h
	 10fzikJ0amQRjsvDKqYInE9YULwc6xtmaJsqZsk/PMGKZErls3XZkoYhM0DcPBYlU7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=RUn5HyOzv5zK74OCIfLVACQcizuS/sHn5qpIQd0Zvv8=;
	b=OIbMltCd3zxqV+DjYrGl33C32e7VBv37c0QATW6RhLpoBDfgyBcouh/e3Y/jeZdlG9rC
	 JizjJEvgC2W8VPlOj7xKfLmwDAPeS72q4mF0hbhiZeGKuO8xUUHF8lJ27JbWRXhdoGI7Q
	 2EWCDla1R6GNTv1CZDlYdQno6FbJR1IYR/inXewpM/bNdDmGEOWUFBa/YEC3cYO8Pac0Q
	 zCuR9phWNT16oE60JYjsFt2c7h/jVFzCRn1HEUy5q0AnBQjOM2MKW7yZd9VT55JJKYCqu
	 XmI704CIcRC7nwoZK4InhNJmpvfV/7sA0Mm5GY1CrMgIlZ4WYfqbr4mcdhEbD8v3VkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=afSYRRYW;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16976606A334
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 10:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16976606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=afSYRRYW
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-490d59c3edaso395264f8f.1
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 02:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564655; x=1795169455; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RUn5HyOzv5zK74OCIfLVACQcizuS/sHn5qpIQd0Zvv8=;
        b=afSYRRYW0Lzg1RjNF5a8Z8fp4FTD8+wBAkqEEgX+uXVLN6iB/1Oe+S3s3pjBsHkfPy
         t+OYs+BeBV0n1jEyBb10NVx3dBSZolIBqoZV0sAqk1NmAyPkc8BtADcPrCcEDzdTW4+p
         zgkm0FzjpTOQt7I53MJB0zmRNwJ5JPK+9oiFhFL/qPiFq6x22bgZ8fSq9Se2ho9ikF+q
         rg0gx4TedCmdQu2h6zCkoXcFHWmQ+ZQsRVeKTv2sVCXhncyHGZ2k8DCVvoh7926dtvhd
         5w+l12l3Dd1UCqA4z70s6tomNhqNtGqcJuf3lRDB60cxVt/wNhZpOgzeegjchzcaCyfn
         tojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564655; x=1795169455;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUn5HyOzv5zK74OCIfLVACQcizuS/sHn5qpIQd0Zvv8=;
        b=kpkH01sH+diBRg3hfpIgcNxS4qSb3TDEkMVk6RFqX+DbPzD/QKTfAaqtHxoKOxMskI
         y4SNOrYRg9L4mHg4Pwavti7+mPePKMn+nFWyEhmjzFmNG5OkFWyBwUMb6BREx3V/D22z
         JuOZJB7SLjek0mtOK/P7JYKfI1knR10m9eUJm+giPW41J6V+kn0QU8g/S49+4K/d4Vn0
         c62/dFm41Q0ycxX8PtH+fhnW8KMGClFsevElsJqBYP6Xx3E4C/Txi4DaAU+q1LGUDwKQ
         qDkAYhU3cGeGPnZzoSznx07QbIvFDzmVhflkalSNFaxs4COi1zhNfV5uLCXbrgWK4tSX
         Qr6w==
X-Forwarded-Encrypted: i=1; AL+hErE8eh0KR/XHp87nhmxmd8ArGCNw2W/2CIvmQ1xxXJClZjYkQ6COdgsTVofqFsfbvDUAjDerfiFkH71ZJBe22opuMh6fj3s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8epdwh0Gh5+1SF0kEMINj1gcIRNmJ/OcAe7n55lIBJwilwqvfN
	KrcElZKZnFJVon9BljM1Z+DILTSkCRt4IZsr/OXpGsoTRokgLr1s2g0mcIQvoRa45lBX
X-Gm-Gg: AYBFou2KKgbfWPlDmvx6Y1Iu1adHeXsGn2guYFNAjY8XzzZfFVNt+RPuzfTl2jRQN5u
	hidjI1Pb7ntPcGMrU9QQgar+ouAmvRwN2MU4K4ty6x989YGqNp+/ET+7cy1HQivlkbFg4PxRDe1
	xJmf8ourNE76YPM6Q2j0PVo2slCx5Kugvvvutu+m+x7N9B/dSybOKZgzHY2i5dBouthscyNeMUr
	hEFoL9WP135Rm9uYWufFWCrL9IxwAwMw7EeM45mVDrq7F+pSITtFEP8WVwsrq+FIAjijAYqw1tq
	cG3ZqffmZ5CZmiLsOThVYZ/1qq4yTYFGYO0uEA3zhsbWStiEOtGyQci8p8KBUJVQ5bVVGD4e7Gu
	eaHKxi1kD6lD001mbFZ6M8bZEmg7QKYHndkuTMYwcd1ZTVcNW9sfW/DMJcN3sVW2Shc5ecTnhfF
	06e79MYmRw3GGeiHBDY8yMe1AIbd5zEpyevP1hbSqMybY1dxIDEWE38kLI5soysmyoU+ykuyvK5
	EKi379fD6PVC8LiLLra6Bb77IWhbhH0gCklSihTvAF+avTIGrqTlpytjkekf8KQVcb1qGhfcSlY
	f9d/xqMnFC28g+FBxeie6t0Jd+4OX+T8+9pmoRwI9phD0N2s8210OJYZn3O/IFk=
X-Received: by 2002:a05:6000:470e:b0:499:ffd4:f519 with SMTP id ffacd0b85a97d-49b02d4c2cfmr11662822f8f.23.1794564655454;
        Fri, 13 Nov 2026 02:10:55 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5a32d336sm4988050f8f.0.2026.11.13.02.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:10:55 -0800 (PST)
Message-ID: <0894c601b3f3c5b92008c6c399faaa539b658307.camel@amutable.com>
Subject: Re: [PATCH RFC 17/41] securityfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:10:52 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-17-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-17-4c998976c6c7@kernel.org>
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
> Initialize securityfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. securityfs never holds executables
> or
> device nodes.
>=20
> AppArmor puts a .null device node into securityfs but only ever opens
> it via dentry_open() which doesn't care about SB_I_NODEV.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/inode.c b/security/inode.c
> index 080402367674..93997a9f16fc 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -14,6 +14,7 @@
> =C2=A0#include <linux/kobject.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/init.h>
> @@ -64,6 +65,7 @@ static const struct fs_context_operations
> securityfs_context_ops =3D {
> =C2=A0
> =C2=A0static int securityfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &securityfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
