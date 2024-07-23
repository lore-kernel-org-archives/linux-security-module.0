Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0C152196
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jul 2024 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740080; cv=none; b=RaQW3tjiq7M+YHO6kPy20Eri4HvpU4u4xgP18vKyjk0YzYKSWyGOp+TyOm95TR6v73C4Aip7b3F3adeeIz6p0GOOu4CxGYiommltS31w8NGhjo7nUxCHB2kP/dNfM2xYZV1bA2JJDPLbNrgbmVr+kvHMhwPFTjnElWRZsx2wZpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740080; c=relaxed/simple;
	bh=3m05c7i0mMEu004ZpuJCMzUvWT2aeBR3MrMAQqPh7Zc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VthWoUIk33U61c9Wd43i4JccqGNNBhK7pI5hrpuwX+eDMZDvPIwtrV5tzGsQBG5PJNMWH5g1kZhvW2VJKx4c78XHHADhhpIXZ6NaF9L4ZvB9YDbk6hT3+zllDkqUywCKiUITHzpU9fOjVHPmU623tdw+RKd0Zv4S40UWLMQahWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mjz7pdTI; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mjz7pdTI"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5a2d4fb1e73so4196032a12.2
        for <linux-security-module@vger.kernel.org>; Tue, 23 Jul 2024 06:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721740077; x=1722344877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifo7WERZ8jRl11fTVb1cJHkwdS3F5GkVkABM96JEq0Y=;
        b=mjz7pdTIf/BDty9f2td3W8rdYoc2UvneFBX2aqD7kPm7wwJ5Kr2lQDv1c9BH7437CF
         SZXlJJmc92qNXRf3o4tIsLxx4BfbboKMJKEOMHKPSkyUQ4cshbC411ZWUSNj0Z7EzT6Q
         r28GP9BWRryEOq8jkLn2vO6kSBWe3INwKyUgIKd4Xyn5IJDQx+RuJzvL0SiDdr1ZpssR
         /Xr7eRtJ7YGPs/eunDfPCjwi1TjPBr2LaCzt7J2OF4NDVeeVBGpzENQwkazH74MMPeob
         UTfmxo9n1fNoeTZovsrNjXGsVZ1ysxMEP7ng2+J5vAZBt2vxrQZfwt/HNxgebfhJEC61
         XThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721740077; x=1722344877;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ifo7WERZ8jRl11fTVb1cJHkwdS3F5GkVkABM96JEq0Y=;
        b=dSF2s/2uvmECle2O4L3TB/JI4FumFe81cqVmg+iwUQQZBUYUTOaSobmFKNf2BllhQc
         xjOKCHg8CvxIYTmg55kCzo+yRmhPEk//K/IReWRH0R4GNfRTtvYNX6D/yAUy2w+eIwMe
         A/g+3C794WkDTuNfqVMCJ9BJ6C87U/wRAY5qAdVOC6rFqxHoucqDwLNmNwDKeL50o2Df
         rrsgdQ4/RILz4yb3EL7HxbziRTCUPNCS42jwlJdzIxqFgRPzAJW2Y2w/N1IAGdrqoV2B
         omfO2NMZ6bVvG4tbI09hwtxvd3NGIbrXU2U96LuiBnjUkgnEY1FolTRlMloE8zhuK4At
         0v3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWo8DwzbbqVtL5kMKADXw73QmJI3dKz5ClCAOBIzY+g3ztunL960FQTvf47JTM6GQMEg8bm8WkmbAuIFSzMnGpyJsYzcdLBKHeXNBkWJCu+3xcAl38T
X-Gm-Message-State: AOJu0YxL7IghGnm5ZKRGEzMxdNPEWMnoUGGm891pL5X2oM2q+iCnILYM
	L/kIXnsGbHfEpAVJ/V6uPrawiwziTiUwednDNX8ft3kREf5HyNlWD2Hl11DSubsSbjcvwKRGaqE
	a5w==
X-Google-Smtp-Source: AGHT+IFB5NsIdU9NWjHNX7qeCpoQfX0fL0OlpN4f8jnXYypXk0QtvfEYqf6ESHp/Uk3rvzEirX6S59fIVI0=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:aa7:d951:0:b0:58b:f7c3:83fe with SMTP id
 4fb4d7f45d1cf-5a3f0883f7bmr9336a12.3.1721740076592; Tue, 23 Jul 2024 06:07:56
 -0700 (PDT)
Date: Tue, 23 Jul 2024 15:07:53 +0200
In-Reply-To: <20240719150618.197991-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240719150618.197991-1-mic@digikod.net>
Message-ID: <Zp-q9zxmCmGjR2-N@google.com>
Subject: Re: [RFC PATCH v1 0/3] Use socket's Landlock domain
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Paul Moore <paul@paul-moore.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Jeff Xu <jeffxu@google.com>, 
	Kees Cook <keescook@chromium.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Shervin Oloumi <enlightened@chromium.org>, Tahera Fahimi <fahimitahera@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Micka=C3=ABl!

On Fri, Jul 19, 2024 at 05:06:15PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> While the current approach works, I think we should change the way
> Landlock restricts network actions.  Because this feature is relatively
> new, we can still fix this inconsistency.  In a nutshell, let's follow a
> more capability-based model.  Please let me know what you think.

Thanks for sending the patch.  The implementation with ->f_cred is much sim=
pler
than I had thought it would be.  Some higher level questions:

 * I assume that the plan is to backport this as a fix to older kernels tha=
t
   already have the feature?  (Otherwise, we would potentially have backwar=
ds
   compatibility issues.)

 * I believe it clashes a little bit with the TCP server example [1],
   which I found a useful use case for the TCP connect/bind and socket
   restriction features.

 * accept(2) on a passive (listen-mode) socket will give you a new socket F=
D
   -- does that new socket inherit its f_cred from the server socket,
   or does it inherit its f_cred from the thread?

Regarding the TCP server example, the current implementation is *very* simp=
le,
and does the following steps:

 1. create socket with socket(2)
 2. bind(2) the socket to the desired port
 3. enforce a Landlock ruleset that disables all networking features
    (TCP bind, TCP connect and socket creation with the new patch set)
 4. listen(2) on the socket
 5. go into the accept(2) loop

With the old behaviour, step 3 is going to affect the existing passive sock=
et:
It will not be possible any more to bind(2) that passive socket to another =
port.

With the new behaviour (after your patch), step 3 does *not* affect the exi=
sting
socket, and the server socket can be reused to bind(2) to other ports.

Or, in other words: If the relevant domain is tied to the socket at creatio=
n
time, that means that a future client connection which takes over the proce=
ss
might be able to use that socket's Landlock domain, which potentially grant=
s
more permissions than the thread's domain

I think it would be nice if a use case like in the TCP server example would
still be possible with Landlock; there are multiple ways to reach that:

 - We could enforce two layers of Landlock rules, one before socket creatio=
n
   that restricts bind(2) to a given port, and one after socket creation th=
at
   restricts other bind(2), create(2) and socket(2) operations.

   Drawbacks:

   - One Landlock layer more, and needs to add a Landlock rule:
     This is a bit more complicated to implement.
   - The bind(2) restriction on the socket is still only per port *number*,
     but it is still possible to bind with that port number on different IP
     addresses.

 - Alternatively, I wish we could just lock the passive server socket in, s=
o
   that it can't be made to reconnect anywhere else.  After all, the socket
   disassociation with connect(2) with AF_UNSPEC seems to be a somewhat obs=
cure
   and seldomly used feature - if we could just disallow that operation, we
   could ensure that this socket gets reused for such a nefarious purpose.

   It would still require two nested Landlock rulesets to make the TCP serv=
er
   example work, but they would be a bit simpler than in the alternative ab=
ove.

 - There are probably more alternatives...?

What do you think?

=E2=80=94G=C3=BCnther

[1] https://wiki.gnoack.org/LandlockTcpServerExample
