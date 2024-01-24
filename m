Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A9D7E760
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129275; cv=none; b=csnb1PxLPpgS7KjxXuf1xPpqjSl4dp+pLM5HbtyCwcWNtxlMC1wJaLTzBwSvzRBKyBDu3bP1dT14HWsU5fA4NmcDHbsIl01sC6eRcXjDyL5VaISNIcAnixhtSPQkOzbhcTveFVHk6QnAwEKCT5WII4TY7BSjPvK23yRbjOSTnyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129275; c=relaxed/simple;
	bh=7cPnVJTTwAqS5m/D9fwBaWJXEtqGZq8IcE/AOficsKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHjp0uo+y9ZYA3IRZTzjVDINz8nN27fWenDhfVUNqClCKRjXc9hLvx0tiDAfn4FTz4zUPK2wPi2g31sRkd8qBYJYbpKdvq/jgIBGpSXJ8jnEIi4tNzIb3np2azQpnJTsTq/Vdrq+qgPwHrNBqrOKexprxyQ5cKNm2SyfyUAGd0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SUN/4OWl; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SUN/4OWl"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55790581457so8014834a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 12:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706129272; x=1706734072; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rk3ry+wMmO/dN2zz3UHRD0lGEi4syprX1/TUT7irM/o=;
        b=SUN/4OWlUYlWYLYZ9vbkg5QVEfIKK10dzzJsUhdZABaaW07g7ypcreDM0HZaUbSZtz
         uePKNHCfIGZZv4XghoLpwqRuzGTGtVoQ71CibzvWq48US7+YmzOTcBhIWQlD9ob/cmDH
         xvAuO9AXRQA+x/eNm+B5rN94wMKl2VCvxzj1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706129272; x=1706734072;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rk3ry+wMmO/dN2zz3UHRD0lGEi4syprX1/TUT7irM/o=;
        b=i6trkqyXn9iKsnkHhjhmHrG2lR6VEo3hMK0Hh8uaJUFoj1BX5kMN6da/eJQJQ201mo
         LOy/VjYHM4/8rTh5eJTbIpU/GMJ/EkAY9zH7KIKkp+jZT+oEHvqEz8rMOUIyokN61gcQ
         oveBuQsp3sA6Y56pDjYBEONuKYekQfBbY+grSs4cjdBEFZIO5RE6qktx+iZQfLJaQqA9
         fZdS4VGN0QH4YfbH3S+Gutmukux08uExlh7P9fZ/2l5Y9vhftRgiGxeESS4pElu1EQwf
         51+a4/dvLkOzsnHCQ4/6npqsVsznP2JMWkpWdYYxhstcm73cS7AFUo7MV8hyjFKT8iPp
         zu4g==
X-Gm-Message-State: AOJu0YxCLeIbInU2whYoyC8DyIV2QFUvD1/nb4rVQuUvsW5PBABu+EIt
	jL10tmk+EGTgXO4l5Vlct98lxHaWU2Y4oBk2iCmOqUhNbSv7iVQyDNZDc/QPj60C5TekSr7pDX+
	JaPh+yw==
X-Google-Smtp-Source: AGHT+IEEMFby+b2UNlRrOkq6fwEVYHJPMBN9Yy/9IAXcWNAu5IgiFY1nim0RWrG2dsLrNw+I7p169g==
X-Received: by 2002:a05:6402:693:b0:559:d0ef:616b with SMTP id f19-20020a056402069300b00559d0ef616bmr14625edy.42.1706129271872;
        Wed, 24 Jan 2024 12:47:51 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id fg7-20020a056402548700b005593c83bdafsm12991382edb.45.2024.01.24.12.47.51
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 12:47:51 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e76626170so65472815e9.2
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 12:47:51 -0800 (PST)
X-Received: by 2002:a05:600c:4ec9:b0:40e:a3aa:a463 with SMTP id
 g9-20020a05600c4ec900b0040ea3aaa463mr1545745wmq.20.1706129271244; Wed, 24 Jan
 2024 12:47:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124192228.work.788-kees@kernel.org> <CAG48ez017tTwxXbxdZ4joVDv5i8FLWEjk=K_z1Vf=pf0v1=cTg@mail.gmail.com>
 <202401241206.031E2C75B@keescook>
In-Reply-To: <202401241206.031E2C75B@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 12:47:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com>
Message-ID: <CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com>
Subject: Re: [PATCH] exec: Check __FMODE_EXEC instead of in_execve for LSMs
To: Kees Cook <keescook@chromium.org>
Cc: Jann Horn <jannh@google.com>, Josh Triplett <josh@joshtriplett.org>, 
	Kevin Locke <kevin@kevinlocke.name>, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 12:15, Kees Cook <keescook@chromium.org> wrote:
>
> Hmpf, and frustratingly Ubuntu (and Debian) still builds with
> CONFIG_USELIB, even though it was reported[2] to them almost 4 years ago.

Well, we could just remove the __FMODE_EXEC from uselib.

It's kind of wrong anyway.

Unlike a real execve(), where the target executable actually takes
control and you can't actually control it (except with ptrace, of
course), 'uselib()' really is just a wrapper around a special mmap.

And you can see it in the "acc_mode" flags: uselib already requires
MAY_READ for that reason. So you cannot uselib() a non-readable file,
unlike execve().

So I think just removing __FMODE_EXEC would just do the
RightThing(tm), and changes nothing for any sane situation.

In fact, I don't think __FMODE_EXEC really ever did anything for the
uselib() case, so removing it *really* shouldn't matter, and only fix
the new AppArmor / Tomoyo use.

Of course, as you say, not having CONFIG_USELIB enabled at all is the
_truly_ sane thing, but the only thing that used the FMODE_EXEC bit
were landlock and some special-case nfs stuff.

And at least the nfs stuff was about "don't require read permissions
for exec", which was already wrong for the uselib() case as per above.

So I think the simple oneliner is literally just

  --- a/fs/exec.c
  +++ b/fs/exec.c
  @@ -128,7 +128,7 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
        struct filename *tmp = getname(library);
        int error = PTR_ERR(tmp);
        static const struct open_flags uselib_flags = {
  -             .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
  +             .open_flag = O_LARGEFILE | O_RDONLY,
                .acc_mode = MAY_READ | MAY_EXEC,
                .intent = LOOKUP_OPEN,
                .lookup_flags = LOOKUP_FOLLOW,

but I obviously have nothing that uses uselib(). I don't see how it
really *could* break anything, though, exactly because of that

                .acc_mode = MAY_READ | MAY_EXEC,

that means that the *regular* permission checks already require the
file to be readable. Never mind any LSM checks that might be confused.

           Linus
