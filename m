Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2186745027
	for <linux-security-module@vger.kernel.org>; Fri, 21 Feb 2025 03:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740107803; cv=none; b=RexyjTdi/rnm8Uniy3OMjOnrIP0/wcTTwRG3mLXQaKdEy8ITSoxEaYDymJJgHEAiXHbtLR2cmKYQWXLT1BqSm+7Wu0toIXEVZYoXolTz0TrKnGz4MZiZdQGNhzWPwXg93PDinWCCcpTfQCpg0uYwHrFbTkAxzdnMQ1Toqvbmk90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740107803; c=relaxed/simple;
	bh=kdrOUzgVVdFR3sHFxXYQEjkbdG9MBlaaptabQxv0kQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/yhH0jUGhJUAu3yqg79OVVrDdPps63rH4Q8AFZjXSJyBESOltYlvygcFqvXZ6WNFIa1XLHgOI1Dol5VPItp8QVstCNEeI1eWImeWolaecTkBjiag3F3Z+T0qaJZ41Uxol8TfkLsQkMEwm95oRLNkcG3t6lWfFKj01etreXQFcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a4RAVbIO; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a4RAVbIO"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5209ea469e9so1822628e0c.0
        for <linux-security-module@vger.kernel.org>; Thu, 20 Feb 2025 19:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740107801; x=1740712601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkwUVxurgul/K7FCcMY+3Tk9R0xuunIgonMxNv/xP3Q=;
        b=a4RAVbIOfJ9x4isztn4snzAIQkKsa2B4Ev/2g9k8qeTpj9xGOAW87HuLHh5HVLExoX
         lzAadz9B0iCjyj/k2wlypSEkZdlaov3Kur7BqYAC/qDAmeXIfHGOeyp6HJAe5/dT1+qR
         +Q5bAVtg/QIEE+y+DUnyABwyURrH2xk3DqWvEwbSjsO8HgBmu5JYgMxYfgKXFlYKfA+K
         h+YHXjAZ/MOqhqi3GJLJOUw7hn1WZZtlMLmy1iAss+p4Q6wEke2fx08JzXfhveqn9TWY
         R0UaJaovVuhL6I5AXhPbom6thjGdPXeGd+8Yq354mUBhZTB4FO7GDPvrGbHvAUu2V+77
         3icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740107801; x=1740712601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkwUVxurgul/K7FCcMY+3Tk9R0xuunIgonMxNv/xP3Q=;
        b=RpoOTUvWNuLoVC3v1JDulL9hZlNpYS2Wsmecz5FvNZPeJFhV13ft+f5luGymtGpLg0
         Qed/I358a6cRhznyO7AuEJMy6kHGb1npv0VjrOPDQUthFD/M5tBzcO5JRQF30wUUeLgA
         eXJ2DjI5npH+vZF7ydHVVvuY5TXUJwLdqAhOdWTj6r/exGyXmxZDZLEFIGxaZ15k6BuW
         FE+F1gLOPwg8LQsn0Nvf/iaRGYeITeAkXiiz1CaibsXc2krCRrxgzk3JSiIvdR+tTZg/
         sZmnEk0S4hTQdyMRxon8qK9zlfZCtU1k0d9MQ54C5af3ybQ81hU2DhF5uAan2RO2lZKT
         JNzw==
X-Forwarded-Encrypted: i=1; AJvYcCUl7T4qtR4TzYsH8sxewt5ohgvCJEHgsIxxmAtiBy0nmYWfZr8kz1peWVebxcKVb91SoAdjKZQ/nKGg8ojyIU7Q4zju3Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsShb1/lAWsRpc2cunJ7doIwEWLWmyzTJisvC0sqIgZq1AhMwu
	f5gX2Xk1wIE3CK/zM9JnMAzI3n8wiVa0+Wgm4R9WQbiAZPzp4ILDpAM2dXYQMJwxM7+bXR0Od4l
	Wo3/V3LHROP/yx2YJ1FEYJGRF0d/IdXbYPSAB
X-Gm-Gg: ASbGnctBp4ruBQEfkNRSIH7nMyx+Jt48YFR9wSYflrTO5ETLoXhfB9Nq7+2Hgq6OyPR
	ToFqdM7j/5yo/JMSS9UYZaXEUWixUwpNEECqrO99nTzBo0sxae7ZPdanXgefpD+P6zn1sLPyZ+A
	8Nj0F0qv0=
X-Google-Smtp-Source: AGHT+IH4wi2+Fbki2I5z7rt08OZ60QpOG7qQiecIvmmUTNGESL+MgXrnaybH2kx63UDin7eeHdz7nGr7qRecyFqb7AQ=
X-Received: by 2002:a05:6122:1789:b0:520:a84c:1b59 with SMTP id
 71dfb90a1353d-521dcfc0dd1mr3393922e0c.5.1740107801011; Thu, 20 Feb 2025
 19:16:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023212158.18718-1-casey@schaufler-ca.com>
 <20241023212158.18718-5-casey@schaufler-ca.com> <CAEjxPJ56H_Y-ObgNHrCggDK28NOARZ0CDmLDRvY5qgzu=YgE=A@mail.gmail.com>
 <CAHC9VhSSpLx=ku7ZJ7qVxHHyOZZPQWs_hoxVRZpTfhOJ=T2X9w@mail.gmail.com>
 <CAHC9VhQUUOqh3j9mK5eaVOc6H7JXsjH8vajgrDOoOGOBTszWQw@mail.gmail.com>
 <CAEjxPJ6-jL=h-Djxp5MGRbTexQF1vRDPNcwpxCZwFM22Gja0dg@mail.gmail.com>
 <CAEjxPJ5KTJ1DDaAJ89sSdxUetbP_5nHB5OZ0qL18m4b_5N10-w@mail.gmail.com>
 <1b6af217-a84e-4445-a856-3c69222bf0ed@schaufler-ca.com> <CAEjxPJ44NNZU7u7vLN_Oj4jeptZ=Mb9RkKvJtL=xGciXOWDmKA@mail.gmail.com>
 <eba48af3-a8ef-4220-87a1-c86b96bcdad8@schaufler-ca.com> <CAEjxPJ7aXgOCP4+1Lbfe2b5fjB9Mu1n2h2juDY1RjPgP10PUxQ@mail.gmail.com>
 <784b9c6d-22e1-44d0-86f8-d2b13c4b0e11@schaufler-ca.com>
In-Reply-To: <784b9c6d-22e1-44d0-86f8-d2b13c4b0e11@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 20 Feb 2025 22:16:30 -0500
X-Gm-Features: AWEUYZmAClGRobwy2rc6ntcXOfyVW75ozxug9Z5R0cdhhnSfjf0Qve2WSPi3N4M
Message-ID: <CAHC9VhT968J3zBxtzJcnW+6AKzDKA4MzBgMYoHHXsEaREAe=ww@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] LSM: lsm_context in security_dentry_init_security
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 4:08=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> Adding the lsm_context was cleaner. Not worth yet another roadblock.
> I will have a patch asap. I'm dealing with a facilities issue at
> Smack Labs (whole site being painted, everything in disarray) that
> is slowing things down.

Sorry for the delay today, I was distracted by some meetings and
wrestling with gcc v15 on my Fedora Rawhide dev/test system while I
try to test the LSM init patchset.  Anyway, I'll add my comments to
Stephen's formal patch posting.

--=20
paul-moore.com
