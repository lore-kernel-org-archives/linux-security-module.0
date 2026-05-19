Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310D63BED27
	for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 20:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224080; cv=none; b=SeZcrWvFm/jK2vaUqNZqrRCBxapuiA3pknSpJiBfGfkpO0zJ/EZmXhB8kdlnnHWHhE0iWyqA0JWBJ3KPwpgk9Dpr6vE3GS7cB36JYgt7Wlr72hx+lNncUaZoXqfO2VSEOdWHkylE6fYIXbuHesyApRwQn2EPxeEwAIJYHutkFjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224080; c=relaxed/simple;
	bh=oF/m2XYOnSMuXZ9jLRj8lo6/kvbdkSor/OtbOLVKRik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxF16fv4dXziK9y8yIqOvb+WvuR/OMLRtcADVSbUyFQ5Yn+qr63A9jszlHeXsP/2/HMX4PkACwVDlL3xVfhUJ/lcWbS167uI0oCq7QPiKhGmkHjnH/66UvDRMjLHBKnvsI9IKPaFM3i7tT621mMCMTMdfnuW8BAZDfGsB+9eRsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0R7wkTn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0R7wkTn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CE21F00894
	for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 20:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779224078;
	bh=oF/m2XYOnSMuXZ9jLRj8lo6/kvbdkSor/OtbOLVKRik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=F0R7wkTnbd7bXaPtWN7FJ2DMNk6LhSg+h9SSrAx9kW85ukS0jpyXvUto0Q6pSeEyk
	 Bqy39JDTsG/ibGFtUGkSlQRveT43Y2f1dD1BV00ZTmijgTM2eVIo5DTKQpLv7eT37D
	 7MOI/gPdko5KRL8wVgPe2lijHocmnWT/Wip6ULTj7+zmOaEJMtHB6MBiKJWaPMr7rx
	 4nJYH2Mcm4fSlNsIScQxWHRhc26H+YZgARX6YK8YWinbdE3je4/uf9zac3jAE9fiY+
	 svoqfjrV2JZ26jPSKAiPVWIRjDPw2IlbO3LObp/pIH4I/HQnitjzzvd0F8GDUbI3jM
	 3lk39WSTzE9ww==
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8b4000e51fdso44506196d6.1
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 13:54:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+74eeQwPDftej5GqwWBVTvu8LQpnGnXcUYo4pZCoGJaTp8sUCmcW/okLyndfvGs0sJZ7sdGu/LDuHfPJ5ONNKn4S8wHgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc8IozlblHajhnPgxwrQ1ixC4bwcwi0UdNJTUUkeHS8Th/iYcD
	lQ6LXmHG5xaBNT7BAOBaUw2sOKIig20YsvQLVlfPfeuVMjH3MUlRqRJvQXJKYKb2ov08IBpHAFu
	Ipmk5MFsYbXmow2zhHooADC56UAZU35A=
X-Received: by 2002:a05:6214:428f:b0:8ae:6460:c544 with SMTP id
 6a1803df08f44-8ca0f6a3759mr350440686d6.41.1779224078246; Tue, 19 May 2026
 13:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519200933.30752-1-kpsingh@kernel.org>
In-Reply-To: <20260519200933.30752-1-kpsingh@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 19 May 2026 13:54:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7n7w=DfT9Lmd06Eet=mk4E0ghA2dXome9TpaD+ocj=8w@mail.gmail.com>
X-Gm-Features: AVHnY4IIPghVq49tjruuoI16kaUolZH7_5sKoeopTdzvFcthmleIBHnS8fLKBLo
Message-ID: <CAPhsuW7n7w=DfT9Lmd06Eet=mk4E0ghA2dXome9TpaD+ocj=8w@mail.gmail.com>
Subject: Re: [PATCH] bpf: reject NULL data/sig in bpf_verify_pkcs7_signature
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, Xianrui Dong <dongxianrui1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 1:14=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> __bpf_dynptr_data() can return NULL (FILE dynptrs, any non-contiguous
> backing). bpf_verify_pkcs7_signature() forwards the pointer to
> verify_pkcs7_signature() unchecked, causing a NULL deref in
> asn1_ber_decoder() reachable from a sleepable BPF LSM at lsm.s/bpf.
>
> NULL-check both pointers and reject with -EINVAL. Mirrors the guards
> already in kernel/bpf/crypto.c.
>
> Fixes: 865b0566d8f1 ("bpf: Add bpf_verify_pkcs7_signature() kfunc")
> Reported-by: Xianrui Dong <dongxianrui1@gmail.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Acked-by: Song Liu <song@kernel.org>
