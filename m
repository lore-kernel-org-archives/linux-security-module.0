Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564824;
	b=H0v2Q9vXrG2iDFu9gguwNEQRTKO+knLck42qmIvCUKFNsS8BldOLZNL8uB46Mt9YNecG
	 n0J6h0bm/zETOV390LoGaMltKj3gA2Swse9uZZZLvYipJJlz1m89K6wauXYC/JEh60zci
	 PAoEi9fzxqRUfAHlEYqeDAWb2Zox1T84nlG1a4cqNXluW9HJA6CExor33dS+gjY/MbqkY
	 GU6w+Pkai7ybsz/n11/5mpN1r0iEpgQRr7oD80sP16L3QFXrV9wm16FTeMzQe5EICT+H2
	 V1IEJXCTJoc/ycUrfYYSIx62Gr8O8/XgDYk6Wjq+7MHp4+VL90ZGWVlAd+6gmycj7yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
	b=W9pRt3CiCKdvYNaJ+xQ+li5U0vplcPGqNtOSDtUvT6DauPmeyua4wu3SgmW7KeKzcVbS
	 SmCVYPQ5/8ZviyCBSY3kb+qRVzZqfzs7vucGdSItXzuEwoub7g4rZVXh8xZWobQh+722I
	 KwOwxzucS5aUSG2VasD05yE25fIbJKJzK8ulWKJLXzIQOUq0lcDe3DeCqyaycYdKRrjUn
	 2sJ6Sr5vVyB51IGOif5FLbUzIk8DIXoOj80/vPRqk+nH1eunnK/snO0B4AW1tGwbqfc46
	 ZQT9nJQ74PpyiTfJCRa2uc91aYL1s7mjOcdDnzamP41HRYFMFcBnkophGYVutH4ObNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tBSDp3uS;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F290960A260F
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 10:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F290960A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tBSDp3uS
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b581b6b0e9so1096348a12.2
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 02:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564822; x=1795169622; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
        b=tBSDp3uSBFgypsbtBQgsadIQZQK7UWodMC4WHZVi1N1ipHHYu6WywVfCa4AZ6QIaRM
         wIcOajhLTVFUJp4yf9/N65gePrg5n4K0AYKI0yA+7KNwnMoUY/irx0jTqY91Kx7jR9xZ
         Pm03fPe9TdsIWGPKhcU7A4Ssshd7c8Dhe1zzS2a/pwsZLiwc6FmAy6ptf2LWGhArJX18
         uzRhPjO9k+hyhG0ceM77HGUPCflD5+7VnbyODCgVUFUm1PdMwYT1gZdGgKWe2z5NHlJg
         Ao5qYJPp+rBAoBURzi6iHuHACVVyoOXqBDLcaaEy2+qVTTu+93IkZN11FbEDMtWMDX2T
         mB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564822; x=1795169622;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
        b=L2FO4Yb1DnvP0tjmBFjigyDu89LaO8KFpt0HlBS9whJYLlAouzEV6al1Ma7/l+gRV0
         Lud7vNoDVS4DPvO+cy0Id/cZsoKemHpi3IazQUtGAIdp4ksDv4xU1zDcE4D4ygNbTsB2
         W7Zg2DVtq8MtW/JBiNkfqgL+nR+9LQJCAiyhgip70UXV6hcs2RbFaRiLmYNMDa10ak2s
         eTWjfJZlzYvpFZVS1reeCr5sVttbHCAcXBH1Lt0As5xzR/RgETEF/8Wg7iCFWxvZZgeB
         9o5U9qiW8/gu49WsJl8XFATncliKqbF6eP3IZ3ZJez6eRjzm6SislL0M8R5O7Tt3p10L
         xqvg==
X-Forwarded-Encrypted: i=1; AL+hErFcv7Pzi+9theb2yiAYGDeaiA+XhKKbBTOpXr470KAmiEymFdhXH6N2Vif55/uaiMq9N3ScHttEis69auUU7HBdEv4FRBo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mbFFqNMn8Grg252kYF+kXVf1N5Q6VLqJzfGuOGbNuyceoghgo
	LIK3hcyf6yTL1Dmcqw8OOOilPijyUsiDnxO1vkclRtWAwGkHK4qyr/VPmCACyeJuSYTP
X-Gm-Gg: AYBFou1IP7kKf9ppzd44mOzt5AeWw+aqjbu5cFeKYAwC/c7ALUpj6gDr6SCHR+uCk49
	ZV6OgI3PGbcXO2lZCI8qSMlmxG+k+mUfQrY0TyJwc+gp8bNywvCCl28qCLvYN5wkHBTxXkcJNog
	3P2yga1NaRXerHvHPnC2POd9VyA6SosTTrEPe5PU89FLrIWoWmEJKDJUYGpd79dTXIh37uPzC2j
	qO5kL/IEBHVvnbu/Z0uobhL6/FiBaGwuRG35hZ2kBa9qAA8F+IgM2FBeL5KpTGCTam4clb0k9sl
	NqZQIAMGDB7BU7j+OmB2isNIkZ287Qv7Lu3RNuj3Rd9lP9YLLZOomWyAkpylt8qT5kUISgdHklM
	Zh6ho4Y098T0R4XpmtLtO8DFavKnga9yfdnguLgnvbEb2vqPuWSDpZM9/AEQplfU6RYQyIgfpxw
	KXXFpa0Skmf5LAthxHk8DKn0HHF0wX8wMMh6f7uHEELsRpPQQy0BabL4J3zHgEnRA0hs0XESenV
	mdFbzDXtBc50Bk6czVjC/6JPpip0UEJDFuWkS9lWitz5NlGozD6CRSBhN5qP/KalAACmfayq2/H
	hm4rdheOV7Qw8EHmDZptAP3TryLUDIlaGDkvYXo1xQSddQuhMbnAculD9K1rw8HJPpsuC1KWk6T
	417RVqUuu
X-Received: by 2002:a05:6402:208c:20b0:6b5:69f4:e7ce with SMTP id 4fb4d7f45d1cf-6b7c0c62bacmr1415990a12.39.1794564822367;
        Fri, 13 Nov 2026 02:13:42 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4d29sm4332158f8f.35.2026.11.13.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:42 -0800 (PST)
Message-ID: <3546dd28b1d63c1478d391a2015fff4c1b976639.camel@amutable.com>
Subject: Re: [PATCH RFC 24/41] efivarfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:13:40 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-24-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-24-4c998976c6c7@kernel.org>
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
> Initialize efivarfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. efivarfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/efivarfs/super.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 12746ced6dc6..e598d42c5f42 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -8,6 +8,7 @@
> =C2=A0#include <linux/efi.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/pagemap.h>
> @@ -554,6 +555,7 @@ static int efivarfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	}
> =C2=A0
> =C2=A0	fc->s_fs_info =3D sfi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &efivarfs_context_ops;
> =C2=A0
> =C2=A0	return 0;
