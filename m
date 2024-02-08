Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335FC14F68
	for <linux-security-module@vger.kernel.org>; Thu,  8 Feb 2024 00:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707353848; cv=none; b=S41BhX6EwoGSwGPX8OOISE1rTbsmJKthcaSJ9emaI1CHFIxLFcNbfa2mQkZ9NL5vXaTJqRcd18GtgLI3tI8YRrB342m3Aqyg1dyWe87+7J9sM97H3fBhKkp049b+dCdna8rLkB8fwyhvhX6ddU46LCGcbAwa+rWQxWA6ZnvJ9hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707353848; c=relaxed/simple;
	bh=5rzBR40j85GN64DttI9QF8dovqFWnPsmrhGZ4XP4f5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhcM7t1t+IovM+PiUm2LuvGNEVxVZ3iyq5hoib2+eftZqBTFBo3pET4GCYwVoFHTR8jYY+bQCLiG6He0DAB76I8E8Fl0+r1zxKRKlZSl4iKguVTrl4bKxOYf58nCp4SCwVRiPqBT4D9Y/SosN1FMZIEEYcJMcdukZjG/02yOVtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HAffjzdj; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HAffjzdj"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60499a12ca0so10898077b3.2
        for <linux-security-module@vger.kernel.org>; Wed, 07 Feb 2024 16:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707353846; x=1707958646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YrEg2rNCoVlCXajfENN1lI3JlSqoiORMZh++WxQ9Oo=;
        b=HAffjzdjvRXMUQxwnkhHJWj4HHtMoKI73XvSowUhh6v6F+fhtZLZiJS15jB4pDgh07
         vG9rXwCGqjvTUaX+eoU2SY7GmmAvDs72UlZOuCBFaa5W3QDka1n8ja5R6nLoXdIWrZ71
         QYPeV2Zzcheer3aGixt2FWnCEqbMT3TP3e8XlITrVxx3O0bGVhOaz9u9BCLX0AcWMUet
         4AyPe7DYmN+J2A8inkuzUWWeyHghBB+isYOBEIZopRR0MexOtXIk8YKCmovK8/5kbE1I
         HGPGCv8wdZXjxqu/aBk2giWUsGfEAFnUkspnu0s7lrSF9NQGR5NrS7kBGrcEDJrwN8+K
         dm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707353846; x=1707958646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YrEg2rNCoVlCXajfENN1lI3JlSqoiORMZh++WxQ9Oo=;
        b=aud7SMRI4K3rHAxIx3aSeVtT47k438olqPCane/1ff9e9rNT3Pl01D7BxpVzmMcnvo
         ChEpFoyFO64VMgDnyAWiMZBWH744/+UV0IpRdGFS4k4CfQvhaTwukZVE1rm+Kt5M9PUd
         jJMyIED2TZKVY1GN+evY7nRfzwJDzq7S9/oYC+LZ2Uow3C6tiGMOMzjryhwh87QrC5Jf
         zUJPeUWbByQn0DD97CQNxWaUa7Qd+9CtMhU4lcfbGEqweuAnM1dIbBVJKWtujWIcbYsf
         g2Bb7oGh80Hb5clN/W0Wn+W54DTKn3C5Cu0JaNsbbWyvuu+M5g/s8JHFoUWrDPZKMEGt
         dOjA==
X-Forwarded-Encrypted: i=1; AJvYcCXDBGMST1UN0H0OTIQt67j1jsWLWDoxGrwNMjNMWj9rLZPXOSFkd+Tu6tGsKAG042+97ofSg7EdefWUvt3FXOjmip9ifOgvJO2/vFg9C8sOCC/UR8LO
X-Gm-Message-State: AOJu0YwihVF6f1JlhfHGmvMjmAFf/wbCNg1hNH97HIaVeyPozOPLWx8S
	jTaqS8BpXSleAvuGDNaGjrV8xHTH0r44PBVicdfs8/ZuxUZzs/4bfTjMFvgPCGfYvvI1y6VNRdU
	FJmdrryP4AmEaqObLXcuMVnlBBdZ+IOYpVa6X
X-Google-Smtp-Source: AGHT+IFmH+dP6BAf5+6H4fHAw8GKxdIg12Zbn50hUBo89UP0SMhSBXIOobLXRDQ+0CKVwqEmJEFEnJm0Mkg18dfZeKA=
X-Received: by 2002:a25:c513:0:b0:dc6:d7cc:8a97 with SMTP id
 v19-20020a25c513000000b00dc6d7cc8a97mr6765016ybe.3.1707353846137; Wed, 07 Feb
 2024 16:57:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
 <999a4733-c554-43ca-a6e9-998c939fbeb8@I-love.SAKURA.ne.jp>
 <202402070622.D2DCD9C4@keescook> <CAHC9VhTJ85d6jBFBMYUoA4CrYgb6i9yHDC_tFce9ACKi7UTa6Q@mail.gmail.com>
 <202402070740.CFE981A4@keescook> <CAHC9VhT+eORkacqafT_5KWSgkRS-QLz89a2LEVJHvi7z7ts0MQ@mail.gmail.com>
 <CAHk-=whSMoFWCw=p1Nyu5DJ2hP2k=dYmPp-WjeY8xuc7O=ts7g@mail.gmail.com> <824bbb77-588b-4b64-b0cd-85519c16a3fb@I-love.SAKURA.ne.jp>
In-Reply-To: <824bbb77-588b-4b64-b0cd-85519c16a3fb@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Feb 2024 19:57:15 -0500
Message-ID: <CAHC9VhSaHMoNaNpRQWD03Wa7mKRih0FXQkoCRA7Jt1b=KB-tQA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] LSM: add security_execve_abort() hook
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 5:23=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2024/02/08 2:57, Linus Torvalds wrote:
> > On Wed, 7 Feb 2024 at 16:45, Paul Moore <paul@paul-moore.com> wrote:
> >>
> >> Okay, let's get confirmation from Tetsuo on the current state of
> >> TOMOYO in Linus' tree.  If it is currently broken [..]
> >
> > As far as I understand, the current state is working, just the horrid
> > random flag.
>
> Yes, the current state is working.

Thanks for confirming that Tetsuo.

--=20
paul-moore.com
