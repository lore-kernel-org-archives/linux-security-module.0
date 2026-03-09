Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE9233EAEB
	for <linux-security-module@vger.kernel.org>; Mon,  9 Mar 2026 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773080167; cv=pass; b=WVV5hDK3HxlQfN3ymc4csbdqlZwoI0K8Ph59HDsHdEiD+COoohbwrvZgmWsOdrdaBS62ZpIaSLovNVBRMLPg9tXHCjgmwwF+2JYkR2jfzmB9bVjnlRb5U4MAM1ZHHrJ1FmhfpvB8hMFf+Mz52ANHrPk/HnU+IytoCCmdRAK4Q8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773080167; c=relaxed/simple;
	bh=biMW06izqHwC/weF6dlF7kNuElYeXGJotcHh9VHQtgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAYjbJlw9PxB3PxSZL6isUi8YyMTzjzK50SJYH2wltzlLoH1MeeDTLtlQdl8QhovnXEzdeCsFbVrYPWKMvEI8Jwd/Zfhru/0oe56B0Z/7lcvdi7dxPb7UJj+OAJBQ4k+3VcU9jdBjvX5ZWfM1GIDzqo0IBvV+kn7Hx6AzLg0kJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih6p8PbZ; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih6p8PbZ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a9296b3926so91868765ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 09 Mar 2026 11:16:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773080166; cv=none;
        d=google.com; s=arc-20240605;
        b=Kce2rUIAemsXwy1bRWGNIx+t14Zx/Kh22yWGrE9rgC/zRHFa/zOq2AHwowXDiPqxJ/
         7oaJJyv9+61gPu+sKiyUpk/6B0mT6LWBqG2xGHhzu8j0UJnmz3xvKKk701ds2PQrgZFJ
         E6Pkyub0khqNjDwIugrxx2LGvyO990gpz3uc+tcRcth5aE7ajvKPqz6hrXl4IDSoe+SO
         DideggNm2W4aWmyC7c1B9lMq1Rk9VxvuGGqthe0zRJgUk/PXdOEoKQKW5chJT/aEGKWC
         Ekyyc9+iNNMntniGUaJuJNBxT1bGeBYSEtfN/mRGdBfuNSpESgn6tlgGre9X5FGQD1Np
         I0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RsTb1dXByGvvHOMrPfAupkKkViEWmxwYD54CiX/bfHY=;
        fh=46UGOt+L5yCbgEGNmx/LHtLJfkMybOZGFSdwC+XRES4=;
        b=aZSDEImk5IKgSuCxrdypn5mfpGinLnhufu3fJzn/qEpRYvYBnEVXX6210ZL4meTSxM
         dEV/B113mddVM4zGYajoKAT5VbsLS1OxKpFFuBOTsx+Iw91HfNtpCx9B0CD81QgBIkXJ
         aYYrX/FRDdCta/aQzvxqkoXU9JxPWdqj5KvU9gqrcKWsgaGPKI2kb2sdI0TPPsSnfznp
         akQs/e/HvJ1Lk6QIeCNJXlYoCZQe9tuH3caWa21s7zKM6xXQaNOET+e0PBUVtAvWlZec
         6OQgeO7ROzpBPsbUIoYXGyzQOLWupGGLGQ9OdOnh8k4nC9glySSs5dR13zPG+WUxFFzN
         OEXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773080166; x=1773684966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsTb1dXByGvvHOMrPfAupkKkViEWmxwYD54CiX/bfHY=;
        b=ih6p8PbZULf3J/K+pLKPkiEfn6wGge0Dp3WQysJIJ6xHt8h8CXd/qVnFS+jMOt0LSM
         d4OBQ2PiT2FZsHCFOXQau+2tKsTJiRHhmvuwSGlsNUrumChZy5zrwxtB+WE41CSGG8XY
         By3wJesxy027IE0oI72lzSPG0f27Mev8+BRfzRYDJhJlUiBDeT36Zw5dn3Hvcd/QJFBy
         ePbkLky9Mxx8qGhdDB4zQjTfz7aGrxqGCatMlhP/Ncy+7OANoxK01lIvIEq8Ll7IPunz
         CLXLAtwfav+Nd2DCWTy2tf2yH3s80q+l1S8Rp+NM3WPtmdbPJkEwMTAM96t24mRgemR4
         c0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773080166; x=1773684966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RsTb1dXByGvvHOMrPfAupkKkViEWmxwYD54CiX/bfHY=;
        b=frYVGxMgKDqEjiRz0c6QkShUGclXWt01XOY08cf3eMln0tI/ELVjHM38bFpnw2vwpq
         Nt+ks7GwNrq4B5uPU8RcrtqOflV+PGgp2iVroGZsOqLsXbD51Wyf+ZnLAukIrdgXaBms
         +pSdgWVVMDuopGE7SMHmGZW1SDuICvOcMr1ZsgtGOHBLNUrADkQNbSSD0Py63tQeImbX
         NzJGQ854I2AUYtCktwBjaK8RzteQgtoF4EWwF154OoEcqDXF7efc1C8+RoU8FzX0qk01
         SS8sl7OREYU0AolwyVjgAKV6borh2ZGawHnvYPLYNJIeMkTPY0boadBA8g/6/mayUDra
         G1hg==
X-Forwarded-Encrypted: i=1; AJvYcCXlQtiAGEXD9BxQw4KU6uVJ4+Cit+rECUUDcuUNX+m2naLie43V2Y2ScSkJSimfaI08vlN0OfYIuqiogEhZ03iOliuTUQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAtHrH3mtaa9MvUOez6jk+wY8tJy2udEzYLeC98EIlpkcEBqZg
	Vwa6QGg+y8D3E0AbMkgTvtDnN3UK4abPRH1eGyguQe3DT52Hx/Hhsgp8J2RKKDct1ZL1zjU+noa
	h/3A1vdRXXJdTJPoZ00d2fAAYJvHw44U=
X-Gm-Gg: ATEYQzzS1rdBVywmJ+Ee3pwNm2ajhlmLLIgenjybWLtbLSVGf4A5OwawUYbv025L7lX
	dCgLlghpptI9BoVDzoaolNcAV/Xm7cuRjk5NRSJNLI2mfhEwJvT2xEXuRwl7ozY5e5t8nypU4FC
	hGYPSMydd28Q5ufwQjRaOx55PUqcfz5IDTPZGQOcY2UG2QX12nUuslfzyHpqzPabFUzwJFz7tmg
	lDPsyTTt83VY5+PUCgBSRJNijdk5Uw/J/bI753AHnUdzHC1HZVOGu9xtYScffxlTMN8xO2u+WOP
	3nkSYvw=
X-Received: by 2002:a17:902:cec4:b0:2ae:5275:4d52 with SMTP id
 d9443c01a7336-2ae8255cfe2mr123792365ad.53.1773080165933; Mon, 09 Mar 2026
 11:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com>
 <CAEjxPJ4urh7mUbDJEi-DbdiAifMM_uDH3m35tLeTdx6z+qhPyg@mail.gmail.com>
 <CAHC9VhTGruOPJ+NWZT8vw1bjXzkB4DSPFmWd1pC=J2jTYHP5BA@mail.gmail.com>
 <20260306174815.GA9953@wind.enjellic.com> <ae5e9c1b-d0cd-476b-87d2-70c0bc8ba09c@schaufler-ca.com>
In-Reply-To: <ae5e9c1b-d0cd-476b-87d2-70c0bc8ba09c@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 9 Mar 2026 14:15:54 -0400
X-Gm-Features: AaiRm52n-DeisXreA1xmhL7j8kFFiI-ZDWYWVOQBkYYMQj742vSU-nsyvi7JKCI
Message-ID: <CAEjxPJ7yuJ6sAZ-ViqT04M5WPC9O39m5UUGw2f3+GDR87tvbsA@mail.gmail.com>
Subject: Re: LSM namespacing API
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "Dr. Greg" <greg@enjellic.com>, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 4:01=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> On 3/6/2026 9:48 AM, Dr. Greg wrote:
> > On Tue, Mar 03, 2026 at 11:46:53AM -0500, Paul Moore wrote:
> >
> > Good morning, I hope the week is winding down well for everyone.
> >
> >> On Tue, Mar 3, 2026 at 8:30???AM Stephen Smalley
> >>> I think my only caveat here is that your proposal is quite a bit more
> >>> complex than what I implemented here:
> >>> [1] https://lore.kernel.org/selinux/20251003190959.3288-2-stephen.sma=
lley.work@gmail.com/
> >>> [2] https://lore.kernel.org/selinux/20251003191328.3605-1-stephen.sma=
lley.work@gmail.com/
> >>> and I'm not sure the extra complexity is worth it.
> >>>
> >>> In particular:
> >>> 1. Immediately unsharing the namespace upon lsm_set_self_attr() allow=
s
> >>> the caller to immediately and unambiguously know if the operation is
> >>> supported and allowed ...
> >> Performing the unshare operation immediately looks much less like a
> >> LSM attribute and more like its own syscall.  That isn't a problem
> >> in my eyes, it just means if this is the direction we want to go we
> >> should implement a lsm_unshare(2) API, or something similar.
> > Stephen's take on this is correct, the least complicated path forward
> > is a simple call, presumably lsm_unshare(2), that instructs the LSM(s)
> > to carry out whatever is needed to create a new security namespace.
> >
> > There are only two public implementations of what can be referred to
> > as major security namespacing efforts; Stephen's work with SeLinux and
> > our TSEM implementation.
>
> Please be just a tiny bit careful before you make this sort of assertion:
>
>         https://lwn.net/Articles/645403/

I believe both AppArmor and TOMOYO also have namespacing
implementations already upstream, so SELinux is certainly not the only
one. Looks like the Smack implementation you cited above was based on
extending user namespaces rather than purely Smack-internal like the
others; is that why it wasn't ultimately merged?
