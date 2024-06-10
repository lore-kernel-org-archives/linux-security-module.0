Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FE61514E8
	for <linux-security-module@vger.kernel.org>; Mon, 10 Jun 2024 22:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058520; cv=none; b=bf+hObZjjM1/A92HO7dGL7levDTLU1Jq9IMT2+/hkXbQ5awOcdzAbRiQmHlcl0tl+bYslWGRjjH3fdxV4QLO/dRS59rsB3fohcsvYysGPCrVjOFpIyqZ/0bvrqvOlLpVF/y+mL6drOy7fRCLDh1SXkxJ3SFuhzNsYllFtT/jxcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058520; c=relaxed/simple;
	bh=//h+SQzpQEpDtNpeBuStauUMjF/1FnjkWddWusmEJoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDWm1DXfE3f7gOA7hnYxNleg8OTf1C3UnWxzfrhEZ5dbf4oueDVZFXu/goqWI9audldaQSir54+jTkOOD7FrcEmrOlxGDds46bkwYlby7ltpI2bPFjGOhM7UD63jm4zBOrgNwKdVTzL0AyvS8hGjYKAFeimp2sAER4JMytVORAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qOsuBHUx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qOsuBHUx"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ee5f3123d8so28995ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 10 Jun 2024 15:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718058518; x=1718663318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CltNPHp24X0YdbNxXIq1nZmVRV43NqFIhiiPqMk86LI=;
        b=qOsuBHUxVv7JdC0fC1XPGmTCR1Gr/Yb2Fmt1DMNtBp7B299EnwZ0ABmihyCpphO9Di
         5gs5C71Jok9EIQb3+NZ4XXSit4ZHgvUgKeInWrr8BthF4wqhHzGWsC+oGH6YjQrWqO9J
         yjNehOoyoSZ3FdX80UnKtZ4TGx1CFX33e4I+9UOPSTNofxFAYieRE6ihQYOChBriInAX
         imNZECoYSUB/0d8U9WTu7Jaf/jXfiQ3pqzf7nuRdNh8YIhXvB37Ulf/+bP3abRRBVtBn
         L2jx7uRYMycBsMX1IfCBpU0ETM58P3Kqitx2/vlDPMyfz/RxDavOp9+iDB4OnnstaFMo
         /zSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718058518; x=1718663318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CltNPHp24X0YdbNxXIq1nZmVRV43NqFIhiiPqMk86LI=;
        b=KtFy0oz40dIfdX7LLMI7YHN7XhUL+K0c3TD+MN/YerSqBTBo+rIrh+Glw/lNxN8Mqn
         7v9cil+i8MD8iIP50lUSciQ8Ol0rdeKH8G5Cv4gmyftWuHtIo+aDfWqww+jCK5wt6RfU
         41II+1xQbXlnpI+Je3iICDUrnlZItLVc7l0o/I7OkXNPuR7008PMCi7j440iMxqxuy92
         50XF8JFjFWL1rXZDMnbKD50M0ltWIiVYkEAd5sKOM9dcX0lQ5+G+ki3/usjRH8UxtNj+
         /tDL/LJrVjGaRU7HcY1bZWquKzGoh78SSFvqGClK7bXOBW8Kx42lL3UF6Sz4Dhu2qzFW
         TJrg==
X-Forwarded-Encrypted: i=1; AJvYcCWP/65LejvI4sgDew7eP8TwOKtot6QZmg7e7OQHJLFc1SWHnZUR0XKP7KZX3511WRc+aRByGiVvgfbHliLKMoGDNcUKIdJnA65CKiadwLlOnrWpuHt8
X-Gm-Message-State: AOJu0YzAfgkvQvWZIMV8kmXe1urs7mFPbptLB+1VYM5emQpnHOk2B5qk
	0YdpjG0/AEGdPi9ZY9LWaU+X0YnNWKxTyd6cqcOaugth+m1DyWIjFI0xk5VjVSWz+PR7DXOBNnV
	qVtm6E+BCL5UvF5T9KpAKqqT1gy7v5W0pVdbb
X-Google-Smtp-Source: AGHT+IG5DxgTD1WhUH3nJ9EmVhkKot+5sCCwTEAuekdiSfrw+FdsqlljtFn9AaT3xI8iDYGmH91HNrjaFh3g24AwBas=
X-Received: by 2002:a17:902:6acc:b0:1f6:7fce:5684 with SMTP id
 d9443c01a7336-1f72f726f4amr440435ad.3.1718058517742; Mon, 10 Jun 2024
 15:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZmJJ7lZdQuQop7e5@tahera-OptiPlex-5000>
In-Reply-To: <ZmJJ7lZdQuQop7e5@tahera-OptiPlex-5000>
From: Jann Horn <jannh@google.com>
Date: Tue, 11 Jun 2024 00:27:58 +0200
Message-ID: <CAG48ez3NvVnonOqKH4oRwRqbSOLO0p9djBqgvxVwn6gtGQBPcw@mail.gmail.com>
Subject: Re: [PATCH v3] landlock: Add abstract unix socket connect restriction
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, outreachy@lists.linux.dev, netdev@vger.kernel.org, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

Thanks for helping with making Landlock more comprehensive!

On Fri, Jun 7, 2024 at 1:44=E2=80=AFAM Tahera Fahimi <fahimitahera@gmail.co=
m> wrote:
> Abstract unix sockets are used for local inter-process communications
> without on a filesystem. Currently a sandboxed process can connect to a
> socket outside of the sandboxed environment, since landlock has no
> restriction for connecting to a unix socket in the abstract namespace.
> Access to such sockets for a sandboxed process should be scoped the same
> way ptrace is limited.

This reminds me - from what I remember, Landlock also doesn't restrict
access to filesystem-based unix sockets yet... I'm I'm right about
that, we should probably at some point add code at some point to
restrict that as part of the path-based filesystem access rules? (But
to be clear, I'm not saying I expect you to do that as part of your
patch, just commenting for context.)

> Because of compatibility reasons and since landlock should be flexible,
> we extend the user space interface by adding a new "scoped" field. This
> field optionally contains a "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to
> specify that the ruleset will deny any connection from within the
> sandbox to its parents(i.e. any parent sandbox or non-sandbox processes)

You call the feature "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET", but I
don't see anything in this code that actually restricts it to abstract
unix sockets (as opposed to path-based ones and unnamed ones, see the
"Three types of address are distinguished" paragraph of
https://man7.org/linux/man-pages/man7/unix.7.html). If the feature is
supposed to be limited to abstract unix sockets, I guess you'd maybe
have to inspect the unix_sk(other)->addr, check that it's non-NULL,
and then check that `unix_sk(other)->addr->name->sun_path[0] =3D=3D 0`,
similar to what unix_seq_show() does? (unix_seq_show() shows abstract
sockets with an "@".)

Separately, I wonder if it would be useful to have another mode for
forbidding access to abstract unix sockets entirely; or alternatively
to change the semantics of LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET so
that it also forbids access from outside the landlocked domain as was
discussed elsewhere in the thread. If a landlocked process starts
listening on something like "@/tmp/.X11-unix/X0", maybe X11 clients
elsewhere on my system shouldn't be confused into connecting to that
landlocked socket...

[...]
> +static bool sock_is_scoped(struct sock *const other)
> +{
> +       bool is_scoped =3D true;
> +       const struct landlock_ruleset *dom_other;
> +       const struct cred *cred_other;
> +
> +       const struct landlock_ruleset *const dom =3D
> +               landlock_get_current_domain();
> +       if (!dom)
> +               return true;
> +
> +       lockdep_assert_held(&unix_sk(other)->lock);
> +       /* the credentials will not change */
> +       cred_other =3D get_cred(other->sk_peer_cred);
> +       dom_other =3D landlock_cred(cred_other)->domain;
> +       is_scoped =3D domain_scope_le(dom, dom_other);
> +       put_cred(cred_other);

You don't have to use get_cred()/put_cred() here; as the comment says,
the credentials will not change, so we don't need to take another
reference to them.

> +       return is_scoped;
> +}
