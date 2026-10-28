Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793214240;
	b=oNB+bCNUiHDt0Pp0GRVCoI4MloIkUArsEuMMr2TRhf79jojnNdR4umdDL87/scZczzj2
	 U/DcV/nYZm6M5Ahrh3gsgXU7oy/whJHGhojUTben0o+DT33eb/Vcw0WWsPH1ihs07A5zJ
	 f+ZZoELOWcj/r9RcBBPCqY5W20Bzp2x6bKbUlgymMHSOPJOtfRbtKBg7tTI0iG2k0JGNQ
	 ZIL7/wRt2iEEigfK2AryPCeZOAWQkye+7BkVcQFfkkmhXdatglGNiMuhFw0HtnWCvEcU9
	 uCkLK1oBnlkki4uZN3zS7h07hpBg/IAvuGWaU3jdgu6XsU4h9EAcbqdR+YoG16o1EeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=gYV5Bfizpq8kTLjJP5sooyUCJxWfa7okNcqH8MZz4LM=;
	b=1zp3GjvvkfryM9bufO1wHiNUvQDb2vLKJt8Rg13dkrmGwSEWt47ZkQejkhrfsIOXCVCE
	 SHRpt1/QjrKZaWAYL3u6b8MXNI98ZbTrNHTRNwhB2UVD+dQoBHMR9gzeHCSuqKEzoQZVO
	 NZ0QS4Y0US1vEYIdAsq9NfpeE1/HH1sPKF+YD6NqttgS6GeMgc3zInFHeSf+pGHhDBJR3
	 NDrlzlvG2+oTbhWZ+HJAXB+RXjjLBn+Ikracmy9BEJ8/3GHig8YlrvX8VmezKOSZkdvoh
	 yWKQGogpt8jMbPNoxYPg8v5UoCf13s15pcQqMjUkMQj0geXf6srQUtUZcQIXn+GgXxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PmTJlIj9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAE360A262C
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 19:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FAE360A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PmTJlIj9
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8ab3d3c5761so12926797b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 12:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793214239; cv=none;
        d=google.com; s=arc-20260327;
        b=Ai5dPjMhQrSlQNe/EnMXQyKY7sTEZDviScGdjftD6s6JOG4s8AoyWJdXL8daNMsgQv
         hqoWAJ3GZN14xPqKNl2YUI+9MMxK2l6QVgYQsVFv5w5go/aLnOzK5769NsXF6wsgvm+P
         +EDTiydb9dk94N/5AOsYQ0hEJMfPLYUeog6sMYQlgsRGWRvGLDqUtGDnSKAiimvyVn5S
         GsYHcKsUsNav6oPhvd3cl0NuuMzmHcvr2/uXinzl+hoFX41ZK5lMCoW6LzE8C/YmLwXh
         rUuTBSgAIoO+C9GjoWAm45zMtjMplEM49nvVChv/dE+ZvwsuhBK9JGNsjStWP0TnHwTV
         vL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gYV5Bfizpq8kTLjJP5sooyUCJxWfa7okNcqH8MZz4LM=;
        fh=DejPGiHrVtanWSax6WeNuYvz0okHkg028ClAwW9PAQs=;
        b=jg+/ivNu/BCsIGeRVy7+UQIJSWz70a4agWA4m3WTAeTt+D8iuoXWSPYm34ka0XFMY7
         dTBRiYo7tx1WsbAf1gaq4c8qaJkGgV4TndoXWLB7ng5K4RyYEKWh2JmsQThmWItmpHfC
         McvA3u9KA6/HkonNogRF3n7jRge3F3k5lsBi7hUpbr//xPwJGb2s7nuLSTFZYBeb5xtf
         ADNdPzpFm3v8VjG25h35cAbdS5BAXqC4BnnkzG44okc5oHLOlHEw/S5TSh/3rfMfZuuy
         JTdYutvCbs8YsdUtFIRAtqNr9iWYjbJ7tJxCnZtYZ/+mmqAR7CjUlBTf/1qykrwsiLu5
         9rkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793214239; x=1793819039; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gYV5Bfizpq8kTLjJP5sooyUCJxWfa7okNcqH8MZz4LM=;
        b=PmTJlIj9BJE+hyWdYFmRhJ+3tw2R4WUGUDZVYILng+0oxJHUDaC9pvgOJiP+/g/GVW
         Jhv3CgGsVhdXnLp5zNe69oj87R+yWv+rh7zb7Y7JFFlsmzoaHUUcLELpNaSyTSWM+RM1
         CxOE7zT308P9cR7jJhSUPhFXrtf9VRYI1qzSrK8Erdbw1plM+UylP/yPlUnQ/iwNiDPS
         tMxkJB02aqb3L0+NIqZEMzTz4uh1g00BKOmZvi2KbGuZzsEFaRK9qrK1oyiJ6zvi/pV0
         qfRo9mnyvnaWsLQh5HGoviBGccm9j1jWwaedGCLja2JC/qO7HIz9SDEH6U+Fnwg/+d7+
         lscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214239; x=1793819039;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gYV5Bfizpq8kTLjJP5sooyUCJxWfa7okNcqH8MZz4LM=;
        b=Ioiyl4E5Rc+WSWLkIgL6PcaIttoWRG9U/eY4CpLbSbvz6BItLbwrTXk6Z7FI2iV4FY
         57R5NpbWbYQLeJxFMgI+jVeHVLRgzGCitQpD98yoL5+TJH0Z+30K4ySuTYNGHcm9G2WS
         /jMXsijxMo4mCCHz/OhMM2mcrdbwQKzjv5MyrZtcRz3jbCCaLLW8mHKNF8qi2ThfIg/7
         4ufz59Qdzs7EhRcjsuLwfzpIuR42G8XEsNMbuxVTtjd3nRNLpOfQ/4zxqqqIiPTpDKAS
         fORirb0fCy+4rTbd41Z2UM/gEA6+z2qvcXsTNt62PbqUatP44BIQe6ai5Mfz9tmIM+Io
         KyDA==
X-Forwarded-Encrypted: i=1; AKwUvBzcK8bWZlA35zpn6tNiqixT1ZB3cSaPOeijwCziomrTdXJkLn/fH9y0JTerijWJtg580CN3Kyyh6IupqrLW89Y+dPj6WHw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfMGiKOdl0KySm0JANNEsc6JbbOPwzA8tyok5fDpJGRWEYUosi
	ObHvZIKG765owGSOmXPn1VqhC8GU/Fa9oWIM3K1VEB0nJ61gCxPieFRZDfK/rpI0CLKf/Fbew2V
	R1E0d98zZX6TpCf259v4xrMbr8GgtMm8=
X-Gm-Gg: AYBFou2a+/yk2GLLfTK2gldhIIlQb06ebJVJmREonf4oehLBRQFcD/DOtlCF9lRxpz1
	+wh9AJof1qZVpvm64Ygx76T/0rkWs5Ed98uYFP+E9gW2i6zjgd3/zfVVqJcOdKxAofmB9qVaHvk
	RhfdWh5mxkLlkT11cRlW+Kdb3iOwjXyvNmrUoW6twJU21Ghxe85Q2ZouE2SHk4k90bkUAhTDd6r
	qAzO18XQM7oKQ4M1PSuiZFfoA7ykU7HqFq6ndbF1wT3TCzUjBgwr82OMjCoH3AV7G6ECkSlAqoY
	p+ODRJDVbQrdIiiEEC5vROhcwsgHgd2TEbL5sn+Q0nO5AJNxiqe2VDIbVjPlG3csGAcWv3hcLM7
	Ay7NhJ6e94ZqEmXQDGdc9voHZnWEKSu0RpwEgMkj9XJ9m5naxb1xOjxG8O/UxoEP2GDLYk2c=
X-Received: by 2002:a05:690c:dd4:b0:8b1:60a1:cd3b with SMTP id
 00721157ae682-8b1b5c17da0mr25103967b3.24.1793214239135; Wed, 28 Oct 2026
 12:03:59 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
 <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org> <20261021-groll-donnerstag-erfuhren-ce34a0ed4e97@brauner>
 <CAHC9VhTHUU0h9k74CMT6wYhMwyY3YhbSSFwJoDTvoFRyTFVZwg@mail.gmail.com>
 <20261022-hausbank-dozent-hurtig-9443f3777475@brauner> <CAHC9VhQ4sdCRvJ+YPZoiQzR_hgQN6-=84qvnTDDGPf=7=L9-jA@mail.gmail.com>
 <5143896100674c9fd744c4d7d6ce12232910e789.camel@gmail.com>
 <CAMw=ZnR54hMBwGTps23t9Mm_VO1bAvmeX8uTf_VJ0rJsFNMLuw@mail.gmail.com>
 <37b653494cf282c6e428e2ae8fd781a0ea69bf3f.camel@HansenPartnership.com>
 <CAMw=ZnQU0PRSn5gh-QNT+GuKroQaRsRUUMDB=rM=LSX+=h-JkQ@mail.gmail.com> <ac7d9af1336f86baf2dfbe417944298a3ff6edbb.camel@HansenPartnership.com>
In-Reply-To: <ac7d9af1336f86baf2dfbe417944298a3ff6edbb.camel@HansenPartnership.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Wed, 28 Oct 2026 19:03:47 +0000
X-Gm-Features: AclHuK_dsl-iiTAA_RkgI0lW_me3PKlvDAD9Xjk5WqhnflULesXoa7TLNE1dmyA
Message-ID: <CAMw=ZnQA8nZnF-khYkKfY9L4dtB2hmmbzHyKQrf_Vf1scVNM8A@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Paul Moore <paul@paul-moore.com>, Christian Brauner <brauner@kernel.org>, Fan Wu <wufan@kernel.org>, 
	Manuel Huber <manuelh@nvidia.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Andrew Halaney <andrew@amutable.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Oct 2026 at 16:14, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Wed, 2026-10-28 at 14:26 +0000, Luca Boccassi wrote:
> > On Wed, 28 Oct 2026 at 12:42, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Tue, 2026-10-27 at 11:07 +0000, Luca Boccassi wrote:
> > > > On Mon, 26 Oct 2026 at 12:57, <luca.boccassi@gmail.com> wrote:
> > > > > I think there is one issue with the design pattern where
> > > > > keyrings are set up in userspace, that I have mentioned a few
> > > > > times already and I got documented in
> > > > > https://www.freedesktop.org/software/systemd/man/latest/systemd-system.conf.html#RestrictFileSystemAccess=
> > > > > as well: they are trivially bypassable if the kernel has kexec
> > > > > enabled and it is signed. The security model relies on the
> > > > > "good" userspace running first, but if kexec is enabled,
> > > > > there's no guarantee that will be the case, and as far as I can
> > > > > tell it gives root trivial capability of overriding it and
> > > > > extending the trust chain as the attacker wishes.
> > >
> > > The attack sounds doable, but it also seems to be exploiting a gap
> > > in kexec policy: kexec is supposed to behave like a warm reboot so
> > > if boot policy requires UKI only then so should kexec and that
> > > sounds like the thing that should be fixed.
> >
> > I don't think that's the case though, even before KHO/LUO existed,
> > kexec has never really behaved like a warm reboot, as for example
> > boot services do not run again, so various chains of trusts are not
> > reset  (eg: a bootloader might now be blocked so warm reboot would
> > not work, but kexec would). And since KHO now exists, the difference
> > is even greater, as more and more state is retained across the
> > boundary.
>
> But still, a lot of people are using it for servicing reboots so it
> does sound as if it needs policy control.

And what policy would that be, given there are dozens of different
ways to boot a system, each with their own particular methods of
establishing trust? Even the most common one (UKI) was tried several
times over the years to be tied into kexec, but to the best of my
knowledge nothing was ever actually merged, as in practice it's really
difficult to do, there are dozens of ways of doing it and no apparent
agreement on which way to go, and so on and so forth.

> > > What's the mechanism boot uses to ensure UKI only? So we can see if
> > > it can be adopted to kexec.
> >
> > There isn't one, and I don't think there is correlation, as booting a
> > UKI is not the only way to boot a system. Eg: this problem applies
> > just as well to booting an arm system on uboot. So I really would not
> > tie this to UKI or UEFI specifics, it's more generic.
>
> Well here's the problem: I agree root could kexec to their own initrd,
> but it looks like they could also properly install and reboot to it, so
> it doesn't make that much sense to plug one hole without the other (and
> when they both get plugged it does make sense to use a similar
> mechanism).

That depends on the firmware and bootloaders involved. It is true in
some cases, but not in others (again, setups using uboot for example),
and in the latter cases the hole exists only at kexec time.
