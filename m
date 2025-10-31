Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7404F175A5
	for <linux-security-module@vger.kernel.org>; Fri, 31 Oct 2025 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928233; cv=none; b=ZkgBlMSwAliuFhc+TvQpjWfk3D0mnJOw8waAvrnRjD302RM2ku/TrZ0B+oLqXUprkAHBhpbwLDH6PJ4mEECDqC4HklzyrLy5I1dV43qY6IVTQLWQ5DL3x7q3NxdSQq5+/h4H9ZyppRwRdim4LTKGJkcEEQZQmanzmLQMBD3DPkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928233; c=relaxed/simple;
	bh=fY4FiQOBHOZhR9CGYCZyVsyAJBH1cSuT7A9/k8YyMTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rE996xy3RcTiXZ2QhLaoXLQOET2MkzxpDGiENm9iLNlgUb8GVol4MB6INDILqHIZeHOk60uvHrZCWM9o0FSZhLQf3Eqtyeyog9HwiKLA8pewfKgm2TQKgt5fb24y1WDjPFJFB+xNc4Mb7mSZQn3OQ4SZ2Llh6+sGpP7F2FwrSSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aPJwoIOc; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aPJwoIOc"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso4578617a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 31 Oct 2025 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761928229; x=1762533029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cDYNWSApLb0T0CEMAKuoBZ4CmprFjy5i/htqaeEinvs=;
        b=aPJwoIOcWmzfqBOsTdGPZ4QG8FFXQC2tdPLMIo7CmkSWWG0Ow2vWNel7drc0bsl7l1
         u6QfkYU5mVke8F18P+VPEfrNUE78lo3orrqm8n2p27EsO9z/o5GBCEgUuU92amM6AmQU
         LBGUz9BZliJNxpk7HXql+qTko8EXpxHgNo+ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761928229; x=1762533029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDYNWSApLb0T0CEMAKuoBZ4CmprFjy5i/htqaeEinvs=;
        b=wMa+3b5ztFQiZnpYlTppOZDWFo5vH0QrPA/0qkv+oPaQfPmJBvDSScpP9htYa/GdAU
         qeVbiIIZ1rl7g3q4elzJgbc9iO510OGxm8dpnnOFZ7ts5dbMoJKvreo3gOUbeq8+bpqh
         OE1PzK6l/iRboGcp1mYIQ3NOZ0KR/yTtENfdl+7iKkKvzewhwmzsLBwdb7InyZ2U6Jx2
         5bn3F5QRAdBI2C01TLT0hCmbugjYTp/6jZaFEeAKUstYRRmoWi7UU9Qg34iC8BpoA8M7
         LcWPZpdJXV/x42gC/+PJftKVUiYEiLagblDPrfolQadz2kk7NSNzPIT1tVGrymLjU26X
         sRxA==
X-Forwarded-Encrypted: i=1; AJvYcCWBl4GA1xz+kYT1FIGkZxnCjKPuf1UFcxwhbpwyQQsLwxqN7UN0EcSN7nyt1b1xH0X8JMdcChB4JlIyofzYj5Q70yqGhLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/X94CICBc/lHiEMr3P/SBB2ZQ+9n9xfUYE9t1YRC4I+Kz1MPU
	IUZGFeQ8bIsiPcBDcr9ctNwIWRDtKfZq5rbDWdUPl8SHYskXD3wioYpwihLNOnIMcc4m8XLtm1o
	bO5uYWHk=
X-Gm-Gg: ASbGncu6+4JcddHxNvFXv+PGX+jMY4CSQc2nq0/yocfTnJa5uT5CtFrNwsumLO2XziT
	4o+QYFPTu5lxvyoR8RUl8Cp4mBFOGHwuG1X1E+wtJeNRlBac+o8qFQ+qsuXJ/TYAPiVxK8SDk1o
	2Nmx2+ImBQtFgb4+Q5ly5/TJbYHjxh3UUJyw4LDkGWpilP86H+S6Z6QZbb4TseQhj5lut2xdfEf
	mZG484ZMSyy4D9cRoAeoASKS/JSt651OJovRXixU1+smbjBeFSUQDZyxHSVMEFlh/pFS3otXWAd
	U0rQDzpXdzg7J7PMxL4n4gq1gswyX6+9o8KaMU0DOZ03ChOEYFu/1byvFcflER+OpnVdyyNbRfu
	Rqm66+1Yd0/Ir2+iRt4a/pF28MRVuj9rSZ3oKrzMV5al7K1uQVYvk+IVmf34LepCTU0IMtrsrN/
	SgEK0yUdqwYN7XLLJoqrGgluxCocAyEg7nlnePcevpMXyK+GAYdTt6ViYZgmBu
X-Google-Smtp-Source: AGHT+IG0e3KO3Hjbo7XV0dNTjYXinBEJYzly4oyvR+o5aXcQJhqPns7kixpciObqmOjldjyFW2Ac9w==
X-Received: by 2002:a05:6402:40c6:b0:634:11d7:f70c with SMTP id 4fb4d7f45d1cf-640752fd07dmr4072995a12.2.1761928229171;
        Fri, 31 Oct 2025 09:30:29 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b438536sm1987489a12.26.2025.10.31.09.30.27
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 09:30:28 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63bdfd73e6eso6777030a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 31 Oct 2025 09:30:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUw3QOoLpOAOZYInkce8lY+5xgy+DYhFLiniC2moGxczrapxL6YISfKG5Pk5w6nywOzT+ILD9F47D6CXks/ew7O1VJgq8=@vger.kernel.org
X-Received: by 2002:a50:9e6b:0:b0:633:14bb:dcb1 with SMTP id
 4fb4d7f45d1cf-6405efcc93fmr4626276a12.11.1761928227242; Fri, 31 Oct 2025
 09:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <37fb8720-bee9-43b7-b0ff-0214a8ad33a2@kernel.dk>
 <CAHk-=wgZ9x+yxUB9sjete2s9KBiHnPm2+rcwiWNXhx-rpcKxcw@mail.gmail.com> <20251031-zerkratzen-privileg-77a7fb326e34@brauner>
In-Reply-To: <20251031-zerkratzen-privileg-77a7fb326e34@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 31 Oct 2025 09:30:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6+ngpnQsp0ic_5Ebhv5g=cVKVWjrJyRBQWBp4MDiJNQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkyIQQlQkmgn3AWxbQRzVye-4t89_fz8JwOLmT7ueXhoF2H1ZGUGfxzOtU
Message-ID: <CAHk-=wg6+ngpnQsp0ic_5Ebhv5g=cVKVWjrJyRBQWBp4MDiJNQ@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 6.18-rc3
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 08:44, Christian Brauner <brauner@kernel.org> wrote:
>
> Hm, two immediate observations before I go off and write the series.
>
> (1) The thing is that init_cred would have to be exposed to modules via
>     EXPORT_SYMBOL() for this to work. It would be easier to just force
>     the use of init_task->cred instead.

Yea, I guess we already export that.

>     That pointer deref won't matter in the face of the allocations and
>     refcounts we wipe out with this. Then we should also move init_cred
>     to init/init_task.c and make it static const. Nobody really needs it
>     currently.

Well, I did the "does it compile ok" with it marked as 'const', but as
mentioned, those 'struct cred' instances aren't *really* const, they
are only pseudo-const things in that they are *marked* const so that
nobody modifies them by mistake, but then the ref-counting will cast
the constness away in order to update references.

So I don't think we can *actually* mark it "static const", because
that will put the data structure in the const data section, and then
the refcounting will trigger kernel page faults.

End result: I think we can indeed move it to init/init_task.c. And
yes, we can and should make it static to that file, but not plain
'const'.

If we expose it to others - but I think you're right that maybe it's
not a good idea - we should *expose* it as a 'const' data structure.

But we should probably put it in some explicitly writable section (I
was going to suggest marking it "__read_mostly", but it turns out some
architectures #define that to be empty, so a "const __read_mosyly"
data structure could still end up in a read-only section).

> (2) I think the plain override_creds() would work but we can do better.
>     I envision we can leverage CLASS() to completely hide any access to
>     init_cred and force a scope with kernel creds.

Ack.

                  Linus
