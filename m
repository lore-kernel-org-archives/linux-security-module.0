Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF7137927
	for <linux-security-module@vger.kernel.org>; Mon,  3 Jun 2024 22:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717453988; cv=none; b=MQP2ZBFvKWrg9Bwhgd2fibUNh9nMjs2zZNcKKxreDITiD/tocrRcKB8SiTS49CojzGvWaM4xdDSdb+8cm/W4x0VIzfgJCcUgFk1ahLfGAB6vqgpZ1PqN9GJi1U4xmR3+N5tFfmya7i6BSXJsb/5Kgx6mBZyCFlNVSfJvZww0cs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717453988; c=relaxed/simple;
	bh=TrBwn/d0GqpAZPrdLpc4RcvWvhLgItWxHDsohsEZ+mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDcQiQwryyiUD7cCZiMnGbM8ukdwCOIHVdaA1e9kQYgqsUxzYKKrIS0bFxndhfCpMLMc2Dt9SlYbIwtgJBvTDd11qP5yUVBx+aIPidOWpqmHpiXWezsQvIIB1V2VRVVBGWMpj/hkD5eFx8ucMUJbdeomuDzKUCYIffdbkStJPtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Cqk3uWBH; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Cqk3uWBH"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62a08099115so4601717b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 03 Jun 2024 15:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1717453986; x=1718058786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2SrD9AjsN7hWG3w/JbHlDonIw+G9fSsvP6AVFkewqI=;
        b=Cqk3uWBHO5xkcSR9OvfeaYwHFU2Nz+N7UgMH5n1qAYOO8wqBNB0VbfSGLRZJJYUgoI
         2kj+OERIQMbTonNExd7yXScSt3DqB0Oim6pjUuwW2rh4iO6fj9gMeL/RZSnhyi9Z2KOn
         l9D4mnqAjBmJE+VUOCEw2y59h3ca/CAkpZ04HbZ74+zpD6B+h73yC50iCvG+zCW/+ASA
         YlZSQbxCqeCd76xnNPFPIWlkWmnWjD9BVuoA7ykJtoyyP3SRpCoqYhkqri/C3z/Oupov
         lhbkpNki4YfemDE66lgUF3Que4IhTAvbkcwVevhfLkTU1/ItbT7bWO4m5U8U7QHusB2u
         M3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717453986; x=1718058786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2SrD9AjsN7hWG3w/JbHlDonIw+G9fSsvP6AVFkewqI=;
        b=Ao/G4XkaVGSnOTYm2FKt+W5ywYgm1DnvwbFSbwxRBQ0POr7do5zUyOj1921MWZDiJk
         Gm0pQv2xw6wYSNPkUgkptLdBEgu/sLdk6FfHFbyFZ46PmoZvgVkTzuBSDqJXXrWy4k18
         OqpVZrBSgVeRPsyRGX4yaWs+Bvm0MOLP/Fz0Ry3Vd/vTy7Hz6whqAmrSxTZuUPz9n5Cd
         zx0k1yQwHZ6/iQY+I+aTrKBJSrRcnbub6yeY8jfbG18jvzibqaX/p+jUy4tpRUNpz5sr
         Ya0S8DCLPuG/xclv+JXPcUp4sK9ew7chGgr+PF4z1KAW4W6s2vOZqhlBfdOkCCKL0Q+6
         n3nA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ9QbzxPlAlk2XnSthshnQzWMK8OkWcxbJUoBx2cBFXeLQBB46oubJCxJahsEruxfYVGz/kBuLmhz/fq5qzO2XwIzAvDrRjOnHqvpg3Y5vroD/pnAF
X-Gm-Message-State: AOJu0YxQcI32Fy7csV4UdC5RDWqAN/TcI/dMLPghd49vdPI/OBt2fjKj
	iEU44CsnssuzUC4COA2x02Gj9hZvgM28tz/TPwolQ6FXjV3/M/qWBM1HncdxiC9Mlcwh+P3yZgs
	zCXY3JDeesEJlLCkr6G5nNGoMpSd+b/gkhN2UwIKM6cdpYPHcNw==
X-Google-Smtp-Source: AGHT+IEoFZngLQNS1XtJnekiPwFn2p+z+HRz+Ler08TZyqvLEc0Sw3TmueJSUNY7Se/9laGlczTR31R2relv4GZbMUQ=
X-Received: by 2002:a0d:c884:0:b0:61b:3402:805f with SMTP id
 00721157ae682-62c79626ca6mr107691097b3.10.1717453985979; Mon, 03 Jun 2024
 15:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005850.466144-2-paul@paul-moore.com> <06dc0e21-f44b-48c0-8552-9840147facfc@schaufler-ca.com>
 <CAHC9VhQUW42aicyiMAVaSEsCR-G8E+uVZJVCXodDv8obC3V0VA@mail.gmail.com>
 <18c63d96-d574-4ce2-8fd3-7755d2da6c74@schaufler-ca.com> <CAHC9VhQcUrxxejcJP9m5SwyN8D=Y0rOiF7=w6SQR4=fF=nBNDw@mail.gmail.com>
 <CAHC9VhRdwgorXdBt7jUuQ7tLNbtCggGrbrhxw-Um7aCmk0JgmQ@mail.gmail.com> <CAHC9VhQUi8vo+gZ0OXYXGSbLpuSaCaNx+7CzXw0eAJyQ48X80w@mail.gmail.com>
In-Reply-To: <CAHC9VhQUi8vo+gZ0OXYXGSbLpuSaCaNx+7CzXw0eAJyQ48X80w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 3 Jun 2024 18:32:55 -0400
Message-ID: <CAHC9VhRQBpOPEwKec7K9hdsbZ3RZbj51yy5YuyjGfQQNLjb7RQ@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: fixup the inode xattr capability handling
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, Felix Fu <fuzhen5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 3:17=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Mon, May 6, 2024 at 4:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > On Fri, May 3, 2024 at 12:26=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > I also need to track down the appropriate commits for the 'Fixes:'
> > > tag(s); I'm not entirely convinced that some of the other patches wer=
e
> > > targeting the proper commit ...
> >
> > Looking at this again, I'm not sure we can easily narrow this down to
> > one or two commits as the current flawed situation is really the
> > result of a lot of things.  If I had to pick two may be the addition
> > of the BPF LSM and the introduction of the LSM hook macros?  I think
> > this patch may just get a stable tag without an explicit set of
> > 'Fixes', which should be okay.
>
> I merged this patch, with Casey's ACK and a stable tag, into
> lsm/dev-staging.  Assuming no issues are uncovered during testing, or
> mentioned on-list, I'll plan to merge this into lsm/dev after the
> upcoming merge window closes; I'll send another note when that
> happens.

Quick update to let everyone know that I've just merged this into lsm/dev.

--=20
paul-moore.com
