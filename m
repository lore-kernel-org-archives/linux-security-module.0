Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDB11E3781
	for <linux-security-module@vger.kernel.org>; Fri,  4 Oct 2024 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056798; cv=none; b=GSY9QcvAc1ZRM1Gov73LxCTXirSFYPROm4+QF5a6QF1cb3gU9yRuYxkkAZfpLQrEPJxSt0DgQ5HBdRDXCFFwXsLJlh7HFDQyq8EuIiSMRVhrgSxu4YtvY4jqridBqGSnQjma8SRdF6wS0lLT57FSRuarUXLHqj6oFBYWAsU4/jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056798; c=relaxed/simple;
	bh=PiHvLeAZ25LHw+3W/ZSamSrbH+RlzEy+yvSUSr+9frQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TErH3gUkSNFN2oyabtEoXLkkTxIm6jFDLDA3MihuWuIWbcozRm+SoZdYQweHAiziXGQa8nvOt/QEyuUej3RlJ9PlJcQA3b+tS1kmwWI2hezPvgs5vjR1Vv65C3CyldoPbR9k1uWjGqfUnP2GPnDwHn8YaNV2av1OYhasdl8y36I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JPbn+AAZ; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JPbn+AAZ"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e29c50ccbaso21077257b3.2
        for <linux-security-module@vger.kernel.org>; Fri, 04 Oct 2024 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728056795; x=1728661595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbrLkU1Lpo6SakeS0wd5Gjuoh+k4+sarkAymZmH2Fqo=;
        b=JPbn+AAZoSbD9Fmn+GMWd2iWGa0TElqHNGJ5Zq3FqcOxBIONwpHHa69UnKCAFUYIJh
         qA3rOJvJCoDRvkk5VFCR7TjY3qW99zn+B7/QdsnPzXLfjTdTbr8L3oC8XJAmsOmkD/a6
         vpouekJ4pbSYh/Z2h/jRSoS/SvuB/V6yzGvAeTvrdjGj6V0wWOphCIMTPJ47noBWcnJP
         Dg7gpqMbKkwdjbCi3wlHjZmZPeKbURSOAQFucAEm1/koRzqr0ccaW5ovs6LIbNnxioSC
         1S+ZqTtDee50ZVv0aXio6qDHqe/xEssaDh+6k29UUw1a8FpEVDcUREF9jdCdFyNDWaNE
         V++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728056795; x=1728661595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbrLkU1Lpo6SakeS0wd5Gjuoh+k4+sarkAymZmH2Fqo=;
        b=IkR2xRgKqLS5Sc4R66m8c+O1SM0IXqTdHVUI+strJCeGCEgDPXRcV5v/s1viDuGMzz
         X+/5On/1NdF0Oae78IvWfDt0aKIzqAhgqP+f+a/YT6KVny3PewYow6q1cXnP5xYvLOoS
         XtnMQ64eNfCfCCXSHo1Ml4zDt0wEVKYfmW1wz0pkqDfpJkDzMX6BQXed2dL2Mr5JcXbi
         YQEzHmRRhVLni+oEIjE1pCttdQ6PJ15j5hIdqQ4EphtvUkeST1Z5DE2quEah++hy4WwO
         hnr1y8Cd++Cd7W0ap932+cTsquDPQmFQUEk4Jv15PnZ5yNIt2UOYFVsYKwl1RD/88IPI
         Vpsw==
X-Gm-Message-State: AOJu0YxHGQcFYdISdy8eOmJgPTTUpu6D9ChLIDgvUjdRkJX8XlJhL3Iv
	NTVNPPA3CAVQ5fC4+oONxsZhxpvzDqR1AWSlmkOnYtuV4H6AIzqGokYdk0yKV9kC/gVc7eUnE1J
	yRH+I/UU1jjtmy3NGwNVYAUDyigLxnY2+6/rlhG51u6e5WBA=
X-Google-Smtp-Source: AGHT+IHyoR3WK5GUcUBMxg8QfS3SEqcaGeXTISKPRyYm5Ix/zXPTbJ71AatOry9tcLgKpIBJudHIh7rFFaufMlesOJM=
X-Received: by 2002:a05:690c:87:b0:6e2:e22:12d9 with SMTP id
 00721157ae682-6e2c72f6e1fmr33067777b3.35.1728056795367; Fri, 04 Oct 2024
 08:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003210831.387261-2-paul@paul-moore.com> <CAHC9VhTpUsjbNr80MKW5mkg6c+bQXiFDQO3nkBqf_o=Xxb8iAA@mail.gmail.com>
In-Reply-To: <CAHC9VhTpUsjbNr80MKW5mkg6c+bQXiFDQO3nkBqf_o=Xxb8iAA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 4 Oct 2024 11:46:24 -0400
Message-ID: <CAHC9VhTes1Rq=5UA5hju20pm3z_z_bQ36jiKze_xCaQHCE1-4Q@mail.gmail.com>
Subject: Re: [PATCH] tomoyo: revert CONFIG_SECURITY_TOMOYO_LKM support
To: linux-security-module@vger.kernel.org, tomoyo-dev-en@lists.osdn.me
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 5:12=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Thu, Oct 3, 2024 at 5:08=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > This patch reverts two TOMOYO patches that were merged into Linus' tree
> > during the v6.12 merge window:
> >
> > 8b985bbfabbe ("tomoyo: allow building as a loadable LSM module")
> > 268225a1de1a ("tomoyo: preparation step for building as a loadable LSM =
module")
> >
> > Together these two patches introduced the CONFIG_SECURITY_TOMOYO_LKM
> > Kconfig build option which enabled a TOMOYO specific dynamic LSM loadin=
g
> > mechanism (see the original commits for more details).  Unfortunately,
> > this approach was widely rejected by the LSM community as well as some
> > members of the general kernel community.  Objections included concerns
> > over setting a bad precedent regarding individual LSMs managing their
> > LSM callback registrations as well as general kernel symbol exporting
> > practices.  With little to no support for the CONFIG_SECURITY_TOMOYO_LK=
M
> > approach outside of Tetsuo, and multiple objections, we need to revert
> > these changes.
> >
> > Link: https://lore.kernel.org/all/0c4b443a-9c72-4800-97e8-a3816b6a9ae2@=
I-love.SAKURA.ne.jp
> > Link: https://lore.kernel.org/all/CAHC9VhR=3DQjdoHG3wJgHFJkKYBg7vkQH2Mp=
ffgVzQ0tAByo_wRg@mail.gmail.com
> > Acked-by: John Johansen <john.johansen@canonical.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/tomoyo/Kconfig               |  15 --
> >  security/tomoyo/Makefile              |   8 +-
> >  security/tomoyo/common.c              |  14 +-
> >  security/tomoyo/common.h              |  72 -----
> >  security/tomoyo/gc.c                  |   3 -
> >  security/tomoyo/init.c                | 366 --------------------------
> >  security/tomoyo/load_policy.c         |  12 -
> >  security/tomoyo/proxy.c               |  82 ------
> >  security/tomoyo/securityfs_if.c       |  10 +-
> >  security/tomoyo/{hooks.h =3D> tomoyo.c} | 110 +++++++-
> >  security/tomoyo/util.c                |   3 +
> >  11 files changed, 118 insertions(+), 577 deletions(-)
> >  delete mode 100644 security/tomoyo/init.c
> >  delete mode 100644 security/tomoyo/proxy.c
> >  rename security/tomoyo/{hooks.h =3D> tomoyo.c} (79%)
>
> As promised, I'm going to wait until Friday (US time) to send this off
> to Linus in case there are any additional objections to this revert,
> but based on the conversation thus far it appears that support for
> reverting CONFIG_SECURITY_TOMOYO_LKM is high.
>
> John, I added your ACK from the earlier thread, if you would like it
> removed please let me know.
>
> If anyone else wants to add their ACK, Reviewed-by, etc. please let me
> know soon; I'd like to send this up to Linus in time for v6.12-rc2.

Merged into lsm/stable-6.12, I'll be sending this up to Linus soon.

--=20
paul-moore.com
