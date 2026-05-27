Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ECF3803D9
	for <linux-security-module@vger.kernel.org>; Wed, 27 May 2026 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897969; cv=pass; b=Cc5sk8NKZw9Z5QzhUSBh4sSRJ+1YfOlW7fdW7YaILuzfJ1glYOaoD9NTG8nfUZm7LpJnJ+hncO6JNLO5rP/p9ZSw4afYSdNKnPVO3gAChHeGzyqfdy6Qg8tw6YLCmyV3gpgSuMaGIFKvio7Owhco21EHBY0KYZuKpT6MFPWVXjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897969; c=relaxed/simple;
	bh=i1icdQSbLVKb84W8T5OLxldeI4K9rAc4DdjpT+GW458=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9XngvPBAQ/uuvBIWTbwIObWH2Kq672ZjA/nEXjPYQ9BQFI3OcV8sTlli950oGcU/0BRNvBi+mf1asO5rRbjEzcGArdGUIxUXpNEzwHVpcDcwJVFvwmFphyh4Or5BacZlBsZLZnO/LQ9PXhNb6eaus1fVngaSy3aRGDDyUVBoDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLNhVbzy; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLNhVbzy"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65e15fb394bso8345597d50.2
        for <linux-security-module@vger.kernel.org>; Wed, 27 May 2026 09:06:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779897968; cv=none;
        d=google.com; s=arc-20240605;
        b=YwDOzvD8cDNyh2helOdMorYetY/JcdvE+ST8/BvBHbDyvCuT3PEGRHttTh974mA3rg
         S/dFo0uwfMfBZ86gmRPkKWq6IJPAXfUHkoXtMvSQwgg1FVz8GFtft9IvuEGQw8TTYGe+
         Br331RPZpPMQ0gY5M+yQ0Ur3TvbVPSYlDzDCS8bRbPaVrRtaMJlrWDIC2dsdGPiOoJp0
         AkOgJwhknZbCz6rCW+O2VnxtmHc57nFT3I6eeVex/27lQ9bUqQadBRj0RlrbWh7WZpnG
         Q6j50+Ich4YJcoRzMtmKQ6IpzFkz8YWPrbMaNR+qfNlnFedRhvPPL7HOSzUQPQ7ZsqTE
         3t+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MFz0JpS9h6a1QbnwdkkCkC2M7duzoq5zRNrxnxL5G8E=;
        fh=v3sFyMpNy+PUwMeVLu+TvApJNU8B6DaqrM8svjMxbfw=;
        b=WECMJGoEWdy4EhLPk0bidPhHYhi20m6rPNeqYHRvfHQOEBSi30/uG4UeLuuCRGrpN9
         60v+tIA6S9v8U+vIuYMrtLOB/dtbfMnMfHM2FSFqfmZnYAflFMmhvGVvYKvjBvW9obwM
         7xidTgcLPwACkwVfwbu26L0muBrcymOhQUNH4C3lAV3r5HsMhfPsyZ3xUfMW1b4/dbdY
         cOOw+0vV40WHmbYFHAuB07HJANzXNFWLr83LDEeZiTR6y7TGeB8MwsBd45MBzI8DusGT
         Wt1n3Nz51yNXT9kccnhdPSCtDJyX1PUi5Ye7v1+PF/W3ghqCfK1IHY8VDKSoCY6xFdlP
         E85w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779897968; x=1780502768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFz0JpS9h6a1QbnwdkkCkC2M7duzoq5zRNrxnxL5G8E=;
        b=GLNhVbzykXj1By6sKduBzX9bIuxZq5cstweJmApT0hJhUcQpJRvziX/u8gC443JLNB
         Pn+KEPB94oam3RA6eAdMdxdQNsmoxr84pxJaQaixP9gnNX1lIw16oChbRDrmZeWiLyUW
         Q688DPqK9kBgxpql0x+243bTUa8+kCRJvPC4liYwizU7hq4ywc/imzcZ1y93d2Mde7ah
         sz5q9ULQgWaxxyR+19TBo4mYqHrwYCGCfKJGHlo7K/WMCR/3Ow05mgv80a0sQi1AGcC+
         BXaLV9wHgtS5wvxehcsoA3c7Ce8H2I2x9OW83keOPYLBXVxMrGnVBvDlkNqqacZjfID7
         GUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779897968; x=1780502768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MFz0JpS9h6a1QbnwdkkCkC2M7duzoq5zRNrxnxL5G8E=;
        b=CyCD3+0phPSrE2lXeJS1v2oX41XFKnUzpxATeUrpzFZQVoBijFMYSxNDYV3QSzyAI3
         bOqoZHeV3H/j2SYh9W0qOxlR/0Pi+zRoZhmM3cmS7eGrYQVDslzrHa2wWFvI05tlI0Rp
         ss0CiqLtvoKPilN9Ft5IFva001PQEkl50hPrVxw9OGH2FxmEwYkBroaweLN95pGjYHmF
         elxP6YPxcDXsW+7cfcKH4lGSRFzE30QQAr020hsGnQcNOdBI6gLhRf77DRHssXoPZmbj
         G1enHX8Y+liRIbcJ89wg8G7BDKiAvUkmkX0IPNVpsO6pvYboxxjvLZNu6Q80nCmYrsem
         fWXg==
X-Gm-Message-State: AOJu0YyRKmpRcxkhqYgh8uRejb1WKoApLHY3y1zCAI7h5v3mv+gjhfoN
	yX+aG8hSiMwivNEy9u/+tRCkEAo6OSzwEGTrkt+K2pK/U65d3XketzzC/R1iS+77KFZBzM7uKGa
	9HbH3Y+0+c7laze4YzbWX/k+Yga77gV5XZ5yg
X-Gm-Gg: Acq92OEYbYvzFTnV6sDeLxaF87LjPN99Tm6WtOMuZovnCc3CNCBkSTH/aP7+amI8T4l
	ZQVkB6Kcd+W/f0WfEYEiS5K6cjEI6l0Up5nIzxroYHLmWZxZHjqHZMn/lig8qrw++S4XbdaHoRC
	Ja47eJp1MLBYgzGS07APVp83aJoYmUrgAFf87wzbS/XLF3JbnlqPaT5prwCBZf+7yzTVNZLzjVj
	J+okU9Gd2Bw3uUP+84jqFvQ6/ZLILEVe1UVGVYe0JmhXcV0Q9JPHprHgZ9zPbs3z51S8u099SyW
	+WpHoGlwbUin8G0OVg==
X-Received: by 2002:a05:690e:480d:b0:657:a0f4:ac1d with SMTP id
 956f58d0204a3-65ec95f0ae3mr18086212d50.12.1779897967362; Wed, 27 May 2026
 09:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFftDdrzV2xC7HBcgS8EPb-YewJyCK9uos4crXOCh5ONm6SxSg@mail.gmail.com>
 <CAFftDdqp8b5n21hdEP6w0-PK+CoG7mmQxgrnhpBLU7-1GZxniw@mail.gmail.com> <090a355d-3680-4113-a542-ff3b1c565f58@schaufler-ca.com>
In-Reply-To: <090a355d-3680-4113-a542-ff3b1c565f58@schaufler-ca.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 27 May 2026 11:05:56 -0500
X-Gm-Features: AVHnY4K9DobnEhOiqOKEKCFAfQjNn8RffoFCvgjm5aUjo7D7Cai83DC0JmhlLS8
Message-ID: <CAFftDdqvvqrbm=+XsDdkJHdm12jxK9799_A=Txz6Q5goYC2ALQ@mail.gmail.com>
Subject: Re: security_task_prctl: why -ENOSYS
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 6:42=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 5/26/2026 4:21 PM, William Roberts wrote:
> > On Tue, May 26, 2026 at 5:39=E2=80=AFPM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> >> Hello,
> >>
> >> I am trying to understand the motivation behind having
> >> security_task_prctl only continue if the return value is -ENOSYS. This
> >> seems to be very different from other LSM hooks I have investigated.
> >> For example, in other hooks, the value from SE Linux avc_has_perms is
> >> used directly. This essentially means that a 0 will cause the check to
> >> pass, and anything < 0 usually an error.
> >>
> >> In commit:
> >> ----
> >> commit d84f4f992cbd76e8f39c488cf0c5d123843923b1 ("CRED: Inaugurate COW
> >> credentials")
> >>
> >> (8) security_task_prctl() and cap_task_prctl().
> >>
> >>          security_task_prctl() has been modified to return -ENOSYS if =
it doesn't
> >>          want to handle a function, or otherwise return the return
> >> value directly
> >>          rather than through an argument.
> >>
> >>          Additionally, cap_task_prctl() now prepares a new set of
> >> credentials, even
> >>          if it doesn't end up using it.
> >> ----
> >>
> >> The check in kernel/sys.c is currently:
> >>         error =3D security_task_prctl(option, arg2, arg3, arg4, arg5);
> >>         if (error !=3D -ENOSYS)
> >>                 return error;
> >>
> >> Should this be something like, "error && error !=3D -ENOSYS"?
> >>
> >> I ask because I am looking to leverage this hook in SE Linux, and it's
> >> annoying to have to coerce all 0 returns to -ENOSYS.
> > Of course after hours of banging my head and one email sent, it's more =
clear to
> > me now WHY. This hook isn't meant for making yes or no decisions on an =
operation
> > but rather to also handle special prctl flags for an LSM in question.
> >
> > I guess with the said, do we want this interface to be used for both
> > a, let the lsm handle
> > this prctl flag directed to me, as well as a yes/no security decision
> > or do we want to split
> > this out into two hooks?
>
> The task_prctl hook is used in capability and yama. It is only used to
> provide a place to process LSM specific prctl options. It is not used to
> make security decisions outside of processing the LSM's options. If you
> want to make security decisions on general prctl options you will need
> a new hook.

Yeah I finally saw that after I sent the email, as always :-p, but thanks
Casey for confirming my understanding.

So now for naming... We have security_task_prctl for handling random
prctl interface calls into LSMs. So what should this hook be called?
Perhaps security_task_prctl_check? Should we rename the old hook to
something else?

For now, I will just pick a name, but suggestions are welcome.

As an aside, any lore as to why go through generic prctl vs an
LSM specific filesystem or an lsm specific prctl (we already
have arch_prctl why not lsm_prctl)?





>
> >
> >> Thanks,
> >> Bill
