Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792965503;
	b=dK/C2WVSMzfpBz7AvmGvA3q+6Xm84Wt8tEwIB+elcDSU4kcI5OqggUfxIY/vPJmc2uBf
	 xO0vFAyqb3B9MeCfYsAkciyBOvI72h6rofOWZBYd6NBGcst5BgQ/Edcvo1qih3D1iFbvj
	 Y1P8tdt63fAvG+wT8WqSfpSv3vlGDCwEHyslqUg5KQrEIp0sGWgpae9V7mdNM4Iv5Vlr1
	 lRk4FD8Yeb8boGgtQd45Oroh32T4Wf+WUFPy8io3YQL4puH9DVCVSF23vKe0Ygf5+1EU/
	 v30DSzErfSL3Icisum6vh8Ymgd9mlA1bo5xcsTuc1JBabReAI8e888UpnPj95sHn9kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965503;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kvZ3lSi6Tt2Wj33E5oFIA9PxiWNdWQfCeDMs2YC+DR4=;
	b=XZcUQPixMw2qy4T/2vWk+tZ1c9YQoZ/iav7CAoWMQePNhFcgK5Ya+/CIvtZnC/C317dl
	 ZNaEDgVOnMkgWASFIMJL43Xu7OMuC2h599gKmNWiV4YMQJE2ouwhlYWpa38HwHlJoi7D0
	 RHtMaIJqNmCeoCXxnPlZZCjY8mf4yFVN2LX+ErOz2IOfT3Y07gkqMQGqR0lUjOI+eXwwN
	 LE0UVq5JwC9SyNiHTjdM1U6kPBE4EjYdq2MC1sL7hAC5/mbncMLNWUZsbBgeyg9za2s9Y
	 tWQPzl0PUi9lapEmubyaQqmPenP86sos6ABgoqb6qh03Ye5bkSv8C1Xe8loaN7D/5+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KQxHI0dA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D28F606A31D
	for <linux-security-module@vger.kernel.org>; Sun, 25 Oct 2026 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KQxHI0dA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7371F01828
	for <linux-security-module@vger.kernel.org>; Sun, 25 Oct 2026 21:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792965502;
	bh=kvZ3lSi6Tt2Wj33E5oFIA9PxiWNdWQfCeDMs2YC+DR4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KQxHI0dAJiLxxdbR4qfQm6fsrrKTOB9IG0PelY/iqQJiw5sNeUlPGnIfItTQ3U/78
	 eWWgnXjPE17D3vAyueewP2qtqIBrmTntZfkljJXGMgIJICzGDZr5QvYPHvRx/vK0t3
	 LjrNc2LoScJwzkxo6Miil34nN446FUQgXUJd3Pwmv94fLvsrpkuBmuHoeJPWqT+9OB
	 Qy/6In445T4fhu46mZtPTz+a/e9OHK8C4QMvgJRpFk6+8DzTMsqofeT9eKJbKq1iwJ
	 CxR4x818i76Khapo5Z/GceMo+HSHmxOfY2U47DwuUcF7vpa/OhL3Y4LimNWihxkTX3
	 v5bulLWMMilWg==
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1931ff67a29so5458537c88.1
        for <linux-security-module@vger.kernel.org>; Sun, 25 Oct 2026 14:58:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByERRcySZKp9a5GsjQ5sXtFZ8uePk6dK3Y24Wb+6Q9+Rmo3ed158yD5Ay54sZWp6jsZM0P675BOmkRERANwQCdzohUsI/M=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFQeaSBg8rw8K4bj+4lFKm7Mij2GIt4pYtVzr49wD87xflCfHz
	kG8L2weoKwdLCXL/oJHZW8ydqRrzKxeSv8i4ogWMep3HVfv+HXLTsT7uf9ixhJU1R9ydO3k0Ttr
	G/8asSsfjOgA50/gpviCoTs4KQw5uUIY=
X-Received: by 2002:a05:7022:b90a:b0:14d:baf5:c415 with SMTP id
 a92af1059eb24-1993499de9fmr7765063c88.7.1792965502214; Sun, 25 Oct 2026
 14:58:22 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025204534.122506-1-ebiggers@kernel.org>
In-Reply-To: <20261025204534.122506-1-ebiggers@kernel.org>
From: Fan Wu <wufan@kernel.org>
Date: Sun, 25 Oct 2026 14:58:10 -0700
X-Gmail-Original-Message-ID: <CAKtyLkEoM0denNMUygkhVxrREfAjD7C6x1JKRhG+g0OXuLMsdQ@mail.gmail.com>
X-Gm-Features: AclHuK9DXVo7gzKYi3TIlVq-U2b7yv3AWnPgaGZUiil2pj-fz5cZeytCqyAm4uc
Message-ID: <CAKtyLkEoM0denNMUygkhVxrREfAjD7C6x1JKRhG+g0OXuLMsdQ@mail.gmail.com>
Subject: Re: [PATCH] fsverity: Tell LSMs about signature only after verity is enabled
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-security-module@vger.kernel.org, 
	Fan Wu <wufan@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 1:45=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> FS_IOC_ENABLE_VERITY calls security_inode_setintegrity() before verity
> has finished being enabled.  That's broken because enabling verity can
> still fail at that point, e.g. due to insufficient xattr space.
>
> Afterwards, arbitrary contents can be written to the file, which doesn't
> actually have verity enabled.  The in-core inode stays the same, so the
> LSM considers it to have verity enabled with a valid signature.  (Or
> rather, in the case of IPE, which is the only LSM that implements
> security_inode_setintegrity(), it also checks IS_VERITY(), which can be
> bypassed by enabling verity with no signature after the file writes.)
>
> Fix this by moving the call to security_inode_setintegrity() out of
> fsverity_verify_signature() and into a new function that is called from
> the appropriate places.
>
> Fixes: 7c373e4f1445 ("fsverity: expose verified fsverity built-in signatu=
res to LSMs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---

Thanks for the fix!

Reviewed-by: Fan Wu <wufan@kernel.org>
Tested-by: Fan Wu <wufan@kernel.org>
