Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610996;
	b=A9/pRFwuWqMv6GUKHWNWyHxUYVq89ISQuSMV9xKmitqNzWMb4OR5EpXDqkqrlXJqUYoY
	 0KgY35NbmsFqp0zl0k23DouZtxJlmxswFTiMjsffMLZ4VneyJSY5s9Rguxnns/xcq5Z65
	 DDI3g/dahNZTLerhU4NoZUIwMvIzOtupHuhTMCvJ2Turyyrt5AuAagPzVoBTaiEMjbKCd
	 cTRpd5qz8cUBEi3K1gdSN/AVgBov65DdZUs2RCcn1IATx1tJdhwSPhp4vJe9NwRpaitGg
	 tut2mMUp5H7/3s6SFt3B7eXPwyA1IO8NYAtPhc3uCHNkV25KzUka4WcCu4/j/L80PIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Le4AwFe0WXouABp9DXzuQtZ3ZnCfLcbkB8kE/IdX7wA=;
	b=wtbVYpCgEpuQwvSPzyaK0Y2DSl3MVxPQTtFvvRKUeOgEaQI63GXfAPbPcx0aUzL2NGgU
	 aRob1XM7qGX/s8U1QR+F98ZNuexm1/yn3rH+iF8r+qUvcIBfes5TIi6h4UtuXKwuSoEqI
	 N/srKxBrMI56ZwJ+1rg1XlnQLh68wtIgSi7lN69tE5f1kqbuYTeTKJQhnNmfs0qhC8nI0
	 KtNFmpcoTKFqSsP9cJvkJebRM3adS0Yrs/bPXIZsyWBF0K2fNItqUD7VXTB/HK/9viBPU
	 Z5m3qrjqdDZ1A/k+kVhSColJccp0ZHXkTm0QWY+aoIYcPg9D3QlqEZ1fZzs3UTy+gDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ijrvPjrs;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC8B606A321
	for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 12:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BC8B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ijrvPjrs
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4a357b1c649so3327972f8f.3
        for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 04:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795610993; x=1796215793; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Le4AwFe0WXouABp9DXzuQtZ3ZnCfLcbkB8kE/IdX7wA=;
        b=ijrvPjrs4XPMGxLv2/cLDzYf1DTkp26koBrs+YwuqX5elYJruc4hClaOIjF62Q3+YN
         LRHIUBC22PWGF/rAGALu7SoOt5zqUHESVTCa5vHMQJoFy4B5gkLHeV5hugIirMLPKc1z
         lwkIjSkykztPQpKhyKTDraxT5P3oaH7NzwApTcr02ARr2hT5KerzhwRvxghSP1A3P/Bp
         EtgDED95aoU7Ek6mxljMaLWO6Bx5amJKRdXl3ABZkqxCYsSCC5SlDmTZNR4DGfcavrRk
         HtSpSZ/UepV+pwNgpwEHfsqbflJPpiVU5KOF/FpJhp5lP9+HVdK4ulKpQ0NMqA1E55T/
         7WHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795610993; x=1796215793;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Le4AwFe0WXouABp9DXzuQtZ3ZnCfLcbkB8kE/IdX7wA=;
        b=kq2UqFMt3dJQvCZv9aacTar4zv8t4VEX0FayuqBJTX+fdAa356qEhbcgbIyOjofqT3
         7bQn3B+tuoXzK5KbTOAn8XtTfdAB1zJlu7cNn7Pf9XdCcYapTpnmsrtjbScH9MCDf9q/
         x4QaoJcR7s3Us1FQ6SWylI94nDobF8gJlK6cnWA4/uYwnf1BL8N7WcqApPK1pI00n+xs
         uevdY+wzAL4UMk6MVD1RbBkvs57bcUwFvNaaokNT3ZpJjgoKJJT+Sq3xn08VKkceSH1m
         +t0uD9Rm2YoaMgATy8fLC1+J15qAVybTcPwamReHS993OZTFiRUat+3DJ8xjRvBKKUyi
         jpDw==
X-Forwarded-Encrypted: i=1; AL+hErGHpYdKBFlIrhMozL7NfcNdQ92pgkfi33Mccdt1iZh8kyNtkyxp85z1snDJ7BNorOy2pz1qgzlR70Ru3QMkC2vIS7eZ0G8=@vger.kernel.org
X-Gm-Message-State: APuU4Z//iBccW3qNsfXg8bZ6uP31pHCzY/9i9zoizz5pfRfHYkXBSjiB
	Wv0IMYZNM9obCZafVUcb4whxY2QyPj/1Mo44jj3fOw2BTaFECQI9dvwyKKYIVWqluOG4
X-Gm-Gg: AZFdTZdoJ8eVusFXUffSkyZmeImdeYQTOv2YeQFSJlsiJt+gm5NK6VanGOKx4W0vrcS
	DjVIyTTx9w5xkphLDBzsgpU9qzOKsWe57GVABgEdhP2LBmc8UNVMvtjb9ksOFRWo0wHXWoNxmqp
	cauGRLIHEENh+8WtftYYr0VyBmOPA1Eh3xUGOr8G4dFkn0ZNuILrjAT6uONx94YcK78KL7qhLT5
	PPTSWA1l94Yhua6WlCslUr5Kop2uqO3kTLaWM4Qxpgd2TtjMdnoeRqFEcDqEWF4u4PenUPWh/ou
	lLMNzzm7l0i8lYz0F0xElg/Ae6hD8sPiHLRpC1uvXK2a2XjUOxa12vBEX1Hfu/+y7uvv1uJ1Ty8
	cjBbAMnj/l3JNBHuYwploGXgflZd1M6Ls1U+J6kAvniw7CmmG+aZ2PADxamHRrQyHZQJ7/amQA8
	4wTE/D7UOqOljKXHH0sVEAhRy1/zAfowoqzwomyLY0hDg7Rwvw2yAL+jFpBxYBOnx4KRlYf1p6c
	UFEDGRJHiz0SWCobvML03NCF1ghKc0SqYfCzj8i7jYcmRWsrbzGuKb4SnC3cwSJdlRdkJoiE7BQ
	pbdCnI65sXn7v+SYKXSAtgl/P++R8MqU4mXWX6e7H8YK9GseB8RQuZJzJ3hdHwSlRHBmx8pOabC
	lMuPOina8mQFqy8Z+TDdKGw9lLLEZ6To10PX7QXxga6BPp+v/QbAtCQ==
X-Received: by 2002:a05:600c:a11:b0:4a2:e0c:2b0a with SMTP id 5b1f17b1804b1-4bb888120famr364999585e9.16.1795610993400;
        Wed, 25 Nov 2026 04:49:53 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:c235:97b:8b16:8928? (p200300cf572c2800c235097b8b168928.dip0.t-ipconnect.de. [2003:cf:572c:2800:c235:97b:8b16:8928])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm710678895e9.13.2026.11.25.04.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:49:53 -0800 (PST)
Message-ID: <34297f66e07c1a64d81205c7669801738676f356.camel@amutable.com>
Subject: Re: [PATCH v2 11/13] fs: remove d_real_inode()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, Amir Goldstein
 <amir73il@gmail.com>, 	linux-fsdevel@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Miklos Szeredi <mszeredi@redhat.com>,
 	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	linux-trace-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 linux-mm@kvack.org
Date: Wed, 25 Nov 2026 13:49:52 +0100
In-Reply-To: <20261116-work-ovl-d_real-v2-11-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
	 <20261116-work-ovl-d_real-v2-11-90564c4ae347@kernel.org>
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

On Mon, 2026-11-16 at 10:44 +0100, Christian Brauner wrote:
> All callers have been converted to d_real_data_inode() or
> d_real_metadata_inode(). Remove d_real_inode() so that any user we
> missed, or one that gets added in another tree, fails to build
> instead
> of passing an ERR_PTR() from d_real() to d_inode().
>=20
> Add a porting.rst entry.
>=20
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0Documentation/filesystems/porting.rst | 10 ++++++++++
> =C2=A0include/linux/dcache.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 -------------
> =C2=A02 files changed, 10 insertions(+), 13 deletions(-)
>=20
> diff --git a/Documentation/filesystems/porting.rst
> b/Documentation/filesystems/porting.rst
> index c38f5df755bb5..aa0fc43907017 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1422,3 +1422,13 @@ helpers take a const struct mnt_idmap *.
> mnt_idmap() and file_mnt_idmap()
> =C2=A0return one. The idmapping is immutable so nothing should have
> modified it
> =C2=A0anyway. References are taken and dropped via mnt_idmap_get() and
> =C2=A0mnt_idmap_put() as before, both accept a const pointer.
> +
> +---
> +
> +**mandatory**
> +
> +d_real_inode() is gone. d_real() can fail for D_REAL_DATA now and
> returns an
> +ERR_PTR() then, e.g., when overlayfs can't look up the data of a
> metacopy file
> +in a data-only layer. Use d_real_data_inode(), which returns the
> inode hosting
> +the data or an ERR_PTR(), and handle the error. Use
> d_real_metadata_inode() for
> +the inode hosting the metadata and handle its errors as well.
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index fd8853622f250..fe1aa8fea0c7a 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -654,19 +654,6 @@ static inline struct dentry *d_real(struct
> dentry *dentry, enum d_real_type type
> =C2=A0		return dentry;
> =C2=A0}
> =C2=A0
> -/**
> - * d_real_inode - Return the real inode hosting the data
> - * @dentry: The dentry to query
> - *
> - * If dentry is on a union/overlay, then return the underlying, real
> inode.
> - * Otherwise return d_inode().
> - */
> -static inline struct inode *d_real_inode(const struct dentry
> *dentry)
> -{
> -	/* This usage of d_real() results in const dentry */
> -	return d_inode(d_real((struct dentry *) dentry,
> D_REAL_DATA));
> -}
> -
> =C2=A0/**
> =C2=A0 * d_real_data_inode - Return the real inode hosting the data
> =C2=A0 * @dentry: The dentry to query
