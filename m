Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15A382D84
	for <linux-security-module@vger.kernel.org>; Wed,  7 Feb 2024 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329547; cv=none; b=HoxZcZVBHBT+lulfaB3wd2DMe+PmGz2JDwTCHztCU6Y+HEYhRf0VmGd2dlc7iFTWruzXzbofUegIuK6ui6k0usEIc7tN+nClXaRu8Jjlh0QI7tH+V4TIgSSe3Ru81AJE1O1Y+v0VXScR0Cj53Ny4auiYnW4RC4Jq4w+o4bCgkck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329547; c=relaxed/simple;
	bh=HemVGK6zZne3B0GajBNYqVima/P4OLJW7RPvot4BnIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciKbL1CJAADo0k+XxaN7nTtA1/QoeudgdGE2DosoQNLbHW0l5pO2v9n1XpTKvwC+JuuWC5o5QDa8xlh8JgbU00bFFjYcrPStZpcQVZADVg2U56f7dMiwPThqRmHn2Ecjym63+gca6exvOCt44R+cgymHCBsw2o646Sbww5pXT+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SWReDU48; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SWReDU48"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6e080c1f0so974691276.2
        for <linux-security-module@vger.kernel.org>; Wed, 07 Feb 2024 10:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707329545; x=1707934345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hHXbmrv3ps1sMVSmLFG15zm3/Plob5tS/368EqKz5w=;
        b=SWReDU48FE7BclzS2BxrGrfX+g+CGjiVq0wUg09cuz9SyES6ugYQ7Lm6UvTijviwcO
         tSkY9hIEDdWyIdw0VWpCZLPduw5Uxtrn6aLpU2VScppiocx0+zKxTVby62emzn8JcOth
         yFRa0KaCzlOjDXa8L7VecFSlHMKb4eG/N/zaZJyQxcpoVAN3wH+Rf0pDiWsfTTLVdW6D
         6js/jtMKe06gp35Nziyib/+X8yA7wazlz0VXWZddYfeQPgiYvx9ziTvG47XTWvvI5nby
         L8t+zNZ/XYGWX1B7kG7BWW9yE5D03ZoJIw2BoavzC5rh1s5UORbC+XfkdQ7jchiRNCZn
         L/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707329545; x=1707934345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hHXbmrv3ps1sMVSmLFG15zm3/Plob5tS/368EqKz5w=;
        b=ixegxzC07MZFV4VDHJuMg6MR6geKA32RwBNXTeE97loZKdfAheO6hvAEfTQw/NYdgl
         AN0CX7dQBb6wg1Ds9uV3YJWK/gUyyrOVOami0lg5y47JghsEiIt2dqaLpz22Feh/HXtO
         TBBhW5ZG+YfprAGtt+GuKKi6QJGxNLqLA30RbJBckC5PypfPxtlsoTHEZnig5jBgvq9X
         yhFpotxW+0RqA/HAm9ZGU/5880tepaOZTzHi1az4NAP21K8dj+6hcctgeJm3FwaOHeAo
         d1pBJN6PGOCcV+hLYBW4Ob8lT0zYJx8uNVeqTGkJ0IRBS8PITQY6vcYQYQbs7aW47XrB
         X0Ig==
X-Gm-Message-State: AOJu0YzrJyuEWipaxRsGgKhGJq+XINIevt8KVo/l0koajoVaAh9H7Ld/
	eLOg33wcpGn4JXwPMAr5HMEuGWx6XYBZkevqatMPX6bKd1rTCIqhdQKUyACLOpq6lJ/lbr0eKLZ
	uz9u90fHPSxBXU4zc609HAg9bELqValjRHCFP
X-Google-Smtp-Source: AGHT+IHxnQ5vAEAJSNuMes3+eXgpNC1vkbsCULnqxfu1b77zpdub65nMVS21AFiTfVqgPjNJ25GA/1LSAKxOdxXqZY4=
X-Received: by 2002:a25:ec0e:0:b0:dc7:1d:5db4 with SMTP id j14-20020a25ec0e000000b00dc7001d5db4mr5835418ybh.34.1707329544772;
 Wed, 07 Feb 2024 10:12:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
 <999a4733-c554-43ca-a6e9-998c939fbeb8@I-love.SAKURA.ne.jp>
 <202402070622.D2DCD9C4@keescook> <CAHC9VhTJ85d6jBFBMYUoA4CrYgb6i9yHDC_tFce9ACKi7UTa6Q@mail.gmail.com>
 <202402070740.CFE981A4@keescook> <CAHC9VhT+eORkacqafT_5KWSgkRS-QLz89a2LEVJHvi7z7ts0MQ@mail.gmail.com>
 <CAHk-=whSMoFWCw=p1Nyu5DJ2hP2k=dYmPp-WjeY8xuc7O=ts7g@mail.gmail.com>
In-Reply-To: <CAHk-=whSMoFWCw=p1Nyu5DJ2hP2k=dYmPp-WjeY8xuc7O=ts7g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Feb 2024 13:12:13 -0500
Message-ID: <CAHC9VhQ4UZGOJg=DCEokKEP7e5S62pSax+XOgiBB-qQ=WGCbOA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] LSM: add security_execve_abort() hook
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 12:57=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 7 Feb 2024 at 16:45, Paul Moore <paul@paul-moore.com> wrote:
> >
> > Okay, let's get confirmation from Tetsuo on the current state of
> > TOMOYO in Linus' tree.  If it is currently broken [..]
>
> As far as I understand, the current state is working, just the horrid
> random flag.
>
> So I think the series is a cleanup and worth doing, but also not
> hugely urgent. But it would probably be good to just get this whole
> thing over and done with, rather than leave it lingering for another
> release for no reason.

I've always operated under a policy of "just fixes" during the -rcX
period of development, but you're the boss.  Once we get something
suitable for merging I'll send it up to you after it has soaked in
linux-next for a bit.

--=20
paul-moore.com
