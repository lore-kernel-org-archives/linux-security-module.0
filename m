Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9206F3D16FC
	for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2026 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393357; cv=pass; b=XG1rVsBEaW2B38WoTmiP7iPdDnkFNfgTVCFk0u8qNT6WGfyZthzSG03XakWyYoh6fdnSZN7ziR6CcBRlVP9H7gOmbTjxw2N2yf9bOmN1LFZUckemFsCtfgrRr6H7CcqRAhzAKihFZ/Xp+CTRYqw4A4PJGBsWla15LEm3wqyD9Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393357; c=relaxed/simple;
	bh=AhL326c1YdAwbi5q6PvrTRQ6TefqA6HxsocAsD+zo5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lp077cKj0Uyz7ZTqimFCOU1LZxuawzU0/V8yR2Ea0HZz1zevBDq5o0NySREtNGuRVP26FBhIHPQZ4AmNsvSXHMPO8WXGPqnmKeRp8PHttXisp87ueztDMWffQwaVAF7BcpdoDwnjgQO68bZhRJE5fsg9mkoc4KBE79CGpllfQvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctWka/32; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctWka/32"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4864abba33fso153321b6e.0
        for <linux-security-module@vger.kernel.org>; Tue, 02 Jun 2026 02:42:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780393354; cv=none;
        d=google.com; s=arc-20240605;
        b=PAbxy5cUfPnyaCaVrraiNq1+EaYnCZ11rNesNdKZ1wob+4uPVi4ck0n5Y2F1KWFVRV
         u1W6GferJxgCYmOF4gCfFkpZp4OXDWhoO9P/cxCmX83hXYTRay1Y2qIzdBFdvVaLmu7I
         Fzh4pbwabxgMY3WKJsx+XyXX6tP+Kwiz9tIC5Vf61g7xwe70zbcSXyZ6Y0eHersHkgNl
         mP4GuQEYsxl2dSbiQ8woP7ToAcgucGrTzSa4C2VXejBXI31Ki7Pmt8WhhApzDt1qvfAF
         Uzt5BxE6rISP7l43qHKUXOo+cg2xuKkxKo9QID2NASw98f5JoOWPTVYRxWNdxFA43XLD
         9+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2WN709sXoGtblvRyrImhrRUuQENQMA3uMpblskCxCeI=;
        fh=er7XJLEyXb1uFmkh55gpSZl1Sfj6JtncwwDZpyDWfy4=;
        b=ajq8Yb+RdKL4Cx+7cl8VBmNyaP4q4fU6x7uBlzMc8ijzSrR99FFivS68wL0mkTPefE
         jXxln3Fpeifxld0iGpSweNZDy7wsxtAl7WINBRroOrqUi1JQmHlcdydoN6YoAhq8WzoE
         9hTShGvTWKJl2Bsf6HgGMpbly6/tcjVJtU5lYqJpzxQt6JJuPwPNEzKoM/bqicdndulF
         iVM6kIZeUZn4kKDQtsdaccKKqGIKR/7KG/8skhz9vHIQ31G9zkw4N4j9gMEoall0zhAt
         vAu0NNQCLkkB5W2IvCBV9C2n831/U6pf+hCtqk5nHvgrX5EcV4Y6Lv0XglMzTbnkwB+8
         2h8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780393354; x=1780998154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WN709sXoGtblvRyrImhrRUuQENQMA3uMpblskCxCeI=;
        b=ctWka/32L0p9k9rRF89Abbcq4eFeaMTFfzDIYlQ1ye1U7jMF80LqjJqMFlFUf2Esaf
         7bA02vZfCW0AkXNgJMGBzlbmv2Z4i1bXrhWR8jbjd9WQv1JKE1w2XJk06P3xuWB1zR2v
         JoaGqOrwEJuTrFPJLXAe1tG7tb2ircWgiRdqqDFS7MkE3z65hAzJMIPab4B5JMzCe/QH
         tKYdCeX4aWK904g0qxJuoic5LwlHDAJvsEgTguYTHqhqEcfOsmXTFLoZw2N0er8d9THx
         ZzrXfzojP4kiTcLMRquOIuytExLNseKC5zX6JOQXuEv2+kJ5LA7AjLI8mLAFiS8EiHQH
         0P2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780393354; x=1780998154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2WN709sXoGtblvRyrImhrRUuQENQMA3uMpblskCxCeI=;
        b=XHvqFCkiofLsBeY7wxUawB1ijDRS24QIfKCpp+jeYUds+Q1gWn8X+mVwcH4q3SPVK3
         QRrTcljE7o4dnV5I1//tshacTlCDghbv0un1wOvBmwLeNZ5dO7A7Qpz2A+6lYRUdvoOJ
         GzO920NZPLv9uPf4FW1iqvb3xUVF25t4VbGH+58wKM7/xungldMGXdBuYUkj2YxdI5lB
         XdthwMxtVe4oTuwRBFKMdu+ag+BxUWZUszlK1dWC7B5H90nH9TaQNf/fSuWt2HsWiq/x
         AlsKSe5ITzkCxcIb5XDeKwkcqB1ZhLAcuoNzae20MHwqO8InvjoJVX9lMg8lfA/Kf3IK
         K+kA==
X-Forwarded-Encrypted: i=1; AFNElJ+svbeJjlWMHatKEcoSSWi6rEQkvPUyqYa7btFu1lJbly5xMsaB4OJhH8S5Yp5cciat8DuZsyIUnxeQd30pHV9jesqVqBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVWhck0mCPRtvrq2Ru2c2Ls515RD8T40ddIOonSfvpPYg6Vdts
	t/D9uDaLSOA8nX9W4IH51c3X0BMUGXPmo9O2yC2QzUNhi3VacqAX472zGqJx1YKeqzauFLTzqMK
	DLcdasJDsyJUNYwJevxnnIc7aBqv6OK8=
X-Gm-Gg: Acq92OHkObpHl2NbN4LmFohDDsnYOdoRBuvEadrSklBiZ87bpzoFUFphNJEWw050+dH
	YzWRvWM16T7C/blnnj0PL/GvujTYhapGZwHgEUNVLQ6cpFmYLJeLGCUW/QQXS6/Wn57W2J4eEqo
	TtzsFs2uZlhsNpNgDD0Ma+XH72zitiwNirso4SFmFdkXineI2F+GV16L/n/TFSu4q0kVYUJisvd
	RSn4WDdGMuFmjeDg8kHDJwKGw+qITiMU55vO259Zpae7A+JwMBoN69OxfLlrtgpRO2jHJgQuC2l
	fj6DvH7i3T/D6+xF6R6WzzU99bF9Uo9P00P939lMFVd0LKCA0NYTV68WgK+O2G+BFfCjPpUmO5E
	BocEY/RCbeOTG01Q+0Hm1ZRduVZHN/h8=
X-Received: by 2002:a05:6808:e86:b0:46a:17b8:bd7f with SMTP id
 5614622812f47-4863e7c2d94mr1611036b6e.19.1780393354616; Tue, 02 Jun 2026
 02:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529033406.20673-1-hanguidong02@gmail.com> <aho3CYdv8lQd2s85@kernel.org>
In-Reply-To: <aho3CYdv8lQd2s85@kernel.org>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Tue, 2 Jun 2026 17:42:26 +0800
X-Gm-Features: AVHnY4J3U44_QK8F7qYis9j67ueNmOkF5BG_lTDT6BBkwq5FJDnvTbsRP1vkKJE
Message-ID: <CALbr=LYaca4+=hTsZJORQfrtzyUAGo8c+4ZEgkzgkFWQDWNJBA@mail.gmail.com>
Subject: Re: [PATCH] KEYS: Use acquire when reading state in keyring search
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, ebiggers@google.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 9:02=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Fri, May 29, 2026 at 11:34:06AM +0800, Gui-Dong Han wrote:
> > The negative-key race fix added release/acquire ordering for key use.
> >
> > Publish payload before state; read state before payload.
> >
> > keyring_search_iterator() still uses READ_ONCE() before match callbacks=
.
> > An asymmetric match callback calls asymmetric_key_ids(), which reads
> > key->payload.data[asym_key_ids].
> >
> > Use key_read_state() there to complete that ordering.
>
> OK, so... I'm having a bit trouble understanding the exact concurrency
> scenario you're trying to describe despite I think I get the fix itself
> i.e. it is not pairing with mark_key_instantiated?

Yes, it is intended to pair with mark_key_instantiated().

>
> I'm a bit puzzled too why this was not done already in the original
> commit despite introducing all the primitives.

The original commit added the right primitives, but this site was easy to
miss because the payload access is hidden behind ctx->match_data.cmp().
For example, the asymmetric match callbacks call asymmetric_key_ids(),
which reads key->payload.data[asym_key_ids].

I also checked the two pre-existing issues reported by Sashiko [1].
The uninitialized-read case does not look possible from the code, but the
cached-error issue is real and was dynamically reproduced.  I can send a
separate patch for that if useful.

Thanks.

[1] https://sashiko.dev/#/patchset/20260529033406.20673-1-hanguidong02%40gm=
ail.com

>
> >
> > Fixes: 363b02dab09b ("KEYS: Fix race between updating and finding a neg=
ative key")
> > Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> > ---
> > Found by auditing READ_ONCE() used for synchronization.
> > A similar fix can be found in 8df672bfe3ec.
> > ---
> >  security/keys/keyring.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> > index b39038f7dd31..243fb1636f10 100644
> > --- a/security/keys/keyring.c
> > +++ b/security/keys/keyring.c
> > @@ -576,7 +576,7 @@ static int keyring_search_iterator(const void *obje=
ct, void *iterator_data)
> >       struct keyring_search_context *ctx =3D iterator_data;
> >       const struct key *key =3D keyring_ptr_to_key(object);
> >       unsigned long kflags =3D READ_ONCE(key->flags);
> > -     short state =3D READ_ONCE(key->state);
> > +     short state =3D key_read_state(key);
> >
> >       kenter("{%d}", key->serial);
> >
> > --
> > 2.34.1
> >
>
> BR, Jarkko
