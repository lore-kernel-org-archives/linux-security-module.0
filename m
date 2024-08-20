Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804E938FA6
	for <linux-security-module@vger.kernel.org>; Tue, 20 Aug 2024 04:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724128436; cv=none; b=R+JYvFE4hbgYrsdMSS3PlE4yFL3H94IxzSIgKntKg2zR1ZX8ER6vU5KlETWdyyFAcQReRoDyrmdR8rGfqlPR9AAot25pPokOBbkY7OdCiqJC0+ftK2zwZEJ9nbSdl5pPR/NyS+ModTCOYhCXZQkLiiLgVHRp42oSGguDEO03qzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724128436; c=relaxed/simple;
	bh=zhEqPS7GHdqMJse27lQWRdYXUw4ubv7uqJ7MGu3CeTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6T3NOS9BxahXu8E3oc/d53g6/M6tmLuN0NqtagMgZlRe0vjv8PDnI9u1RkkwaxA3w/haxtvxkmfnh6ZyWvDMl7r/IM5BWdszoNK1wjkPKFLuteaNlH0gX0S/5V15usjeK3JId6NNCFIkhjaysn/kbfqSLYukbAIlVGXh8pcEug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LIn9pyw4; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LIn9pyw4"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6b41af35b1fso26201547b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 19 Aug 2024 21:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724128433; x=1724733233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hh2PCGc+K5cunZ/qwakjKSHo7lYNiPsK7m7qg92LGVg=;
        b=LIn9pyw43fb0C4ZzlT8si3gLUOhYL0mc68nQKOttGfcYNAifN811QqU3b5hg3Lcb0k
         +5Rm9yRXm1bagooRrHia5fIU8ItzxecFhDd8Dd6G9Rtra5Tmn1+6QtlJF4nvc1XDZCSC
         DbaNKg7UM4Zbm4rk29hgfPrDAmdfRgPG9y2lAMzJln7W3LQKb5C6lpLcemEqM3PKOcBL
         9YCNMhGRBskgD4jtXrNgF+zfExX6K9hchppmG+HPNPGZaK7WlyISCSneSPhlTAlLZXWZ
         LrPTCrJbM0IsLJwj4MnJhIbzPVFwUZfEAhJqIS/21y1r2tmCa7xSyJSI/J9r1YVzZ2aU
         44GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724128433; x=1724733233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hh2PCGc+K5cunZ/qwakjKSHo7lYNiPsK7m7qg92LGVg=;
        b=mZMcmuSxeEYSWND27Y5KDn71Dzvo97fCVp3OV6mp8A1jQLahhXX2QM2GFcSYVSl89d
         VCRLRxjlobNwviLS7fIRostUk2sl3hX0sLchDY5WBGoVlgemVUH5cZ+dGpqGy/82KOZj
         xnKTfdPdO3X12EYIuH6C4klcaZj+E81bx/2Z9fpF7bh21TCJThWHU3pUTNFksMjEKCu7
         IEp6bOQRsHrF6ACroga6HqJZB7FZzUbv39AbP4UM0cbmbzX7nH/Cjv0T2R+RgtOLCpFp
         n0qi7XuYWytiK4zXLYpdGRQizhzeZSGX38SGdR0r7JlsU1YTwhI4171iWtKOAkny+amT
         RoXw==
X-Forwarded-Encrypted: i=1; AJvYcCVztoBX9rEykPd7TtO1/tBPQ0DLNY7MmdM1nRT4b9fvkLn4mxvzQnvS0iTzMKauMbv3GVUujrnUnkvsfVxVsIPhnSA860pt6CTv78dIwbB3C+gE7HXA
X-Gm-Message-State: AOJu0YxtFtwUMMicJIiFa/Mcpm0z57IsgdZi6mlUHPAGidcVfZ6nbYRT
	Jt+pS/qXvTwXcrhEys/aHS5gALoHTOZVBR98G6pteV704P2OR8HmrE/UF9PprfPUoR+zQouKvbd
	lwyPtCeqv0vTaBmpLPQ9AAHgvCGX0Ka3qcVFeKno6J4AaILg=
X-Google-Smtp-Source: AGHT+IEcPtboqaqxuboCIBCdC2X9+UGxp2JXC5GT31PipGlZgu2et1276RlQgUB9DQ5/QRmlNmCw62lsYgGo3+0pnk0=
X-Received: by 2002:a05:690c:6ac7:b0:6b0:45d:bf78 with SMTP id
 00721157ae682-6be2ef29217mr11133857b3.36.1724128433327; Mon, 19 Aug 2024
 21:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816154307.3031838-1-kpsingh@kernel.org> <d95d9cbe-54ea-4e85-aa63-4494508be5e7@roeck-us.net>
In-Reply-To: <d95d9cbe-54ea-4e85-aa63-4494508be5e7@roeck-us.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Aug 2024 00:33:42 -0400
Message-ID: <CAHC9VhTAkifc5+Ka3keL0=rUwfU=S=pDXh4mqdVxJDUwD-swsA@mail.gmail.com>
Subject: Re: [PATCH v15 0/4] Reduce overhead of LSMs with static calls
To: Guenter Roeck <linux@roeck-us.net>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, ast@kernel.org, casey@schaufler-ca.com, 
	andrii@kernel.org, keescook@chromium.org, daniel@iogearbox.net, 
	renauld@google.com, revest@chromium.org, song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 5:30=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
> On 8/16/24 08:43, KP Singh wrote:
> [ ... ]
> > # v14 to v15
> >
> > * Fixed early LSM init wuth Patch 1
> > * Made the static call table aligned to u64 and added a comment as to w=
hy this
> >    is needed.
> >
>
> Applied to v6.11-rc3, together with several other LSM patches from linux-=
next
> to avoid conflicts, this series passes all my qemu tests. Feel free to ad=
d
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks Guenter, I appreciate your help testing and debugging all of
the different arches.

--=20
paul-moore.com
