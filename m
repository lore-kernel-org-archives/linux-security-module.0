Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F0116C684
	for <linux-security-module@vger.kernel.org>; Mon, 12 Aug 2024 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723497281; cv=none; b=ct+CFtNY6DkcepGm+VZ3DuoLqugevBwoHnf/+AJQNrEev4zgi+oxhoQK9Cn6+tsssr+vbv5+ic0Mnli0tD1C3ETpyqh2N6WFWK6ghf6eaDytyz948PO2yvVHfbdDKgIFqKGbSJvaJBEIyL9fU9vuc9E62z3HlTegAB8vA9whCqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723497281; c=relaxed/simple;
	bh=U/wIq7aEp0El9u2mq5CsMTPXjOHii2eHLcx60+uN+mI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esPhhvq5iCNGlpLlMNPE9AXC4QNU2z1iV0ksyCjK5AkGJq3UDmH4w01OeQCZrC9qOCyWMB/WKMKX7G7ZrA11z8v/ELG7/mWiWYC6vR571N/ab5809Dtix2Z5wPlz+5ES32aX7dAM8OOpkvyphepP69vfL5pVNAB9h1gRJNBD65c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGsv9Nky; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGsv9Nky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7E8C4AF13
	for <linux-security-module@vger.kernel.org>; Mon, 12 Aug 2024 21:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723497281;
	bh=U/wIq7aEp0El9u2mq5CsMTPXjOHii2eHLcx60+uN+mI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TGsv9NkyHdPk09hIaMWQKTNYJrhgf4KZ+w6uZ55AjIUfx+Yl3CH6s3ErAdCLJGgXU
	 Bzpo/KCnMEB7p69DY9djAiAnT/smichx90cv7F93V+UNs+V75jM4v1sr1PA7ZmGNsh
	 83qt4UbwFsA2GlfUs2B2VpTi0o2wI3ljsUXG6XREx6fPqQ8Zjbvv2IXKG2Ppj4tKwC
	 BA5HQXfose8LYM0WUHqZgBCc1dS2xuerIo3rMAMW6jBdwgBKcIqmfjcf0SYD7A7O81
	 kKYVr13NmyrmcQJ9xPWsHf+zW4OecyGXzCtJZU3+QuYcGiLD9sEc+dJSS46AqeD8aY
	 i3zDi6VdJchQg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bd13ea7604so3085711a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 12 Aug 2024 14:14:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWK8HMmsRQ+M7zcHZ4UnS1HhGgpvIVzL/vADlYaII8EU1eLOyQ/zJblsyC6Mp+csDGzo6BZjl/X0BgmKYjcIVkfC5b5wL+621PxyzTeaqg/Y+pefVhj
X-Gm-Message-State: AOJu0YwnEdyoPKx2CjbMX58vBp10oyAWzRY4BarYpZxhAdEkkx+m44uy
	/TN13Irp0jtR2Dks0BgQ4t90tjiHCQhQK1JD1VbX53CYVnrjl8GTl3bQosh9ZIQZeZMLqdRjwCP
	R/Sd4Wftp8h2Z1ewTcoa2GI22NpWOYkrWJXyb
X-Google-Smtp-Source: AGHT+IGIb4/rfhmtq5OzXCtJRCFSdY/UlCa8r3+gAcwb9Hkqu8BJzG/6izGO2L9ihJ1RyJ4z0U9vxGuPOC7FZDXlXtg=
X-Received: by 2002:a05:6402:354f:b0:5a1:7570:8914 with SMTP id
 4fb4d7f45d1cf-5bd44c27370mr1098830a12.11.1723497280058; Mon, 12 Aug 2024
 14:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
 <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
 <CAHC9VhQ1JOJD6Eqvcn98UanH5e+s6wJ4qwWEdym4_ycm+vfxmQ@mail.gmail.com>
 <873b04da-7a1e-47b9-9cfd-81db5d76644d@roeck-us.net> <CAHC9VhTd0MKVXsZ7J_b_Mmr2vP+RMJtxzfsgpH1rZ_hoHY1D3A@mail.gmail.com>
 <779dfb7f-d690-432e-8461-b26935974ac6@roeck-us.net> <0673d2b2-ad78-46f4-93b2-73ea3acd70f7@roeck-us.net>
 <CACYkzJ63DRLtDy6DAsGhz8_mM1pUSaC-DjbCtTBtEMP0c-=yRg@mail.gmail.com>
 <d9fc949a-6945-4c41-83de-c3717d536c15@roeck-us.net> <CAHC9VhRGt-b8PmtR-hZwOWB1zfmuhfftoppjacqrjq60tm0mag@mail.gmail.com>
 <8061553f-6bfc-4ee6-a8f1-e3741cf5ae6c@roeck-us.net> <CAHC9VhSKzxknTgKQu6ODoyxhc3skcjh_h11wSQrEvWb_vP5Ziw@mail.gmail.com>
 <CACYkzJ6NuGQchRaj-QD_XzQWNT8c3zb0ZEBXWjzjAckQdNDCWw@mail.gmail.com> <CAHC9VhQjCHBii=CwMMnbs0hiiN-Dy49S+3gpDvaXp-YQyEHTGw@mail.gmail.com>
In-Reply-To: <CAHC9VhQjCHBii=CwMMnbs0hiiN-Dy49S+3gpDvaXp-YQyEHTGw@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Mon, 12 Aug 2024 23:14:29 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7vC7OJWdgm6LbOL82eO=27cn7Gh8i6-HOp_A94-SU-gA@mail.gmail.com>
Message-ID: <CACYkzJ7vC7OJWdgm6LbOL82eO=27cn7Gh8i6-HOp_A94-SU-gA@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: Paul Moore <paul@paul-moore.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org, ink@jurassic.park.msu.ru, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 9:33=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Aug 12, 2024 at 1:12=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> >
> > JFYI, I synced with Guenter and all arch seem to pass and alpha does
> > not work due to a reason that I am unable to debug. I will try doing
> > more debugging but I will need more alpha help here (Added the
> > maintainers to this thread).
>
> Thanks for the update; I was hoping that we might have a resolution
> for the Alpha failure by now but it doesn't look like we're that
> lucky.  Hopefully the Alpha devs will be able to help resolve this
> without too much trouble.
>
> Unfortunately, this does mean that I'm going to drop the static call
> patches from the lsm/dev branch so that we can continue merging other
> things.  Of course this doesn't mean the static call patches can't
> come back in later during this dev cycle once everything is solved if
> there is still time, and worst case there is always the next dev
> cycle.
>

Do we really want to drop them for alpha? I would rather disable
CONFIG_SECURITY for alpha and if people really care for alpha we can
enable it. Alpha folks, what do you think?



> --
> paul-moore.com
