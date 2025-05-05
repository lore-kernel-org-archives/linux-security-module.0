Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920052701DB
	for <linux-security-module@vger.kernel.org>; Mon,  5 May 2025 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746479101; cv=none; b=IKroKuMxfHxyFLke551qIKSxsb1yoHT8D0vbQOGOCrc30LYncU8jmkdk1/2cfNJk+zafnI4LHMmJ1/ZDJh/fJnhfGD5ldtynlfI2qM1CQunV0RBzuVz8tuyuP60Ot2jCu45oHkyAVKXuW6Glyv1aCal1NN81RGZVsulWuX8DFqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746479101; c=relaxed/simple;
	bh=pvJm4iJToWGX01vWFAWNiClNkhuZHWWKlI9oy7VPwrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0E4dXJcGEFeFnM64IqjO5kkRpQ/kSjEU7IIcCrm4mKbcc7d7DJsroJXGqIXjNGl+UgoOuaUO9kFrz7mrq1U6Yu4AG4lJ5FswVOHl4OPGUN4GlZvO7VKoKSPMGwZyrY0nFDaATFRXPZSXdM+wP7n0uaq+OMvwAJFiUoB4wtHBug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WhgsSo9J; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WhgsSo9J"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7086dcab64bso45796167b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 05 May 2025 14:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746479098; x=1747083898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qV6Ehr5flIzxPNkBJYbjhBPm/Nie/yPzlaQWxf1OGLY=;
        b=WhgsSo9JWV48EKUKRmgKeuu2vJsYMPLJ1pLf+ibrUGTWn2+WkRrraD+IuzYDCHdsgi
         TTDKbg3e0i/eTbdgI7l2QVK9n+kI6ObrZPtfmtNfL6qlZz7+41N8oEYLIPnbj2iALqTn
         Q/Cbc8qsYJ5YdcG1kADDtxqU59toKqXSim9JJDVAhrJ9jSOKR2EUyWklInE1QZftyxzS
         Xy5L+DZJtUBnNvNxpVf7D0wvIpluIpP8tW0iRyAtZ+KsLBR8uXQ38omd9fXF9QzLJJWM
         Jm0W5mbRYgTmCH2APZteUpOA4pIIyDAfPbaFAL4S+GSuat4CMUTYEnHGbaXEHzMdZXO3
         5wfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746479098; x=1747083898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qV6Ehr5flIzxPNkBJYbjhBPm/Nie/yPzlaQWxf1OGLY=;
        b=AZIme1yHOTO1RnftkCdS0fvfuFH86BU1Tc89h97FiVPGAIGpUqJhj4Nv67pCyckNCJ
         uOoDeSOXAKJqS2CKt/CL3YZROrxDllnuAI64XknVsrOPOOC6yuubumq/qqTK25Vk/5CA
         YJ04CReKkBG3yh8vVPsA+saWhpycnygQU5HX+DhlbDB5nWUVFjWL5JQgAAQANoG8CKAM
         YInC7zN6I30szjUWMDZ/KWjTWa7Vxkpwo+wXqb1EzaB0V70XBA+bXy+2ODhy/WC+P0RJ
         bP//3bVFaTG3CBOI5thZ4G1UClXccbSK5HIGUkhoezvSM3qX9iOvAv3c50gFxPFLf4eH
         QOSw==
X-Forwarded-Encrypted: i=1; AJvYcCW9SGRvu+3ItMvjTRMnm5PZnIPHwZr4Bl/gbpwHdeYXwYUo3fYMp3DzAqCrqeFNMYjBmRWTBWOZPbguRC6f5sAsjNhN0ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQiR8xz6PJ4g7z8vOXP2khOm9xWmJAMQWbkcOSbq+AQquCfKHE
	p+SL822vdDT8bm89FS1G7pMbrWiAM1jHYEzGDSro5q+JUfxOKXfv2nYpqpx7Eskti7YGZraMMz0
	b747+L8crK9Q4qJhpTLtP+2DB4RQJl0wPgfHF
X-Gm-Gg: ASbGnctfPD1ha5QzlV7JHDLDoW1OwS/EhfLzy7NuNoZ4Fj3TWFMc/zWTYp987MpTAno
	z8YCZy4uxWl/V2XKPHM4OWhEP9CF+n8HTZUbztcmxOqHQDBwAeE0REoRpjG8tJA7YUhvhGel5sl
	ELg63ciGQ6bfXnb/ZNYfP85Q==
X-Google-Smtp-Source: AGHT+IFmAkNEdgI8Usf/OOS6czpCIUfjzjMmDrrLFeB8TbVt16spO751vhSxBgmbdO5FhYFLhIwyiyfP8SeItQ5Z+90=
X-Received: by 2002:a05:690c:368b:b0:703:c3ed:1f61 with SMTP id
 00721157ae682-708eaeef043mr127166017b3.20.1746479098491; Mon, 05 May 2025
 14:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org> <87o6w7ge3o.fsf@microsoft.com> <CACYkzJ7Ur4kFaGZTDvcFJpn0ZwJ9V+=3ZefUURtkrQGfa68zLg@mail.gmail.com>
In-Reply-To: <CACYkzJ7Ur4kFaGZTDvcFJpn0ZwJ9V+=3ZefUURtkrQGfa68zLg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 5 May 2025 17:04:47 -0400
X-Gm-Features: ATxdqUH7QOdmAmbomuCBMV4FUrVw8a-HbJeWUtKQ1wX8nnex6ppuCCrqNPrIXY8
Message-ID: <CAHC9VhRwpvQQyMmFTeiQaos0+yJDkuCkt03QcYdnsxUvBXAtVA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
To: KP Singh <kpsingh@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, James.Bottomley@hansenpartnership.com, 
	bpf@vger.kernel.org, code@tyhicks.com, corbet@lwn.net, davem@davemloft.net, 
	dhowells@redhat.com, gnoack@google.com, herbert@gondor.apana.org.au, 
	jarkko@kernel.org, jmorris@namei.org, jstancek@redhat.com, 
	justinstitt@google.com, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org, 
	llvm@lists.linux.dev, masahiroy@kernel.org, mic@digikod.net, morbo@google.com, 
	nathan@kernel.org, neal@gompa.dev, nick.desaulniers+lkml@gmail.com, 
	nicolas@fjasle.eu, nkapron@google.com, roberto.sassu@huawei.com, 
	serge@hallyn.com, shuah@kernel.org, teknoraver@meta.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 4:41=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
> On Mon, May 5, 2025 at 7:30=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
> >
> > KP Singh <kpsingh@kernel.org> writes:
> >
> > [...]
> >
> > > Now if you really care about the use-case and want to work with the m=
aintainers
> > > and implement signing for the community, here's how we think it shoul=
d be done:
> > >
> > > * The core signing logic and the tooling stays in BPF, something that=
 the users
> > >   are already using. No new tooling.
> > > * The policy decision on the effect of signing can be built into vari=
ous
> > >   existing LSMs. I don't think we need a new LSM for it.
> > > * A simple UAPI (emphasis on UAPI!) change to union bpf_attr in uapi/=
bpf.h in
> > >   the BPF_PROG_LOAD command:
> > >
> > > __aligned_u64 signature;
> > > __u32 signature_size;
> >
> > I think having some actual details on the various parties' requirements
> > here would be helpful. KP, I do look forward to seeing your design;
> > however, having code signing proposals where the capabilities are
> > dictated from above and any dissent is dismissed as "you're doing it
> > wrong" isn't going to be helpful to anyone that needs to use this in
> > practice.
>
> Please don't misrepresent the facts ...

KP, I believe the most constructive thing at this point is to share
your design idea with this thread as previously requested so everyone
can review it.  We can continue to argue about how we got to where we
are at if you like, but that isn't likely to help us move towards a
solution.  If you are unable to share your design idea, either in a
couple of paragraphs or in some form of PoC, please let us know.

--=20
paul-moore.com
