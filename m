Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAC41E32BE;
	Thu,  8 May 2025 03:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746675158; cv=none; b=fSbNxNH5PmJFzYQKz68xH94O6m3yUNL8bXp/4G18tNEL4BzfriFAWUrg4obDFRJJ3WJTyP/oMWdTpFQGhwOemuBQCUrnP/LlRsLaaZHVz82Y5H/mx5ejz/edOAtIM7afNDR6dowOqGKcUAiUh31mokaN8mbNkRNzf4brAWbXCbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746675158; c=relaxed/simple;
	bh=4zWakdWzDEr5ut1LZ1rZdc8a0RclyxGBdbydjpd0ke4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyVTA87//HD44VEL3+Q2KLmf8OxgNE1uokY9+QWCJaknh+MTrD+M/5n5/t19pHWO0XYJ9NK7j1DOCFIX4u9f3XNz/XlJaJjCkNlpxmwkeGX8IKkv/aElVTABuXyp/62Q5RZKxakB2dRG5cRgm49Vth8yIOfqPp1gFeJXXu9+MR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PV6NLVgh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PV6NLVgh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4D9C4CEEE;
	Thu,  8 May 2025 03:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746675157;
	bh=4zWakdWzDEr5ut1LZ1rZdc8a0RclyxGBdbydjpd0ke4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PV6NLVghdQptO19IARU2+LkB3BbQph/mb/EPBkeZSScL4sTDkXF3MlGOJ6YyBRl64
	 +E9lYv54vQY/YqIgyRQPwEaClMceXXMTPIazXa4oj59ejgVpYNXS4kbvDJ7CMU0bIA
	 Ap3r5v4QvB/x1RTKQkrKsCVyQdabo8w09KkIB02X5Fr4M///prEYFVcW/jJDrs9Deg
	 YXvy7t9zGRbXXp67VwbOplQKSthXOGs4HPi5aaovnHM7hNf8pTCX34bJznvN3W9ofT
	 CyOsJVWmt1USehYT4uYfw8YIW4e9firDu5OqPNK1Uxv47dXum0o8A0QafSVEpsAQOB
	 0Wgj34aK2tN8w==
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30a9cd61159so549971a91.1;
        Wed, 07 May 2025 20:32:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUO3N79dFToRDEfqwVL7y2nan1EAYLbCZpc6YQE6VhfQ7XyM070abZBBcLXNnFyJOBKBwJwYKhQ4LA/eOGvofuhIsDWjM6s@vger.kernel.org, AJvYcCWcG1mMjwM63c1Q50Lb00Me+jLV904UiwhrvRJrD0G4eGYnPHHLTKLkdBIkwhQNR3Y/A0pi3PeYjPI1yHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj4p8ojjIbOeAs8Q56qyfjAvpD/ZS1kKivfu5xWV5/NWsDgtkt
	hXHAY8DfQQtIv6VKyxh56JMDW1A57YGOu2zRJUfaNzZnl8qnUoaaH+6QTeriOsUXaM1cukscaxq
	1WIQVaIDHoyX61Wgk/P6fEJAFTcw=
X-Google-Smtp-Source: AGHT+IGSyEdgQCH9NU5LZJXrep04qBZPcZeJ0/77eOImdowWZgCxfZAPvW2zenlA/XI5GZNoiryLKItpB6vYx2RCiHE=
X-Received: by 2002:a17:90a:c2cc:b0:2fa:3174:e344 with SMTP id
 98e67ed59e1d1-30adbf58c30mr3173092a91.14.1746675157331; Wed, 07 May 2025
 20:32:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <20250309151907.GA178120@mail.hallyn.com> <CAKPOu+_vTuZqsBLfRH+kyphiWAtRfWq=nKAcAYu=Wn2JBAkkYg@mail.gmail.com>
 <20250506132158.GA682102@mail.hallyn.com> <CAKPOu+9JCLVpJ-g_0WwLm5oy=9sq=c9rmoAJD6kNatpMZbbw9w@mail.gmail.com>
 <CACmP8U+aLY7wmEqdb=a_tpDCY5LaPGb46DU+jSD3bCXX=JUAuA@mail.gmail.com> <CAKPOu+_=ocLeEqcaSMjb5qqrvi6KAu3GYJa19Fqz_dm3a5F77w@mail.gmail.com>
In-Reply-To: <CAKPOu+_=ocLeEqcaSMjb5qqrvi6KAu3GYJa19Fqz_dm3a5F77w@mail.gmail.com>
From: "Andrew G. Morgan" <morgan@kernel.org>
Date: Wed, 7 May 2025 20:32:25 -0700
X-Gmail-Original-Message-ID: <CACmP8UJmC22+59RcHu_X3xpdUYP-i93rjdVQvZn6_Haj-F8tPw@mail.gmail.com>
X-Gm-Features: ATxdqUETDS-_DiXOin6JvJoBx88vidjk3ff1ALn2oCTlkow1yogvF7prMzrsEms
Message-ID: <CACmP8UJmC22+59RcHu_X3xpdUYP-i93rjdVQvZn6_Haj-F8tPw@mail.gmail.com>
Subject: Re: [PATCH] security/commoncap: don't assume "setid" if all ids are identical
To: Max Kellermann <max.kellermann@ionos.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Andy Lutomirski <luto@kernel.org>, paul@paul-moore.com, 
	jmorris@namei.org, kees@kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm looking at this code:

        /* Check for privilege-elevated exec. */
        if (is_setid ||
            (!__is_real(root_uid, new) &&
             (effective ||
              __cap_grew(permitted, ambient, new))))
                bprm->secureexec =3D 1;

If a luser runs a setuid program, then the kernel will set this
bprm->secureexec bit. Indeed, every time this program re-exec's
itself, that bit will consistently be set. Today.

However, with your change, that behavior will change. The first time
the program is exec'd by luser this bit will be set. However, it will
"surprisingly" not occur should the program exec itself again. If you
are unaware of this bit's purpose there is a nice writeup here:

https://www.kernel.org/doc/html/v5.1/security/LSM.html

See the "bprm_set_creds" paragraph. My concern is that there is an
exploit vector associated with an abuser setting LD_LIBRARY_PATH=3D to
something nefarious, and then invoking a setuid program that happens
to re-exec itself for some reason. The first invocation will be as
before, but when the binary re-exec's itself, I am concerned that this
could cause the privileged binary to load an exploit.

This has nothing to do with your interest in NO_NEW_PRIV but more to
do with the legacy behavior changes like this are exposed to.

Cheers

Andrew

On Tue, May 6, 2025 at 11:33=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Wed, May 7, 2025 at 5:16=E2=80=AFAM Andrew G. Morgan <morgan@kernel.or=
g> wrote:
> > If a setuid program execs itself, does the presence of this code undo
> > any protection the kernel afforded it on its first invocation?
>
> What protection do you mean, and what behavior do you expect when
> setid execs itself? I see this affects:
>
> 1. reset effective ids to real ids (only affects NO_NEW_PRIVS)
> 2. new cap_permitted cannot be higher than old cap_permitted
> 3. clear cap_ambient
> 4. clear pdeath_signal (in begin_new_exec)
> 5. reset stack limits (in begin_new_exec)
>
> About these (from my very limited knowledge of this part of the kernel):
>
> 1. is my primary goal, and really no new privs gained by allowing the
> process to keep existing ids
> 2. only ever changes anything if new cap_permitted is higher, but if
> that's the case, the is_setid check is irrelevant because __cap_gained
> is true, therefore no change with my patch
> 3. as I already described, the kernel is wrong (or the documentation
> is wrong), and my patch adjusts kernel to behave as documented
> 4. I don't see how this is dangerous for anything regarding re-exec;
> if pdeath_signal wasn't reset on the first exec, it's safe to keep it
> after the re-exec, too
> 5. same as 4, I think
>
> Did I miss anything?
>
> > FWIW I ran the libcap quicktest.sh script against your change and it
> > doesn't break any capability thing I test for when making libcap
> > releases.
>
> Thanks for taking the time to run these tests. I'm glad the existing
> tests didn't find any obvious bugs. If we identify an actual problem
> with my patch, let's write a new test that fails with my patch!
>
> > That being said, in general this whole zoo of *[ug]id values
> > and their subtle behavior is not casually obvious. I'd recommend using
> > a userspace workaround for your use case, and not changing the legacy
> > behavior of the kernel.
>
> What userspace workaround would be possible? The only thing that comes
> to my mind is to apply NO_NEW_PRIVS in the child process after exec -
> but that's too late, because arbitrary untrusted code has already been
> executed at this point. This means I lose NO_NEW_PRIVS completely,
> because the attacker can simply skip the call.
>
> Max
