Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09964347B4
	for <linux-security-module@vger.kernel.org>; Mon, 16 Sep 2024 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726474106; cv=none; b=uEotUobmHVxBAEo+NdO4BLqzCyp0zxSKe/LIHIKhCXllTQOCOzDlGUyhFvfpn9umWtIyyeBszartawgCjgHuo/xTPxPqIgVN0vJSjEvrxJd6ehBYS/Emnblt3yMXQY30B2xr/eoi2gkp7TrPgH6eKk/lHXf+9jznPVZj9iTs6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726474106; c=relaxed/simple;
	bh=xvWOgGhr06YrjQpWY6uecZoD9WlV683oa1tQnmbVya4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELNvK4JtcrdtA1o3Rp4bqv/QYyJyYMyceBR4rn+NmiR9WclcQli5PI5nnBBNxO8tAZC+UKmmYoGAOho1u9wGfSFLl4bzcHq/w1Q//E+taQvtvu324kFAVY6ne/x/ALq8vv4xD+LMrNfUotVP0n1AmA8KgDqu39QUgyYLdf8U5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OADd1aFU; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OADd1aFU"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ddce91cab2so5754617b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 16 Sep 2024 01:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726474103; x=1727078903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0+8g6W9Xy7DC9ahNTGaEIXFMvMobpS3AWPeOGTLD28=;
        b=OADd1aFU4Elq4XFQZptzSDBRtYzbXEFCFFO1NXyCTFDxbLe+DfGa18ObwDCj2Pe8ho
         xFzr6/2rXPfJmBqd5s8eOb9t/woLTw49YouOMtVpmgbP9ypn6daUnpW+s0szQMQQHYuS
         73g4C6NL4JXGMalnxgDOkc/sbM0pk/svctwkQw7Lst5TB6upct522f+rGT5EEZXbxTRh
         FgC/U3rDWBw3M8zVq8d5kp1Yg47SsRT8ar0ZA4Zum4Y7jsx5BSjUr7Ndvh+fl66E4Z0i
         SwjTSMk/sJYt2M++EPgygVXD5X2Q3NzqLoJBCp62F+hO5MMI0+D9Ls6x6pscuAgFNHNd
         uY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726474103; x=1727078903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0+8g6W9Xy7DC9ahNTGaEIXFMvMobpS3AWPeOGTLD28=;
        b=E19KVblVk+m+CkWBEJ69Jt6UE2H/yhIQKO+pBmQ1IdZUD+jegsbcTDSSA+udc9vsr1
         ZRQd4EL56v7HxoJ9fS3xcGRm3i46s98gBk9rwytlFnDV50X+U9829oMxc8uiLMATaVdi
         O+MIqjy+kXA+RN6401P+UXdT0PJsKp+WTZaXr486N77B/Rzx+LyyICZ8lQM3xoOZqs1O
         hN5pq43eXGQk3Cv3+L2F7ePyCYW5DIONbKlkkCskynC6Scx5rRU1AiGr66j8J82AR4vt
         Brh9xcyqixm9Jq2Ogq5yWR3r2aTLxUGmBnk0PNGb2b2ouVrD//BCSa4Zfx0YDhMJXqs+
         yT4w==
X-Forwarded-Encrypted: i=1; AJvYcCVgQvSonZ9pRnp90Yhjm7Ut4k4W+X3mpm3Y+05im1sDor8Z8Bwj5EzX8HfKVqrikAuCnJQebFaxhiAL+vi3DjPT2eF8Hus=@vger.kernel.org
X-Gm-Message-State: AOJu0YySItDfzIKNHpikEKE0VaRFBxTvM/N3XsVJUUoZ40/blLdB0/uN
	RB6WoVFiDQaOLVec678POoAe2/021dfXNJIuXppzLifturCKwTqnyJvjOs8DEdAXVQv8sLsDbRv
	s1nonHLzThhREllNNHgglWVySp+TrO9HndcuakXFfzteI27tfuQ==
X-Google-Smtp-Source: AGHT+IEtjQWvWBNnu/4Nm2e4jVNcENFMN8zZXbALCj2BpwB1jQ4SS9xrt+8GM3EUi/xA8h9UtzFmswreoUCjhv4fSDY=
X-Received: by 2002:a05:690c:92:b0:6dd:d5b7:f33e with SMTP id
 00721157ae682-6ddd5b7fa95mr5442187b3.33.1726474102738; Mon, 16 Sep 2024
 01:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d15ee1ccfb91bda67d248b3ec70f0475@paul-moore.com>
 <960e740f-e5d9-409b-bb2a-8bdceffaae95@I-love.SAKURA.ne.jp> <69e4014e-0a34-4fde-8080-4850a52b0a94@I-love.SAKURA.ne.jp>
In-Reply-To: <69e4014e-0a34-4fde-8080-4850a52b0a94@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Sep 2024 04:08:11 -0400
Message-ID: <CAHC9VhQq0-D=p9Kicx2UsDrK2NJQDyn9psL-PWojAA+Y17WiFQ@mail.gmail.com>
Subject: Re: [GIT PULL] lsm/lsm-pr-20240911
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 8:38=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2024/09/14 0:28, Paul Moore wrote:
> > I find it somewhat amusing that you are complaining about the LSM
> > framework not accepting new LSMs in the same pull request where we are
> > adding a new LSM (IPE).  As a reminder, we have documented guidelines
> > regarding the addition of new LSMs:
> >
> > https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
> (...snipped...)
> > While I have no intention to negatively impact out-of-tree LSMs,
>
> What I call "patent examination" is "New LSM Guidelines" section within
> that link. That section includes "here are a list of requirements for
> new LSM submissions:" and "The new LSM must be sufficiently unique", and
> out-of-tree LSMs which cannot satisfy it won't be able to become in-tree.
> If we apply this requirement to userspace program, this requirement means
> you are declaring that "postfix" (or anything except "sendmail") cannot
> become in-tree because "sendmail" is already in-tree. This is a clear
> intention of negatively impact out-of-tree LSMs. People have the right to
> use whatever subsets/alternatives. Even if a new LSM has were completely =
a
> subset of existing in-tree LSMs, people have the right to use such LSM.

Comparing userspace applications to kernel code isn't a fair
comparison as a userspace application can generally be added without
impacting the other applications on the system.

> While I consider that some of out-of-tree LSMs being unable to become in-=
tree
> is inevitable, the requirement that any LSM has to be built-in is a barri=
er
> for LSMs which cannot be built-in.

Anyone is always free to build their own kernel with whatever code
changes they like, this is the beauty of the kernel source being
available and licensed as Open Source.  You are free to build a kernel
with whatever LSM you like included and enabled.  You have been shown
examples on how to do this in previous threads.

> People have the right to install whatever userspace software / kernel mod=
ules
> they need.

Anyone is free to build their own kernel with whatever LSMs they want,
either in-tree or out-of-tree; the static call changes do not prevent
that.

> > My focus is on the upstream Linux kernel and ensuring that the upstream=
,
> > in-tree LSMs have the best framework possible to ensure their proper
> > operation and ease of development/maintenance.  While I have no
> > intention to negatively impact out-of-tree LSMs, I will not harm the
> > upstream code base solely to support out-of-tree LSMs.  Further, if
> > improvements to the upstream LSM framework are determined to harm
> > out-of-tree LSMs, that shall be no reason to reject the upstream
> > improvements.
>
> I have been asking you for a solution for "in-tree but not built-in" LSM
> (namely TOMOYO). You are refusing to provide a solution for the sake of
> "in-tree and built-in" LSMs. The "static call" changes fails to ensure th=
at
> the upstream, in-tree TOMOYO to have the best framework. The "static call=
"
> changes makes the upstream, in-tree TOMOYO to have a worse framework than
> now.

As mentioned so many times before, the "in-tree but not built-in" LSM
problem is entirely a distribution/binary-kernel problem.  The
upstream kernel community is not responsible for the choices and
individual build configurations of the different Linux distros.
Support for mechanisms which allow for dynamic LSMs in pre-built
distro kernels is something we could consider, but so far everything
that has been proposed has had a negative impact on the upstream
kernel sources and has been rejected as a result.

--=20
paul-moore.com
