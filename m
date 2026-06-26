Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483EC2E7372
	for <linux-security-module@vger.kernel.org>; Fri, 26 Jun 2026 01:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782438296; cv=pass; b=EEugT6gvDRump7Yt8xVIfkEX0szKDk0IZNz0gLRWnU65jpweCz7XNyktQxxexKsFIsb5iR7oS17uKwDPbWBAVvOynQREXlf2fCu6cdAUIp+2NESOdAX44lEO2M/7+WRsrOAKoNVEBSrLJvTyK254Jmclz8PyTK7a7Yl+AkAaIxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782438296; c=relaxed/simple;
	bh=KT/h4RvNkwV6td0Y1CASCpzX7ZKOJHSgx1w9JAbNaj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBo9c7NM9RgMJEL3tAzLKPCa5wiGJjZin/sV68xOhl8NXGjCPtfF8l9Kw7YLN/VnZ0F+qj3z1Tv8nyQaLwumutuK+OWh2nCm4l/NeimTneG9xgrItDLdb/DNhRK7A03gRSS/n4+yJBWYJuieCoi8rklXhM5dy4PhwVD4VJaiXFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdWLPp0V; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdWLPp0V"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c89636920a3so162494a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jun 2026 18:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782438294; cv=none;
        d=google.com; s=arc-20260327;
        b=ngkSefIPuOVVgOyGI03j4IJL805Kh3ifoe/vp6hxGJW0KpnmlDi0JiqDENnmD1SC71
         T8dT3k26KuM42T5CMleo6LP2XL/wMSMZX/T3JzGQPpXJkpSGUxThWNasC9btqX6zs6bu
         AZ8ee7xRzjkhSN5VJdHM02Uh0IJInLHRt+Wzad8qh/EH/ySclXSMfDjm1gGWVO1VxZ2z
         Tz2wbHRywCwBHXC19nfAzHH117cMjCxO8lN7ft12IHr9ElgkmU8WagjuMXqkcEOxlEUV
         4S6Vm7iDGvcar98bV+AfSZqgwYC+LwKOWsZyOOLNrUJ9Lhb6B3o/RUq+Lzadd55GBnux
         oTug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hk4S99SuHcZuOujtVnQ3HhN1Y/S42sKaVPyUJbXd+kk=;
        fh=LapepS0x45lgmlBksdee8ejoP/lFamUKn1jj5wvExKU=;
        b=SDbUlnLXrqA+39lqGfUC8KPBampb0qFPqw9lH1wS5+Dc9QZygx6szYCDi1RdzffoZZ
         a65ZOcYn4SJ2kAxR8y8h9Xya50uoO+6XfnHLglLj+gmupLo7NapAeyAtlGU5gQzod0eT
         j5upGMErvvrEtEu5NsiaZKLsrl90w4fkxayEJwYh58z1RH17MCFBArEBRUW+kBQpxIOb
         NdLEzuzwGpnwTs3cuQYwlx6CkqJyXPa6ekObnk+B81T06OQYXLZoHw9LNj9JWEcARHsE
         PZuXPtV/LK/XJ+Zhq2AZoGo3NdZzz18WQInqeyNCJFjtksc/2yhBx9IndxTDTSWLeGH7
         xNJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782438294; x=1783043094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hk4S99SuHcZuOujtVnQ3HhN1Y/S42sKaVPyUJbXd+kk=;
        b=OdWLPp0V8fubsDWOqDba1aKd2xqBkO3gqPUBD1gUqVFyMMPwq5qQETEZMVMzNUWM8J
         ka+Ofuv0kEEnzKh/ypgxywb+WrtVRL0t5h073/xk3IN45PUpDzgnYpLXtE38VZOBamY6
         S7vOFZOa6R9IkqFIkwrDlzlR18ladzFyknM1rBpXUG7jLJlsS872h7C1hQT2OwkyTijZ
         tJNI2gZLPBoWqzkiSMTH/6eR3k2ctX6d1B7n96jU5GIJrenLs1LJCJQLKj2xd+1mrP9i
         RQKINWBkdmb+/BwY/fe8BEqdKOqq5hZooz8W1KCJAVTnPmXVZNSK1r1abRLhHyMqFDiG
         JfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782438294; x=1783043094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hk4S99SuHcZuOujtVnQ3HhN1Y/S42sKaVPyUJbXd+kk=;
        b=mrHwkrR/Tp5zU9hWGeavxibz/QhNf5ZGvBEf0QvAshq1/ycdEJwUM3d/+m+jsOMjl+
         PPX3+Ani6h9VHOd8hEYImQhgDZcrFHAbURXpqb9Mnbnv9k7Y0DbYbh6dctdQCWvM+6jc
         8frzI8LHmsVuORh72nRFxg464BQJZyAYPIU7Avj4+32fSODGychS3btF0cRe8t6TqLhm
         XUn/UjuCdHJHJfrHb7I67MjnVX1o0rhnREVwc2WkAo/cWhZUa22MdC2UwtqYFqvz2eHb
         tkROOBVV8S5EaurgffK1sBRiBGWJYlCJ7moc9513SOOrO497vMhrRTZ2btY870o+f+gM
         qIIg==
X-Forwarded-Encrypted: i=1; AFNElJ/eKBmp5TcrxLSlYu29AR9kurzxTptHUUDwgM3lpJlTx2JbhYPklifPFteO/LsLXqA3D0BagFLtFBoRD3jk3b5DsHfxWlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8rJbhpQ6Fo8XYgG6soNG/jNCTK/zVlwVa9C8RcOk4Ig3jpjSM
	mSDquD8hEFyDcnVfqB8wgiqTjow622IdtcAkJTuLvVtreI2UkPyAo7Cjqi9ao/vu85//v6XG5b4
	cvGEumyM1NPa+nKjXXU7QiXtG4T6azVE=
X-Gm-Gg: AfdE7cmOCXituE3lhFoo3gVNQcpSOR7ruqXDRA86V6b/LlL2TyTcT8I4a2v27IYUPTv
	bxGM+1TSKjLDBs5iu4eW6/+IUAVc9aJvw6+l0trphQ9bLlhuTKlVNW5vXrIidxBLspMLkj8uEqa
	/oH+Lv+4n5fE0B9gVz5V9rpjvzYo0MGPHXzzW8Kn7LDyNxedP7XyPZ30j+IOZghadFAj+RRdS4M
	N2QiFGBrm7xB+1eo5Ayu4nZ1MJyefRMUZQwtX2YTbVWWXMLimLSUFENz1rH7aVjbatZWtVuQg59
	2+04LbT1J7UTSHbWXe4pf+OBIeQ0OaJEDOV1mgiX/b9L/86pBQrGhLdkshuoD63p9s9wVei5HMu
	vlqRv6TpJrF2x
X-Received: by 2002:a05:6a20:43ac:b0:39c:4af6:4309 with SMTP id
 adf61e73a8af0-3bd4ac6181fmr6501194637.12.1782438294463; Thu, 25 Jun 2026
 18:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624140301.93421-1-daniel@iogearbox.net> <20260624140301.93421-2-daniel@iogearbox.net>
 <CAHC9VhRar1x7kyjhgdmJ=Mfz4Msarv=wQ1821v723CaVdk1uTA@mail.gmail.com>
 <603d0f6f-bf02-48ec-af90-f16a239bad85@iogearbox.net> <CAHC9VhTF6_VaSm0uOjW1eV05CvsaaL+2jimVuPTXHeLGEQcMPg@mail.gmail.com>
 <c4dc3117-ad84-4c94-952a-cf0642cb42e7@iogearbox.net> <CAHC9VhRV9jW+dwNf7mW+1zTCsZ1xstBAugWL-TJ-DVNARdzC=Q@mail.gmail.com>
 <DJIL18C2F40B.39U9WHD43SDBR@gmail.com> <CAHC9VhQsjW0OJhKYUNEdkt_31oo56aMusDTANDOAQFNQwCpo4A@mail.gmail.com>
In-Reply-To: <CAHC9VhQsjW0OJhKYUNEdkt_31oo56aMusDTANDOAQFNQwCpo4A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Jun 2026 18:44:42 -0700
X-Gm-Features: AVVi8CePO7sLLsN4XpGKZsba-S-SCeCow-rJOQ2O5WodW2mERu7mursGgyYu-lk
Message-ID: <CAADnVQLdDZR+q66XgCgprPnikhE_Zf_LH3XTFh43u_ks62cWRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Verify signed loader metadata at
 load time
To: Paul Moore <paul@paul-moore.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 6:38=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Jun 25, 2026 at 9:16=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Thu Jun 25, 2026 at 5:59 PM PDT, Paul Moore wrote:
> > >
> > > For all the reasons I gave previously, I can't support moving the
> > > existing security_bpf_prog_load() hook at this point in time.
> >
> > Paul,
> > it's not up to you to approve or deny where security_bpf_prog_load()
> > is called within bpf subsystem as long as it doesn't affect behavior.
> > Daniel's patch doesn't change observable state from LSMs pov.
> > It merely moves the call from syscall.c to verifier.c.
>
> Alexei,
> It is my responsibility to speak up and voice my opinion about LSM
> hook placement; arguably that is one of the LSM maintainer's larger
> responsibilities.  Non-trivial work, including several allocations
> (which can be quite large in some cases), occurs between the current
> placement of security_bpf_prog_load() and Daniel's proposed location.
> We must preserve the existing security_bpf_prog_load() call site.

I don't think you read the patch because you're saying nonsense.
