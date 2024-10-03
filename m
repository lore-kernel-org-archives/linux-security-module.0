Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB8819DF92
	for <linux-security-module@vger.kernel.org>; Thu,  3 Oct 2024 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969573; cv=none; b=FwB+SvTvhlnT8gr+8gJ59QOt+t4tgwxq17jZfrUx1THqfxxZGNuDDYiAfGwdsS86jXEyDubQZwqoAyYt//hYOUl/GXh5REHrI4c1prb6dwOeT0NGijOsFWk4ek9ur/xTtv3uv9W9/6Xww1bHDly1OOpM0iyz9Hrj0GI+9QB0nQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969573; c=relaxed/simple;
	bh=8weqr709BfoEL9iOQY3OC+ipedBddqQa6WKZ7oOPh3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/HmQgmwBFSAE5HkN9arjQgF2+A8UCJyI/iFoxzJCpdsGx9HY1g0pp+xKzi6Cg9dyEUg2GgrJ13U9iaTVy4cO+HVQ9PW15xaPuxlF1oxSu03RBne86b667YfPV+RnT9UGRWjbWtwd0P2WdUeFUApnsXFQenPQS03XEOSwfat424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CHfPO6Un; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CHfPO6Un"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6dbb24ee2ebso10873567b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 03 Oct 2024 08:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727969570; x=1728574370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HFRYKXbAMWs0srCc1X2bWC6dhYqvFE2OeEGwjCGAgw=;
        b=CHfPO6UnKXbkIsJUBHUT6YztCRifgHs+xP008S/xDs2gK/JeyfCKk8b8K0HtdxVvD7
         7hGLvVAZHa82q3BkYFGDqVS4I1Eic4l13T8I8yagu8Cuac9gaNKnBkLjf3QG0xkhNYMG
         Y+CNoL3c593ZHceAjKmNYEZkB03bq+nvgqYEE8TQ7rnq0sWhXUaJjLtUwq4RMCJEikC+
         0g2x0A85aZIgLptAqr1zw76WeHRqfhzraNwTqmFOdUuluGBMlWFCXz/amV9mo0Cu20IJ
         QYk7iTdYi6tOO+vyhEsCpqpuFJtHfDcRgaq5KVU2L5YMEa9ayzL77JqaZe+XCskJMy/q
         61mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727969570; x=1728574370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HFRYKXbAMWs0srCc1X2bWC6dhYqvFE2OeEGwjCGAgw=;
        b=HBI97jdbGvKWHkklRP2LBHPMVARYUwYlWzRjF3jbS8N7or0Fp45OnT7ztmCviK2tCh
         x8kO7XuZ5qJLe4b4syK54pvZozBfP1nfdyD2G2Vu1EFcsQdx3V/F+eJRAFOI9DIheih5
         KeqMSvFvqbPymWNx9pBaHdtYhWGn4JDUUADzL3pqPGdyxts/QFp9byBLiHHTxgKD/xh/
         1eAgQIIjcyIsJQjX7sisJ/vK09PNJ6L1c1YWTg8CdaNabKTz8VayIrRDxB6JXLrVQiN/
         BLqDsadSar8nn0+PLWsJ8zrnlmdAK/bAIUkwrJ2iIK+B5Ef/PZB78ObIP1lf1C619Td/
         O3Bw==
X-Forwarded-Encrypted: i=1; AJvYcCV65muhOKxHaqzvMCL5lS6xndxYfcT8y6KGBUCzsB94/eDPE1GSZJYyvIQZzBVLAjYPynkb5rRVpgapG+OdEWDhviltzNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCJWvnQaE42KbRK2udBO7vR/dPBdYbNkufGZJj48MShDwvpvcS
	qo04hke54ultKoRBDjvL+twTDlB+cv+KzvfsLbA8SIwM3kmLAwWAhQX3wANpNpgLEoSAcbjM8po
	5k7nygV/w5rwucJtcY8sOAryCijKn+fw6IxaK
X-Google-Smtp-Source: AGHT+IGZDvnEJvX5eOrGwlGawzdHjXogpp6tqLgSMDUt1fw2Ul1fXEb0Z8ggDi9ZrTpZGjWuKJXxKSGot85YtWJhSN4=
X-Received: by 2002:a05:690c:660f:b0:6e2:1467:17b4 with SMTP id
 00721157ae682-6e2a2ae053dmr64208017b3.9.1727969570233; Thu, 03 Oct 2024
 08:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <20241003024307.GA833999@mail.hallyn.com>
In-Reply-To: <20241003024307.GA833999@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 3 Oct 2024 11:32:39 -0400
Message-ID: <CAHC9VhSa-Jpqmej=3WsLFvSKWamZjFDwUpLHrJOyxaPPujM6ww@mail.gmail.com>
Subject: Re: TOMOYO's pull request for v6.12
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Fan Wu <wufan@linux.microsoft.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 10:43=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
> On Wed, Oct 02, 2024 at 04:12:50PM -0400, Paul Moore wrote:
> > Hi all,
> >
> > Hopefully by now you've at least seen the TOMOYO v6.12 pull request
> > thread; if you haven't read it yet, I suggest you do so before reading
> > the rest of this mail:
> >
> > https://lore.kernel.org/all/0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love=
.SAKURA.ne.jp
> >
> > Of the three commits in the pull request, the commit which concerns me
> > the most is 8b985bbfabbe ("tomoyo: allow building as a loadable LSM
> > module").  The commit worries me as it brings management of the TOMOYO
> > LSM callbacks into TOMOYO itself, overriding the LSM framework.
> > Jonathan raises a similar point, although his issue is more focused on
> > the symbol export approach itself, rather than conceptual issues
> > relating to the LSM framework.  I will admit there are some high level
> > similarities to this approach and the BPF LSM, but I believe we can
> > say that the BPF LSM exception is necessary due to the nature of BPF,
> > and not something we want to see duplicated outside of that one
> > special case.
> >
> > As I wrote in my original response to this pull request, this is not
> > something I would accept in a new LSM submission and thus I feel
> > compelled to speak out against this change and submit a revert to
> > Linus.  However, as the LSM framework exists to satisfy the needs of
> > the individual LSMs, I've tried to ensure that significant changes
> > like these are done with support of the majority of LSMs.  I
> > understand that in a case like this, reverting LSM-specific commits,
> > individual LSM maintainers may not want to speak up on the issue so
> > I'm going to let this message sit on-list until Friday morning, unless
> > I see the majority of the LSMs voicing support *against* reverting the
> > TOMOYO commit above (and the other related commit) I will proceed with
> > submitting the revert to Linus on Friday.  I would prefer if all
> > responses are sent on-list, but you can also mail me privately with
> > your objection to the revert and I will include it in the count.
> >
> > Thanks.
>
> Huh!  Honestly, when I read the thread, especially Jon's comments, I was
> worried.  But getting a chance to look at the patch now, it actually
> seems good to me.  No one is getting affected unless they enable
> CONFIG_TOMOYO_LKM.  Even those distros which have been enabling TOMOYO
> won't be exporting new hooks without a config change, iiuc.

I don't want to set a precedent of individual LSMs managing how they
plug into the rest of the kernel; at best it results in a lot of code
duplication between the individual LSM and the framework, at worst it
opens the door for buggy interactions and difficult to predict
behavior.  Look at all the work we've done over the past couple of
years to cleanup how the LSM framework manages the individual LSM
callbacks both to reduce the chances of error and improve performance.
Sidestepping this by allowing individual LSMs to implement their own
layer of callback management is a big step backwards and not something
I want to see supported.

--=20
paul-moore.com
