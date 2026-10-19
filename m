Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD564F68BB
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420433; cv=pass; b=rq9ia6WCLupYBwdLbo5w2lta7ziJynteh8XcgJ3/qqXk3EqRB5t6tE0iKKj6zqk6qNn1++k7GOXQnUda4AGPS57ER0fdlMcPVWSvTfJakrySQ69GldLBoKOaVl7vPV30Gu6zr0MnPxA7WUgL8SsxrTUIT/tXS2WPPTm9UXl4278=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420433; c=relaxed/simple;
	bh=NvMYER91I0ByJlC1PXbZsAccJ7mHl0SXPzTmOrRuRiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOPuZ2uIu6mPsCs3WsrwNUSBf4gdZUxUtnnxzRDUw7XYYDjQaAS2qQvAS1+MJyaxt1sJDKVk4GWfkNGku+MZx8sabddxEjvPc7kEG+6ioenM20hd8S98O7Sav9wGrQaPodueFvq+LUNT5BUPU0faVUy+TQd6zQz6UMnIhoN3cHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sj5fggap; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sj5fggap"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4395d31228so162368466b.1
        for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 07:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792420430; cv=none;
        d=google.com; s=arc-20260327;
        b=UmdbTJcri9uL5my6uPHkpDkfd0M18mLPsQM9YprxnIgJ3MoJQ9oS04COYJGJVHs56T
         W7NBO7mXoIfbkNGdRLTLtBd2tY00DxFPMEnDy0OSJRX9eBogYTLMTaayWG3atRg/CNpV
         Gwos1by9wL4f6CSs7xtxk2lmnbn1L7lgUsqom7pOUDCQR6Zzxaz/wKO+32fA4PD3hUyq
         dTQ5hBreVRr/cbFVuEBHmqxijAKjZtKhf2LoALQ9yGg6HCMMNYloO9vBzHfFY70ZfZ7U
         72KWc5Dv5x0vHESFbQjxeKysSKpYJvTv8jA+zuoYkNLb8UXitRQMzMNO1lM1qr1M5TpM
         pxhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dd7763LZWG48vYgb2048I0cZQ6AvUime8DR/exqEMsY=;
        fh=JdSN4vuoy7nkfSTthzONHaJTgmmVYWsF2hT33hvXxcI=;
        b=MfA7TUm571ThBLFwM9yYmmoqLGfxr+jCCpd+TUpX/5xG8w8OX7jjdyBnbo7Zfs5Urh
         eKRXhbtHyHd+TFQFIg4ybrsd3+GkFjk4wxeyBq+MpPsKdyPW1h0R+0XrdqhNQJgNu56f
         hhsM8o6gHhnT+9fdU1BckB//aznIpdW2KDQpDPdQBWHDI9hifMLuKvbFX9EJpvdYSb4n
         fsxKnQifUkTVA+DgLio7T3aTb5XofQlllCPMxr6t1JW6Mp1icD3ZVFRjj21axppEEf93
         bqqOMUzMgDngizjF4Md9IKscJNdJ6R1YSri4IGe7GslChV42a5NgTeM951Ectq5ZWNZ8
         5eBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792420430; x=1793025230; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dd7763LZWG48vYgb2048I0cZQ6AvUime8DR/exqEMsY=;
        b=Sj5fggapQS9TNHc2zKgz8HmWl5WcVSh9SnmukGnnYKmGjEVQlSpijJvwLGKrEk0iOP
         x2Mgalidcbj3TWWhAZkN2tsqhQvy4mC73HSyun6RnwOvZ4lF4deSswK92Ho/xLjL7lLd
         Ad9O3EB2s30xrD3iEtwmxd39IL2vuHKiRKWYRaGB3YCbpry5bSVGwVgOgD3M9II7hmtc
         ZV+Y5EkqKB/SJyx379yyjn+T3aNv7cBO4iHXHT/oxuorJEcd0I0ng1kjpR84umYONZ9v
         4L4cvrtNls4CQoiDSQRhd70UyBqas+JxyGj/2D8lpL+nkZsshPpL2ycZprj2SGjEewlV
         0A2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792420430; x=1793025230;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dd7763LZWG48vYgb2048I0cZQ6AvUime8DR/exqEMsY=;
        b=Hwbywx/tbeXIGu3rB3hV+k7JuNYREhcX4UzLYzz6NeUItadUSMh8OLjOsQ/Ui2MG40
         bv1ofZum+2lYh6U7DHk0tdwzvwtN6f8C/MDjAm5xUfJeBeKw0bgb3h81EHnoBic0sZ11
         BdMATKbGjmicOGCHTIn+sCQ76VqN6yiqSDl6fztnv1MufoN4G5MKuJLuF4kGRaGwHzs7
         822c2aASqJKsXa63TBkyPEte8ZVgMGcL9ORmX5bt5tV9S+FHKppA5rINhFTke12ddZEl
         hal554jSCipTVi+J6zFc9M3D3rkkeOrSD50MbQ24287+jmBENXaB+vCLIqOg7qBk8i46
         clIw==
X-Forwarded-Encrypted: i=1; AKwUvBx4cY95/7l51xBZDNUo2B5H//yDXy7t4bv8ctRKM208ectNpM3bdgpKI+OwYyesIqwUO888hhTEKHRlvpFbelZ9oEU9cx4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUTOzlpmW/DAT/SKv3qRJV5vfGmji1nQldWbCiEm5CF/bGY+fC
	8bOUP19+20LMlv4ff/TZ5C1BjsUmeLeajsK0dXtQyGsY7RH52OkHlSe40o7jkkdAzshrr+i28yw
	NzlwFB4PXkzKEuwLAn/dd8iuMDdX1rJw=
X-Gm-Gg: AYBFou3Jnvib2+BlkTHBq5LEiCmpG/3Hq10HWpE4d3NASNjxWtVqCviA4nEVdarC0fa
	NnLM57BjEHJL8vlP6ekV2OhGUH6PXgJZ11a8QSXup2SPPa/Qncr3FWQlmrU9oEbgiCYYckObx3P
	m0ngylpXq6sYR5mNLciO0sEdR8CZbUyZitWXC5mmL01jCeukxzoq0oxLX2PO+h9lEP3J+SV78VH
	GeaKqhcVlf3d48qGwNDAZtYOFNsosxIBH0LPjcdYEuu8GLZsX36FVHQOH5tAUjviogwMHYpax2R
	yCx1kLlF7niMjWSf+P9onTEEZgYbYpcVfumF1ka9r+7maouH+P327zVI1UKFNlM0ex5bJvhXLxw
	mY/TD7JdS7A==
X-Received: by 2002:a17:907:3e15:b0:c41:4c20:5a80 with SMTP id
 a640c23a62f3a-c41a0bd5bc4mr588936366b.44.1792420429899; Mon, 19 Oct 2026
 07:33:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-key-management-objects-candidate-0002-v3-2baa8cad2bb554364e10@gmail.com>
 <20261017035156.GA29318@sol> <CAFRLqsWcV=0MKituMQqALy_2rS3kOPPFpMHxn7yRxoyxOHp6hg@mail.gmail.com>
 <atOiKzlHKH47SMNt@kernel.org> <atOi7jWhglgRZ0C4@kernel.org>
In-Reply-To: <atOi7jWhglgRZ0C4@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 19 Oct 2026 22:33:36 +0800
X-Gm-Features: AclHuK9OlBsEmWtkP_XTvi9GQcsF_fx5BP_zryLibZN9CiuCkz2in8tqjXVdgK4
Message-ID: <CAFRLqsWxNHz0xngwMaCbnkifRs=e3NTeGmvvTEmCRSLn4YeQhQ@mail.gmail.com>
Subject: Re: [PATCH v2] keys: Avoid the owner account dereference in named
 keyring lookup
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, dhowells@redhat.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, sergeh@kernel.org, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8818=E6=
=97=A5=E5=91=A8=E6=97=A5 00:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Oct 17, 2026 at 07:28:31PM +0300, Jarkko Sakkinen wrote:
> > On Sat, Oct 17, 2026 at 03:47:32PM +0800, Cen Zhang wrote:
> > > Hi Eric,
> > >
> > > Eric Biggers <ebiggers@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=881=
7=E6=97=A5=E5=91=A8=E5=85=AD 11:51=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > Don't key_serial_next() and find_ge_key() (used when reading from
> > > > /proc/keys) have the same bug?
> > > >
> > > > - Eric
> > >
> > > Thansk a lot for the reivew. You're right =E2=80=94 key_serial_next()=
 and
> > > find_ge_key() have
> > > the same issue.
> > >
> > > I'll send a follow-up patch to fix those as well.
> > >
> > > Thanks for the catch again.
> > >
> > > Best regards,
> > > Cen Zhang
> >
> > Yeah, please do.
> >
> > You put so much effort to scenario and you are nailing the bug
> > that way, and I do appreciate that, so here's what you should do
> > with the commit messages:
> >
> > 1. Do the first half like you always do. That's great. And I've
> >    also said that.
> > 2. Think just a moment. If you get anxiety from that something
> >    that should be mentioned e.g., something that you did not get
> >    immediately yourself at first, write remarks those down. I'm
> >    100% sure you know when it might be good tip on something
> >    non-obvious.
> > 3. Send that. If we feel it is lacking some info needed, let's
> >    iterate that. It's not a big deal.
> >
> > I'm just underlining this because so little would have to be
> > improved to make this right :-)
>
> And also: I would not complain about anything if I did not want
> you to send patches because it does not make sense to waste time
> like that. So take it this from that angle. And they bring value
> thanks to well described scenarios.
>
> Br, Jarkko

Thanks for taking the time to explain this, and for the encouragement.
This helps me a lot.
I'll keep the scenario descriptions and pay more attention to
explaining the non-obvious parts.
I really appreciate your patience and guidance.

Best regards,
Cen Zhang
