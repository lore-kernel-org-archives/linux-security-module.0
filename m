Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C28133426
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 20:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706127308; cv=none; b=CY8rpEvpLMYk83bLLZxK1PMPMLYbifeRnQGnYnre8Iik5gz3RTJU0tyAZGva6/tqqWbXmdg5xGNHa6ayBMk8luBdQH334kQuLD4OkadDJCmwqJH/dXJsbn+EQCEjCjGMrGx84iHdjNqOSTjYTmDh4PHxQHPUG+TwZPMJxOKc5xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706127308; c=relaxed/simple;
	bh=qgrbcEGeImcGchUMQ4e+5muNpBrHulW7Z5vgrHJx0zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FB1ykevGlMyuo/yoEkbCTHGyf3p1KKLxFf5tzr+Spp6mSQsPKw3lGHsFprHYabYXsf54qQe3H0zRsTGx9dBVj2uR+GlPweXhog5igN7Lgq4v9UPyXAhVLW8YK8VtYqpPLIZBbU7gFMDsmc3ncTr1ylYRgYlAcxxi6e0GcacNRD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FjdZxPgE; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FjdZxPgE"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6dd853c1f80so24052b3a.1
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 12:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706127307; x=1706732107; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Id1qRAoiWWWvqW/dbMxgihjX2oP7pYm4HN95FDf9D2k=;
        b=FjdZxPgEPFJ7RZPevFfZMqlA39csXfimhSPZQ4YAeqPrvpm2BqaZwenAm9q2f4mUdg
         npyuAQXuqOVIG7NcZsvhQiNKew4Es2e5VY/PLFmf0upAjXxp3tZ0XSnDfjSjitmiv8YY
         duHl/LQqbBkKZWaSpBI+f5TEG86YrB7hPmwRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706127307; x=1706732107;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Id1qRAoiWWWvqW/dbMxgihjX2oP7pYm4HN95FDf9D2k=;
        b=WgXeSBxhOGex9OOrjTPihdgYotnvYl+2V71ZskKhazlKgCFEtz1rAWEiZzL2SZGKGY
         ks5WX7b9VArpOagTmVevFDJKOg6CGbyVqgydd7u3m2riCeRYQ6C8TUiFQXH/aN1ip4pa
         reRi6iq3R8WvPSBxl+IyR2dSF+Yl6dbwjIjQS1RZYQTNeC6ZPWvkkqhlUAFAIOYJFEFA
         rDnbffV1xYXy4qdtodHnGXvKkKxoF/2vl5L23MLxQDCVewr+NZXpOapoy4dyq2ef1GQl
         n68WbxGFa+oozAvQt4rJjSMfexU8Qn3KFMIvejswnQCOWBjgB0OeOAOUmHqBKSz2+g8a
         ylDA==
X-Gm-Message-State: AOJu0Yz9AQX5Hw/SuEvB3hkLAo+hCxAyP82wLFuJYqrAuiVUkwCyvreK
	3DT2CkaeL+PKfnVFwiuhv49CZQGKhjLmlktMrSRJPcCBHiu5GjDnBWOVgvZh9w==
X-Google-Smtp-Source: AGHT+IHQpUi+5B9WnuXhSmDXus8mitL4WXU/2ZY6llD9ZE0jvrWSufppkdsO/vLRfpghtMHGOwhO/A==
X-Received: by 2002:a05:6a00:9297:b0:6db:9c1:7164 with SMTP id jw23-20020a056a00929700b006db09c17164mr66699pfb.15.1706127306883;
        Wed, 24 Jan 2024 12:15:06 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fb18-20020a056a002d9200b006ddc2ac59cesm546649pfb.12.2024.01.24.12.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 12:15:06 -0800 (PST)
Date: Wed, 24 Jan 2024 12:15:05 -0800
From: Kees Cook <keescook@chromium.org>
To: Jann Horn <jannh@google.com>
Cc: Josh Triplett <josh@joshtriplett.org>,
	Kevin Locke <kevin@kevinlocke.name>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] exec: Check __FMODE_EXEC instead of in_execve for LSMs
Message-ID: <202401241206.031E2C75B@keescook>
References: <20240124192228.work.788-kees@kernel.org>
 <CAG48ez017tTwxXbxdZ4joVDv5i8FLWEjk=K_z1Vf=pf0v1=cTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez017tTwxXbxdZ4joVDv5i8FLWEjk=K_z1Vf=pf0v1=cTg@mail.gmail.com>

On Wed, Jan 24, 2024 at 08:58:55PM +0100, Jann Horn wrote:
> On Wed, Jan 24, 2024 at 8:22 PM Kees Cook <keescook@chromium.org> wrote:
> > After commit 978ffcbf00d8 ("execve: open the executable file before
> > doing anything else"), current->in_execve was no longer in sync with the
> > open(). This broke AppArmor and TOMOYO which depend on this flag to
> > distinguish "open" operations from being "exec" operations.
> >
> > Instead of moving around in_execve, switch to using __FMODE_EXEC, which
> > is where the "is this an exec?" intent is stored. Note that TOMOYO still
> > uses in_execve around cred handling.
> 
> I think this is wrong. When CONFIG_USELIB is enabled, the uselib()
> syscall will open a file with __FMODE_EXEC but without going through
> execve(). From what I can tell, there are no bprm hooks on this path.

Hrm, that's true.

We've been trying to remove uselib for at least 10 years[1]. :(

> I don't know if it _matters_ much, given that it'll only let you
> read/execute stuff from files with valid ELF headers, but still.

Hmpf, and frustratingly Ubuntu (and Debian) still builds with
CONFIG_USELIB, even though it was reported[2] to them almost 4 years ago.

-Kees

[1] https://lore.kernel.org/lkml/20140221181103.GA5773@jtriplet-mobl1/
[2] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1879454

-- 
Kees Cook
