Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EA421504D
	for <linux-security-module@vger.kernel.org>; Thu,  8 May 2025 06:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746686304; cv=none; b=BjrdtkEt2p71yRWb5Xxll4n2BmPM1J0SUes1jO71h3YUGmCxFGH6qUoUbdVRpVRe1YavBzlDXkDY7by1/a7szXk8aN2Bj+0PdaZjOEfA2C+8wvs6Vojpdug+wWT/GImiksDGtfg/PbejwdBUG0mw7/3yT6s2uvqEpd+X37BQtYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746686304; c=relaxed/simple;
	bh=uzuQCC5ghMJYEPnyKjKBV04i+zMfu41L9Xe8o16Wfbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzNcY5c94QGr4tgKdbcwjaimDAd3Wwiu/CjS2WmCKRuXA+GdXRRecMzJA8ogMn08zUNyNq9KDqkjkn6NW38ZCC/X0tSvqDNY2yOYiIP18DgtyIkAvnaqmxDnZsF14Hk2gVhBk934INmMA3fBwtXP/fKXtYdusixTIZizmTlTtTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=T1MsoXKU; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="T1MsoXKU"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad1d1f57a01so114323966b.2
        for <linux-security-module@vger.kernel.org>; Wed, 07 May 2025 23:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1746686301; x=1747291101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzuQCC5ghMJYEPnyKjKBV04i+zMfu41L9Xe8o16Wfbg=;
        b=T1MsoXKURtZr0vm0rVwyr+uIujKpJFnqaUv1deLXCt0yqoqt79HNaDuMRodGVoGawo
         uBEe31o6fObSQVozBQUlFZjzlrrvoqv7O7nbJhTyD/4EWZueRutbNhp0g6r5EXv/kWgZ
         6T2/LZUkdCuOsBvsNnTb2NHGsuqKLB2pq21Vjtoxgvce5LDlbhv+u/OqXggeKnpZz69d
         gq7HD9Bt85RV5jJEC1zRF5o9SqA6HWDDbhBKqmnJVSvfyBqTA5PtDhAjN3UoFIr8AxAc
         uw3hucINsFfKFN5+zvr856wrrPOQgRJaG2zKGTvKBdSjk3lz/rrsuKQaiRukc528vRq2
         oBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746686301; x=1747291101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzuQCC5ghMJYEPnyKjKBV04i+zMfu41L9Xe8o16Wfbg=;
        b=tRUJi5ghFUPNjafLvv+SwNhkEVX0VIJKaBJ9HGvHu8Je3WTgnRRTPbTRE2jGaTKvRA
         +bFDNsY6zjEGr1wDry5vANng4jRklxACRl4Dw7K2wm7HS75vCzIY7CUFY5AdwZ+0u6V2
         RLQq8UQ4v+zaWInj9tka/POBLXdqfReWzwTVD+4+HvzL94CjPZv5SfjBwXYLmgMCAz21
         8qSiGAPWCL655ULM1BAS4H+Yo4zMKS/oT9P5/5n06VW5+iEhDV5+OIZ8d0Mt3sumEQTh
         BdwNVE5sg7fp19z3u9kG5GO5cvtnlNL+yz9+ixXsA/Dp5H8JDZCfXt8JMZ9W3X35Wpp+
         RAQA==
X-Forwarded-Encrypted: i=1; AJvYcCUHvBiBv2rbufub9NYEbsNRPaIpU72W1CbFGocpN52tTIehP3h3h9rHIEia6mIE2qGIkXp/PO+M4Ct5zbPhx/RT6uym72A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzleFGAgv2iPV0HIBq3dsBcSk2aD+ua2EMWVnfqinjqWGnVrIfn
	Z4kGsYQqp9cYlRKvIlDi0eyP7GNtPFRUzd2JDk7tqKemfoxqxLxNXJV1YMNVTPBqEv8mnCBN4T3
	wXSS143Nnl485ArZ2bW+CDZIelmA8MeZgqqilUw==
X-Gm-Gg: ASbGncvNWVdEOQ3UmOfJZS2LNX27y1xYci6WAS1T4s9zRHdEZbM/EFrHqqMFB2KbTyJ
	FDbcCY7aQ2Glsl2L7LotkB/NfO47eIimdNokKbzdBPLNEcoZmMc0jve8cT7J+yHfT89dFBcaARo
	POzrh5DNMHh9NDFadGn5Jq1wtI01/afpvBjLOpiQOIPanFTZ3+irA=
X-Google-Smtp-Source: AGHT+IEJnhD8RI/Yrk0zkL8Hxbb9r+cPRYe1z8R9ozw2q2PITji7RSEHOIvkBsA2AYrTnza6IRBtheYc8zmJJnyV8kU=
X-Received: by 2002:a17:906:5003:b0:ad1:ea5e:207a with SMTP id
 a640c23a62f3a-ad1ea5e3cdemr473001266b.59.1746686300904; Wed, 07 May 2025
 23:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <20250309151907.GA178120@mail.hallyn.com> <CAKPOu+_vTuZqsBLfRH+kyphiWAtRfWq=nKAcAYu=Wn2JBAkkYg@mail.gmail.com>
 <20250506132158.GA682102@mail.hallyn.com> <CAKPOu+9JCLVpJ-g_0WwLm5oy=9sq=c9rmoAJD6kNatpMZbbw9w@mail.gmail.com>
 <CACmP8U+aLY7wmEqdb=a_tpDCY5LaPGb46DU+jSD3bCXX=JUAuA@mail.gmail.com>
 <CAKPOu+_=ocLeEqcaSMjb5qqrvi6KAu3GYJa19Fqz_dm3a5F77w@mail.gmail.com> <CACmP8UJmC22+59RcHu_X3xpdUYP-i93rjdVQvZn6_Haj-F8tPw@mail.gmail.com>
In-Reply-To: <CACmP8UJmC22+59RcHu_X3xpdUYP-i93rjdVQvZn6_Haj-F8tPw@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 8 May 2025 08:38:09 +0200
X-Gm-Features: ATxdqUEkKf35_oMQDpSf-yk8EpkbOq1qvyk_p06Buc6efrYr3tNFr-W5bWN9M4w
Message-ID: <CAKPOu+8Kc_2gs4FUhkGqjFDLZ+6AW2b93bqUd8o9vL8c_TriSg@mail.gmail.com>
Subject: Re: [PATCH] security/commoncap: don't assume "setid" if all ids are identical
To: "Andrew G. Morgan" <morgan@kernel.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Andy Lutomirski <luto@kernel.org>, paul@paul-moore.com, 
	jmorris@namei.org, kees@kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 5:32=E2=80=AFAM Andrew G. Morgan <morgan@kernel.org>=
 wrote:
> If a luser runs a setuid program, then the kernel will set this
> bprm->secureexec bit. Indeed, every time this program re-exec's
> itself, that bit will consistently be set. Today.
>
> However, with your change, that behavior will change. The first time
> the program is exec'd by luser this bit will be set. However, it will
> "surprisingly" not occur should the program exec itself again.

I had covered this case in my previous email already. This flag is
only used by begin_new_exec(), and the only consequence is resetting
pdeath_signal (point 4) and stack limit reset (point 5). I thought
both are no deal at all for the second exec - or are they? I don't
know.

> If you are unaware of this bit's purpose there is a nice writeup here:
>
> https://www.kernel.org/doc/html/v5.1/security/LSM.html

I don't see this document describing the purpose anywhere. It only
states that bprm_set_creds should set it "if a secure exec has
happened" but doesn't say what a "secure exec" is, and doesn't say
what is supposed to happen when it's set.

Is it really a "secureexec" if executing a non-suid program while
having effective!=3Dreal? (Currently: true, my patch: false)
Is it really a "secureexec" if executing a suid program but no actual
uid/gid changes occurred (no-op) because they're the same as before
(and no capabilities raised)? (Currently: true, my patch: false)

> See the "bprm_set_creds" paragraph. My concern is that there is an
> exploit vector associated with an abuser setting LD_LIBRARY_PATH=3D to
> something nefarious, and then invoking a setuid program that happens
> to re-exec itself for some reason. The first invocation will be as
> before, but when the binary re-exec's itself, I am concerned that this
> could cause the privileged binary to load an exploit.

How would resetting pdeath_signal and stack limit affect this problem?

LD_LIBRARY_PATH is an environment variable that's used by the
userspace linker, not by the kernel. Userspace doesn't have access to
the "secureexec" flag. The usual protection against
LD_LIBRARY_PATH/LD_PRELOAD attacks is that the glibc ld.so ignores (or
removes?) these when it observes real!=3Deffective. That check still
works with my patch, and has nothing to do with the "secureexec" flag,
does it?

> This has nothing to do with your interest in NO_NEW_PRIV but more to
> do with the legacy behavior changes like this are exposed to.

Yes, I understand your worries, and I can limit my patch to the
NO_NEW_PRIVS case, if you prefer that. But I think it is worth
exploring the legacy behavior and see if there is really a problem
(i.e. if there is really a userspace-visible effect), and if that
legacy behavior really makes sense. To me, it seems like the legacy
code doesn't make much sense; the checks for "secureexec" are wrong
currently, and maybe we can fix this without adding more complexity,
but by cutting unnecessary complexity away. Simpler code that is
easier to understand is less likely to have vulnerabilities.

Max
