Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40F83B83F0
	for <linux-security-module@vger.kernel.org>; Fri, 16 Oct 2026 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146957; cv=pass; b=e2DSPWlbybxVgADDY5oo4hoXH04nub6bVpwkiMEdxwdO7VnVhXpyhrMDR0vq4+yiTmUyX+5ppP2vtxhHRFG04AZh11emUz5Ro+syzpcpS7OBLV5LwfDU1iq3cJ7CK96BA5q5VChv87QCBZx1ChuMF1t2Nqp7vJW4bm9BEGfh2yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146957; c=relaxed/simple;
	bh=iRfVm8IL1MFnh3TXtWSNTqHffR5dbb9ebdI9wSrMS48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WyiT42O8W0XDXcGfnYXJDmLIN+752CAuFfGBrCAW8Zl6wGU4B05w4A7IzMjM2V8mMRZVk1a06rWNdbGA9rpMgO27MiQYuPOkxAQ97HH15+cIuKgX4wp0u4SwhtdwdWctmS3VkYy2v1eaMwvkZXufI7IsKfs2rIlsTSPUuWiik+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDIyBTxh; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDIyBTxh"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8a83d2706fdso29434277b3.0
        for <linux-security-module@vger.kernel.org>; Fri, 16 Oct 2026 03:35:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792146955; cv=none;
        d=google.com; s=arc-20260327;
        b=A6873jAsuuk5D2ZFS0rF1iKOcRBk3Wz4AHIrYbnXx/+XigHnjLlpfzvFSZDgpk9hDH
         jeHZ1wt9iy43vJsOhj+6oijkCKvbKpnBFqNRXucu7ogrYxklHnQf1Du1VbXty8BGD5HW
         iwwhmK67MAPs2bmdVnUzD+COw23nxmDm+/vYSMF8kuV0rm0ECrRU0VmSBadYBXJesVW3
         I3TVs71qN35wia7ODo8Y3fvKpSFmS8okEY8HTJRBmrCNNtLWaP6KVKed+TkLK2B3XZq5
         PlMDwDG8UCMr2zYVD/VEIubz3ClzGGX4NXJbSFNoQy5yooTOWXI8e2sP8ZLsy66xZ9gH
         EJqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iRfVm8IL1MFnh3TXtWSNTqHffR5dbb9ebdI9wSrMS48=;
        fh=peVDYglzqJGhF26sS5YIgP0ccTaMjs+XERc6RqDJNMY=;
        b=kPesQxWFq9p8Dny0mhiUbZoQHEqBvGZuSMV8cm0YaK1rwUe+KLiQuxnw0dNyet7lW0
         3MWq7Mv+B1lxihp+FSQoVgBzL4qycudG9f8TuI7HSkrDX2YZy9zooHCjrJr+pvxeDstn
         iYY3ajs4xantRgIM54wY0esgzJwuvho8C3d4senZIJDDfnQTVAc+CVU8Gf6MYjLsAkme
         9L7TLMK4rQvmK9mPOVsKQgL3chr5RObBRuHYhLVJi3m2tBr11RoCQtD2ICFuYc6rMaKp
         TAGNvREQG4cM1Rm8wcZqjOd2/XEJu6PkjgjrOyW5n6ESjY16gj1ZffS6gh32ZEHtJDjo
         x0BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792146955; x=1792751755; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iRfVm8IL1MFnh3TXtWSNTqHffR5dbb9ebdI9wSrMS48=;
        b=eDIyBTxhrDQff7mW9sng0mdhK3g5PpoOmrMtkcWP6JeUT4/mOAEAjZpWV9xgqTpuVw
         4WmqIfMpdw/CyGzm+tjj/e+d/GSGnxSgJIK122wf2DexNRHhrvyY4JyG0eGYNb0xial0
         aGobp7Ulo7sQRukxtwfsZaxp2fZP6PUgab+9MT0w+4hvwZBleb9SxxaiEl/5bcFv6NEO
         Je4+NP8A1Vp/cLpgs1qPbS3PNYTLxMDGa57appTf7WOU19RyyichOtCGDnvTfvs6YpkQ
         Loq7c6bQNBjrgn8578PL691hsdKWIlncs6fQRNVqSYVM2/wst7lrVPHUTzY0vb1wz9SJ
         6eUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792146955; x=1792751755;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iRfVm8IL1MFnh3TXtWSNTqHffR5dbb9ebdI9wSrMS48=;
        b=eWl/N2RIozk57RYMzhHwFos8Byht0/+5+dIvlgdjjBbvQ/lrGNQc8XCJZ+jkuO0z5W
         /knX4NxoEYwEEfFNr5yoxn/QSNRQ0E5NE3ZwLR2crXt8m8CJa67PL6NPSgGCW+XMFbk4
         0zN4mzbXYKlZBv4Azo/5V/hTf6cBU8oUaj7Le2abOtuE8T1WDgW+Nxdph02Qq93rfry9
         Sw9aknr4pAS4+uVvIOtsGYOs7sB6gdRWuL8mqakx6dVymGCGPdstDRoiLgUH2ofYcWOW
         kAnKD+vaKxqgpVW0d6fK3ney4toulXxgaZh1TWcBEF40KcAeWmAKJ37TY1Xeab74RAox
         2dfg==
X-Forwarded-Encrypted: i=1; AKwUvBxLFrBTWtlgczt+Lo0lgofQY+nSznjux8pj5wOe8Ag5v1Gkfg3DCGLg3b3qXyAhD33QyMBLfVy5UkCZ8Elz0hF76UnEn6g=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPJJRGGzzxqRlfjfUFxaX6bynTF5UbCNX9jwpkkzYZLBOCbiby
	LNx4ZFkGZEVuXnE4wDZ0cjzeZvhRzEOyThBngeoCFDIUIwUAS7lF5zUaOrC9bzj/r9N0rGCQ8+e
	reXhzggfxyn39J/0h5rCnNlKqr5t2lLw=
X-Gm-Gg: AYBFou2a/41RDq4NkyrdciscGe2u5POwboSMVzL+zy3tkP6Sa5J70v6K4sxO+ynqjX6
	uH6jsFcb3zgGMS2zAJQFPVzHz8q1EP449cFGD/Vu5mWUf3NNlewjxXanJvHaC60Hp9f2dNGBiSq
	Z4Q2acpbxjY4KIKFiYCT1G3ruIvqu2UlOz2a8q4B/akWejOU1Pb0Egols7SV/1ae+XF0si1Ngyq
	5OEdeh5hKKtHme3Gz5rpQgYLX/s2sQxwiIECiLOZZyW8C/fsTrIeOC7X/t+SYoqi/UFuUKcs9mQ
	GXrmdN3TByf+2OqxQbl10InkgCzKh5/TDhKG84U0Y1A/j0akjo9a9nkbmGYAODn9oF1U4//bqNa
	nfzD78fVpYA==
X-Received: by 2002:a05:690c:a78a:b0:87e:2404:45fc with SMTP id
 00721157ae682-8b07ee0119bmr44016477b3.53.1792146954580; Fri, 16 Oct 2026
 03:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-key-management-objects-candidate-0001-v6-9876bf3e2116d47c065e@gmail.com>
 <aszZ3KPvMMHLEJ0s@kernel.org> <aszalro6U6BFO_D3@kernel.org>
 <CAFRLqsUB0MQRoCHg8cXmyofWqbDGyvAr7vV07i0jUpMnSaksVQ@mail.gmail.com>
 <CAFRLqsU7w=ctKeAv5FQwxcPVbdWO7EjC3WmE1JXywe_JWWY+gQ@mail.gmail.com> <asz2YfhterfAVIDH@kernel.org>
In-Reply-To: <asz2YfhterfAVIDH@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Fri, 16 Oct 2026 18:35:42 +0800
X-Gm-Features: AclHuK-sJzY1eXcpx-cLXrXzPnaYrBx0Yr-GHF2vWKubBZ1hKuC-0SCei8df9QY
Message-ID: <CAFRLqsX--CoQ5XwazdJS_bscK43F9oE_nLOpq=2FDh3teQmnfw@mail.gmail.com>
Subject: Re: [PATCH] KEYS: Protect user key quota access during instantiation
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, akpm@osdl.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=B8=80 23:01=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Oct 12, 2026 at 09:33:06PM +0800, Cen Zhang wrote:
> > Hi Jarkko,
> >
> > Sorry for the previous email =E2=80=94 the line wrapping got a bit mess=
y on my
> > side. Hope it was still readable :).
>
> All cool.
>
> >
> > Best regards,
> > Cen
>
> Br, Jarkko
>

After reviewing Chengfeng Ye=E2=80=99s v4 patch
(https://lore.kernel.org/r/20261013090358.1178367-2-nicoyip.dev@gmail.com/)=
,
it also address this issue as well. That fix looks good to me, so
please disregard my earlier patch.

Thanks for your review and patience again.

Best regards,
Cen Zhang
