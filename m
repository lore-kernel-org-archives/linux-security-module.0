Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903941;
	b=LnAs0rRpYTWkCsBpacx1OmKzzxqNx2GWud3XNjMddgtvPVtZpGOwe+hkFiuJWsQSt7fd
	 cDz0yz8EaYPqTpLAKbp3gPICwy86oXLTViVEvfeUG4TB6qyoHO6GO5ZQTxdZAFWk267ed
	 djX2d1vJxKcpb+xk3rbSKjsIdE8hBs3iTTUDUMDcOBdG8qwrQQvsVlSKaRPPYs2dtxxpz
	 sfGFOLMagQMH9USwqZZmrJ20I50fcQkZPuzfuGA7PNW1FNrT5okKldnrCuJnS5HsAzD8P
	 z8VLTEZeCm4AyeKLdImW0q6vzT4obrWaP+N2ltAKFLMkNhH5tRSDGZT79JKOToMA3XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
	b=vMQUcxoje8HwCTr40BVl1M+i06YO2DI6QxMK4U0d8p0QsjzZ6OK+vwdAUWgbTb1Ie6NJ
	 K+g6J2qD6gS5MbAXUDFDgPWNIv2GdaNTpbFYZrSoCdFF47pusCFTaFN9rc7R4VPQObwL2
	 AhKanuPid07y0TBy2wuKaUyBNk27ROdYbWRyUceve+5UsrUirm2l60hsWkHZ39HX9tRHJ
	 N3ZfhM2ZlNWQtd8Q90siwsWJ3GlWc/oEMCD/KcS05/OjePssoNdysIlNtbYxoMPnYP9c/
	 WML4x/ShB+V0jCZ0kj047ayiaGLu9P7S6iNALXA7HJyO88zuySSC4Ls9td21kVAr9tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="QoCmkI1/";
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B216C606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 08:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B216C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QoCmkI1/
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48dee593f18so4521676f8f.3
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 00:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794903939; x=1795508739; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
        b=QoCmkI1/XbLLMuB5pWQjj6w7lhYbbqiM96jQW+pj9RZ000aRRl9S7H2qSmbtORMNOo
         ePt1TXAWzVIR/TrMeI58Zu3n81XgIdPHavzyhyljr/3uEJYZwsW6Sg14gd450d308jE0
         RrvE2vSlthe4MhW9V05IsJzW8g0CM3u+nfQ1hkfntpYQW6a4z4zmXmxD0w/TiuzDbd7U
         U8xZ2FexNWbZhSQ3d3pA0tlH/f0MOfn4O69UeuIyRM8vQ/YXTKpGPDyGoQczoxEfoynP
         BDcwZppUf46pJGXZ+RH52kug0iZSl25eld2NGIqCa+XVs4XFwFr0CZI1pzljVyhbNHw0
         NmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903939; x=1795508739;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
        b=y+Dx+BeVvhsCueIhHbXowb1yoQA9oxqjxa5jhuqV3OhLC+XrEj1cHXpvljqcut2Qjp
         oF3hU/7eYYKsYpTFFz5jYo27nXbtqOgaJQeFnwZur/yDTPvm6sFSnV5rJHU6PZV4dr2j
         kqNT5gPigIVQxAFv9nFMv3Ge9r9Ch5BvaCvJ0uy5GGZRwiQ49LJ31ChH5Kyu6GsoBb7r
         QSgG9Ej55eU4oYKM1g3N2wmeyQ+s/vmsBBStdJXITnW/MFPMPGSSQqT7OudHV/hvIl+Z
         jhuimbTPyUf0tR9LwUrRKSnROPWFudbNCObIugYzvdfSXdln3EVas4GMON8psLYTe9fd
         hTDA==
X-Forwarded-Encrypted: i=1; AL+hErEWKHOuwrhmLYFzLfcHCU/4j/ljDYSsJ2zo3Vz3hjs+wnXhQiuTqkNojYNax8rAAdXCizaf0PoVkpH1QkwndHuRvpAiqaU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dvZe4SlTXbapQdQLrTF3gSqRrFp7f/2jjbKDyqgK6wfw1Oa7t
	IRXbehJkgTkypsbZcGXiAjkSyXO5PAFiLklKLtq+ZmndqeCtbfXcJH3ICdm5P2QHHkP1
X-Gm-Gg: AZFdTZdzo5N8naMQU3+V5cAQvxltvFi5QcQId5BzKh2Me+b+irZgSpTGqegx0gjeUtX
	PXGJg1CENlTuh9x/S+JyVNM1luKhjV4mL0qmj72ZfGMPSkoSLdvnNSzztCVsdzo68cwQNek3BCw
	KXV4MixuR7rNLlhp5GEtvj2gURpLdrlfYgZXFChVLuGT8F76mSqHcsvTjNKED1tbYbMDTXyF77y
	yv34UzgH/ZYl46bZR5H5TouxSlCNf6nHnPg8oDgDSCM+uYvxhVmVfQMKI40WnLNvNkXHPduoO+C
	zM2zS5M94FkGKr3GBpux2haVpyMOQFPfufltEz9j5zEiGV/6nXBKwh/pK3T1asnI/+kxf0BCuqa
	iYN/zHNadNt+DDSWP0vPSPZg/N4R5LhSOOkBNRWtVr3J5DoQpI1nxeviMw8K1gQmwo8vQJT8RrR
	/Grc8MKYcbE7Ebp6QrUxY+PZClLCLuw76nZF3gRVeKME+zraqTThMwtc42ZhpAzqwyz6J0OzQKQ
	PrV4+Vlawq1Y/79f9qcyea0klXH1DaP52z1ykO21ccv5f3qGQh1rYgZI3EJVd6wENcXAi3tUksE
	2+xoEWyhXSEfRuSCUdSS9qYQMNQSCIW7Li0N0QQIafZAEltm4jAmWY0AhS+j3G9IFp28BoCuaqu
	fIltAX4og7qy+L75bTZYc46rP8qhnIxfRd1KDBAPPDFNWGH6R+hMNpEnSU8LZFrdUhT6lc/Wj+l
	8XFQ==
X-Received: by 2002:a05:6000:2084:b0:492:46e:d4ce with SMTP id ffacd0b85a97d-49c6fd932c8mr25238543f8f.13.1794903938925;
        Tue, 17 Nov 2026 00:25:38 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5ff2be55sm26907832f8f.28.2026.11.17.00.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:25:38 -0800 (PST)
Message-ID: <a9124bf1c858cef3e8ac06b1b2396dcb0e19e2a5.camel@amutable.com>
Subject: Re: [PATCH RFC v3 02/44] nvmet: check that the file backend
 supports ->{read,write}_iter
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
Date: Tue, 17 Nov 2026 09:25:36 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-2-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-2-8cbbea1cf34f@kernel.org>
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
> The file backend calls ->read_iter() and ->write_iter() of the
> backing
> file directly but never checks that they exist. Everything that isn't
> a
> block device ends up in the file backend. So a namespace pointing to
> a
> file without them calls a NULL pointer on its first I/O. Only
> buffered_io=3D1 gets that far as the O_DIRECT open fails for such
> files.
>=20
> Refuse them when the namespace is enabled the same way zloop does
> since
> commit 0c10f8a1a7ae ("zloop: check that the zone backing file support
> ->{read,write}_iter").
>=20
> Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0drivers/nvme/target/io-cmd-file.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/nvme/target/io-cmd-file.c
> b/drivers/nvme/target/io-cmd-file.c
> index 695963dd932ee..dfa8aa46188c8 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -47,6 +47,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> +	if (!ns->file->f_op->read_iter || !ns->file->f_op-
> >write_iter) {
> +		ret =3D -EINVAL;
> +		goto err;
> +	}
> +
> =C2=A0	nvmet_file_ns_revalidate(ns);
> =C2=A0
> =C2=A0	/*
