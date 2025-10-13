Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58A02FB96A
	for <linux-security-module@vger.kernel.org>; Mon, 13 Oct 2025 21:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392685; cv=none; b=VzrDi1Fs69O6YoevSfDq7vHj4cVxGBDkr4I3ilQ6bCt9FGlfyCTE4Taf8fS5prjvFzeiGNjzoYLrcL+CAMGw8KY5Wl60Iu35T6mt/wEAkzoVFVN3WBqLb4CHemXZAaqs6V14ovxKJtXlOVlRPERByfq5LVDzX0sQmHrYKQ7y4jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392685; c=relaxed/simple;
	bh=a34WwR8TE6Aip8LlUbHfNQGz2RV/O8jHdj1Ny6Rgbkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVSEL6W/W5k69arT0i9OE0g3laXval5PPQnn8sVoE31jt0IlRd/8sY9j+hbg25Lp1tnT92VW/ReA7zNW4eL/zLlt5OnrPl3NSpOvW6d4PgxYCwgqLfMOBaRoyH4u7UNxeLCTT9StXe9iK8TbxZSfkOMQ6dja5GcgvRutogoWrn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NA23l4/P; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NA23l4/P"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-79af647cef2so1657779b3a.3
        for <linux-security-module@vger.kernel.org>; Mon, 13 Oct 2025 14:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760392683; x=1760997483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHuZLOyOM7eE9XI8O0kZg4fgFmCZ8ASKGqgY/QnK7/8=;
        b=NA23l4/P60PYJsDuxUJg1fonq4VSvJ5ZOcY4sPT61IUBTPVBh3fpvcEVLwc6IOI9pN
         0NpshEsnF2Gqavjgqt1zsqlJFNZbaOhy+dleeew6x1aTAloSRuKwBVRuNjPEYb1NmpFW
         DwBOhSAzc03AGKdyDUalOQAiK69F7im+QuioQZn6D1XCZNv9atc2HEwTRgfQ3YfvZG04
         jGUuxgWWnu5AT/jAvf+P4JX/zsSIrtQ134xMFCjW7Qh62MehSSp+Xpz8mt6QMSlXX6y6
         qRJziyYYgYpfflXDqOzzIbYcNi7q4c6cPcvXirxAl0RAPenbSVTU9vOZ7vTvsglTzHjL
         B7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392683; x=1760997483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHuZLOyOM7eE9XI8O0kZg4fgFmCZ8ASKGqgY/QnK7/8=;
        b=JOHWBVWe9goxqggEpdKFRhcSfb3TF8IcAOLZ1V8fXMCaVVEIKII7DHi1b0aDIjw4ZK
         1PV3AveD5lY9jBL5q7Dq7GK8e/Rk8zTxqTwXg9v3aPPyIWfLOTMCqbu7SvSjROuhL++8
         hxfbeQWr7TjnPy/M+dnjWqWsIw8FzagYsBULCBaNAbs5qJ0H9zm8Ng2lsd4Evgxmc5O9
         dZbxEr5TDLR6krizfJxl9zJox62npyxz/bbbh1CIxzv96CfPFRvWlBl24/GJEynusyC0
         Vbk+EoPLODF0Ey6iMON+RoFa8HZPFQMMc1NSwMdeBpiLT/r1TRazgTGT1r4mbSZPPdAd
         LHpw==
X-Gm-Message-State: AOJu0YzMCsMKi67QYJnCvSfpexKaj7DeEVSKxEvMgZX4qbvr4lmZpIXG
	31VUjxIVK6pGc1+cJwM6WL4HIsdgMiarRzIucfblj1+gX19QIrzmTM8jKDVxFvYFxnsrh9O9H82
	9CFlNP14Iw12BWBXj67W7LqL1UCx98vLcDOwt0wLp
X-Gm-Gg: ASbGncscrkbEUw5ZvhWLlqvqWRBhiasgWxZ2u72Ox3jJm7DBXR/41+5yG44TD3SF5WW
	V6TKmHM76LlvmIGqRrcAAYAJ/4A5V9niY+HSau8isyZn6Rbslc+2RDWg7pfuMW0CkmYefWA2R9M
	7prddmBVTxadHvPsXedfVmR1aJAtPw59MWHE9rAx5H6hp3/eKjVzDk/GXqIxIhswUeHwpoIVsO1
	Pt5Ap7VI33rbmoVL3i+yJaeGd1D14hNYOqD
X-Google-Smtp-Source: AGHT+IHlB0VII3A3IwzmNDnKhCczB+qBWIrTNLYC3M16p8OAtV0z8FLfkNPVTBLZSOHZq13gex3BeUt78NYZRp8U3sk=
X-Received: by 2002:a05:6a20:1585:b0:2fd:71cb:e8fe with SMTP id
 adf61e73a8af0-32da80da680mr30442372637.10.1760392682856; Mon, 13 Oct 2025
 14:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001215643.31465-1-casey@schaufler-ca.com> <20251001215643.31465-2-casey@schaufler-ca.com>
In-Reply-To: <20251001215643.31465-2-casey@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Oct 2025 17:57:51 -0400
X-Gm-Features: AS18NWAwjSZ_k0afShpLgHgWO3Dk4i9SeBTOoW8dS7ECmUQlZYriulh-t6qGbek
Message-ID: <CAHC9VhTJBSejFr78csXudG4xKW5hXVy3undDP-m8YdjhJLYrYA@mail.gmail.com>
Subject: Re: [PATCH 1/2] LSM: Exclusive secmark usage
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 5:56=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> The network secmark can only be used by one security module
> at a time. Establish mechanism to identify to security modules
> whether they have access to the secmark. SELinux already
> incorparates mechanism, but it has to be added to Smack and
> AppArmor.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h        |  1 +
>  security/apparmor/include/net.h  |  5 +++++
>  security/apparmor/lsm.c          |  7 ++++---
>  security/security.c              |  6 ++++++
>  security/selinux/hooks.c         |  4 +++-
>  security/smack/smack.h           |  5 +++++
>  security/smack/smack_lsm.c       |  3 ++-
>  security/smack/smack_netfilter.c | 10 ++++++++--
>  8 files changed, 34 insertions(+), 7 deletions(-)

...

>  /* Prepare LSM for initialization. */
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c95a5874bf7d..5b6db7d8effb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -164,7 +164,8 @@ __setup("checkreqprot=3D", checkreqprot_setup);
>   */
>  static int selinux_secmark_enabled(void)
>  {
> -       return (selinux_policycap_alwaysnetwork() ||
> +       return selinux_blob_sizes.lbs_secmark &&
> +              (selinux_policycap_alwaysnetwork() ||
>                 atomic_read(&selinux_secmark_refcount));
>  }

This is an odd way to approach secmark enablement in SELinux, and not
something I think I want to see.  Ignoring the
selinux_policycap_alwaysnetwork "abomination" (a joke I think only
about four people in the world might understand), the
selinux_secmark_enabled() function is really there simply as a
performance optimization since the majority of SELinux users don't
utilize the per-packet access controls.  Using it as a mechanism to
effectively turn off SELinux's secmark functionality could result in a
confusing situation for users who are setting SELinux secmarks on
packets and not seeing the system's policy properly enforced.

--=20
paul-moore.com
