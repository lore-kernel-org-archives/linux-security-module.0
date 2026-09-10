Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45232492E30
	for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2026 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050049; cv=pass; b=EeZUkYe2l7THoVAESR1QeH80LCsxeshylyNqRLDGPYlo/Bn9wue3S5S/H7KbqcQrnQCMfF7dhF1S94kooVTkQ7SDyhwuF1Sk34FqaLYGhEp1LODpEdcVmzKcfjbm3zL+wWAfkPKG/31TJhF29fpMSw5hqU17m4mgRcVirw9XXz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050049; c=relaxed/simple;
	bh=kHC7Ae2Tl3n/mBGFrKAMMqnaWcYKFzJ/lmrhtoGI6qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4eBcHZno9TNTxYoHVLFCLIq9sB7dwwf4AKGnaSQexxj+rU0BuR3Nkb5JCQvAW/1un4er5t6KtUGxXysCccc6D3aWzYmPTKpeNetNN8YYWH9xwDt4aKxyCzyY9IoSIZzKNdVrWtA92AB5MEqaOEc0TwQHT4qtjwYX2CjrA+t7Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OKWZu9ym; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OKWZu9ym"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso6629092a91.3
        for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2026 07:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789050047; cv=none;
        d=google.com; s=arc-20260327;
        b=fZmVPpTZtJYuSMtys6WJvVqkMHdllwL0PgWoyGvU7LQ8PrME9bdva7CRiVbX8Pqgnm
         EWsqPLLuxeqCZWdGcp9EDY7uOYGBt2MSvPh6TDM7us5ygEa7UIOfjoCxT2zTx169KBKV
         Gvn0hYwwItloc1dYVooKeEXXNpoc+J7xRnCnPdG5Mu9dJOkUFdhk0k7GuQYUOYajyTf0
         wzNgeNIkHDgTApmEd0GYS9LJm+y/pG/xlMRclVMHc6ZzwzH0iUdXRdTntwQWKscDbHHH
         UN0kO+kUGiSvuJGBcFPlHhyzZjNjQWzc73zbOCd21d3bKlSPKuGjo5JPO1UuwBEUEMH4
         2yjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kHC7Ae2Tl3n/mBGFrKAMMqnaWcYKFzJ/lmrhtoGI6qk=;
        fh=0G8z3T0eBfswsqwzDCENb1Xh74lTDGbgncBChuzfrCA=;
        b=fxcyWhiQ8OuYFhgoa0bZ/Xd2CIQe6s5FEJmaWXU8WzOmlLmX/npmcP8+kP5CRGtZbb
         vj/G8cbwDbmYAl5WMp91wI+YmBcMnn43SxlMwMMF/3JQW87Vw3j9XNWiHFWLtMxknBq9
         4OiuH5Nr/J28wy7Hb6bMEe//SswrRoUK5rGcnv+3ZePDCYqoy+yd0WnqEGTeUyFZ52nu
         QQvPlV67uvVyDJ1LpbQqZtErL0/HeNm2V/0g/khSb2RW/UbSeCOEMwnPzHziQqGLcwF5
         vztJx9UL0PrBdYv1mTh+CoKtz75NpVuxL15jHUNhU20yb4Y2rzMc0gvGU7q5X4Fas5wb
         6OqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789050047; x=1789654847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kHC7Ae2Tl3n/mBGFrKAMMqnaWcYKFzJ/lmrhtoGI6qk=;
        b=OKWZu9ymn5Qz7S+ShDmSTTthKUZeP3gaCnqLBGMgefhkXxhD86vbg55xU5i7guRuxH
         tuDOseuQNTmzNudvxG3q5VkH1w2N0jYOGYgb3C7m2bcAmX96MarVNxVJQyjgJ/n5Wg6X
         0ZXRHJSjkOVBvbAtSamErddfmjFNwTAqakZtpabCWTOmZQGPLn95ElLpQWmAZhYadGEV
         4dpNNSQcP//3YP+SWt6AdzRg/HEM87YA/YcPSnAu9lmq/6n97OlSNFdaigmILrfcPKZe
         2spGQGnYs7umBRplsH2Q0tXWQi9R6ACdBiqN3aERgdw4OnWeR2mm3hh62At83dx/WOhl
         KbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050047; x=1789654847;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kHC7Ae2Tl3n/mBGFrKAMMqnaWcYKFzJ/lmrhtoGI6qk=;
        b=pnhZr2TQijnmGP+3xYE5N5WOdllyDGnLkuZv9Y9u4NvqcmKjDxaEaIvPI9YLM1Zfaw
         KGlp1Sy/t9WSQOT3jL5bMZ63J1kt0wM4fgiwsSzHKOC8yvcSrml4uM2nyZtS/SqZcVbf
         ExcYiAuk5Q3NwsWTlN1r6g2Jc45ZpVB2exjif0IJQ0zgDBL9GpnGpRADTVsOTwBAyl1V
         lfkiFJZ3Yf+eLG0wH+a7INNNebIaKnaZH+MvwcLKloEqRV/WaOM5L5Rk2S/Uv3r7bN1p
         Jm1VRp9liSZdhwPQS+eDmNzYBFti4LGkIa2VLjmbAwNVEDao1qPvevuFWHygFqqI4JrA
         eLHQ==
X-Forwarded-Encrypted: i=1; AKwUvBx07MwXfgknVhx65H+VF1C/9S/yLLOwhSJ3sjePgYtshYSNd+B6sR+mtbgff9d7pDCsLZMa6t/SpRshJKWLwaU6LQcoYoU=@vger.kernel.org
X-Gm-Message-State: AFuF++miaNd0pUEg03Tm+fOe5mqPJGBZjW430J2qdgUzLnjDhJwuY02K
	OwGozRWdF2lGZ5QvwBsrUZ+ZXpIDu8KoijbYS1gPY59BLvawLGH3A+Uc+GbRW48gPr6HnlYMPdp
	UMl+p+n+43FYlRw3SqJ70G6cxdbc4TZhazfhE8SAq
X-Gm-Gg: AYBFou2VO17gUQPuqqwnfKKHLHZ/+JsgkqrFItBiWv3altRlwfYHqDOrB1FYOBYdI6p
	noHMkfkrkKBl5jCk/3Z2b/jBDvAcG/8JOcyvkYaStRurGEWCrg9naQpajo26w2zvT39YS/7ZOL1
	S2ZL2mybx44wNqCczwA+2OdrZ21zwLxdKFUjn7u2deqXCkBJN7w21+AaNS0JFltKv5gZMickDjc
	9IbtBe+sI+jtjutWm/s28kGBJRSb1BvweQlWbOuyEgZgFK6mcczdLAhw62JrvlYx48bSeZxL+o1
	tobZA5g/TVVRqYOWS+rQX4fXuVKFqGnr3fO1B0gPAKrr/6UBWfIDsgn3cAIQpDdE1afs4DXm3QG
	SBa0rwPNl9NY=
X-Received: by 2002:a17:90a:dfd0:b0:396:61f1:da5c with SMTP id
 98e67ed59e1d1-39b260de667mr62254361a91.4.1789050047048; Thu, 10 Sep 2026
 07:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828024335.946-1-nils.lehnen@proton.me> <CANiq72mn2vvCL2VP8yJxmzXM4n+jfV4R7arUcj4UXSi04y5sfQ@mail.gmail.com>
 <CAHC9VhSuuNmdRQ5puaxWh5ez3Dz9LhtAmZU40SUGgEAL8Sn9-w@mail.gmail.com> <CANiq72m0yYRj75RQBRprcHTrqfd7=m_OnZAAQfZdO9T3dfUQdw@mail.gmail.com>
In-Reply-To: <CANiq72m0yYRj75RQBRprcHTrqfd7=m_OnZAAQfZdO9T3dfUQdw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Sep 2026 10:20:34 -0400
X-Gm-Features: AcwNN1XQpJke8Xbxx6RwTk63Zpj7bDWuOMMs7moVd1l9uyfsDlmCNzMgiT1n-QI
Message-ID: <CAHC9VhRjjJpv95AgF6cnOdh4g3gC4zViRoiHVehMLx-Fv9b1vw@mail.gmail.com>
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

On Wed, Sep 9, 2026 at 6:43=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Wed, Sep 9, 2026 at 11:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > Looks fine to me, I'm assuming the Rust folks would prefer to take this=
 patch?
>
> Up to you! If usually patches go through your tree, then that is fine;
> otherwise, I am happy to take it of course (ideally with an Acked-by).

I'm not sure we have a "usually" yet with the Rust LSM glue code, but
I'm happy to take this patch :)

Since you've already reviewed it, can I add your Reviewed-by tag?

--=20
paul-moore.com
