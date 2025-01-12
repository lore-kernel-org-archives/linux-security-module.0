Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AB31BDA99
	for <linux-security-module@vger.kernel.org>; Sun, 12 Jan 2025 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736699820; cv=none; b=NaxtGLndsIeN6a2Xri/FF5PuaUuI19HCuXjNij5na2B2SaiMe4YFc1aOF5mjxN20cU23lAoHiYdKu2M5xuCoOMphgGEsFi/XwXjGZUIWld7xEh1bedbqoNtMuintNkjZUDHDd4P0Eb04+TFvK94KpcpMLes49oER8EezSiQ5v7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736699820; c=relaxed/simple;
	bh=mgdxqN0bYV7p1LBfaK8u0pPJA3FwFbTYbBJIMc8nJow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOy2YjTngRQdldrK51SkN5iTTnleKrh389XfSO9/I8tSRt5ef/A35z46COpuRl5HPRphS6MiNXDjdWEOKXVKkU6IcqU5weMaiXTZvmOlIav3vHMsqnqqa8BzBW/BkvStOEm/3JM7mcd3zmkbLFYv6HkwOh8YeAExkbXc0fTW6jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JpyerwBh; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JpyerwBh"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e53a91756e5so6168228276.1
        for <linux-security-module@vger.kernel.org>; Sun, 12 Jan 2025 08:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736699817; x=1737304617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vr1ktmu3cwRXhTgySXlqgLK2IZ2AAICyoWgt+rRYqSA=;
        b=JpyerwBhfrzAmHG/BYyw9E8c7TrMnB1CZ9hdbKA1/6cgCcJrDLSBusRFkkbB072uph
         DUiqIyIyPxoPnvU2zSe+wJlvdSNbOmiwL8hlfAl6Nuh9h8wgxLLHbwvLxwBiKhEVUfxL
         yl+sFRE0ZqdTp36YWl7t2g0hY8uxSi8ugDKzd15bmn68nYY0Pfe7JVFr9/FlCCmGLUE/
         qOHOl7Cd6/HvIz/lioirUAK92n0qY9b2mhERyNpjIHSXe/wQtV6kudafo9F3Djzdja4v
         16pQeHpoBGiLHmGUCNTi+YxypAOiWxZz8E+r7ehNH6KUrL60dpyessCeAXmSmQJcHuiE
         1Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736699817; x=1737304617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vr1ktmu3cwRXhTgySXlqgLK2IZ2AAICyoWgt+rRYqSA=;
        b=tLyBKzJwYuw3SR/4fqqEbL4lMaxXMZZ5bRTXvjk1Z7kF25YbFvQAP2lHR502DSjKXx
         QwbOKlOcwosnRGS49BysYllZJHgMyKyhY0So4cVAfveaeO4FfW0CgEx534qZFPTv3PNI
         USM6cB6rBcDwy07EWrOOAn37PhQZHcLEyRfPgwmyW/go95dFI9zKLGC18p7DIPIL9mGa
         YiQv7mAcqgzYi44WhBpIfW/1+2fwrtVPLrzwb8BGV8A2ZO9+jElSe8+IWozuUrnI7rWK
         1cTO+jx0wgCjhDGkSX6IYlW9H6GCZw4lwaBwo45OdUNH+x9JoCq9f+adCxSso2cWDmkr
         rqew==
X-Forwarded-Encrypted: i=1; AJvYcCVNWu/gbdKi619+mz3CZa4sOq4iO7KM6KccAdlr79DNv24wANXqWIT+KQhp5ppcgNAdCgKQ71UcMuqXo02xHxPJiDKwCFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNrsKeplMvw1kjzJfwC6lFICj+MwWwy5evQNthOWzthEtYu18B
	jiUJzYapmzKjEV8b6bDEH3v8MW6pAjaafAkQ83RRfS1WPrs1p7FC+rCLtzSf39QlEaaONgB6Wuz
	d+2FgUFTZ6LDJg6PZiQ2QJRciHxbbbKP4VRU0
X-Gm-Gg: ASbGncsemcQFk8+lGmO9qyjrOAzlkg+2Z8pQt5ib6/dNt7SVjIIXeAfnliTHsx/SWdS
	iLT/8PCjEEqWG6qnSUbSaYGDzFAaRYQxpu28n
X-Google-Smtp-Source: AGHT+IGIA6hMaBoWY4qF4q6O4nbIJYkuiC4pn3Ji5ObcZCNpPRu/wBbEKhJKyaUL1cf/zrWh1YtCi+h4orpQA8HPIdQ=
X-Received: by 2002:a05:6902:a09:b0:e57:31f1:9722 with SMTP id
 3f1490d57ef6-e5731f1a429mr6492655276.29.1736699816946; Sun, 12 Jan 2025
 08:36:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111.22fc32ae0729@gnoack.org> <20250112072925.1774-1-tanyaagarwal25699@gmail.com>
In-Reply-To: <20250112072925.1774-1-tanyaagarwal25699@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 12 Jan 2025 11:36:46 -0500
X-Gm-Features: AbW1kvYKYLPgf17jvvR-FCco9-QwNGcpYookaR3B9G1F3dpIui_cbJeum1-JgEY
Message-ID: <CAHC9VhRbZLtBZ8dH-kASnkQUehG4Cu=zd23A6Jj9zfnyeGOTsA@mail.gmail.com>
Subject: Re: [PATCH V2] security: fix typos and spelling errors
To: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Cc: casey@schaufler-ca.com, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp, john.johansen@canonical.com, 
	jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	mic@digikod.net, gnoack@google.com, stephen.smalley.work@gmail.com, 
	omosnace@redhat.com, linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	skhan@linuxfoundation.org, anupnewsmail@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2025 at 2:30=E2=80=AFAM Tanya Agarwal
<tanyaagarwal25699@gmail.com> wrote:
>
> From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
>
> Fix typos and spelling errors in security module comments that were
> identified using the codespell tool.
> No functional changes - documentation only.
>
> Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> ---
> Thanks G=C3=BCnther, for catching this error.
> The irony of having a spelling mistake in a patch that fixes spelling
> mistakes is not lost on me :)
>
> I've fixed it in V2 of the patch. Thank you for the careful review!
>
> V2: fix spelling mistake - s/beeen/been/
>
>  security/apparmor/apparmorfs.c      | 6 +++---
>  security/apparmor/domain.c          | 4 ++--
>  security/apparmor/label.c           | 2 +-
>  security/apparmor/lsm.c             | 2 +-
>  security/apparmor/policy.c          | 4 ++--
>  security/integrity/evm/evm_crypto.c | 2 +-
>  security/integrity/evm/evm_main.c   | 2 +-
>  security/integrity/ima/ima_main.c   | 6 +++---
>  security/landlock/ruleset.c         | 2 +-
>  security/selinux/avc.c              | 2 +-
>  security/smack/smack.h              | 2 +-
>  security/smack/smack_access.c       | 4 ++--
>  security/smack/smack_lsm.c          | 6 +++---
>  security/smack/smackfs.c            | 2 +-
>  security/tomoyo/domain.c            | 2 +-
>  15 files changed, 24 insertions(+), 24 deletions(-)

Hi Tanya,

Ideally this patchset would be split into into seperate, independent
patches, one for AppArmor, one for IMA/EVM, one for Landlock, one for
SELinux, one for Smack, and one for TOMOYO.  This allows for each LSM
maintainer to review and merge these fixes individually as opposed to
requiring every LSM maintainer to ACK this patch before it can be
merged.  There is also a risk, as with any cross-subsystem patch, that
this patch will cause merge conflicts in the future as there is the
possibility of multiple development trees touching the same file
region, function, etc.

As a general rule, if you have a single patch that touches multiple
kernel subsystems, and the changes in each subsystem can be applied
independently, you really should split the patch into subsystem
specific patches.  You also should post these patches independently,
and not as a single patchset, as a single patchset crossing multiple
subsystems can sometimes cause some confusion among maintainers about
who is going to be responsible for handling the patchset (even if all
the patches are split properly).

--
paul-moore.com
