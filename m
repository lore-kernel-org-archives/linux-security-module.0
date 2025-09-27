Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4FB217F56
	for <linux-security-module@vger.kernel.org>; Sat, 27 Sep 2025 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759012406; cv=none; b=XYRZ+i3YHjngmRnDNvdR1Ap/rdXqm9fs85rLRn+N0fOnLEWucbgXAfW5/41yKLl4MFDTKxK/RkRLByKASjg+mn/GKDH/bgiZkcwyxpIDhsyOBaLsoyzlDhs/YKMdunLsr05CYQtZoxtgPRigcJyZITOEJkIT/wYfgMdpalCLNTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759012406; c=relaxed/simple;
	bh=okSoG67AVrqwQgRDUVgLSQHl4EEy9sXaZ6gvaK1fRr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0+lUa6Ehk5vEvb69qBMq4hY5AgEsFmuiQ3mUwf2bb+S/clFz7kdhPrxt4TNG6U6p3g+JpnQ/GmeSNsYOgIsIIbq+DxPZw8aGr6xdxFOHtj9l6Z4Lo2ZrYTNurY6X7Rwp+4383J5dBGO0zq/F0qqyFt/ExmbVVGVUOJNJWPKGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fzzyqiw6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fzzyqiw6"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso3345034f8f.3
        for <linux-security-module@vger.kernel.org>; Sat, 27 Sep 2025 15:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759012403; x=1759617203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+r8GKg6ojoggq3b5ZSlvwmzwsCqHsWdwX0u8H9jkcc=;
        b=Fzzyqiw6clbnrSBAYQoFVIFqoNSOOy89a2NX+njLZ7B3z+qO5yZ5xRo+bVZfWfxlwv
         RLGShwe4rbKgIF0oimq/UU2fIqwsE282rW3CRgD1em4/ajuy4f87hvg/scxNU4Nu++cn
         tgYiSbFRMX8AMokI+T/WS8IZBinmY7RxB6CJZKFsMEXKvIK87LXzMap80FbfMGTK2BMT
         yY0oQW6bbnHZZrRN/5TbWBXDKL3DEWwdTX/Wid5AIYCO5wYaYgSFXazkwAADx9NabNgk
         DxRKz7z3gR/eWEdttWqYc4neGACAcsxQWLH3ln9eNSrjkCndgS3WRBqfToHQrHf34Jj6
         BrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759012403; x=1759617203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+r8GKg6ojoggq3b5ZSlvwmzwsCqHsWdwX0u8H9jkcc=;
        b=Khw+tGloQJpUW9fAMcL6gXZy9hC0rEUwzmHuFNBAGYnG40/dv7pAseDNxdEzXFIZs/
         6b8BIZSL46H5TtVvwwLLDLFlz2HZfzhT5qd38AQNaBcLO03rpH1HpbmA3DpRNIsRE2ow
         CqodVCbL55ID20Fb3mMjR8lhOy4k/fwaKc7mpL5Zlr2XJFVHF1Do7uYIqi5g/Dv9oA3Y
         Q6FGNQGTIm84L1JNZvpUKONnJrcnOUxPXLj7i+26pFPKQyZPjVYJ/GElOMhcrwK7c5uv
         Zv+blLzSYJhLfHjShGUs7y/GifDXuu5KlH9ihS32muaOOeGXJdU0o9mB6I0C82mzEzX9
         ue9A==
X-Forwarded-Encrypted: i=1; AJvYcCUV3fdQSfswnz/9+opJ2bvamnLs8OWtj07JmYrUcCnY7oIm9VRQfOt/xlxjRNKtT9mjXMVdjadCtvz3P4hPuLh+WOjM1R0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkf6OoJXP3yqi7jp2vdeLCt3vQaCkVUIkiRVMbUcTDyZe/su/M
	OlynvV+VNye37cemVzOEIvQx3BGKlfw6Es0p24C7jYj+4ZZAWyCLsxkVcI4iRLSblUPF9NVjpsJ
	Sqt6P8vcB/jhWqYG6My2qnCGweO253y0=
X-Gm-Gg: ASbGncu1UsgZGNhw9qL+GVqG5/4wDEd91ywjl/3FO+qoh+ag7YbVADxU40zzd1Ok7Yj
	pGZqbXGJXXYmQPcvvFR7S6oJ+UNRHphef02ZYpTe3hsW4viWXjDgDU3FrC5+APldxe6ccDT+LFL
	mVQRboq3XT1C9gMdgf3nhN6klbH5Ja+5UbRYtMh3Umi6OqYXJ61Lp7XV41dKza+lv9NhIwjD53Z
	CPLICpVpunOeFFe
X-Google-Smtp-Source: AGHT+IHlvY4jduOUJxngyjg2fpYMtY/KoN4vYBo2gCLH9NW+PTBP86xfLcfWyKXfuJG1gXmEWJ+rAOk3JufiofvxzkY=
X-Received: by 2002:a05:6000:1861:b0:3e8:e7a6:e5a9 with SMTP id
 ffacd0b85a97d-40e4ca79e1bmr11210982f8f.48.1759012402988; Sat, 27 Sep 2025
 15:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921133133.82062-1-kpsingh@kernel.org> <20250921133133.82062-4-kpsingh@kernel.org>
 <20250927210345.GE9798@quark>
In-Reply-To: <20250927210345.GE9798@quark>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 27 Sep 2025 23:33:12 +0100
X-Gm-Features: AS18NWCpnMoezfM_ulk-gMxklejFWtM936-2X14gBfp3bMxRAfH64BtYGnYtoQM
Message-ID: <CAADnVQ+t6JJ9YgH_xgicbzvvP2WvEJWxi+hioQtFKrR6BLTsCg@mail.gmail.com>
Subject: Re: [PATCH v5 03/12] libbpf: Implement SHA256 internal helper
To: Eric Biggers <ebiggers@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 10:03=E2=80=AFPM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
> On Sun, Sep 21, 2025 at 03:31:24PM +0200, KP Singh wrote:
> > Use AF_ALG sockets to not have libbpf depend on OpenSSL. The helper is
> > used for the loader generation code to embed the metadata hash in the
> > loader program and also by the bpf_map__make_exclusive API to calculate
> > the hash of the program the map is exclusive to.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
>
> Nacked-by: Eric Biggers <ebiggers@kernel.org>
>
> No more users of AF_ALG, please.  It's a huge mistake and has been
> incredibly problematic over the years.

Lol. True, but good luck with that. AF_ALG is uapi and it will be removed
only when the last user retires many years from now.

> If you don't want to depend on a library, then just include some basic
> SHA-256 code, similar to what I'm doing for iproute2 and SHA-1 at
> https://lore.kernel.org/netdev/20250925225322.13013-1-ebiggers@kernel.org=
/.
> I'd even be glad to write the patch for you, if you want.

Yes. Please. If you can craft sha256 without external dependencies
we can certainly use it.
Certainly agree that it would be better than AF_ALG.
