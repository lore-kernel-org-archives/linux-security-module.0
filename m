Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904596;
	b=LX9hIdXjszZCS6iD5bvF00iHWbzwUSuvQ/gaiOC08r3NFRNWg4HbdZKo7xw8mJ3cMfFC
	 +cZtiqnEaAGTDKsvAjHbwcv4e9vnHQywNjXI/2oOyK3BYFdc5WWcoVpGWrueGSTS10OYS
	 DV1X4tywolAye2L1ElxObfiAUnGeylR5nj+Yq10b+z3D8aT5wM+hjn4fQw1K7bN7njht/
	 GZtCbEE2a46NYxwzgGa08fhn8yUiM5hKksfn1fySy5XpgvKZmzSovXQZgn22Zz+qvtecq
	 Gtt4aOJuoxO2epzkkn4l5HoZqZx3YHYD4cUocJItRqI0GIk/OWxRgCAzS4eCxQ4ApZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
	b=PYnPWU/fn2IgxfQexELEjhvyv8F6oMxOZ/lbCCmH+alv8AkCMNFtIX0oIZ+32Jd2FILP
	 EkIPvl/2YbRlq05TwzPvi1thncb8Pn7xjYbZPEh5kpN6aEGzX6IDpWt3NP+olz4lFFGWg
	 6K9OnoBhhuUloblgqOVx9etE6aZTEJcCaQt8TQAuVJcWFNXfeqbAEDyukhHVF7yStNIYJ
	 oatbPBm3j1oUFkKK1N0txP/HemCJbFlpX/2vkEMRILyrRRkf5z88aQ56EJxGeu0rw1eL5
	 kcdpeDmZMgD9WqeeNA5bHk5j89ImeBc/OdbZoQJ/20i1V9C/ubLUI4MhyzhzuKzDTGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VB84C1sh;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A451A606A88F
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 08:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A451A606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VB84C1sh
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so21992435e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 00:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904592; x=1795509392; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
        b=VB84C1shjSG034pSk2oK3egXlQwWjuu3VjrdbAKPawk/Twv4Yif6yhPlbROFWtMgPQ
         3tz2NQZOgPBk3fq0QRZC/paJXFCSb8aJt/mhh+A0iXMTZvR4a2C4xo37cxqDT+bS5wyK
         cFfqQ64HX4H+WtOYlqmaNWk53bLD4rVzH3Dam/22N7EldMgTIeT60YiznWNjIzN+eEJD
         Zc6kl9xoD3REW2KAU35dfm9/7zuNgWUL6hteTTxoqyJmYKiacM/NYuvwNSKHsMwzezat
         1L4qftGlpMPZouPAaee8sA2dATEpRVvU+RzrgkUS2mvSj/+KFRi5Npjbd19v9tUdsF88
         Zbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904592; x=1795509392;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
        b=z6y24zbzVHqZlVxEHIHrAd+ttR31foNPZL1LXOJOCyMcGM3czoD8knugMjI3/W1CaL
         qfqR22bC5THmWnYmtN8sMOyZD0BFZHwlWIf+TKGkC7f41Nj+jpPS6Tw33M1LXpJ/x33o
         jsDZbSBRpBuTMyrd32m0zrjITGZDJ2J4b8j16oYksQic4KHvjgX1Pc/9uwXohbK629BM
         jSlJz9g7/57JBVhQau4o8TTULMVddgQOf5FhTG21nUb9Sqdj0hqP5rXdd4WEUJgX40SO
         a96SiuSHC99J5st5xDXnrz+nfsO1QYknbH607DtU/MubdEgPcYc6XDzLRm6RpLpOIIks
         SDaA==
X-Forwarded-Encrypted: i=1; AL+hErE/SL7qrq4fkyiTC9wJ+UzZ8XnwLLbbmDGt87x1Sei51N7RLzAQ90bYBdnJ70tVn37uNehZoLafBo4eMEa2lUDz0YRJxCY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HvQ8k+1A355qOXsuZ0k97vy6RyIFSYtvc95suJF/tfV0Qlsyc
	MUTEWB/GjAvLNoIYl7EbghC4Z30fkN4GcKCHkpigYaOIc4XOrDOmsawNqS+cQcGBAbYW
X-Gm-Gg: AYBFou0TT9mMFx9ejd4O+0pYTGLKZBaa6NTSlukGk0TmGCfSHP6L9L9izraHWqlBnSy
	tgviqVaKod6oGBIVc3Pl9lSqWIjeoCLEJfpDpp7sIbiRyrJ/NS2F0uPxy8MqBkmj9Ic9Aqvhhfr
	kYORD8FBDLJ1x+7SiPpmTw7VeHwrxft2UN4PpMcav4q2mNL0kLEsMYjNF5HDUlgosxiQpIyiQ4Q
	KqcSV5O6JuxEsgOAbp16Fez7e2wocW6Bnp8N0+mbv72ajrpEtfMQJtNeuTyxAAUBK80zxmNQ4Rq
	r40ST9rz2vywb10PAMa0LtGvb0ZOhEqCnQHGaEpq3BqUvjnO/VYWC1XWcpb8SMflN9+zmhAbdBZ
	iuLZxJ/wNXWoGtdE3wtWQDbOV43v5q5d2bZ2W9Iiero/bTPM8emYFpf3POFRCtzphbFNJ7sykMM
	ij6gZVDBa9rdKwV1uCotR6A8YPTistnvJLFky60S4g/Fu9kzP0dAuuhK3qg/MuxNaGS2Mky0vc6
	vb2IU5r53EDO8ZJgwsMrfTvA7im8OEl86P3Q0o+ku8snfmjd4PqX9Hg7JdU1azvgur2X9nblMOp
	pdMw0N3Jq4EK6EDKoU7QWTx3E0eeClkTcyqK5x/kCgBIU6lupsgN8uDo8jpkdj0254uyNXdqPRa
	KNLMpmbaMrnpA8DeSy5qNXXJM44vFKnC3zuHmYr32V6RthZ0YfCSOyfOq
X-Received: by 2002:a05:600c:1f90:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4bb55ab281bmr266345525e9.21.1794904592167;
        Tue, 17 Nov 2026 00:36:32 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78430752sm52548565e9.12.2026.11.17.00.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:36:31 -0800 (PST)
Message-ID: <411502f9a4f940c223b2b88d7e19fafdce63172e.camel@amutable.com>
Subject: Re: [PATCH RFC v3 29/44] s390/hypfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:36:30 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-29-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-29-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:05 +0100, Christian Brauner wrote:
> Initialize hypfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. hypfs never holds executables or
> device nodes.
>=20

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0arch/s390/hypfs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
> index 559b011e68800..8662169de477a 100644
> --- a/arch/s390/hypfs/inode.c
> +++ b/arch/s390/hypfs/inode.c
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/errno.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/vfs.h>
> @@ -301,6 +302,7 @@ static int hypfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	sbi->gid =3D current_gid();
> =C2=A0
> =C2=A0	fc->s_fs_info =3D sbi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &hypfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
