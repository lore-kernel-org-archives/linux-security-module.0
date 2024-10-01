Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0311CCB2F
	for <linux-security-module@vger.kernel.org>; Tue,  1 Oct 2024 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727806964; cv=none; b=oD7kKOD8Iy27+bd45HiZqHsTHjsSAo1Xjuyr9At/ZlJM/kKHMnQm3UI53apMOEaLYLiu2IVP5OabUde8mv496yMMHbhwLx2tk3zKxNdJYH1c4KpNCV6uLKWpIY2JpUURkI4cAhGylf5n+u/HyaMsTejjgox5pYIlItZLyY1o1IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727806964; c=relaxed/simple;
	bh=vAvOy79PwjXzUDgojljwRNNgFvmSyzKgpOjj12PG6p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojs3Ih+GKLTi1V+68nge+BWMMt++w+8qKNlIYrpfVi0qktwCqdyAfd3adVDoRt4c9Mb2xSetB20A+KzdO9Kw+oDVqsZyfHq6zqHzeHGilsJn8GxT2Wkv3T10xq/QVoO49HlUSpW6/TNifqGQLmstoRGwF/mLXJbqjcWcM3whENQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dm1TY/wm; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dm1TY/wm"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e25ccd64be9so5225288276.2
        for <linux-security-module@vger.kernel.org>; Tue, 01 Oct 2024 11:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727806961; x=1728411761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgwPyT2bLxkRGazo5VUANjf0pT4h7FhmCc+e+AU2d3E=;
        b=dm1TY/wmAfeFLpiDCWn2kPXeEKm2XwguwYPnT7zcNgDz++v3w1a8tGuDdmFo6MA41R
         +hS+ZKe2/dnELrtzx//HN74ms/o9LfGPrY6p/bsT1qUt/1/hUDJobMKDxFpAS0RTIXMf
         0VnoJrKfYP81VU59C7YZkNudYHSfIecY9lyo8MOKy24UugdkhMJks6nLac6koHIsDr1v
         rwPu5eAZqchzbW8AVI7wq3X68rsJ8sSnIwNMRaXiu39N13i6gSXcXO0qQRaK07wT8mFu
         ZS/I3srgoDl6rEq1IUhXjquvAmZeRPbxIguRTO5c/uVpCS9/2dHP7hhHBf7DAAStH5mD
         kJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727806961; x=1728411761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgwPyT2bLxkRGazo5VUANjf0pT4h7FhmCc+e+AU2d3E=;
        b=pdtI35ud5l1Nx5Qmksv3GfRaiwp/AIHZttd48AH+7sd/1z2FfzQ7YE/oRYyOm7H1KM
         iiqFjimqsSZsDrNb0f7dyyxV9vUC0QmGVju/46Ja0UZJ+hjNlHh/x3iMS2MCEYkUpOhQ
         hJgKyV+BGzyARNPuZ95SVDgYi2iIhsaRehjQKWPcznLmuRtq1Ogz8DwW8VxwxgijDyiu
         8sxWeo5FgD6vxyqVFGkQoKhtIshD8/DGSYwhwULISoCZEa4Yewm3ZcMFI/e12VQ5Yl0a
         EgPom51dpmtofzsKKYJjI1MVIaa8fj8IvKVIAbUL7jAuXhRW/+JsRA6kXkvT1hk4K1D1
         FChg==
X-Forwarded-Encrypted: i=1; AJvYcCXTLJaU489fl+BiiVrMvq3j0dMyYRG5K2P8KzSdcgxmMmqM+LmtopU5bYG/qnT09nYmjcU7QZT9lPg57NJZfU7mnjL1M6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWYZAjeLAygcW81ENcbvzBQhMdgShJn6yNiJdEKB3rkaPTvOlV
	m1OmKasHqOOoXvJcN8v2cNCQU0EQ6sUVDZ6p96c4Q7/W5aHtvQiEIrB4GdhEtNwtSGydHBxJZgK
	HAzHZqYS6HXZm41P4h4s9zLAKjOgOHRh8EDac
X-Google-Smtp-Source: AGHT+IGn5lBdfsR9vUYXzY++ASocNA9FMyxmhX5+ojztxwdpZR7OQ9w9sLPT+fbgQmkUUT/x55IiipDee7WgjeC91DM=
X-Received: by 2002:a05:6902:a81:b0:e25:c97d:8565 with SMTP id
 3f1490d57ef6-e2638399076mr523264276.5.1727806961387; Tue, 01 Oct 2024
 11:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net> <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
 <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
In-Reply-To: <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 1 Oct 2024 14:22:30 -0400
Message-ID: <CAHC9VhS_8JtU0KQyy3rEGt0CQ_XMQFt2Kic-bz-Qd=SMjeWe4Q@mail.gmail.com>
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	LKML <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 12:36=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, 1 Oct 2024 at 07:00, Paul Moore <paul@paul-moore.com> wrote:
> >
> > Linus, it's unclear if you're still following this thread after the
> > pull, but can you provide a little insight on your thoughts here?

...

> If the consensus is that we should revert, I'll happily revert.

Starting tomorrow when I'm reliably back in front of computer I'll
sort this out with the rest of the LSM folks.  Unless something
unexpected comes up in the discussion I'll send you a revert later
this week.

> This
> was all inside of the tomoyo subdirectory, so I didn't see it as some
> kind of sidestepping, and treated the pull request as a regular
> "another odd security subsystem update".

Yes, that's fair, I think you would need a deeper understanding of the
LSM framework as well as an understanding of recent discussions on the
list to appreciate all of the details.

--=20
paul-moore.com
