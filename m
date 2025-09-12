Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E946432F757
	for <linux-security-module@vger.kernel.org>; Fri, 12 Sep 2025 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702371; cv=none; b=CaIHfyTO27tCFIJEdeKLFnPuhuBpxf8J5k74Dli1FE+jxUKQrFCB94NF/zQamTME8oqnN3Z10MJfvUvinMreDLb1OiRe3BvVXIY85rAvv8m/WgvsQRmyFtc7bWpJN8dx6b7mE4n5j+SbjVjM0enYIqCp5SjT/B+X8vd+FyUnzUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702371; c=relaxed/simple;
	bh=ZXatryAeaKy8/DIFbCRh6satTWSgR/q9QixZqtxdoLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwZlqGsAIm8wS/bsmtEuk6mX7nXT2dniQprg75pQV0bAxczTkgnraBRcKyeE64MyVmEMoJ3oCiZjYax7+KG4k121y2TyU763Q9y2FdqqXwvSkxISjeqSn+jNNfEg51MVZ+yAhltwjtcUX71N/UJV5P5zaHehy6c/deURtAOvUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k75DK/xV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k75DK/xV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C15C4AF09
	for <linux-security-module@vger.kernel.org>; Fri, 12 Sep 2025 18:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757702370;
	bh=ZXatryAeaKy8/DIFbCRh6satTWSgR/q9QixZqtxdoLk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k75DK/xVxngnMxxIwbYHmGABk9OrjU5FqMnI18EERkwHYgsyjjN/I+YI5o6nItU/Z
	 Yi2tydDibFRuBEUqbICnci65iq2yW99ajk04o/8dCsO6fDwgx6UzmnQ/4CcUJMg16c
	 ePGjqyBKgPyo4A0SU0T3NgbgkJidE0gEXY03rTwtw0Y70NxU0ILnkVw88kxK2/rRh4
	 /eFzMedSPPK2JPSekNQ+zZ21sLjA3sl8v4VnySdvIBTIs4vjd6iIhSRbVASzfhx8kW
	 LZUNNwoVY9spoIhgcCJOr+YRgiwl9xxNTX6//VPq1n5isVmEfYr52bgSOiRaCjOzo4
	 B/W75aMcCsrwQ==
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45df09c7128so18664815e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 12 Sep 2025 11:39:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUzOcymSlRVuCN68yQNm3/6Fyr3ZwcyjBYEoYG9HV4oDx5YC5gSyZvTpFvuM2HO0PjANjx7aZAxVIWizIKf5UvnIQkL0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Fo92Omi/syONshuqlFsufCEUMbDP6ARQod5cpTSu3h6OhWEG
	eBdG6RBtfC+D3a2JNZ1Wlso68M7VlkhGwTMo8n4IvxRiucSCplMQfA1CtBf4j3uWIdyY12SB6R9
	Tf4+0lzRa2zcXDzQl401NRvDdx1ZMIl/5QNobmkem
X-Google-Smtp-Source: AGHT+IFo+12DnoJwolx1wjvax5OayiOuKEps1hZ3s6Wh3ubv4raNK1sUZhtTd8FAXrjh28pHErvN4rhoJJNEobPInww=
X-Received: by 2002:a05:600c:8886:b0:45c:b642:87a6 with SMTP id
 5b1f17b1804b1-45dfd54ac60mr63680615e9.0.1757702369136; Fri, 12 Sep 2025
 11:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813205526.2992911-1-kpsingh@kernel.org> <20250813205526.2992911-10-kpsingh@kernel.org>
 <CAEf4BzbYUPLH97fkFQ3oHqKok=OEREyd1VVkmqfVh0rUvX_1sQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbYUPLH97fkFQ3oHqKok=OEREyd1VVkmqfVh0rUvX_1sQ@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Fri, 12 Sep 2025 20:39:18 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4GkGQU-qbCc6eaj1+E4kFXV3WdedvKkbHYmyqHx=pLsQ@mail.gmail.com>
X-Gm-Features: AS18NWDQq4fKjwiYeNFpK3GWU_OOyR5NIz_NXfFnvRrXamvpRoMHwidJcl3NkoY
Message-ID: <CACYkzJ4GkGQU-qbCc6eaj1+E4kFXV3WdedvKkbHYmyqHx=pLsQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] libbpf: Update light skeleton for signing
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 8:46=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Aug 13, 2025 at 1:55=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> >
> > * The metadata map is created with as an exclusive map (with an
> > excl_prog_hash) This restricts map access exclusively to the signed
> > loader program, preventing tampering by other processes.
> >
> > * The map is then frozen, making it read-only from userspace.
> >
> > * BPF_OBJ_GET_INFO_BY_ID instructs the kernel to compute the hash of th=
e
> >   metadata map (H') and store it in bpf_map->sha.
> >
> > * The loader is then loaded with the signature which is then verified b=
y
> >   the kernel.
> >
> > The sekeleton currently uses the session keyring
> > (KEY_SPEC_SESSION_KEYRING) by default but this can
> > be overridden by the user of the skeleton.
> >
> > loading signed programs prebuilt into the kernel are not currently
> > supported. These can supported by enabling BPF_OBJ_GET_INFO_BY_ID to be
> > called from the kernel.
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  tools/lib/bpf/skel_internal.h | 75 +++++++++++++++++++++++++++++++++--
> >  1 file changed, 71 insertions(+), 4 deletions(-)
> >
>
> [...]
>
> > +static inline int skel_obj_get_info_by_fd(int fd)
> > +{
> > +       const size_t attr_sz =3D offsetofend(union bpf_attr, info);
> > +       __u8 sha[SHA256_DIGEST_LENGTH];
> > +       struct bpf_map_info info =3D {};
>
> memset(0) this instead of relying on =3D {}

done.
