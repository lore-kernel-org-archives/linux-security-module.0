Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7AC27BF77
	for <linux-security-module@vger.kernel.org>; Fri, 11 Apr 2025 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744339305; cv=none; b=SQneccDnyuUAiGuYVMkGcENI19sw49Ee/bUJq0jqCFXYe7lpepZ4wXA09r4sDEHGZsMI4GEq2yxSIhkls/kG7sZsLh6cZt/MfsdHaRyPy3RoFL/RW9UAlDLevO9G7x3lUoG6BOgEBKZHLnSet3IpQ0CyndOUvbPpUptiH5d6Wn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744339305; c=relaxed/simple;
	bh=as9kSQASNHOZEqVjFgkKcfcacxgPlIJuUo017aL6c5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfQisxAWSmX5G8kXTq3kyufpIrEtnwh/FmBztAWMQr9b8i7Oq0gbZZq9whBJVeFwO0EFVQFJwW+rDKr7MbH//w3kIQOgBYjHTu4/9aEUImV/IyaoVDGglt0WkJTGSlBSGOdy0MUOC0zn658lYuhUZ08efOVea+9O1JecpiYnnMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=S30PRnNR; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="S30PRnNR"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e6df4507690so1458865276.0
        for <linux-security-module@vger.kernel.org>; Thu, 10 Apr 2025 19:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744339303; x=1744944103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CwF+ie3M3uU4fIen1I6/2Rgy5lqyQhlFhFk+DF1se8=;
        b=S30PRnNRSvuU9IMAkZaarLZMJWxHbN/EY4RbuvdLB3K7nc5n6hm115VtdZB0w3+wmF
         jkkV9HMoSRNed09lrY3VysuoGz+5MzjdDbtdCcffu/vn4zlnZW68BLmkoCBAv+QB6CPG
         xPhGuPYLyghjUCpKuhkLPIDxiJ6Ts6WMIGjkJIrRk6O//WAPRn0Jp8Ws3lGu4RNnQyjH
         6sFj98j2H1QunBb6W5IsmaTihBXBO5/imtgeh5K8YRLCs4YRNRH6UzoHkmQG7zvBIf2r
         1O1V0XDo3QtyeI0AaBnBzy5u37h20VEPTIRLSJt8nB3fu/oGHbDDcwOczPd722CH8tyK
         s0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744339303; x=1744944103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CwF+ie3M3uU4fIen1I6/2Rgy5lqyQhlFhFk+DF1se8=;
        b=MI/4ZcHxyJUGzSBAfwLVQGYrwuBE1h2izMZELslLrZgbZpYDVXzYG6SGOepq7Mmq5V
         DOsk11aLO9DKDerBJvRBEvDTtUwPS5aEVTCCU1BGo8+d8BmLZNbH8dUSxmDEdh4jD4Y7
         Gn6qYeAZDPPHsTyST08xDAJmx9g2qB64W+sDf6g3vjCRWRH1LhPgVbANDzRPo0z+B0e3
         2hk6WERy1I5R+0rr1f71mXaGGprYhBpydcDHzx/SF7WQEd9AWMA341nenmw4E6TdNGK5
         HBuJQvaz8ZDnodJRMzOwpXeBtjJqLopzuJptOQEurRFcvVzjMDDQ4aEJMhxvtvOQDDmt
         V01w==
X-Gm-Message-State: AOJu0Yzxc93UCyAZUiJnLK0Roz2bQlKqIk6S2rV/vFNAL77xPUesra7b
	I1ee0ZbaBseXIcnrmuIWfmoo4ACCeRCMuWCeUbS8O3k7lu7WoeGv7K8Sk5F4W5wvUHa374m0kl3
	sEIbMFMB7nFMTMAhAc5fn+WP7jTjaCTK8qJJy
X-Gm-Gg: ASbGncu2qz5JS0UmveJ1rCAhYF9jj3eXcyK0ScgusRT8Sjhf6PbKhXAcQ9ltQXfxFjK
	8YKxwgRu9l3xwVcV1rWqoly4iJkZmgtLb+DOd7Weoz2OgCIUms3e7OaXMouIyPa5W973P9BCdwS
	/DX96IEKrm9Kgi+jRitPbs/A==
X-Google-Smtp-Source: AGHT+IFyF3fZnOWLhxV5JgbmPr2sTVJJVPls46hqxiiCUMkby6GAJYYZggmtKw46ptdM2VMxpFqKc+QvSJIG4R08H8I=
X-Received: by 2002:a05:6902:1545:b0:e5d:f98f:6f33 with SMTP id
 3f1490d57ef6-e703e6de386mr8638189276.10.1744339303036; Thu, 10 Apr 2025
 19:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-49-paul@paul-moore.com>
 <202504091639.A12E1A853E@keescook> <CAHC9VhTR=ee4SGuvDbFj-dtevVFN3Pm-tVhtMLpHsiYB24Xxcw@mail.gmail.com>
 <202504101915.CA031AE@keescook>
In-Reply-To: <202504101915.CA031AE@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 22:41:32 -0400
X-Gm-Features: ATxdqUEGP_uYjR2QUaCWVy9WoK8JP8pDyZNvieKfq707AQCl9JSsANJ7Avf5nhA
Message-ID: <CAHC9VhRQ=854kmKnv=gRCUNOk0TK2=-ss8S220yAkwsUP+y-Wg@mail.gmail.com>
Subject: Re: [RFC PATCH 18/29] loadpin: move initcalls to the LSM framework
To: Kees Cook <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Micah Morton <mortonm@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 10:16=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, Apr 10, 2025 at 09:15:47PM -0400, Paul Moore wrote:
> > On Wed, Apr 9, 2025 at 7:39=E2=80=AFPM Kees Cook <kees@kernel.org> wrot=
e:
> > > On Wed, Apr 09, 2025 at 02:50:03PM -0400, Paul Moore wrote:
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > >
> > > Reviewed-by: Kees Cook <kees@kernel.org>
> >
> > Do you mind if I convert this into an Acked-by?  Generally speaking I
> > put more weight behind a Reviewed-by tag, but in the case of Loadpin
> > you are the maintainer and I'd much prefer an Acked-by.  While I'm
> > always happy to get more reviews on a patch, the primary reason for
> > CC'ing you directly was to get ACKs on the LSMs you maintain :)
>
> Acked-by: Kees Cook <kees@kernel.org>
>
> :)

Thanks :)

--=20
paul-moore.com
