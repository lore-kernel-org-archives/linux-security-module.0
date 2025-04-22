Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEDA15098F
	for <linux-security-module@vger.kernel.org>; Tue, 22 Apr 2025 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339305; cv=none; b=vFZpIeKJEZS9R73SSXgxkLYBviXYa3SmPJHx4k5I2mOTlvZGcJH0BDTPbpz53M2fMMqsgeWhlT9Go8BsiuqpvuT44UEFSsfLJgodbSMOEZuinWA6ldqNAMlTrNRvJ6/MLjOosscZL2yG2occ8el+LeTRBSY7RqpAv/YEP72UomI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339305; c=relaxed/simple;
	bh=j+iWAa0suooh/9BbheNTpR15KyC7Wrafy4/wZyt0F8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZtWOYbm7n5ZlPhin7nG7abopvrJSoKBoIu2oFO+dGHXvCWnL81jy+btUqZhJCNg28sdMfbn0WXu6PLZ+0Awy7E6DuVPKhw+3ODvCnymVQeXaMnf3HHKmNVdcuWgcG6VPYc5TDu2w/FTJIXnfAZgUE+CEO6M9GC2HkfKsEQhDoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gOmHCpRH; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gOmHCpRH"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ff4faf858cso37799987b3.2
        for <linux-security-module@vger.kernel.org>; Tue, 22 Apr 2025 09:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745339302; x=1745944102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ/h+SRKg3HKK8qDeGxWSA4UTfkR8SBnHYf8ziXdKBc=;
        b=gOmHCpRHyfwMjWGfVsBTu+W5AOcjKiVXVkKzWE0yS9nwwqCiXnUami/1nRwoUELhPD
         Rv4LStcEtWNyIhMjSP/OVcN2xVH04PH94WYY5AlOtcK17zU8OW3ghM5z0g82LgS3SMiR
         Rfn77PJkuatFRUy90V2HUhiwzt7M1fNuxKYNgba/rNqztu/6DKZZsiYqS1LjTKhHWotY
         de3JCT5+S++6HJ4recCKxQ5C2NPuZ6dSi3MidLzYxJHA1Mj9tMKkasGLWH9ek7eyxW1J
         ZYcCAz56IVvuPhGt1lkZSbahlybyBgSaJume5Cj3xB6N7b45KgNARDxCxI+W6xeBushM
         NqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745339302; x=1745944102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQ/h+SRKg3HKK8qDeGxWSA4UTfkR8SBnHYf8ziXdKBc=;
        b=isFcXPKpsvp3CaEH6i1Mwi6NRK1Bd3vD6v/k6XVxyLIlpCHetslMlWgrnFfdb8BdAi
         zxSNaZEgEnDfqm5MXrv/cr63+Qome9TOs/TZBMkqddU649sS73FUOmLwWNeiKWlV526U
         H3RE1KU9yyLNE4SduKGpCxiqd1yaVyVlPklge1c6ruS7Y3C7Vg2X2vBW9M+5f2ZaZVSA
         MoPO2FzlD+PRoDSSjAWcdSS9+HPkZoeqHYrYHzV6M50IWSSFraJ5rMuhacjWaqyG+PhL
         Vuzgg0AN284V8sRnTGCu/1RwRYLNxi2dvWhyY6F29ATYWsEOhmMHmRSYtmFYCU/7Bipw
         z5Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUSpGdCqTTQ6Q9Nl10GI5DJXO6in21+Dnu95mOwu1aOPxLDLY0CJqZ5Zany0LcSHHsAnxellnxXYS1hXx6lvN3FYE8Hsgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1okT4tcga2KcqY5wmVY5Nnh6BWLscEMEUMB50KFSZLr0iewS0
	MDvsdOdIFdGsrHeK3yz7DigATExTeFHQQlb0dcIHClCyHEia7rYKtaTyhq8jmAaofKWWCDgvowW
	I+hcVdgEgmnXJXUkj4NUPS8GQfnFMjgWhcVpO
X-Gm-Gg: ASbGncsqnCirP1lGYF4yDNJyKc4ETm3yTaKzj9HIerA65Bfna1tzgySxYGqR0Dgey8K
	rBgQb8oIaWWIbAzAnEcAs+jc9mmmvZaOwE2USUD6IQRtxE3u11Gm6kSSRJ2nLfBeaJElnbtrLN0
	p07xWcfB9y9pgiDGUgI4o8Fg==
X-Google-Smtp-Source: AGHT+IFQDSL/ncnLOWK5LRznb2NXOaof3/0NlcAW1YBboG+fEljKszmHQmxJ1eEYy42tv3YqfQtVf9ZlPwKPijpnNCE=
X-Received: by 2002:a05:690c:4443:b0:6fe:bf9d:5de6 with SMTP id
 00721157ae682-706ccb04f2emr232424337b3.0.1745339302344; Tue, 22 Apr 2025
 09:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416213206.26060-2-kernel@o1oo11oo.de> <CAHC9VhS=jWEZqb3MqCtUAJhY9ci8d_N4H6CqWsYU0YmEG=8_yA@mail.gmail.com>
 <c1eb852b-f8aa-4ab0-9579-19eb0d383cb9@o1oo11oo.de>
In-Reply-To: <c1eb852b-f8aa-4ab0-9579-19eb0d383cb9@o1oo11oo.de>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 22 Apr 2025 12:28:11 -0400
X-Gm-Features: ATxdqUHPzGOFeKXTqUOAMaQToBxYYiJZ5vV_2qPozFgBaVAUE1O_hbEaQPAua4U
Message-ID: <CAHC9VhQ2NWr3-zQ8mnQEOV9KzY6A_Vd7AR8uzp5ZZ-FLhkG=yQ@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: Add Rust bindings with example LSM
To: Lukas Fischer <kernel@o1oo11oo.de>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 7:22=E2=80=AFAM Lukas Fischer <kernel@o1oo11oo.de> =
wrote:
> On 21.04.25 21:09, Paul Moore wrote:
> > Thanks for sharing this Lukas.  My Rust knowledge is still far too
> > basic to offer any constructive review of the Rust code, but I'm happy
> > to see some effort being put into looking at what would be required to
> > support a LSM written in Rust.
>
> Hi Paul,
>
> that's alright, I was mainly asking the Rust for Linux contributors for f=
eedback
> on that, but I wanted to keep you in the loop as well.
>
> > It isn't clear to me if this is simply an exercise in seeing what
> > Rust/C interfaces would be needed to implement a Rust based LSM, or if
> > you ultimately have a LSM you would like to submit upstream and this
> > is the necessary groundwork so you can implement it in Rust.  Unless
> > it is the latter, I'm not sure this is something that is a candidate
> > for merging into the upstream Linux kernel as we don't merge "demo"
> > type LSMs.  If you are intending to develop a proper LSM, we do have
> > some guidelines that may help explain what is expected:
> >
> > * https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
> thanks for the feedback, I guess I was missing some context in the initia=
l mail.
> The LSM I'm using it for in my thesis is more of a research testbed (or "=
demo"),
> so I never intended to upstream that. Since I still needed to create bind=
ings to
> implement that in Rust, I figured I would post them to the lists to get s=
ome
> feedback and to get things started in case someone wants to implement an =
actual
> upstreamed LSM in Rust in the future. This is why I marked this "RFC PATC=
H", it
> is not intended for upstreaming, only for feedback.
>
> If there is interest in it, I might polish the bindings after the thesis,=
 so
> that they can be properly used for an actual LSM. In the state they are
> currently in they do allow writing an LSM in Rust, but not in a way a saf=
e Rust
> abstraction should.

Thanks for the background, that's helpful.  If anything changes and
you decide that you do want to implement a proper LSM in Rust and
propose it for upstream inclusion please let me know.

--=20
paul-moore.com
