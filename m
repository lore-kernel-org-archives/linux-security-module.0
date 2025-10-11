Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED8B16DC28
	for <linux-security-module@vger.kernel.org>; Sat, 11 Oct 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760200313; cv=none; b=AMCKj+6c/jCA5kdBzrg9w19yehve4OiG/+Xyt7h8hyA2KkBCKORGw0qSVWjEYKAudyMjob8ZGsPilgCGYtsmgXaavktEgNZ45JKqMPKvm8pQd6Yt445XYlRs0Wnfz0IrzmgZEwRnSgNfh/iA8BW907RA0rRvc27K1QMQtzzALPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760200313; c=relaxed/simple;
	bh=lrO38iizk7wcb60GtWW7Ez8BBgT1YYBpDU8DRQBxMlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZ26ZAbvRdHSZAfCJCLYrFjhKB6lG7WBzHM7fv0VAY0GasGiTw7ggSLFcxBt5gD2dreoajhT4S4TftJ1/leWpYMewY3pXF6vagB6dIXk53ePci/Dxz7bAr62P9dgUNCB/WWIJIlaaMwfu0VSIAaFJan+LKutm8Pv/kzEU5TKiOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ce6+TVFK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ce6+TVFK"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42568669606so2160450f8f.2
        for <linux-security-module@vger.kernel.org>; Sat, 11 Oct 2025 09:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760200310; x=1760805110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrO38iizk7wcb60GtWW7Ez8BBgT1YYBpDU8DRQBxMlg=;
        b=ce6+TVFK8A1SQ2AFHCH3TzRKM08YXJLDNIirmQoL1DNG4cA/TkCaBjQAt+dcQ/wDwV
         n/BLAHCgtOGNEZigOBSJbHJlRnTKqfR0eEBh73tgslry5ZfiJgFk0HsCMzScJtmU0Nxe
         1mF4IWMAep5maZDxhNwI4nS5ZetmfLF0kcg1KBNkcjYilacG6bvlE6K/4YQsuxDzqmjJ
         HG8bLZuCTn9Na077/KcCHBU9iaADMDM5iIlwJLR75rqsj4aG5i6kSfk64wfvpHAFmKlP
         EvDl/Y7iMku4XTAJEHQry7i5yyuC2dtZLi3d8XYhJm+aGAu1+k0E2jGJj9Lm5hJ/aoxJ
         N0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760200310; x=1760805110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrO38iizk7wcb60GtWW7Ez8BBgT1YYBpDU8DRQBxMlg=;
        b=WTJgY93AWD/x7mThouJLEUcIwa/jsnoVxJ13GjC2yMJWBW99nklDGslEePxKtCJ3Os
         H+ve3GsJMScCxGnV+JV6sj+lqmaUERJuErfoThfSi8m9yxsu4rjJReQZF0Zmwwk7B5ZK
         1prPb0srbT3tf46qmRPyezQOm1yLvgjTtWwsSuVuDIGdu2VUG5440NL2zaDboGXu0ynx
         cxazlzRZpRQn2oGkSfNJAhJNS+JnVKBhLDNn+8a6yBw7bRWpz+RhDh1kYLpkEgUTug5S
         mvWvC5WZDT/HWU+WDZYjda6H5m0h/aP5G7AQnVrfp73YJMXCDw0N0bmIYNV8Z6Lai/Ea
         3ilA==
X-Forwarded-Encrypted: i=1; AJvYcCV9Oorb5m2mTGyVWMsIHe6SytcyUXjOdWVQs0ovD4eeTHWw7oygO7yEAdw7cNqXyE031HmIJyLOWxUEeEuY4//Zulx7qHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEaUyCl4dmQzwMtWQuLhqEIxNfoS97AJhRvftGFQ2CWFmU4aqY
	BZP0lQowe2KQcdk6G0JPY0fLmo+/eVXQwqRgEMqhMrtOdlIFGYFkNPEzla7fL89a4PZAFEPpdx9
	FwZ0IW2tsSnaDg70FkVP6ebVeSI5oOjA=
X-Gm-Gg: ASbGnct94AwnOzctr0GuCgNHJGT1qUgO7vQRkzieo2KNtKSLfx/3Zdx+kB+QVS9Mr3j
	6NMfH/MqAKJpZhjrU7xeOKLzyV1q+xFbATD3umMiT0F63vgYDO7f1upyzEFNd/qNmkNYHnhFOQ/
	yRBhVBr5SY/xDbeKSeDn3Lg9YvtuGwXHuuDMCNM8jitWegGAZJqwYqKBrTve3jZ0nIdSPknz2no
	b48y3FdzbH3kxRNtRk+9LQ0RW2Ac8t9i+XJFe2GMg3Axo+zg9tCvHa6AJc=
X-Google-Smtp-Source: AGHT+IFVktQDOHQUp45HLbylL/L1w5pNMbDmebDxa1LOU0GO1YCl7c+TW2wjKLQi1lKbRufqpRFVi7GVoYl4plbBD0U=
X-Received: by 2002:a05:6000:26c9:b0:425:74e1:25f7 with SMTP id
 ffacd0b85a97d-4266e8e6d0amr9983408f8f.62.1760200310238; Sat, 11 Oct 2025
 09:31:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
 <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
 <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
 <CAHC9VhR2Ab8Rw8RBm9je9-Ss++wufstxh4fB3zrZXnBoZpSi_Q@mail.gmail.com>
 <CACYkzJ7u_wRyknFjhkzRxgpt29znoTWzz+ZMwmYEE-msc2GSUw@mail.gmail.com>
 <CAHC9VhSDkwGgPfrBUh7EgBKEJj_JjnY68c0YAmuuLT_i--GskQ@mail.gmail.com>
 <CACYkzJ4mJ6eJBzTLgbPG9A6i_dN2e0B=1WNp6XkAr-WmaEyzkA@mail.gmail.com>
 <CAHC9VhRyG9ooMz6wVA17WKA9xkDy=UEPVkD4zOJf5mqrANMR9g@mail.gmail.com>
 <CAADnVQLfyh=qby02AFe+MfJYr2sPExEU0YGCLV9jJk=cLoZoaA@mail.gmail.com>
 <88703f00d5b7a779728451008626efa45e42db3d.camel@HansenPartnership.com>
 <CAADnVQKdsF5_9Vb_J+z27y5Of3P6J3gPNZ=hXKFi=APm6AHX3w@mail.gmail.com> <42bc677e031ed3df4f379cd3d6c9b3e1e8fadd87.camel@HansenPartnership.com>
In-Reply-To: <42bc677e031ed3df4f379cd3d6c9b3e1e8fadd87.camel@HansenPartnership.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 11 Oct 2025 09:31:39 -0700
X-Gm-Features: AS18NWAkyavqKGn5fC6sLEvcq-QIRJm3Tkt5oPLRbq6OvYCP9hqMJkQoQjx0Eo0
Message-ID: <CAADnVQ+M+_zLaqmd6As0z95A5BwGR8n8oFto-X-i4BgMvuhrXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Paul Moore <paul@paul-moore.com>, Alexei Starovoitov <ast@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, wufan@linux.microsoft.com, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 7:52=E2=80=AFAM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> It doesn't need to, once we check both the loader and the map, the
> integrity is verified and the loader can be trusted to run and relocate
> the map into the bpf program

You should read KP's cover letter again and then research trusted
hash chains. Here is a quote from the first googled link:

"A trusted hash chain is a cryptographic process used to verify the
integrity and authenticity of data by creating a sequence of hash
values, where each hash is linked to the next".

In addition KP's algorithm was vetted by various security teams.
There is nothing novel here. It's a classic algorithm used
to verify integrity and that's what was implemented.

> > You need to realize that single loader plus single map is
> > an implementation choice of tools/lib/bpf/gen_loader.c.
> > It can do the same job with a single prog and no additional map.
>
> Yes, and if the light skeleton scheme embedded the relocation and the
> program itself into prog->insnsi then we wouldn't need the additional
> map verification before the load hook because the pkcs7 signature check
> would fully verify the integrity.

I'm fine if you want to hack gen_loader.c to produce the loader prog
without a map, but we're not going to pollute the kernel with
pointless apis, because you don't understand hash chains.
