Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610651;
	b=huSFkoQGT1qwzIZ/I+yjISQmQQuiN/5nVT8EVoHwh0kwRFprfc+96+zFnlZWKirxdLlY
	 u7ES9287Qa53llp+XoWOlzeK0WxS8p9Kzi26dZkRyVdxXO9ABwVR8MwApQd+qG/LuErvw
	 gXNjmH5lXijhKXcOR21AiDlUZ2QsMqIOeeeYKIMXUACQyIUjfU5L6Qo2kox5V36YRx5YN
	 2r7YSg7i8ys+5dWqYe3VqrANfO93vxuZL4t4UjttTouU0+IdvK9lSB8QmOwBEavO42KtR
	 s+867BPBM86pA2KSnZeMBilXVIf1+AneL4FjfBZxjV6EO7XXaeLDzs0iFKohCKUSVrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610651;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=n3kRI1t8FC4sBJ1KlH6nbApPr67WWAzYu4YOF8wU9ro=;
	b=3K0KLWSWUVgwkkBzG4mP8r15zxTJIA2ceq43Ubt3f454I5x4sP+IEIJPZdvA/aZGUyXI
	 CU929waJbWOeGlfm2PkAe9lb5wnzY6WPedhszWyw7z7ufT5KfJl34+hjkCRtp5fZjLDOG
	 XpipwZ5GE0i0IRRAk03IKsHFITJiN0R5zBQ26KDn1MqO11+2dZL9kfzZl4FUh4+AXb2I0
	 tCba2r/oOVPejQhbt4kfrY5796JACY2gidAeal85k58OW+FNtlgQCp5OKhEcTWoGIR6Pm
	 /R1jppKbkppQQy4zyqqE0/vgYlf26bOWUoZRn178R+5mOLFKFrhkW5Me0Jn2mf/wV2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JcoUc7GM;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7E4606A330
	for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 12:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B7E4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JcoUc7GM
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-49465892f7bso4148018f8f.1
        for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 04:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795610650; x=1796215450; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=n3kRI1t8FC4sBJ1KlH6nbApPr67WWAzYu4YOF8wU9ro=;
        b=JcoUc7GMiAh0LkpV1E480w7GXCIAW/e8cF7hpO69S4aq0dcYx4tjFtoWiYr/DAm4+r
         yQ/2E0q/ZEtANpcmhRiWttvENm2b4bj22INjO2Cx/R+/hBXaXVuDkjlb15+GWRRpJToA
         gOt2R0IR6kS/Ao9M36XuCAmR5ct6HS3dYddtARbxeWS1JjHEBmwNCLXhc2QkvjRgk2lT
         AJJAOIWWGoD+UkNdRCPXyT74UpyGH73ouJzCAPdkF/Lr70PZiakzkApmnO3aBQ+SwCeG
         0TuQ+Y4k0z+qEetWXaTlu1C1y6AjZth3CoXXov75D3SM0G7QrDYTrkbxN01Y+ILgo/HG
         90Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795610650; x=1796215450;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n3kRI1t8FC4sBJ1KlH6nbApPr67WWAzYu4YOF8wU9ro=;
        b=r0M7dyxRZ3tx43PNYsBVmNpGa5th3rGpiYB+SjSDkRQwteQKN5NafOZTTGfRnyfacN
         5/h4CgW1A0NCz56AA4YJ5kPjLPGTi7DhF+2v5LERxVH2xPZulIXlyLgE042BoBLGBYet
         jWsYtIfBEEotBQNIrB+m74LaNUEauE2q3gQJQj2K7uAQe1NBxBZAPHuXDHWkHM5C+DR+
         n6UBWZssP8d1SLyszNw1vSIw27CWFz0Fmq/QhnhQ5AzXlHKHuc/rx1fKVrmIC+c8PLZ4
         Q68Rcojps46ai/E24VOOfDXySGq5YYfieCEYhgnJixTxqAzYlu+IBDe0kgNx3yLemHFJ
         DJHg==
X-Forwarded-Encrypted: i=1; AL+hErGmayja1JJjKvF4G/1udReu1Lpa7i1vItmcuitbwM+Wwl8r2JDNktK9feUyiWl0xBavzsj4pwlUka0N6YZmBUKygNTnM6Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NQbtFEf3U0Km2itQytZtC3xKXkf6TdahEp+nc9ioMGsICRWpL
	N3ktS7n4CwAIm4Alv/KJX7HxN1w0ifdNZZrW3aeMcuYjtui1s3JUHCxW3vs/Kqhcllke
X-Gm-Gg: AZFdTZfnjmNiOErqW8EfKYPMxkHImx0+Q7oHS98wNh7p7iRIpz4ycDyzpw5ok5xZzDK
	SXpnYKuPTUtPSy2bLraCv9bYtRnlOsWosgd6EfurH96x6zLp7JmmxOC45Bv/PQRfvwMZ2WY2/S+
	cJ0H04Sj8YmCoVTHH22O8gokgU0YpFUbY72VTz2Hwu3lbaQzpI0+yMlWAw0EHVyoccyGtM7Sa8G
	1ijs7ROlDTMzM1pOgdD3gDN1My9p0+MyuoaIasiguPJOj6KqZi7w19ZV7BrZU3k90SHnwgh2vSD
	1I/r8glQWyeNqOd4eNz/r+bD2JsG3rUpNAJCMUUKdekP8wCuwrnjceZBfI9ZVhZTLMK84tTHZqX
	usi/eizAmb/9Wbc45od+z/kiG67HcnKg73ubKnAEbK7A42KtVJPeIYQLZvBWT9vuEppS2OS//CZ
	OmsUgdWUr+RQVCvIZrf6nq2k0uh1b99hQwz3/+vjrghKkv+Sd7m24dWtUe0FSJ4jU8nPsMht7Ig
	05UedB+3pgCv9pG94EAKUwR8bfWdKGz1280Zdsj2jex3Kqs3WJfzfk6d8gU7bUpD7qSPqy7+62V
	a5Amz5fY4lQ0Nt3eT5o3AakanZY88vvG9PjnNJS1MQvsWz9si/khdW2V+xR0NL5CXyS3jaGzBj4
	hQFOU/3e4pvXqk0DatEfOF7Se2hgjuYDrl1oQdRIFKsND93V3bBZIm2g=
X-Received: by 2002:a5d:584f:0:b0:4b9:8ac3:f5fa with SMTP id ffacd0b85a97d-4b98ac3f6d5mr4714062f8f.48.1795610649431;
        Wed, 25 Nov 2026 04:44:09 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:c235:97b:8b16:8928? (p200300cf572c2800c235097b8b168928.dip0.t-ipconnect.de. [2003:cf:572c:2800:c235:97b:8b16:8928])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm38964871f8f.24.2026.11.25.04.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:44:08 -0800 (PST)
Message-ID: <e6c23984f7b47f9dcfffd6de2f6fdf75d07a14fe.camel@amutable.com>
Subject: Re: [PATCH v2 01/13] ovl: don't warn when the lazy lowerdata lookup
 fails in ovl_d_real()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, Amir Goldstein
 <amir73il@gmail.com>, 	linux-fsdevel@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Miklos Szeredi <mszeredi@redhat.com>,
 	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	linux-trace-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, 	stable@vger.kernel.org, Sashiko
 <sashiko-bot@kernel.org>
Date: Wed, 25 Nov 2026 13:44:07 +0100
In-Reply-To: <20261116-work-ovl-d_real-v2-1-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
	 <20261116-work-ovl-d_real-v2-1-90564c4ae347@kernel.org>
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

On Mon, 2026-11-16 at 10:43 +0100, Christian Brauner wrote:
> ovl_d_real() looks up the data of a metacopy file in a data-only
> layer
> itself if nothing has done that yet. If that lookup fails it WARN()s
> and
> returns the overlayfs dentry.
>=20
> Commit 42dd69ae1af4 ("ovl: implement lazy lookup of lowerdata in
> data-only layers") assumed that the file would be read before
> trace_uprobe places a uprobe on it so the data would be there
> already.
>=20
> But nothing actually guarantees that. trace_uprobe takes the path
> from
> kern_path() and calls d_real_inode() on it when the event is created
> and
> again when it is enabled. So a uprobe on a metacopy file whose
> redirect
> points at nothing warns twice:
>=20
> =C2=A0 ovl_d_real(/f, 0): real dentry not found
> =C2=A0 WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210, CPU#2:
> sh/279
> =C2=A0 Call Trace:
> =C2=A0=C2=A0 <TASK>
> =C2=A0=C2=A0 __trace_uprobe_create+0x1869/0x25b0
> =C2=A0=C2=A0 trace_probe_create+0xcc/0xe0
> =C2=A0=C2=A0 dyn_event_create+0x46/0x70
> =C2=A0=C2=A0 create_or_delete_trace_uprobe+0x3c/0x70
> =C2=A0=C2=A0 trace_parse_run_command+0x1a6/0x320
> =C2=A0=C2=A0 vfs_write+0x1cd/0xfa0
> =C2=A0=C2=A0 ksys_write+0x116/0x250
> =C2=A0=C2=A0 do_syscall_64+0x10e/0x5e0
> =C2=A0=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0x7f
> =C2=A0=C2=A0 </TASK>
>=20
> bpf's uprobe_multi does the same.
>=20
> A failed lookup isn't a bug though. The data can be missing, its
> verity
> digest can be wrong or a signal can interrupt the wait for the inode
> lock. ovl_open() simply fails in that case and
> ovl_maybe_lookup_lowerdata() already warns ratelimited about failed
> lookups. So return the overlayfs dentry without warning. That's what
> the
> WARN() path returned anyway.
>=20
> Fixes: 42dd69ae1af4 ("ovl: implement lazy lookup of lowerdata in
> data-only layers")
> Cc: stable@vger.kernel.org=C2=A0# v6.5+
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-214581@kernel.org
> Reported-by: Chris Down <chris@chrisdown.name>
> Closes:
> https://lore.kernel.org/all/20261114120557.4bc1eb6e57218cdc@chrisdown.nam=
e
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/overlayfs/super.c | 10 ++++------
> =C2=A01 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 08695a99f4f93..1985b553a47b7 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -58,15 +58,13 @@ static struct dentry *ovl_d_real(struct dentry
> *dentry, enum d_real_type type)
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Best effort lazy lookup of lowerdata for D_REAL_DATA case
> to return
> -	 * the real lowerdata dentry.=C2=A0 The only current caller of
> d_real() with
> -	 * D_REAL_DATA is d_real_inode() from trace_uprobe and this
> caller is
> -	 * likely going to be followed reading from the file, before
> placing
> -	 * uprobes on offset within the file, so lowerdata should be
> available
> -	 * when setting the uprobe.
> +	 * the real lowerdata dentry. Callers may ask for files that
> were never
> +	 * opened, e.g. for uprobes or O_PATH files, so the lookup
> can fail
> +	 * here. Return the overlayfs dentry then.
> =C2=A0	 */
> =C2=A0	err =3D ovl_verify_lowerdata(dentry);
> =C2=A0	if (err)
> -		goto bug;
> +		return dentry;
> =C2=A0	lower =3D ovl_dentry_lowerdata(dentry);
> =C2=A0	if (!lower)
> =C2=A0		goto bug;
