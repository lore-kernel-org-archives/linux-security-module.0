Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C461C688E
	for <linux-security-module@vger.kernel.org>; Tue,  1 Oct 2024 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791700; cv=none; b=a6kJ4go/gpw6vPiKpnUrHrexKlIqCbiDvk6Zj85eqy47t3jSWOyShodDbbPi7/YWtk4HwFsmgwIkCls4nRCKfvS9E2GOPxQeF783/5XH3jh/Vw7p4av8MALDcA4CRiR88B3kxzg2ZniwvkCZh3+wt6M9c14qUQIancnx+eOYIjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791700; c=relaxed/simple;
	bh=W+QNiPX1nti+CLpBJHuN8/cmN2sNYpt8FxHX8VHPJEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEqwqGu28d7cqCCxqDKVjlT4Kx1FhDH7CCOsW6mLkW1XV91LucJybI6W0WfcqyYrS6Hve7+ywoiFWCo88vSifKzwuLprcr8rdhMbDqBNKP2EPEWhh9lmfa+7x2B2wlhP7NpaT9vZxWBGQeog05ArBwLcuf0BYT3agosNgwuYIwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TPOVTZbs; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TPOVTZbs"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e23b300bf9so41167487b3.3
        for <linux-security-module@vger.kernel.org>; Tue, 01 Oct 2024 07:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727791698; x=1728396498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDjggatD71ZQVI9QAnN1g0svCgVssGB6YJc3cVqA30E=;
        b=TPOVTZbsaRXPOSuU1+moXlU6TTm2kSxUrLrsweA84jVeyRgji6K4MofSXf6giqtn50
         7MbER1U4LXBTT71SRYd3sSXbHIzZLypjiLdKhFd4BssW6vdjIxLQcYeuLYTTDVChvKQL
         FDIm7qE3eHv51Q1n+N/mMrexNMLChECHtKY0UuUw6z3Bl/vCrND2EkNJ92++Srqm3jFi
         HQbu+uURYk20OVvHZd4xybUshfO4G1smrpMI3/KDii+uc3TNTYo3OKRf5SPzRwenSsxA
         kPHJqJVI/C5q/pWX/Oai4rjmF2Ytcj9uGkoaLzYQlIMGcoxWGIdkvZpuf5rn5l2mPiWg
         K/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727791698; x=1728396498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDjggatD71ZQVI9QAnN1g0svCgVssGB6YJc3cVqA30E=;
        b=UGk6NO+5VUm9kJhs/NYJxJCqyvCf851B46o+NHekfQX/ldst7zTtE7QNDsi0hh6Lxo
         25rg4AuW/QWuck/oy18ugXNjQ/5UPpsI6+QcEx2AjcaR+747RI4+pe9pFT0N7TT1rOBU
         sCUwXsnu1aCWuINu9Kpwws/c3gwTzp8r8wZvUrT+41UzB2698kdW6883elg+n5tYYiM7
         HMKpB2L49WIC/23rZzpTkhIpl2TAZKK6iDe1CGj/8qzSjgVaezQgHegGK+5MojTZMJPG
         v1NFidj0eBWz5lo0VPISWw9KuR58zngMt0fywgbHbC8YFy6KiHK39l8zSe8J1tuMVfIf
         aXdA==
X-Forwarded-Encrypted: i=1; AJvYcCW2di8YLiuo7zQ771HkN6h/vtMZs94sRIleI+Tl80kwEg6ojpbKP/vTWIXEAQ8/TXm++Xgm4L09wdBrXcI+ULp+7wREh3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAj3kZCxjh24Bzoa5s+CPuQznT+KiS+IqEy54F4x/wB/fG/miX
	ZsxchvHoeg6OFM6C4vhkJ1kM9jXetsSuE8F3hov914nM+V5BL4zY318+ifpBua7xifovKn3eaYc
	mW8ZYfypen1N6gpsVM+HW0DJWP9Hs/zaB406PftQs9gYbL+4ewQ==
X-Google-Smtp-Source: AGHT+IFmA8Zee8fvFoqButoQCNXrJRm6d9pm/RW6pBrhj8FnIAtVHSojfHfEI7J5bxJQaICwjRNEXwhJDSnljiwYoeM=
X-Received: by 2002:a05:690c:f94:b0:65f:a0e5:8324 with SMTP id
 00721157ae682-6e2474d10b6mr134839147b3.4.1727791697954; Tue, 01 Oct 2024
 07:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925192018.15290-2-paul@paul-moore.com> <dd386a1f-9245-45ae-b0fe-d07d1dec5100@schaufler-ca.com>
 <20240926131157.GA683524@mail.hallyn.com> <CAHC9VhSyYkq=AxiVkwkuk1jsTTCqt9xypdto5yaX3jdLXy+Xxg@mail.gmail.com>
 <20240926132251.GB683524@mail.hallyn.com> <CAHC9VhRj5BvBBir3_sWo5whbpRVmpppYEqrvgRf17mR2-xHdAQ@mail.gmail.com>
 <20240930210801.GA778168@mail.hallyn.com>
In-Reply-To: <20240930210801.GA778168@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 1 Oct 2024 10:08:04 -0400
Message-ID: <CAHC9VhQZ1wM-pYW5sPEcP9=uKi4sAFR1nEiEXu-tYypy7feHqA@mail.gmail.com>
Subject: Re: [RFC PATCH] capabilities: remove cap_mmap_file()
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 5:08=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
> On Thu, Sep 26, 2024 at 09:24:06AM -0400, Paul Moore wrote:
> > On Thu, Sep 26, 2024 at 9:22=E2=80=AFAM Serge E. Hallyn <serge@hallyn.c=
om> wrote:
> > > On Thu, Sep 26, 2024 at 09:16:04AM -0400, Paul Moore wrote:
> > > > On Thu, Sep 26, 2024 at 9:11=E2=80=AFAM Serge E. Hallyn <serge@hall=
yn.com> wrote:
> > > > > On Wed, Sep 25, 2024 at 12:45:20PM -0700, Casey Schaufler wrote:
> > > > > > On 9/25/2024 12:20 PM, Paul Moore wrote:
> > > > > > > The cap_mmap_file() LSM callback returns the default value fo=
r the
> > > > > > > security_mmap_file() LSM hook and can be safely removed.
> > > > > > >
> > > > > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > > > >
> > > > > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > > > >
> > > > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > > >
> > > > Thanks Serge.  Any interest in pulling this via the capabilities tr=
ee
> > > > or would you prefer I take this via the LSM tree?
> > >
> > > Oh, jinkeys - I guess should take it through the capabilities tree if
> > > only to check that it still works!
> >
> >  :)
> >
> > Sounds good, if you change your mind let me know and I'll pick this up.
>
> Just got access back to my kernel.org account.  Too late for 6.12 cycle, =
so
> I'll keep it ready for 6.13 window.  I suppose I should see about hooking
> back into the -next kernel for testing.

Sorry for the delay, network access was spotty over the past few days,
and what little I did have was just my phone.

Anyway, yes, this was intended for v6.13 anyway so no harm there.
Glad you're setup again on kernel.org.

Hooking up to linux-next is pretty easy, basically just send some
mail, but if I can offer a suggestion you might want to make your
linux-next branch a automatically generated "composite" branch so you
are better able to get both linux-stable and linux-next patches tested
via the normal linux-next mechanisms.  I'm sure you've seen this
already, but here is the approach I take with the LSM tree:

https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/tree/README=
.md#n94

--=20
paul-moore.com
