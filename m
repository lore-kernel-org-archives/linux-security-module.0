Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904006;
	b=Az7g5bUSVt33edg9trU9CLUEfXwkbOsHAwb9R24cyI0mNeHucyW+/DQHkCUWAEm5kGnE
	 NvbJg+wOXeZ3eMg3+0xqGKVLA142Mmyu5L5v5C1beXI2uuxsrvFOZmYg4QWCdywmOydMJ
	 OK1MorMsVlaixbZhTni8y+zQMjwekUYbZsunySILHCxwWmH4grIEKrz14VAeBZFaf2J3H
	 3OjGkePDMnV5i8Q8m+n5+qKZvD5r7Co7TyUk4e0OV5q7igYHhmXi5O0+6b8E1bLs0TCfo
	 hONqR6Y24HieZ37KySDT3x+oME6dxmBoX29bPS8jfQ3L7wBgzbwAY7vzoDs/zYQskKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=zuUcsMvbqw5dxN0Fzu67367bPJAUtTqv88LLlRQCTVU=;
	b=J2YPEpyi1SYwCxf1V0weroB5FMD+8kueiES21wyIUBf1uk0uW2kOK5GY+tXMoR5F1Qh0
	 AJIhBbvexjAYvm4aP4rAC14aP0YJ/AKOZtymLvZrDB/YqhJ1pSa6i+wuz5nM9NXqbHQUC
	 bnohhJ3Mx63KmZR55JgUxQKzg0A+JPXJvbbGqyquZ5Z69DvNVLPMUemk4pJRd7NKaAH3G
	 1cYqJKTZWokPN6KkWvXrDmkZ0kfF5LqYM+K9Uo9RbESUsE67cVxMC0RwImROcsd/vbIRF
	 CFi2qjbc9wwqLu61kL2LKbLjmiu45OXY7hrO3iB1AhJic7qAlrpSrLK469eTsav4Utw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bh3COd7Z;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FED606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 08:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20FED606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bh3COd7Z
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso1759276f8f.1
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 00:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904004; x=1795508804; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zuUcsMvbqw5dxN0Fzu67367bPJAUtTqv88LLlRQCTVU=;
        b=Bh3COd7ZzI6TmZdb32Fg462zWvuh7WQNnrUpXucHXcpV5t+t8gMfKKxOWwhkcHBcNt
         zIJKpUT9Ten8K9xmb0ZHj3p/ljeyNVefWtOpjWCo7Igmb/P1wzmYs63YOxLg7f+WXmDC
         wf3ao9cg3f1DrvZE/oBKoQiWFPBKSPnWk+jCT2CGoQgxeoDuJREjXd8oRMM0GizRyDLq
         q7c8W4Fdq61I08pJrjWNPm+S1jXNjmZ2MpEutx4SYZ/JoE6iRzvUZ/uRuGO7TyWDBzw1
         OlncqX8aSwrA8zDhY0Cn+N6eWM3qFfFk2ULf9A0Yk8lhKFDJjJXQbcxKbI+h6RZ2p0E1
         0Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904004; x=1795508804;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zuUcsMvbqw5dxN0Fzu67367bPJAUtTqv88LLlRQCTVU=;
        b=gAITJJtZBshxsm2El7xtu2iR49B/N8uNaHdhqzyut9su0eyb+dxhV2cwgP6CVj/BOW
         naW/0k8Hd8xuYmr7RMDOmYvm57NUJFGOzRqwib+tVMVJ/pEWozWFPjT7XNbrKq6xTlmI
         yxGWjZChb7dYAutMS/n5dMHsbAklZLJke4BaozMOb4IAFKAcsSJ0CxJRZCAMQJzG58zh
         SR/vOxNsYRkCfFo5/F78Ct5hBlr9yVD9BLfCKr4hqdDLkvNiW8K6k5VkZrgqQz19ULZx
         W+4XfAxzVL/LE1Fth2lBCuEHYLOHSIDK1q6oP5tesryC/N1tWjD5Qsa6K+y37JkGzbym
         IoYg==
X-Forwarded-Encrypted: i=1; AL+hErHnDZ59YjzbM5fISo4gmh6sifoDVd4wDvfe7ziEHwEx/LMzhfRXgK6tAjB6rb2gGan9JpCsgxnKodtx4pIGovtrvoac+ZM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9fBZCHFA2ZIKi/mWHJiyWfBnwi57RzB99jeqRemDhHqtbgw1lO
	Nkiy/7K+9BN0HfWw4hSK23P4dksLLTjM6lJbMhcTqfsO853f72gmyNFBBs6rcRsoZnST
X-Gm-Gg: AZFdTZdIsZh3u4pm8hEwIAX9kTj+ke3utzZXd5fR8xCX44kmjd3KACVGBXnpWIH/yYv
	TIcngxdCwdXTX5+T5BvcTz3dPZLa6zKN0MuAF13Gbdrtqde0WWOy+XBY6ARLFLDbftxEQh30K4r
	XIJ8yxA2SDvHS2PEmcZmvpOsSKcrQ3cqwRbBhL23oClmJVubepSzYxzRF2WSzEU64AEYDLueieD
	h+CHhkAlndELZHRMpjFh2AYN6BHotln09ej6yNvaKvfa3XGIW/vHe9GHmUZSqb4VAdCm1AmUXHz
	ZNq6GNJu2dJJv4ryTBxlpaU4J5HS11BAK2JVhwx+GwxQOYTIK41sPkA8RU9ustezT/iIfbzgiDR
	jgCnlYY6zD3RseHpM/9XZDN4L+kU1KQqOKs892N00l/NrCJROoDz+yP92JeQLrAiIW/yrwJVS0Q
	i2rV6I7JbRs3CO/NwLj3LUe/2ni4K6Md1sQGH8knkpE0BuSbvkwVr9JReHWmvrGT5JQ2FMnS7kX
	gIkq3i2U4A9ibiwoxq+SjBfhJYoTT7I8TorUjXTppEy7X6w2gb27e/x1Ckol3TVP5rfvE3qCHfV
	flL9P8eFxwEzwN/OHBEOAdgyBqD3LNdfDSSNVuu806UYLFs9WRyxLNGWxfWtKflOopbcIVTo4hn
	sammU0kl82luBHZx8npCo1EWfSZkk2BsZfcKv31za/0bCUtBwpLm81tod
X-Received: by 2002:a05:6000:2009:b0:4a5:2e5b:51c2 with SMTP id ffacd0b85a97d-4a52e6a947bmr243585f8f.29.1794904004601;
        Tue, 17 Nov 2026 00:26:44 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a4de4cb1c3sm977858f8f.8.2026.11.17.00.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:26:44 -0800 (PST)
Message-ID: <c43d70badf41f62f8e149ac024bab3df979fa756.camel@amutable.com>
Subject: Re: [PATCH RFC v3 11/44] failfs: use fc_init_pseudo()
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
 linux-kselftest@vger.kernel.org, Chris Down	 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:26:42 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-11-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-11-8cbbea1cf34f@kernel.org>
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
> Initialize failfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/failfs.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/failfs.c b/fs/failfs.c
> index 437cdc981c2de..f03334f361c0e 100644
> --- a/fs/failfs.c
> +++ b/fs/failfs.c
> @@ -3,6 +3,7 @@
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs/super_types.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_struct.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/mount.h>
> @@ -132,7 +133,7 @@ static int failfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	fc->ops		=3D &failfs_context_ops;
> =C2=A0	fc->global	=3D true;
> =C2=A0	fc->sb_flags	|=3D SB_NOUSER;
> -	fc->s_iflags	|=3D SB_I_NOEXEC | SB_I_NODEV;
> +	fc_init_pseudo(fc);
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
