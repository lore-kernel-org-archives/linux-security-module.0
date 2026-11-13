Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573426;
	b=PzTRcLylcWMWpCeqDuVioWx1+iR6gnFbUU6JXn9Ozuk7+a8SJFDEVRkSmsbLWRe0qEEg
	 vpDWOnz3lmu27Lvm/acaAvsUZZ9RXXapUhMnLcwtUAb0vD4DUPzH8pyk4xC+qmYIB6av6
	 eR6qRqI+VxSqzoq3IziBIi4+QSx2TVjvbfzbR0W1xFjo29T9oYAeW/cES+/DeYjRfMt09
	 3wAl+QOAN8mHcL6oebBXh/i16iri5dDcElFyqfgx9ViO5WQRTcsMcYfQc1hxZgVKfX9SQ
	 lKadtIFeblQkfx8C0THmi4FSf4zOo6TUV34VxLYoDBQT2GyeGkhGHygM2Zi98H01R8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=87/Ge5NhXdmtGpcXCLUvnqWpWEAxiW5M6eWOW+m4zUs=;
	b=l2dKpP5f1YDfOffslDX+0FwKJqmOeWqDIasrq2hdzHatoGR1/WusxViDKe6I49GgvEOG
	 qent4JfjydkTPECkwVq79mKBatgAp+53hvqU6NXWbU3sUSzjwa4iAKDLN0IWQZhPNINAN
	 8GqYBiUW2Q+KS6BR7LJVI7bGYMW9Sgl/AIByeCQwMWu5ujIz4aq3GYqy2Q/2Yekqk7rRt
	 K6IPOzTPyGNxa0ZjVTLHNhm6Uq6tfbjJ0JeMWD48VENuqoM/Shvdj7494AJSyDVRFWwDb
	 yPijh6pPqCRjIXxmb2cvQkEWakriT1QsaEf/Y4yHzUKmk1qgqaqSGo5Qs8AnLRszeKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=n2XPHptJ;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE60D606A338
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 12:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE60D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=n2XPHptJ
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4b886ebe069so3303855e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 04:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794573423; x=1795178223; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=87/Ge5NhXdmtGpcXCLUvnqWpWEAxiW5M6eWOW+m4zUs=;
        b=n2XPHptJWAiGnWBjuWK6g5NkFljgiKFcabC8Vn0J/U7Rs5oCxIs8ae//bm8icbKFtW
         GhaGag1Xoi7ZyXwdHESo4gzqQGVIFHJ4SWyDVffZrMrzihrR6J8Y41NroO1pUm4S3UEM
         GevRMV87lpSFNCzDE68IInZGbL5X+gYDk7IApotAPKeUo9xOfBbHGBSC5mcggp0KJBcK
         Nc+e1mR1SmgmgC0Frha4Bk72pKDTzd14yUseYASwtvG8qZfbG+gNn4GmoQhA8ODET64L
         X6SskqZIriPJvj35d5mhI8G8hobVKdLKjnxeG6bMHAYcCPTjUD9dRkaaJK3nWVTXV/IA
         bDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794573423; x=1795178223;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87/Ge5NhXdmtGpcXCLUvnqWpWEAxiW5M6eWOW+m4zUs=;
        b=tA18EMVLw2QBlpTdJnB6xzlflgZLpHoW9XQB47Y7mjFzHTgn1XrEhiycKhY6/4moIl
         fyPxljAjtDdZ7i02x7bDSnyJi8LIs2jsJLUpyzfcamA/mj+A05S0HmE9V35ZiRPAbMF3
         0YTCOlVbFiaL0S8v0j7aqB6pujcjVQoOJjVKX9IIZzftreSPrjxkyLJjBjCwheXAj4iR
         e+H1KMzSPtM0VwBF1seikw285KI+7iII1w99IEQpWwdpzjaub+7ASILNmAhvBSh84iRM
         yLcgv5sxVBOoxuZ0SKWNmRtVz95+aXqYZvGBI0nnrKiZwP+n0Dke9uXPnhoVWe8wToP6
         MtVQ==
X-Forwarded-Encrypted: i=1; AL+hErGZc2lAiTcchTmVVUGi6sc5j0Gue/+t+0Z5CXuHz/Ga9mn+hZ2qXkSxE4KmxeirwCMFBvTUV0w71nEC7RicJh0wZWMR+ys=@vger.kernel.org
X-Gm-Message-State: APuU4Z8E8vSJ4n9ZeEZ87vM6dZgQ4943sJKQ8BoFqEEWmCflBxbSY8HI
	z6SpUBkDveh+4sgOjG8NfsjsIBWpj8Of+5/umjAUB20zc1bEq9/uWZemOlqbxfhl020w
X-Gm-Gg: AYBFou1Hr0iDsVphgIyMUN20V7qL9k9lSibf9eTj/KWj4MGhR4kp7P2G1Sxs7FFhGiH
	NQr0yXYrQVTLnAArBBMaZsFx8gTeOt7IneDO/gSJrWQEKolN8LW6t8Obb17RiagdTdk+kzARkk6
	tRQAizZ3B7FacUIrmEHPIemo5oASlO9qVD1cvgrlzP8aC460KpmxK+QG7W6dlC0GrDbpP6Pn5mm
	UNX6QJH7oekHAXNAMkCarY1xq1JGnTxEgq3yn55JNyzEUJXdB+PovWWlztvurmmjnabB8WsSzYb
	z2zWWM4OkvPhvi9dRvzH/+WgYoKx4rgl1vBbmSj06j7fpoA+1gaUPpNYVsACPCZGqJDIS7osuOJ
	c65gSVgTpKTapGb1x4yVehGHQXvccWHXqRyYYl3LthaRI3KTxxRiAK4JKyDB8FcUoyPusZ/dYGM
	MIQZ84PZo2XVkSKjr6WnwPsfJLoFoOWHmBDPr74rj+XN8AtUlTSTtKwoxfRvp4J/tCurak/dc4K
	rs8lEtj5VPU8vBHCA+GQ9dV6iEXhhT3EwJGzfOkztAsETz2ljM+TA6aPlwsY1hnJWdWSq507Txc
	lcGOkWMihVK1EM68siLN6SK/nLJdgxuLgKRl3PWmo+7ia5DDpiGet4webaaiyDrktZFveVYiTX+
	lsz4xRPDZ
X-Received: by 2002:a05:600c:b86:b0:4b5:d95c:2378 with SMTP id 5b1f17b1804b1-4bb55ac4030mr49782945e9.34.1794573423157;
        Fri, 13 Nov 2026 04:37:03 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55af2901sm57437255e9.13.2026.11.13.04.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:37:02 -0800 (PST)
Message-ID: <f12140be54ffc4d1e8e4026f80c41c75cf5727e0.camel@amutable.com>
Subject: Re: [PATCH RFC 39/41] usb: gadget: f_mass_storage: refuse files on
 pseudo filesystems
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
Date: Fri, 13 Nov 2026 13:36:59 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-39-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-39-4c998976c6c7@kernel.org>
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
> fsg_lun_open() takes any regular file as the backing file of a LUN.
> The
> file-storage kthread then reads and writes it with kernel_read() and
> kernel_write() on behalf of the USB host. With a procfs or sysfs file
> behind a LUN the host gets to read and write kernel interfaces with
> kernel credentials. Refuse files on pseudo filesystems just like loop
> does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/usb/gadget/function/storage_common.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/usb/gadget/function/storage_common.c
> b/drivers/usb/gadget/function/storage_common.c
> index 75831f2c7abe..83683ade20c2 100644
> --- a/drivers/usb/gadget/function/storage_common.c
> +++ b/drivers/usb/gadget/function/storage_common.c
> @@ -211,6 +211,11 @@ int fsg_lun_open(struct fsg_lun *curlun, const
> char *filename)
> =C2=A0		goto out;
> =C2=A0	}
> =C2=A0
> +	if (file_is_pseudo(filp)) {
> +		LINFO(curlun, "file on a pseudo filesystem: %s\n",
> filename);
> +		goto out;
> +	}
> +
> =C2=A0	/*
> =C2=A0	 * If we can't read the file, it's no good.
> =C2=A0	 * If we can't write the file, use it read-only.
