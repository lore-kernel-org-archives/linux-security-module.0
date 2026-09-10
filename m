Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDC54BE454
	for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2026 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053341; cv=pass; b=ppp6VdPyeZwloaXEwggKTkYdWiG+uTfuEEeLjQIIorgVrDoGDi662o9RfZe7xmE5UcQ2/Kgk36+xtZNScLHouTQwHMjOP6EAuciJ2i2knv6/x70xXBIyBSi8YHoO4FSZT93o4NK+TIspkNc+9TjDbQAxiztIb9IP1x+WAer8ViA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053341; c=relaxed/simple;
	bh=i0qyr2C0ENgPCQGsh4QhYiKOgzXs/bwuuJYt5R71+JY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXASsrF6rqiOZP0dsI331bZKR6YLoEhgpxOhruKTqYB8WEyN2FK4DDA7nAtMSg1JoRdOdNGCcuNGeJfvmzWpP6IHb2/YF+PxJY8eBCsJy8BYCGAOYhVDre1pqe/BRrXY2MsWMuZbSonEDH7O9OR4q1lTmxcqwGwKvDgO7EpL+TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jzUOconq; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jzUOconq"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso68979095e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2026 08:15:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789053335; cv=none;
        d=google.com; s=arc-20260327;
        b=rUIAaXdeTYwpghSMBoMH6FODTd78bhSx115YjNL4mVstb7sP1J9of1PelrMrzt/31z
         +XbF9HpUCERrY/rYQ/iRMjJXLl/IkJsS61bNGrhqe6Fnb5WCFW9dR3KFiUAPO7fbLp5L
         JK6rUQLd7cm9Z7nCgzzUDTAbzDY8wdlnjadGz0wyUZxos1ubcNyApG6Mt3QrHWh7/rgB
         2VOYFaPFoK/PBLlrLk9DWYgTwVP6+tVfwWm8ZZEo4FWK+IQ3Md7O8pQK6RHKrEp5jmlK
         SZXt2nvJ7zXHjPpmJgPyGzVY7/bxPZb0tLL6/nNtXJlMnSn9xd88l7mJ90zLImtWDCRv
         zrRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i0qyr2C0ENgPCQGsh4QhYiKOgzXs/bwuuJYt5R71+JY=;
        fh=tym5xDOsGD0vXWVdZndX4xaHR7w+3NeXIdbyk+qkIZ4=;
        b=Z4hZEHUfbfo4Wiwx6QlxCNyDjpzBjF5Rz6rPIohegJSxU6/jn2GsbvYqX0hE4GrXFX
         kOZHHRHKGO9XdQWb2nGTC9sU036tyhYk6w5+NYXq+LTH1YYi5ulUc7eRJgQJOi/ZYbXf
         4DjInIHQrlls/XR3u7e0EPZ372kmewwSLPYg04HtA4ku8tH/7hERtGqu6RlM2H6Wf0sW
         9/1CDtJDVHbiMuPkC4x5S6KRaUKYyDnw8LAwsRhtxXkb87wd0KqdLkyf+61SzQvgbq9R
         UgfEo5UWQXgmJvqvH/2h6oMvd1iJbzDkkLpRRZFuMRqr+t3+9boxSFsvItTlCOtup1z5
         JtDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789053335; x=1789658135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i0qyr2C0ENgPCQGsh4QhYiKOgzXs/bwuuJYt5R71+JY=;
        b=jzUOconqUVvpvDDNCvwTtRxEW5tyaUELT15zzOt3LOCwc0zBRM0WYkWeGJFkKi57O/
         gW5Sl6Peb5EM9vcQfb0rVisAmznCCdoQmObr5FE9k1mPvst0MX85L8IJyH/nPQlfDPY/
         2uiyFSoMQDqumZgYnwAPY6Padvtmnb6g6PkyMY/uE7FImvfFyATppcmiW88mDMUR3/yR
         7xuYXxUDLm5xYppHSvoyY3T978BxRoFZnEH2ZKG+a+8mplsbUsmTVK1NnbraXHMyQPsp
         v3EmMh1gHjtPMdzwrPs34MvLnEAHkG5ool9O5OQ7TunP5vJ82avaJrI7tR1cgUgkBmQK
         wjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789053335; x=1789658135;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i0qyr2C0ENgPCQGsh4QhYiKOgzXs/bwuuJYt5R71+JY=;
        b=cAWvP9gEOdXAYqKKWQgyNuBUHhuqjndxyNzNQcwbjlCnI1PUTVRuh/hRtnEns7WRRf
         eQ+6pfxq4Zc9wDUA5trKhXIoVoml2ESWPgpVk6N3527U8ZPmHNRItmIfvBOjwHKKeGcv
         G8CzTJDxqQTRd+Z7snjF5XW9Qg7FAcQk1Vu8ZvpAkiKja0y0OnGBiLQ83x/TGbq2CQh7
         MuBAIDFQT7aeiPLQnHPgpXF4mQ8g1YSdQsXU+FceY9uFzdqzmQRx9JfH/OOxwZd84avD
         scuMngMQ7u4M0QDyKZYg3+jPnqkmtEcFV46hBPubtDp8ZseX5XdRXLWwzJYgpAo0X5kr
         WJWw==
X-Forwarded-Encrypted: i=1; AKwUvBw3Fcm5/UoGA30a/vSPnmsBZvkB5LQCt5yR7l/c9NhN3VYyYbYF4vRZToEo2/m598k2d0gC9nGD35ewTTP+bl6l8VzrIqo=@vger.kernel.org
X-Gm-Message-State: AFuF++myWVivjDPpUgT0r/qbfWroBp6ew1nroVmg2kR8e4lEBymGyTes
	YlBuuwXjlopV/i9fhIWXpRVgrN2uNCbCyhevAJBzRoseP++AriCKcnk72uTjg4Od5gFqGH6hW8D
	6GMeGFu+fEqXBFWpDktVyUNSGhAqCQZI/r2R5I5X3
X-Gm-Gg: AYBFou0e13WKCaHkWADr87UDV+OFDfKGd+5wwxWU+muR54bkBz8p9SbwRPVAdTxATsP
	Thh7zGoqEPnmCZqFsSNKsAgu+5Bl8cip5B8VrQ/2lvael2f8IpFnEfmtwCNeI0Yyb8mpzQOST9l
	4bjLN6Q9SjTyiWhul01nnsKB/Xa83PsJUOgudlgm1JkJzFUl3B37HGhog7VXLySQ63VzA506Fbs
	iFUlBh34kbuAjlyF3ZK1ekiQ5Se2HZ+czRa9nQ6uu87uQy0dPSCXQg6u/SasIrdwSxOZLsP5+wr
	Q9LDJDQ6D+Z4pfc1ATJfDSQeaEjFUKnlLn6rwyj6vUWKTxb/C8GZmzgd6fn/PJezRiFy44+lQqX
	at64QrLVdKwO6OGZBsBHD
X-Received: by 2002:a05:600c:3495:b0:49c:dadb:18a7 with SMTP id
 5b1f17b1804b1-49cf8244260mr429288325e9.10.1789053333570; Thu, 10 Sep 2026
 08:15:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828024335.946-1-nils.lehnen@proton.me>
In-Reply-To: <20260828024335.946-1-nils.lehnen@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 10 Sep 2026 17:15:21 +0200
X-Gm-Features: AcwNN1Uzoi8lwGKaGFrFRU-C5_p6rCaJZlH12ISlamLuab6ijiQmyc1yoeBy_qE
Message-ID: <CAH5fLgib5D=nk4OwoREHAqzpC7=Ly=MZoU3gUGpTgGTZLS0mjg@mail.gmail.com>
Subject: Re: [PATCH] rust: security: replace `core::mem::zeroed` with `pin_init::zeroed`
To: Nils Lehnen <nils.lehnen@proton.me>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Boqun Feng <boqun@kernel.org>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, Onur Ozkan <work@onurozkan.dev>, 
	Atharv Dubey <atharvd440@gmail.com>, Ke Sun <sunke@kylinos.cn>, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 4:44=E2=80=AFAM Nils Lehnen <nils.lehnen@proton.me>=
 wrote:
>
> From: Benno Lossin <lossin@kernel.org>
>
> All types in `bindings` implement `Zeroable` if they can, so use
> `pin_init::zeroed` instead of relying on `unsafe` code.
>
> If this ends up not compiling in the future, something in bindgen or on
> the C side changed and is most likely incorrect.
>
> Link: https://lore.kernel.org/r/20250814093046.2071971-8-lossin@kernel.or=
g
> Link: https://github.com/Rust-for-Linux/linux/issues/1189
> Signed-off-by: Benno Lossin <lossin@kernel.org>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Nils Lehnen <nils.lehnen@proton.me>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
