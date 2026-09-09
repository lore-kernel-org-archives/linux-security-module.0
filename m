Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11AB3ED5A1
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 21:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990715; cv=pass; b=NvBZzTRjPLlrIpPD0aPtvO4EmMBDbC8xNQtOfYeFNcVdJ1Z0HmB9a6LV8XkM8hWmxx+4DqhkyqpgUDUROsj8TJp7aKrR9pTFCXoFqe9xTEKQCJaqgVLErKnkYkpMY6N3gWsAIpQ/m2CFWhdk5VK6rEN9aoKuFi/DX9BzVC+G5AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990715; c=relaxed/simple;
	bh=YPRgAxyATeU3F76UKlCXE03VGs6euypcGZFO8EUXhFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lldxVPFPBCCpO9t+AyQ484Rulu8c4fNVdIC1otHxERjOgbLIxHsydPrqG2zNzxlS+5hX5HRykux3qmAwBWg0eZ/2CNiNTCwYenWf0kMI+0+oJtsoHqzRsFwj9mx1Iki2I6L7RQ3UKOBxYBO+3IMrjxMkDUuHUzZVOKN1Hw5U1yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XB5puUEf; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XB5puUEf"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so6189548a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 14:51:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788990709; cv=none;
        d=google.com; s=arc-20260327;
        b=nBy2r5qA15EsrssjsVdjj90li+ictmabMbwYXZGtzWRcvkpo0+eWygR2iW8i6MLWVq
         GBwwMPkVF/LY6G4stZqPuHpeOojUnx8rYUsfu8Dtc5cz4TW3fNGfx2MxHfhjxKiOpFnz
         i1KrlXTdNxNAMS4rb3SuunrVKAJti7PNYyYCsZWaPYWNhOKzwcefZlurnDB2DMnte0Cx
         oik2TXg2CWZR7P/6fwds7E5y8g0HhSt4nmWTydbEOZDi3t89v7oD1rC8mYc3tihIPH/t
         +c7eR2xJskodDSJgZR2GPVrrj2NUi+Qg7rnkS9AVcoz4ud4Gb62iU0sHNuEU2qXE3AUx
         AJ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1P2SF1aoVUknBY0oCkVNz36viHEfihtK8+hDmw1Wi+c=;
        fh=E4wgaxGXMESyhNlPp+4HePxDOklSiXXSjNZOsiop3uw=;
        b=iNjsqu3X+/8HLzQ/VYTYUcU6vjlrO2oE2s1hzoFLDU+XJ7uoNUgVm3RcIzp/3UBcyD
         lZEGgwdHAWA74MRGFNTPEnYS5d/ya+6maN2PETU15VwBEppv7jCBtQLRYA4wnMV9LeEd
         a2MvbmlvKDfguvzgx7BchlU50YixEtw8zTinkXjV5g3AL+ZNkTqrIw2vZbxoBKEGvD+4
         DizfU15cOEuHC7OlN8bqNoB0if61G6BLyq6PVsBaF+TtIignpqtRnQYfFVn6UZne2O/c
         CEYe2YHPg0Tu2lu7TpumWIj6E/05dOkohdK4hy7DT94rcMg1oxHBmKgbT3fd9+ZBJZeC
         n/Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788990709; x=1789595509; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1P2SF1aoVUknBY0oCkVNz36viHEfihtK8+hDmw1Wi+c=;
        b=XB5puUEfiB2thfXXFieC2VJ5imNQr7nCDybRev6Z2hfdslc0KmSekPKGiURZTG9EIp
         pR3EtVxlZUDRaqJgSKMWT2dzGaMP0+DnIF2o0/eep+8ijHNS2/3v8XRlPHbiYTuANEzh
         xLv6x5nxHX4m8gfTs72hQ2DYS4ge+dEAKqt5NK5+BTYUI+0LIb0lyTiWcvKAjFL+qX85
         tUlA/AqbVDGq67jyyVd5FplmxKP3llhNqBEORrGWnqhKgLfim5bX4ZLLKUYbbs1Ey6Zq
         dXArGnJh3QwrbpJZEENiO+yKm6TJ8kYkU4g2CGIq4MI4zvcLYZ8aYwpng0p2/UEZbuXI
         qTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788990709; x=1789595509;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1P2SF1aoVUknBY0oCkVNz36viHEfihtK8+hDmw1Wi+c=;
        b=Cg16irhWO/HLnd/GqfSzq/5qa0GWQbDZn5MeqF12mV2q0VdbPOLFljg6CKI97sGbIq
         W2PYhFPvba5ghgVKfZt7aZABy8VQzIqW52iPEBngFcPWQZ0tZoREp2A0Wa9pH8B4GHlO
         yHZCYZKnLizBhwUkZKEj4K7J1JM3hffy5XaAPNEnH/RGNF2f+UgaccAVo7wBJuMxWmXL
         En8eqfnZwSGPcHcFhr7kSt3elF+UgUZUqj3EGa7y6dzJKcA5BBa9PY0DBbZGeRCuhiu+
         Q+npIOpSQ0o04U0+DiwtE122LE8CxvrX0gBWbdo3huLo+pna22KghoSruKDBcdTTIrQR
         5iGA==
X-Forwarded-Encrypted: i=1; AKwUvBz1PtokGDNKWUaldSnmTK9x9sm3y6EDqfhqzppHS4Zv0wyRp3HpJh462coAij/IJxl+L18aZqHs7G8PHm6zx2tl8VouhkY=@vger.kernel.org
X-Gm-Message-State: AFuF++lQdhjtQAHxMZSWAjtkx1fBo/DhjY0JTHb50WkthQF2ohwCVjaB
	nAImQwOGi+P8sCL6rNqdW5795YkEIEYli+kO3k+M+444rK319vo8vWuhtPA4Tpc3vROdmNnbVy8
	VIt7BrQlF7lML+gcZ26PNt4Vd0xmwJpPNSmaf70mg
X-Gm-Gg: AYBFou1piUsLApKbCMEZX3cCq4LxuC1y0JES+WUqXR/kuunnF3Vsvms4d8rufB0B3cB
	itnrxnt9/WdbtO9bAd3tSQZ8aKiYggiGw39hi2A3pFZLP/fqOb+mZ0oQ3Zuszp9j5CimlL/qyAH
	rYHtTGBAlggKK0puMOPO7Oe8tBd7sqzuzQRzAV2HKqQXf0NVVfTUoCx5AoFch16fxUrufD8I8G9
	EWpyNHvgEvyqplghFYniCsqaCni+t5vwnw8WJnWv0PdWGVNKR+YG25cXjSkoceAah55zjGq2+CO
	Nn30Iy2rL+1CZaGlS4rpHB7cd/RltMoUpEkV/Lrvt9iuyL68J13RTxQaWCKx0yysnQAtDckgVrB
	aobG88kDTyVY=
X-Received: by 2002:a05:6402:42c6:b0:6a6:32fa:1e99 with SMTP id
 4fb4d7f45d1cf-6a7e90b8f43mr14558766a12.17.1788990709336; Wed, 09 Sep 2026
 14:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828024335.946-1-nils.lehnen@proton.me> <CANiq72mn2vvCL2VP8yJxmzXM4n+jfV4R7arUcj4UXSi04y5sfQ@mail.gmail.com>
In-Reply-To: <CANiq72mn2vvCL2VP8yJxmzXM4n+jfV4R7arUcj4UXSi04y5sfQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Sep 2026 17:51:36 -0400
X-Gm-Features: AcwNN1VmtEdFon5AgpPJO-meJZ5NT-8G41KJlj3m5Osmin_JTAnahMcOn8IdkOw
Message-ID: <CAHC9VhSuuNmdRQ5puaxWh5ez3Dz9LhtAmZU40SUGgEAL8Sn9-w@mail.gmail.com>
Subject: Re: [PATCH] rust: security: replace `core::mem::zeroed` with `pin_init::zeroed`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Nils Lehnen <nils.lehnen@proton.me>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>, Boqun Feng <boqun@kernel.org>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, Onur Ozkan <work@onurozkan.dev>, 
	Atharv Dubey <atharvd440@gmail.com>, Ke Sun <sunke@kylinos.cn>, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 2:15=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Fri, Aug 28, 2026 at 4:44=E2=80=AFAM Nils Lehnen <nils.lehnen@proton.m=
e> wrote:
> >
> > Two equivalent one-off patches were posted earlier [3][4]; Miguel asked
> > in [5] for a resend that keeps Benno's authorship, which this is.
> > Cc'ing the LSM list per Paul's request on the original thread.
>
> Looks good, thanks!
>
> Nit: nowadays we typically use a:
>
>   Link: https://patch.msgid.link/...
>
> to refer to a patch that was picked from the mailing list (usually
> written on top of your Signed-off-by) -- `b4` can do it for you
> automatically.
>
> But no need to resend just for that, of course (and Paul/I/we can/may
> change it when it gets applied :)

Looks fine to me, I'm assuming the Rust folks would prefer to take this pat=
ch?

--=20
paul-moore.com
