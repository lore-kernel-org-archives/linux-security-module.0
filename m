Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAD2131727
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jan 2024 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203075; cv=none; b=KnGg42AvVlCg/M10WsJLe41CeGWFhnjWkkTT3blNbxvdXA2sreoy6FM/+PbMc8RTknQWLxye2K82cnDTNkfhF9QJcircfwL/pmQye+BETW8eNRVBDZOccdnQDeScRE9IOMv7XKeFYQ4LV223WXNw4P63D995kDDALj6O1jXQdZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203075; c=relaxed/simple;
	bh=IzszeC5BwpXOho+0jEHlObu6yB5ChY5DXLP5nlCoAoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=md6/bNCieO/fwj8VYBGLHXc160GZnyo/MFeayRyfEHiSt0qEw4dVR7RqCjMebNkb5Jv3KFMNbm4OGXGUP27L13T2P0NpPTcnBzYwDabC2rcsFFz4mivcseJvxIQYknDpmlsbJ334D+7c6FV8Pb8EVupP/jWmn+bYvFm6pGC9eH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Kod+IP+A; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Kod+IP+A"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a50649ff6so7722800a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jan 2024 09:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706203071; x=1706807871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AU+fsHobuU39z9pQZP7B0amkHKcRajVu86fobjazaZU=;
        b=Kod+IP+AZApJaWrbeAtbcf45pmPNcvOblPjR/fjd+/heRlgvlvnSw3xDLJj46DJVKO
         J+b8Zz7lFaRBKiQtS3YXgOywcs27wpgLcosJ6jFGoynDmQBlaOEHQqX/rQ+GsoAtqR6F
         iC/tQN34RmpbwlQP2vwTo337yJ9M5IMvH7nXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706203071; x=1706807871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AU+fsHobuU39z9pQZP7B0amkHKcRajVu86fobjazaZU=;
        b=Bqw+7O2Yyxr8sHBvdQjeJp0gegc8ITq77omVWifz5FeDj/D2ir0H1XeIIxu4KH+kUc
         /nsOU9ngbe7WZVuhw8H0+jrhDc9I0XJR03FXV/o4JdWQXInClf8g/lg7qwMCtS1ndZ5A
         fkgJ7qlOqF7w24UDVQkTKWcPL7DyUWqjZ5OIompSn0E9nYG0wnYQD/ibSo17DvfN3e/d
         IoC1x+i0dRHgivUj5eycUX0/b0pNR6/FHMQJTdShzH9HxGKmDitClGQND9rBrLZrhh93
         HZd9z2lvSGVLtsMXzQm/Ou0X1t/Ic8gSpQtxBXJAE5p3zrjNBmMOo7xWTo1YeR5j7Kn8
         PtIA==
X-Gm-Message-State: AOJu0YzQYqiXW8ZoBKJRxT4ivZAnQUlRUibcgYClaUK7Uu2qxkxRczpH
	6nqQdWaD5rc607CbaZtkTr8THIgiIjwgGuhTKYjUIFpjaJ8V+g4WNA3XQN0MVcbhZ+Z9t+kqlPB
	kKhnTHA==
X-Google-Smtp-Source: AGHT+IF2dwEI6SpyfhkkApBuY0eOqL43t37BSG0ZytZ0XJT5jKULt97KX+x/wDJ2NFEFSwGF4uOHYQ==
X-Received: by 2002:a17:907:8b98:b0:a27:e214:96b with SMTP id tb24-20020a1709078b9800b00a27e214096bmr771522ejc.112.1706203071660;
        Thu, 25 Jan 2024 09:17:51 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id tl15-20020a170907c30f00b00a3186c2c254sm716160ejc.213.2024.01.25.09.17.49
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 09:17:49 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55d20f24275so58768a12.0
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jan 2024 09:17:49 -0800 (PST)
X-Received: by 2002:a05:6402:1246:b0:55c:7e2c:ed7 with SMTP id
 l6-20020a056402124600b0055c7e2c0ed7mr836379edw.18.1706203069390; Thu, 25 Jan
 2024 09:17:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbE4qn9_h14OqADK@kevinlocke.name> <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
 <202401240916.044E6A6A7A@keescook> <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
 <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com> <a9210754-2f94-4075-872f-8f6a18f4af07@I-love.SAKURA.ne.jp>
In-Reply-To: <a9210754-2f94-4075-872f-8f6a18f4af07@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jan 2024 09:17:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjF=zwZ88vRZe-AvexnmP1OCpKZSp_2aCfTpGeH1vLMkA@mail.gmail.com>
Message-ID: <CAHk-=wjF=zwZ88vRZe-AvexnmP1OCpKZSp_2aCfTpGeH1vLMkA@mail.gmail.com>
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from virt-aa-helper
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, Kevin Locke <kevin@kevinlocke.name>, 
	Josh Triplett <josh@joshtriplett.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Kentaro Takeda <takedakn@nttdata.co.jp>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jan 2024 at 06:17, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/01/25 3:27, Linus Torvalds wrote:
> > The whole cred use of current->in_execve in tomoyo should
> > *also* be fixed, but I didn't even try to follow what it actually
> > wanted.
>
> Due to TOMOYO's unique domain transition (transits to new domain before
> execve() succeeds and returns to old domain if execve() failed), TOMOYO
> depends on a tricky ordering shown below.

Ok, that doesn't really clarify anything for me.

I'm less interested in what the call paths are, and more like "_Why_
is all this needed for tomoyo?"

Why doesn't tomoyo just install the new cred at "commit_creds()" time?

(The security hooks that surround that  are
"->bprm_committing_creds()" and "->bprm_committed_creds()")

IOW, the whole "save things across two *independent* execve() calls"
seems crazy.

Very strange and confusing.

                    Linus
