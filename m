Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9B315535C
	for <linux-security-module@vger.kernel.org>; Fri,  3 May 2024 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753623; cv=none; b=JqSWySXKHj8eWMTIQETAfCS5TMrq0EciZDj775psDGXkSSxlxfojHeeqmXhhQfe4KEfa5e6Cw1pRjYUzh0IwqC0ZiabFikXbE1ZyBai0ScFQsjEI10LjYrykGqDT2XEe1ROizSWEqfKDlptLGS1axmXFmEf/89qE5nUwCm1PQ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753623; c=relaxed/simple;
	bh=SHDH9xrhc6Ced0XEhiew+Ce8jcBcildnUePGEjdQosQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egtrHNhM0R0emL+ResdpcbpbftMRFZ6XNuLiei0MC05D4WAcTx+3nZUnw9qb6LJl2IQ/5e5WON8IZMEJsteF2n0DT+woljfZSAdt548nC1RUGPD5gbwRf9qTIwxyL4c24pUrz+yORF9N2ad9NwN0jZprhU/nKb0j4i/j4xwh7Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ghWzqQcj; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ghWzqQcj"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-61e01d5ea74so30604117b3.2
        for <linux-security-module@vger.kernel.org>; Fri, 03 May 2024 09:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714753620; x=1715358420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNKY6mvbjnOkFxiD0Oxxob0RwimRuUPgxJbq729JMqs=;
        b=ghWzqQcjZft0CI/pkazDtAw3uboq8uG5dBLIs1HsJLt5xRfQYJsZO5ubNWfP0G4MlL
         gSLywG5TK5/8NWkuvltWRXSaWLyfHUtEP8lxZ+JPNnGAT+ECfkvtJ2CvsJUVkg+fDz6u
         7w0/mlzOA2D9xAd6sFRQTxIHRgjoJIL8omvnsjxlYwrU0n4t9Wni8faRHJt/XBAb6V8G
         MIvndtGDLqUHGKHdkAE281+PIinUc2ejaBO685p3pEyNHz0sUa4ucZBEfphvpAyQJU2M
         zM7Eky6dNCFJuabHq73OErPH23UoPYZHdP7V16wa/WN8Pw2mAhHLQMTcK2gP3ImBa9AE
         qtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714753620; x=1715358420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNKY6mvbjnOkFxiD0Oxxob0RwimRuUPgxJbq729JMqs=;
        b=HVAlzxONzEy7Vjhlu2nN0sHoHaYhJf2Cxive3RkPzyQA3WZVzOPpwkwnnlOineao/V
         PvWPz5ddAhVV7ZOab2xjKBic5fd8jYAX9h6onuivkwIrv3s7mYOy6zyvonDSHeobh9FZ
         VpRR1V4vWdfe6GMpBH1P/oNluG/8ti+XWmzKcnMBtlyfXO1c5OCfhs9ZwOmNk1EJIL0C
         VN2VTUxmUUcrLgGBAP5WX+QY9vn7LkNVaINSBZ9aB06VyUxfbZyeiTcf9bDqOLGBIgP2
         3hcydCU3WL6ZIT0ojq6Wwxg72rmTOkh5WL/f9FXjJ90h/oNH49ZaHyU2AUZYH9H4zzrA
         mt6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIFaj+gjm0hxhBoIprSIvVpTGfjxGHrk53c6mMq/Z09J01nbDs3Zn3ewT1jkJ4jeJi+aLXB832FNzDH5iBiTFbGc+Ldn0QzckC/b0V+XKySuEbFSK/
X-Gm-Message-State: AOJu0YxTVrhwu97dSe5/3B2OyT3RJ6FuhvSg81RHgqG6nIsJucdXgRlF
	CadekeNe2z0KfILATSJUOJYTBv/Dg1mL2oeQOt99zB68RmDtyfPvH64ks909iQG86X0FqUQsX5o
	DWTiEJ9PL2yKnEAnx9Y+yCs5fz4keZohPaDJc
X-Google-Smtp-Source: AGHT+IH3mmUPlCwa2GCJe/RXeSniZOWE+lKk8LAl6KQhA9wPyfQ3hs3QqkGPlei1mntzdCyiWJkZvICBu3ZLyxjVqJc=
X-Received: by 2002:a81:ac66:0:b0:61e:124c:e71f with SMTP id
 z38-20020a81ac66000000b0061e124ce71fmr2976644ywj.26.1714753620528; Fri, 03
 May 2024 09:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005850.466144-2-paul@paul-moore.com> <06dc0e21-f44b-48c0-8552-9840147facfc@schaufler-ca.com>
 <CAHC9VhQUW42aicyiMAVaSEsCR-G8E+uVZJVCXodDv8obC3V0VA@mail.gmail.com> <18c63d96-d574-4ce2-8fd3-7755d2da6c74@schaufler-ca.com>
In-Reply-To: <18c63d96-d574-4ce2-8fd3-7755d2da6c74@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 3 May 2024 12:26:49 -0400
Message-ID: <CAHC9VhQcUrxxejcJP9m5SwyN8D=Y0rOiF7=w6SQR4=fF=nBNDw@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: fixup the inode xattr capability handling
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, Felix Fu <fuzhen5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 11:51=E2=80=AFAM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 5/3/2024 8:36 AM, Paul Moore wrote:
> > On Fri, May 3, 2024 at 11:26=E2=80=AFAM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> >> On 5/2/2024 5:58 PM, Paul Moore wrote:
> >>> The current security_inode_setxattr() and security_inode_removexattr(=
)
> >>> hooks rely on individual LSMs to either call into the associated
> >>> capability hooks (cap_inode_setxattr() or cap_inode_removexattr()), o=
r
> >>> return a magic value of 1 to indicate that the LSM layer itself shoul=
d
> >>> perform the capability checks.  Unfortunately, with the default retur=
n
> >>> value for these LSM hooks being 0, an individual LSM hook returning a
> >>> 1 will cause the LSM hook processing to exit early, potentially
> >>> skipping a LSM.  Thankfully, with the exception of the BPF LSM, none
> >>> of the LSMs which currently register inode xattr hooks should end up
> >>> returning a value of 1, and in the BPF LSM case, with the BPF LSM hoo=
ks
> >>> executing last there should be no real harm in stopping processing of
> >>> the LSM hooks.  However, the reliance on the individual LSMs to eithe=
r
> >>> call the capability hooks themselves, or signal the LSM with a return
> >>> value of 1, is fragile and relies on a specific set of LSMs being
> >>> enabled.  This patch is an effort to resolve, or minimize, these
> >>> issues.
> >>>
> >>> Before we discuss the solution,
> >> https://lore.kernel.org/lkml/20231215221636.105680-1-casey@schaufler-c=
a.com/T/#mac61625dc1983d13ee5e8015fd22e1165381f079
> >>
> >> ... or am I missing something?
> > Yes, that patch, as well as some of the others that have been posted,
> > change the ordering of the access control checks, moving the LSM-based
> > checks ahead of the capability-based checks.  The patch I'm proposing
> > here not only preserves the current ordering, but it sticks with our
> > access control convention of DAC-before-LSM.
>
> Fair enough.

Are you okay with the patch otherwise?  It's too late for v6.9, but if
everyone is okay with this approach I'd like to merge this after the
v6.10 merge window closes.

I also need to track down the appropriate commits for the 'Fixes:'
tag(s); I'm not entirely convinced that some of the other patches were
targeting the proper commit ...

--=20
paul-moore.com
