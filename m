Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D7E38FAD
	for <linux-security-module@vger.kernel.org>; Fri, 29 Mar 2024 21:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748060; cv=none; b=mwrYP5Sl5gEo8VwQ9675TUPRhxbdeENC6saBQ1WNpnkFeBDdw73YGHvA3/UnOh3MSw0SCs5o2v08Q3KU8S0YRpixqZ+3UaTMW+zkY58BlFIToOfopijgyhVbKxXCvvTbh03UpjeqGWrl1SMfmcTb43LmnpImoPj+HeXG8l0IZrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748060; c=relaxed/simple;
	bh=50M3LT8mnuywmJNlkQScxlgjVAIlHyjJG8qloVonzuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ruri+lwjMit9Sj+eoFSht9sRrQG89SkT3ngKIGADe6VAScb84GT96+7bzfIvCG9AO/q15J83S73AuogHg9W8qdd8Sh5M/Wrlm1WDAh3WCAvGsFHhxPeC7kG8+wU8XcZvIPrQIZWyAGyWNUFYN6AY5eK71wH8LRq+l2EEIc3lZRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YMHcBIpi; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YMHcBIpi"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6147942ae18so58187b3.2
        for <linux-security-module@vger.kernel.org>; Fri, 29 Mar 2024 14:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711748058; x=1712352858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIMHZaDV3wX5X/mP8vILSA3tsnYggDxtMi+vTwU7OY8=;
        b=YMHcBIpiXyp5v0KrwBJ0Y1s2XnC6BUh97Rt05RbaPDWnQ5yncJbRRQ4bpQ1DvCfFyb
         c087fMlQmqN7DDpRyLBIQqPdsJEiFsuSm2asxqRw4bTPYZs0UUSY9k3tVxa7RLZWr/+H
         +3mbQyr+4wOT8rytF947HQrMh4gAO/EygFRiXqiZvPUNfFGWYRppJUuzj5s1jPwRtPrs
         TrHnXhs6ZqmpBajfXab81hUulMHZOPuxSG2ThE+5NbKs6wfqPACS1RFY7Sl4Sl2OXji5
         T5XKNj2Hy69Q3VTwHuEer0avbRFYAP+/bZBNhSGfatQjGkwMXjxiw4LESd+IPURiJm6J
         6wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711748058; x=1712352858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIMHZaDV3wX5X/mP8vILSA3tsnYggDxtMi+vTwU7OY8=;
        b=wx9+QlV//2b+9jpi6EcXdjf0jLIQL5jRxN6NFmTSKxUp1fVvZC6VytCrZ9cbX7ekTW
         mBfXEuEaQjmRHOhXeIhSUEBx8Z4oNFg+llWsQytwykPt2OZNNfXTF7023S4KofPHvuiY
         Mox6THe7vFFSXT1tiAhjzkTwz94Juue6eaNQF7CagGPRrElnd8A+HRZjtsOLkb5kC2h1
         zX9rob121kIJMhsKud8ZzCffkG98prnuIp+RGBRRYzWiGyULxi1lNxBq4BQnEg/ss6py
         84B59lCvLzmJ5x1OMIgGV/cvmY9YDXYcdw6GQSY28x0t3z8KfrT9f0NtOEZbD2LR+IPj
         F8+Q==
X-Gm-Message-State: AOJu0Yw+IbE95Mgx6mj8MmFjk/sqTlmzbQdHDK+HDX62FOeXsHtM61eT
	6swnDG3np8AA8WYYctWb8Vp1EfcgOMo8oIW5GV+hGx+0pJh6wsGN4oKWZAidv8k8Oe6A3U43bFd
	ssAG2nM7+8tr+ruh3OMzIzuEEphSqpju7yTCL
X-Google-Smtp-Source: AGHT+IH9pj0gJOAEZqutXLhCgImC4M5PTgqiAEIOD8jNv+vPhXBfVScVMRmBh9ONVHsoONfJu6nKmSY/GEubTYGORdE=
X-Received: by 2002:a81:84cd:0:b0:609:3c37:a624 with SMTP id
 u196-20020a8184cd000000b006093c37a624mr3517304ywf.35.1711748058196; Fri, 29
 Mar 2024 14:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327120036.233641-1-mic@digikod.net>
In-Reply-To: <20240327120036.233641-1-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Mar 2024 17:34:07 -0400
Message-ID: <CAHC9VhR42y0BaUPB_BgW+8oadDc36xPJRzEqh9Mwqa1RaMMZXQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] lsm: Check and handle error priority for
 socket_bind and socket_connect
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, "Serge E . Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 8:00=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Because the security_socket_bind and the security_socket_bind hooks are
> called before the network stack, it is easy to introduce error code
> inconsistencies. Instead of adding new checks to current and future
> LSMs, let's fix the related hook instead. The new checks are already
> (partially) implemented by SELinux and Landlock, and it should not
> change user space behavior but improve error code consistency instead.
>
> The first check is about the minimal sockaddr length according to the
> address family. This improves the security of the AF_INET and AF_INET6
> sockaddr parsing for current and future LSMs.
>
> The second check is about AF_UNSPEC. This fixes error priority for bind
> on PF_INET6 socket when SELinux (and potentially others) is enabled.
> Indeed, the IPv6 network stack first checks the sockaddr length (-EINVAL
> error) before checking the family (-EAFNOSUPPORT error). See commit
> bbf5a1d0e5d0 ("selinux: Fix error priority for bind with AF_UNSPEC on
> PF_INET6 socket").
>
> The third check is about consistency between socket family and address
> family. Only AF_INET and AF_INET6 are tested (by Landlock tests), so no
> other protocols are checked for now.
>
> These new checks should enable to simplify current LSM implementations,
> but we may want to first land this patch on all stable branches.

[Dropping Alexey Kodanev due to email problems]

This isn't something I would want to see backported to the various
stable trees, this is a consolidation and cleanup for future work, not
really a bugfix.  If an individual LSM is currently missing an address
sanity check that should be resolved with a targeted patch that can be
safely backported without affecting other LSMs.

Now, all that doesn't mean I don't think this is a good idea.
Assuming we can't get the network stack to validate addresses before
calling into these LSM hooks, I think this is an improvement over the
current approach.  I would like to see the patchset include individual
patches which do the desired adjustments to the Smack, TOMOYO,
AppArmor, Landlock, and SELinux code now that the sanity checks have
migrated to the LSM layer.  I expect that to be fairly
straightforward, but given all the corner cases I want to make sure
all the individual LSMs are okay with the changes.

> A following patch adds new tests improving AF_UNSPEC test coverage for
> Landlock.
>
> Cc: Alexey Kodanev <alexey.kodanev@oracle.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Fixes: 20510f2f4e2d ("security: Convert LSM into a static interface")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  security/security.c | 96 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)

--=20
paul-moore.com
