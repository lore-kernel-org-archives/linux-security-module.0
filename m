Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847388;
	b=A2KJ1OpPOKT14T8Svrrwc2ZcpOCgvtiamMaHKgon9P/wjuHJFBZGwy9g26+wfgMrANTr
	 xm6B77PxHJJHfs7rYopdKhbXQiezZMeZmS0HFRKFLI6SrIaDS9phG7vCPMwzfJacWP5An
	 R1H6/At4BzPDI4baUK0mcE7o+PSHQvl90AezYxs9hmNlZrpo3IDp9E01KYVUWc6oq9COD
	 Yi3a6iE8uw90yZcBV5oWHFM53m0YddXdS+m68kOVDDSgC886HViDwjBAxJU3HQfZDT1df
	 vTvE0LKzu4/zGYBkcw0ZXRXZQD2kF82n5dszB/rxsO7HknNlGBMFh6TFHfXPENHooSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=mDfU+sS9f1CGfQAVDBxxcGKeVZ+qJ/3ua+e3uJH5HXA=;
	b=Hd7JOjQ2dcQ66X8t9Ur610i9lzp4xR3n41p8M5lDXDx9ScIgIrGEg4I+cs7OtlksOgE3
	 GNv3K6Sw67dV9yfem2cprKOsT45OhopUOCj4PeBLYbG81VWwtVICnNzcyFm5UrkJJVGGj
	 p0co+qxKSG9JdZWGCKmhosYSsPIX5h2Ie4rdqOa4H+Bu+/OkbAnmqseY4GM+aPKlZP7X7
	 zzxFzkASJkyVB4igsjgTHqDp/Dy7wN2WsXL7jbrOtjNs023gDP/1wYih6rI813ru544XB
	 LKHy8RMUVR2m2qbrpT+Gx8VENMbdVvJKqJqnZl64MkgFs4h2JkjZwvT828I3rWNEnZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--halg.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IHD+g70C;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7044E606A31C
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 16:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7044E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--halg.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IHD+g70C
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c50657eaef0so369701066b.3
        for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 08:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794847387; x=1795452187; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mDfU+sS9f1CGfQAVDBxxcGKeVZ+qJ/3ua+e3uJH5HXA=;
        b=IHD+g70CMjjDb+lNyaZS7FPrR9hKiBjI6am80yEPTtTB9qWtugwit+DSXHqY66L98K
         8EtcQ72+xPDDvax/dKjPailSRAMm2iFoAICCBJiaKhmJXvLESaGHskyifSodaT1tRs2k
         FnHt0a2P09ARVfqqIUhh4npU9nurbR746tcMFt5h0VvYTWxJ99h7V4nt5AdC5Xn+RuNw
         R+UPfCjsMpCI0kZGUr8m/0061Cxdd4HI0FJsop35cbdBWrApwuRCUgB8AqRfgWVySydR
         5NYVgGLoJ1FeSnqZ87k51s8BnWjIU7UBqdkx4H+pPBId62cZa0wxGpKqydkewL7P/Ubz
         LItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794847387; x=1795452187;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mDfU+sS9f1CGfQAVDBxxcGKeVZ+qJ/3ua+e3uJH5HXA=;
        b=ngbbOCWIvF+Bpbbx4jes3jQOLO9B4Ux2aS4qSbEhG6SDRiSAGH4pHsTsdSQig8mNJZ
         m1pUvKYLtDIBdLsPdpQRLc8vnIC6wcR50ycAqh/WNdVc/4V8TGyiyFxgA1qOgpc9yriX
         dPGZkmB0R4APZRN+zQdQN9LAxxFGi4pKlPxCM1DkUH/gTINsurfpT6Hhfb/2RNQPgQss
         MWzCp5cW2HNBuL/hs5Nj61QDQT7HfZs9SyHCSwb4uSZ/hS/eAiQJPpadtftUhAQDx8+g
         XJAPEGh2gXu0JZI/q7YPEVhUeFOGMeuSBfM3JFlmZFQUpIFXWD7PIOteVadLJehLDr4M
         Lwcw==
X-Forwarded-Encrypted: i=1; AL+hErEIcwq6we4Mn+rGCo9eioe6ivqfG1kpiHEBtlTnns/CSWi9ecA9N24Aaay1GranasvMnW5yukBhCJw8qYNzkmSz+oTI0QY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zdsEN2f01Fb7C55//Llgh2AstHoAK3bwgClW7MU6DCFm1p4Zv
	tuK6JTmz3zuS5k5GdgOVb3ZVy8VPiJZ0CaClnjLoad12LUGxxHrdhmz6QN+1zDrS4EeSXVe0XA=
	=
X-Received: from ejja21.prod.google.com ([2002:a17:906:3e95:b0:c3e:edc5:36b1])
 (user=halg job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:6d08:b0:c34:e9fe:82ed
 with SMTP id a640c23a62f3a-c50963d803amr901765866b.28.1794847386433; Mon, 16
 Nov 2026 08:43:06 -0800 (PST)
Date: Mon, 16 Nov 2026 16:43:05 +0000
In-Reply-To: <20261111-behagen-faktisch-entgegen-e2e714373895@brauner>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028221705.3915340-1-halg@google.com> <CALCETrW9ygriu54gxiHFLEd5+hJminQo0r8Jwd63wR69Dj4W7w@mail.gmail.com>
 <20261106-befreien-addieren-eislauf-e09212803534@brauner> <CALCETrWa1SBLcb5oWjqjgzZvKvCoHjmYFk=Lf5ytEM9uqm5jYA@mail.gmail.com>
 <avM41a80aig2de-R@google.com> <20261111-behagen-faktisch-entgegen-e2e714373895@brauner>
Message-ID: <avsymRBSulVZfouF@google.com>
Subject: Re: [PATCH 0/8] userns: per-namespace capability bounding set and
 opt-in netns loopback
From: "Hallgrimur H. Gunnarsson" <halg@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jann Horn <jannh@google.com>, "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>, KP Singh <kpsingh@kernel.org>, 
	Jonathan Calmels <jcalmels@3xx0.net>, Casey Schaufler <casey@schaufler-ca.com>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-api@vger.kernel.org, containers@lists.linux.dev, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Nov 11, 2026 at 04:20:02PM +0100, Christian Brauner wrote:
> Just a note on the essay I cut off. I really object to any arguments
> that amount to "it's too much work" propped up by a few thin arguments
> sprinkled in such as rtnetlink.
> 
> I also reject any arguments that amount to underscoping and overscoping
> of the new capability. The scope is clear: empty netns with brought up
> loop device.

Understood, thanks. I'll split the loopback work out into its own
standalone series and handle it separately, keeping the scope strictly
defined as you described.

> But again, I'm more focussed on cells so here's what I find acceptable:
[snip]
> * a new CapUns: line in /proc/<pid>/status
> * new audit mask in AUDIT_CAPSET record

Quick question on AUDIT_CAPSET: today it's only emitted on capset() and
only logs capability sets that capset() can modify (explicitly or
implicitly like cap_ambient). It does not include cap_bset which is
modified via prctl(). Since capset() never modifies cap_userns either,
does it make sense to treat it like cap_bset and leave it out of
AUDIT_CAPSET, relying on prctl auditing instead?

[snip]
> That gets rid of the sysctl, the clone3() field and the clone flags,
> doesn't need a new capability bit, and nothing changes for anyone who
> doesn't opt in, I think.
> 
> And that loopback thing should be its own series. Not as an nsfs ioctl
> though. All nsfs ioctls only report namespace state and I'd like to keep
> it that way.
> 
> Pipe this through an LLM and make sure it makes sense and covers all
> holes.
> 
> Thoughts?

Thanks for the feedback and the detailed proposal. It looks good to me
and nicely ties everything together. I'll prepare a V2 for review based
on this hybrid design.
