Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D632236FC
	for <linux-security-module@vger.kernel.org>; Thu,  8 May 2025 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716634; cv=none; b=lgxh18+KxGL2fMwF7mfTc69+4IhmlYVErGknBEn76tzT4cDjJoESodpBkNmxVs+eZ+nLj0d4ZgUoPAH9zuEeua4K4e2LmZiUl6GYCgwefZ0iJ3lrfOTMTbZu8nQxNkXhIEXUXS4yw6UzBPrzfiIu3FksaUy4MBnxMcBkqqt4Dl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716634; c=relaxed/simple;
	bh=VrSl4gPPjSpPfFFi4R1VQBb3hFTafvuzLb91HwEIaV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcOz8vBE5ptqV2pyRRffXycBNbgsjT6u+uYUjG2X8SYtlzOjexrLrpCQuj4bhZAMkh/3WdmPsXUs11sa9IhFPKG8B/bgFiVzYK+r0W9dHSTQuX14bmMok7itYTVPah+ZoAr3JmZMCE0WQo9KvXLGOoNT7Cpc6m+rPJoLpABT3gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LHBoDydH; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LHBoDydH"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7081165a238so8825617b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 08 May 2025 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746716631; x=1747321431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hATKNrt93mB3fMVlgIKe7zWgg5+8HzK0HE/V6v7FmAA=;
        b=LHBoDydHsMNmk16aAVrdD2y0x5ViJZPn6txV0b7/aCq2TNYB4lmOp7Rlwu36hLgYQ0
         esMCH3fHO8EYnd3QUCeoTzRi21G9JfKofRmV4TFHbrIV/pGYC0itnET7PTw1Y4OOYdwE
         3CHAiE26ydSPTGIQi5rprhYa5fx4Y9+srFX6BLPEXc7Ez8M+dGhN8jGYn7XtYXtOwXkj
         xCh7BH3GwEwI+/y9pGMDFcBs3+LhO3O2Y+b9IUWoOWujPtiHLqL5w+L0GZ/awlkXNMn6
         uaN2QBDxpP/bpM8okjOak+17cMKnUVqFmYPt1Q6kd9SE87qN0jMEwXBHy5ujFmYmFjnJ
         Z+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746716631; x=1747321431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hATKNrt93mB3fMVlgIKe7zWgg5+8HzK0HE/V6v7FmAA=;
        b=f+GmGCixiztC2nun85jkhQAYE17Ol/CvNiz485qPblsmgUzByS+IXGiWysD584dUs7
         kXKa52HQCFUSzeUcgf90j0eDUzGDeWFoXqKPxfMz6Ei7IHXTDVmvSzqnWhFkAUVh/6f8
         Ne24sB2u1nDvjbA8yp9WmPssD+dZbO/bujhv/qOnhXPO5vRBjsk5jR6yjKRnIGjRKyRR
         r9+LKf4JQlQ2bywp3Vp0lks7Y10M3B22qt6YQ3+b5sgrZBFlpuFYNauEXPqLgMN6X0Vb
         93k/+Uro6q+D7XkayBJOh7bq9vGndw9guJerbiqak0SCXlS6f9HcL7clGaWUSEOTAFpP
         g0SQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8Qry2wWdyhoi+7fO979ea3oVUmS2ktReeHVJNETl+zq3TvEu1I4j4WSWurY8y+7MUqVEavNZSnTykNqMUxRDayvkantM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKyC0rYWtCWI5grk93GlOwzmP5j0E79+Q+OBe8lqM1VwIwZ+Fk
	2ZJem67mTCE5iUGzaU8E0ELPkxAux0Cg65lAeHzsAawVWAUs5wdjJI6j5toJhMAHcb3ySJo+QV2
	xwekLJskZGInxm3tPQTP9Xb/5u4ldz0Ocpt+Q
X-Gm-Gg: ASbGnctJunW0dZ4ZHsXQUqaIJ5VJhOMD8BcSpZI41vTvNHCJIwZg5ePEhChwuCSpQX8
	ufVNZQMlzIYBqECBZqbmdbjWl+5Aou/4IjSB93RVr0djxpdwAXlY2o8IIgE7T1FbU8XBIqKIAMV
	uTcN+yp2vwohLQNP9sHnMWWg==
X-Google-Smtp-Source: AGHT+IG4g33sVMHNUyxeA8WXy5u8pEWZR1PbgdyZZRQWc+iPwrPZ0gfTdbqESem4l6T8ijd28pEZpuM02BQ0QbC+jeI=
X-Received: by 2002:a05:690c:6c07:b0:709:1b68:9f5c with SMTP id
 00721157ae682-70a2ceec6admr57527507b3.16.1746716631367; Thu, 08 May 2025
 08:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhTiABmrJNkTYSfTQkjAS5u-GJdYxd+zJ8PcryScBtsXNA@mail.gmail.com>
 <295201ef-5299-4bf0-b0ee-6e1e2a74174b@I-love.SAKURA.ne.jp>
 <CAPhsuW4U5ULtOQ9ucucs3bs+jw+EbBzrCfhAuvOCO=1g5aWAHg@mail.gmail.com>
 <a6d26d37-3475-4f3f-829f-0883dbf8014d@I-love.SAKURA.ne.jp>
 <39ad6f58-db30-4c3c-a3d1-f0af516025e3@schaufler-ca.com> <CAHC9VhRk1H6OVTF-peV-Rr9PK6aDmyUeM1G7bgE8e-pAvA=FSg@mail.gmail.com>
 <4e25a66a-dd02-4c57-a6a5-4ccaffb48518@I-love.SAKURA.ne.jp>
In-Reply-To: <4e25a66a-dd02-4c57-a6a5-4ccaffb48518@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 May 2025 11:03:39 -0400
X-Gm-Features: AX0GCFvKWPzepbz_JeEJd26ZHoOUobG6Yw7XKG8FuTy8vAGGhEVCZPblzBOC7Tc
Message-ID: <CAHC9VhSB5CieCBrbB-GPfvVH3-TmS1J9P+dPP_b9M+rm6sQCvA@mail.gmail.com>
Subject: Re: [RFC] LSM deprecation / removal policies
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Song Liu <song@kernel.org>, 
	linux-security-module@vger.kernel.org, Fan Wu <wufan@linux.microsoft.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>, 
	John Johansen <john.johansen@canonical.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 10:14=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2025/05/08 5:14, Paul Moore wrote:
> > On Wed, May 7, 2025 at 12:24=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> >> On 5/7/2025 4:06 AM, Tetsuo Handa wrote:
> >>> The problem is that the owner out-of-tree BPF LSM solution cannot joi=
n the
> >>> discussion about LSM hooks being modified/removed. That is, out-of-tr=
ee BPF
> >>> LSMs will be forced to stay as unstable as out-of-tree non-BPF LSMs.
> >>
> >> The same issue applies to out-of-tree filesystems and device drivers.
> >> There's no problem that is new or unique to the LSM interface here.
> >
> > Exactly.  Out-of-tree kernel code is out-of-tree code.  Tetsuo, we've
> > already had this discussion many times, and my opinion on this has not
> > changed since we last discussed this topic.
> >
>
> Out-of-tree filesystems and out-of-tree device drivers can be built as
> loadable kernel modules whereas out-of-tree LSM modules cannot be legally
> built as loadable kernel modules. And replacing the whole kernel in order=
 to
> enable out-of-tree LSM modules (or in-tree but not-builtin LSM modules) i=
s
> a big barrier.
>
> Also, how many LSM modules have been accepted as in-tree after you starte=
d using
> LSM ID as an identifier? I don't know how many device drivers have been a=
ccepted
> as in-tree, but generally getting LSM modules in-tree is much difficult t=
han
> getting device drivers in-tree. Yet another big barrier!
>
> This problem is new and unique to LSM.

Unfortunately your argument is old and tired.  Tetsuo we've
exhaustively discussed these issues more than once, until there is
something new which warrants a new debate, I'm done discussing this
with you.

--=20
paul-moore.com
