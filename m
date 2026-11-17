Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904346;
	b=PmYh8ty4crRWR50bOFWzEON+MRqZdDa/TD/1aZwo9kJBFD+iyPEKFMWxw4PN7bp6QMDr
	 E060tJKZzc2k03RyAEr4y0tAQlfDl+kVpSXC8/hIHVpDF9dA/3RADD0XisB4jDh2ONN0h
	 br+v213T/sB3DYvOcQ7bVhg9/9dgRTQ2/qWU8fnI9O3DwboEneYoBXEkzEFLy2XTTmd5K
	 od0yuHXafPHzjnZaeV5i/pNn69EplkE6CxgS5NLJJbBoI2nxDtPeJyO9gJyUHejHCRhYv
	 2RPr0jgp8LW53OCxz/+6oVCRfYbi1dVdD7SY6mGBFC6gvH4A4dlyp0nGesFruqjd3tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
	b=EwqtZGTMH5sFeXOmHy+oivmMTfaUwccn6xcPFhBYONopEzCOqVvNPAl8eTqtFdwp8sCR
	 lsEXf5DMAwoQMbYUK87nmRLDAvKyoqMwnPrTLJ0MPtyW0uL7yDxccygwu4+U3Kgd9WIox
	 HsQVWXcZMEt0Bz40qL9ihuuDFF29LrVKYXc7l8xIkKaH1zuK0jkq599WyDM7dOAUbM+sU
	 oQ8cb8cSP1aqgaHI62tk5PmN//n9DAXmx16GmdTHQT49JNgb7xwrXhM5GjFOadQ5M/+bD
	 wlQmz9R0rLaPj2CmQ5ki1H60IDi4X+fKfDLfj8+jAjwyDMqaoXRIS+Q0jDc7/R2mnLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EFPX8Vuf;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D426B606A89C
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 08:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D426B606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EFPX8Vuf
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso178011f8f.2
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 00:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904343; x=1795509143; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
        b=EFPX8Vuf7iz+NzEUQG+pPgjK/MbrESqv3n9ATmra3Zopp4tpstszPHFfE2sR6EI1XH
         /MuIqTxoWkMXSLrvcYnqUGQvNVGY6YndEf7Smwels/t/G0PiJAqa5YTB3/XSR2c5vF/4
         5S685rADCuM7kD+KTHsn5xD0Bbvj+kfNJN7h3Eeu6Tgpz77cxc6E5ixV5T0A3r/KAOuP
         +pclbSVYUTOzYQ2RRiRVVs4C5Z7y/NhXCRc6Of4Q0fL8jD/Em4FfidsaQN0h6TdkChBo
         DufH5bn8tmF4fp27j4WWCE7M7sjar8yCORXmuz1wFPQxfWworU2xHCWyEC/YN83R4E+t
         3i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904343; x=1795509143;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
        b=hyLV++TlcOJK0TmlfxI1gtDRtp0LtJfvXGODIk/iLHQAxU0xt5+whYZSIvFnHjb/uF
         t68KcuyvyrlO79p1eb++FgaOtscOO7oqvtmSbdqtjrM4DjyVXNYyGVH6fm+fW0KDHGwi
         n7yqC2jv+73iLg7Ipp7iU5oZrF/eVGziQWt9s/STyvYjvK8RXPzui/gNZMu811kOT+kx
         0MMi8slGjuSC2jqjTN+RCU/Xx5eCqJstmO7uL0JPAu7kCP6+6KK/jzShRb+9EXtdrTf5
         W9sN7QrMdM890QzjFzBHjJL5kA7fuyjcDKBQu7najXn2trvf2gyChMCIuJDsIr7GDxmf
         PaOA==
X-Forwarded-Encrypted: i=1; AL+hErHHa8EqegqNTObaqMJw6R+inQJgvRINmnQBVmNb3Oeecq1eDdkQb8vfe4EoxibBdsVeHu1SqZDv7YlsNtzEfR1h2cdJzJk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/826dC3aEYIDO9cHCCjM33wq38+aNEVdDR8o1zUtTZuQY2u3Y5
	TxaI/uy2EZT8Qp9L4o3asUVensRFzu0Zg4ljMnHVUvgUlWIlUPCkaFaGFpcD1y8pSKfZ
X-Gm-Gg: AZFdTZdrwmpJfdtb6FdgpyQOsRh/mHJ1cURf+/fc50YbZsiwwZ+WddO2L1+l8Ebw3PO
	bD9w+Bv355CcTCpgEehz4JJestt2RR6YXFaNc0ycWxOKPA5dnl6NUtQSTRDIhXi+xjUp1TTzfPj
	KfN9hzq8QvaBInVbaLeOBszn89FNB+3X6VQ7f20mKjc4YaQvihql+TmWbak5wn7ohV4RtOESl7i
	VYHhFspcBmN4yO9xOZyWVJDw/jBjW2pBHxCMkVli/ALwkzTdDiCjgf+5QtdXaiiqrcvLHPJa8cC
	S78GPc/5G+Bp5D0P1c28uog8ZJ/3Qnvxjyk2z2Cp627pxdc2/abpDfxtzrGqcYU/DYtl1e2Ofrz
	C7D6JknkdpMou+RU2wP13caveIh3fKreC4H3jfvi58DwRgvj8qtk5l2sNOhY98sCdA2qXMABH6a
	DCdEg5K3t5TeBlTIt3LhgY0gKzqzt1XQ2t8Mzx9962Uofx1DiOoh2eGm6mdqerv+qYij+LbRsqv
	6KxgZU+x/6Jp9EFz5yWqWXLOb0ZA/eZWpGvAjM0YO+ddtmNvDg67qCwb6NGHUWTaPnCbGQ7OYQf
	f2ZBdPbHYrFsdj4Adm4B1TSGA4Quy4ITn5DFDCciYa0+DVlMaKL1x+4/ybgJFDi5s9a/cnR85rM
	X+bBq7issDKbK1LsmLVgxPARlCva6aZ5Kf4S1rhOjeTWg4h52dS2LiZoF
X-Received: by 2002:a05:6000:3108:b0:48d:f9dd:e3de with SMTP id ffacd0b85a97d-49c7353c415mr27089117f8f.45.1794904343236;
        Tue, 17 Nov 2026 00:32:23 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608d10b2sm43646659f8f.44.2026.11.17.00.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:32:22 -0800 (PST)
Message-ID: <fd39200976086130cc82d59699a988fc3e0689cf.camel@amutable.com>
Subject: Re: [PATCH RFC v3 27/44] openpromfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:32:20 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-27-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-27-8cbbea1cf34f@kernel.org>
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
> Initialize openpromfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. openpromfs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/openpromfs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
> index fb8d84bdedfb2..6cd02d456bac9 100644
> --- a/fs/openpromfs/inode.c
> +++ b/fs/openpromfs/inode.c
> @@ -10,6 +10,7 @@
> =C2=A0#include <linux/string.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/seq_file.h>
> @@ -419,6 +420,7 @@ static const struct fs_context_operations
> openpromfs_context_ops =3D {
> =C2=A0
> =C2=A0static int openpromfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &openpromfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
