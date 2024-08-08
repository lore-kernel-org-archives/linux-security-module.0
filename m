Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BF7190470
	for <linux-security-module@vger.kernel.org>; Thu,  8 Aug 2024 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138370; cv=none; b=Jn8SJNsUp9z3eczUGd5Y7/1c2yh+t1IVWxyNSBOKD5y28ZEim7oBh5eib0eReqolKWCd5NcqenHnSeuhGqzGbZj1PWdvq6qg+WkRSSOzcxbuoPOZRFbtC25RCMgyzUOzinudCzIN68Azp6PfL7uZZQOiZJCK9nOC2mxNALmfpEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138370; c=relaxed/simple;
	bh=ra9Tr8gTinwOfSl5zupa/2o60sqvU0CPOc2qEo8b/Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iflgsDVRGTuDf+v7tQv1YVAi7hGJx2eoGI8C4udJt9DR03eS4MsKMAMCLoPjL1cTs/H/vqXy9WtXQxeAv7se0qXdh+X2LvC2TwMdYfeJhrXdfM/NUt6r5Ya0I+NhpYqfZsgSMqRVL07BroMeZXCS4OF1EKBVusvIabx0HXP72ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ae0qxf8S; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ae0qxf8S"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-65fe1239f12so10696637b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 08 Aug 2024 10:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723138368; x=1723743168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snkmKAtsan0FJLgLs2dcvi/WMO4/avl1Z9NJwFjKlK4=;
        b=ae0qxf8SpaYkuSbhmOZJKsxZg4LYbcm0aC6P7OPfsFcyS2qLEZ2UmQfXQysYWUxmkf
         3WLdcVbu9PwirpvKj1mfSglTg1ULx7lzUy7QklTSu1TCYPMHuEApQGH3kA7PbGr9gheC
         0lmX3yKQVGrc8mub21zu42CWv6xaYR+DAEsB0ymyPMYRs4O+YfYz3PpICnVmgXbzcNg7
         VnNd5LHCoVZo7fOeGRzCyd5y1dQn8Dw9ByGqk8uzQLBtsgCJKMSYFxnmeN7Gl3swtLFs
         Eqhf3FlZ2pGeZ4W6xKVBTgK73Af3rAM2Zl1DR6boGrczeVfteajN0sZRkjfIK4gYXQIg
         57RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138368; x=1723743168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snkmKAtsan0FJLgLs2dcvi/WMO4/avl1Z9NJwFjKlK4=;
        b=ZnINOmZPRtLlbxRsjzJXWN3NKU9zC7Q+MQKfBWNRAsjXVknku6QOEftkafroJslMqU
         1xKc+gcWvJlZC6x8SD/LBlO6uOAVDbkSSlRiWaB5akk13RHFUjvE28V1aWk+4lzskHtZ
         G4Q4Wrgn4jePg4LxRNQFnsaJqFeIHIj6lbiXMYBdinAfiKw8LEanlZD8Tpl6eBdJ8WBw
         fHVIsJzGX3oCgnE6xVEdXi7UZMn1Iv+YQAkdFy0lZqFkBReYKv+sGa+Us8gaEVZf9Y7v
         GnF11PKw+kO2c/SiUOXJYSO2imvmTHXUXyDl1wwvxfLc1mkGv+d9kajH9wNFd14mXKzm
         7wKg==
X-Forwarded-Encrypted: i=1; AJvYcCVbvzx8VweX5b7KHnx0wtFRm1PtCrpn+qXVCSPVDDDkp64LQoHMkf5wtP+EK4DBUozP9OtRyldrCocHcm4w9sNONUgo2O+KU78UY7nByo1dwXW6rv9Z
X-Gm-Message-State: AOJu0YzXKVL/9ZuTHUNecGLdzsqd83R3/rzhtB+rORoOjrGpHUGCsM8/
	zC+QcoImEugvw3T39HGK3USPY8jpINBb75eiYfE7/kzRr47tWMCKMdo+lkXm3u0+f4BZZZK/edc
	3aOv4qYCY8d1kOj0SQG6ZU/5mdg1CKmun0e+q
X-Google-Smtp-Source: AGHT+IHgM3rguJYL14K9UckD4Em4UxPoS2Bfon3v0V4uVdTZxWcfMzLDpbZIRRdaN18as3F/6rOM4AHNH7Y+8kV5TfM=
X-Received: by 2002:a05:690c:f81:b0:67a:f3d4:d9c1 with SMTP id
 00721157ae682-69bf6f7f1abmr27499777b3.2.1723138368376; Thu, 08 Aug 2024
 10:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801171747.3155893-1-kpsingh@kernel.org> <CAHC9VhRO-weTJPGcrkgntFLG3RPRCUvHh9m+uduDN+q4hzyhGg@mail.gmail.com>
 <CACYkzJ6486mzW97LF+QrHhM9-pZt0QPWFH+oCrTmubGkJVvGhw@mail.gmail.com>
 <20240806022002.GA1570554@thelio-3990X> <CAHC9VhTZPsgO=h-zutQ9_LuaAVKZDdE2SwECHt01QSkgB_qexQ@mail.gmail.com>
 <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
 <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
 <CAHC9VhQ1JOJD6Eqvcn98UanH5e+s6wJ4qwWEdym4_ycm+vfxmQ@mail.gmail.com>
 <873b04da-7a1e-47b9-9cfd-81db5d76644d@roeck-us.net> <CAHC9VhTd0MKVXsZ7J_b_Mmr2vP+RMJtxzfsgpH1rZ_hoHY1D3A@mail.gmail.com>
 <779dfb7f-d690-432e-8461-b26935974ac6@roeck-us.net> <0673d2b2-ad78-46f4-93b2-73ea3acd70f7@roeck-us.net>
 <CACYkzJ63DRLtDy6DAsGhz8_mM1pUSaC-DjbCtTBtEMP0c-=yRg@mail.gmail.com> <d9fc949a-6945-4c41-83de-c3717d536c15@roeck-us.net>
In-Reply-To: <d9fc949a-6945-4c41-83de-c3717d536c15@roeck-us.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Aug 2024 13:32:37 -0400
Message-ID: <CAHC9VhRGt-b8PmtR-hZwOWB1zfmuhfftoppjacqrjq60tm0mag@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: Guenter Roeck <linux@roeck-us.net>
Cc: KP Singh <kpsingh@kernel.org>, Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 12:43=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> Also, there is a backtrace on ppc (also see below), but that is unrelated
> to your patches and only seen now because I enabled the security modules
> on that architecture. I'll bring that up with ppc maintainers.

Thanks for all your help testing this Guenter.  I see you've also
already submitted an AppArmor fix for the endian issue, that's very
helpful and I'm sure John will be happy to see it.

Beyond this work testing the static call patches from KP, would you be
willing to add a LSM configuration to your normal testing?  While most
of the LSM subsystem should be architecture agnostic, there are
definitely bits and pieces that can vary (as you've seen), and I think
it would be great to get more testing across a broad range of
supported arches, even if it is just some simple "does it boot" tests.

Out of curiosity, do you have your test setup documented anywhere?  It
sounds fairly impressive and I'd be curious to learn more about it.

--=20
paul-moore.com
