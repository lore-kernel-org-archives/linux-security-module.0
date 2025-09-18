Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190B022D7B5
	for <linux-security-module@vger.kernel.org>; Thu, 18 Sep 2025 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209275; cv=none; b=LzkX+VlSOx1JVMu9KnUAfdlZfmAL2LxRH2S64cng9OsiiWLvvfPbFLOIJjo4kfoF29IHull7f2i9RpyTnAZpSe5r0ZjWZ7rikVOPiP60KXBteTT+sFWejp7jpZ3CBKGEZnjGVcDc3enMeNAGJUWyysBq20R3/1uH20HASZ8/gwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209275; c=relaxed/simple;
	bh=HXvQiKWsrrHBdZACQbTWrX32g69RA1tMFfDPMY+ssIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2+o3ZxbQ4VS8GUY6yBRRKkAIQ1vkr0BqwBKO+IHQWG53jw0EC9alYHu/xhq9rp/JD3zTjXWouGnkY9QDbZ/S8qA0JbQNcMrgeBmDGj6Z6fM/PadkxrkFB6bSkBv8SbfFR7nVVxE4wyxMK07ZRdAVC/fznojPLFX2LmN8GuqqRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HE1jRdqh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HE1jRdqh"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2445824dc27so11332615ad.3
        for <linux-security-module@vger.kernel.org>; Thu, 18 Sep 2025 08:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758209272; x=1758814072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9usXAm7mnQ2i6AJbPrd0D0V8P+IxkfPi+oCGWh2MEZs=;
        b=HE1jRdqhb/bVK2e1hfRNhAHq97SKOklDUV8FCsdx9jxdfinSmXuadzc+aFqX0s7QwE
         6guJAaakj2iWeEI07uuDivcPXSDQJnUMp9nlsojMvkghFB9LTZ4arQLnjnrm2QmZxnwq
         tOPYiBC2qIX8hjQ5QSGSrnxTLGG4rcg7AohKKqQkAL6934GoDzXqsimOs6p9HqIqY9N2
         +ZDCb/0K98MpVlcUKWwdMfGYeY5F+0EgGJ/sYgndmpWydHI4j0Gf4QjnhEnY9LFrq9y3
         aNjDafxyknsAnKv5tgK4EGO4+IblCtOJgeaOapBw8fIPP8bvR4CbTiOV0nQGu41yZTBd
         Td4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758209272; x=1758814072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9usXAm7mnQ2i6AJbPrd0D0V8P+IxkfPi+oCGWh2MEZs=;
        b=siwBxaVaA7UpV/7mWi1C8vv7+TXo9JHtgKsvqMlRQCzmNcOlunSwAZVui8i/CFVwkg
         PFALGfp/oPrNc6RKxWoNvZGMaq5N94N7SnnTkQqZ0Xyjr4377pBWvF6wSyB3S31WGq+4
         bDyJwWjx/RIsr4G3+3pWaoGMaTY2090gdOG12IfTa+czoBQKAw8Ht8o3nCOjZxZyi6TN
         wctBS43if14YxbDO+/oFXiEUCeyCVY5dH7nJ+hrC5CHkyA9jDgfB9CYSTRaVH41ctynh
         dTYrJRMhzh5R+ZPrA8qN5iSLc5vJKaxwK0eCfxa1H/aibi/GHdtvoMIQziWr7mXbPFNZ
         /kkw==
X-Gm-Message-State: AOJu0YzTiMh4/k63HFGvvWDDqv42tqCqD+IPVmDSKrVmwAUXwCZ40aNT
	nhzIFmGrON6okaVDfrXY9H032OfC9PdUXMK7Jv+ylK8iUcefr1iUSBWSwVWCJJCGPjQJVtYMToO
	7+iNkkA+Y5WslLDNzo8EsW/Kf6JkstrJAeFRDjEGv
X-Gm-Gg: ASbGnctSeQojle5TSLbvmMk5BdVTowQgJI6jVJ10vSHblE3k/hBoy6iuxsrpdrA1QIf
	kepGF8buHPzkRNtsuN7g9Sf7qBjGyXx1+98F2UY5Xt4nE5AkqWlL8DaFpI6ZQ4ZltrLMr443+6m
	jIaxnmKrm+U6lHTPXYtRCL0v2v/OuoekNP86ay8DQI+Mt3zDfWlHoYDGRljDOS3nG3a2rCoshMR
	O64rE2fdf/7Wd5wgpyVOT1NxA==
X-Google-Smtp-Source: AGHT+IG7BDPCip6fQa6ARXPNfQrjCV+vC+xcORBNq41mtqWS9WAdTM6NdCI+4xWkS1H6z+w3/aesgQolKoF2syk/PGE=
X-Received: by 2002:a17:902:d544:b0:249:3efa:3c99 with SMTP id
 d9443c01a7336-26813f1e97cmr69129925ad.61.1758209272366; Thu, 18 Sep 2025
 08:27:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916220355.252592-36-paul@paul-moore.com> <20250916220355.252592-60-paul@paul-moore.com>
 <598e9ed199ba23e7e11c5ea29132bd2e3202305f.camel@linux.ibm.com>
In-Reply-To: <598e9ed199ba23e7e11c5ea29132bd2e3202305f.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 18 Sep 2025 11:27:39 -0400
X-Gm-Features: AS18NWBPsneqht7dFrXISa1pEsxcBNxr7SK4dsIkWlo-NPzoZeCCloIzwU8sIuw
Message-ID: <CAHC9VhT53+2qvJT8Cpw5aYsbyT057Q2y0LZwDziRiucuzbUbyQ@mail.gmail.com>
Subject: Re: [PATCH v4 24/34] loadpin: move initcalls to the LSM framework
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 7:16=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> > Acked-by: Kees Cook <kees@kernel.org>
> > Reviewed-by: John Johansen <john.johhansen@canonical.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> For the first couple of iterations, the patch descriptions needed to be a=
dded or
> improved upon.

As was discussed in the first cover letter, and in the related
reviews, the first iteration was simply a FYI primarily for the sake
of Casey who was working on a patchset which has some overlap.

> Some of the patch descriptions are still missing (e.g. 25, 27,
> etc).  Is this intentional because you feel it is redundant ...

Yes.  Take this particular patch as an example, the conversion to
using the new initcall mechanism for Loadpin is perhaps one of the
more trivial patches one might see in the kernel, the subject line of
"loadpin: move initcalls to the LSM framework" is sufficient to
document the patch as far as I'm concerned.

> FYI, teaching newbies how to break up a patch set is not easy.  This patc=
h set
> is nicely broken up and would be a good example.  However, leaving out th=
e patch
> description would be teaching the wrong thing.

Documentation is a good and important part of the work we do, but
redundant and/or excessive documentation simply for the sake of
satisfying a checkbox is not a good thing IMO.

--=20
paul-moore.com
