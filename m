Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143802367CD
	for <linux-security-module@vger.kernel.org>; Fri,  9 May 2025 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746809607; cv=none; b=nFXYCPRJsphl3fzQWYhHsSs0/zfPpDmTlbJWIxPdxUG7r9BgPNpDmCZ7H7IayQTqVpXLv+M7yrnyE2RSrw0PPHbOXqpPb0RbeavmFuWbx917dFchD1FvslNt8Tb97ksXisytUK3+K8Ee6ZQpn8it4PV9qPKt+uLtiKx/CZcRH+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746809607; c=relaxed/simple;
	bh=ovsCpdfdcv5lWd54vzHlEPAEE72CBV3NXgYXZCNXoKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4VDKaDYWNzH/MN1wH8Cfguvqf0KI/iMWw15/Qiy8c2jSg4MyVkd+yw+8I/FXDNiS3VuetVO1wNfzZ9yqWDim3CnL80XJGXuWYTibfLaVYPufBs6O/ZUI2yQ/XcZ0lF4nnHFvkr+Rl4cs0XyEqMZ+9sNy4ypUaHCvkVFL01r7Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fMnjNRxO; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fMnjNRxO"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-acacb8743a7so384275966b.1
        for <linux-security-module@vger.kernel.org>; Fri, 09 May 2025 09:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1746809603; x=1747414403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvftcXXxC+RA38DZ97cxLVbR/d27myTWn86O+uHVzlc=;
        b=fMnjNRxONLDW6QhnV+6UgAOQW8cqEqG+hyzp0G42OxJIIr5AZmti94+nefIRUttvEB
         QqoVofvDQA571rT23L+zHlA43bkDu0fYLC51hbUXZhi6jVtyfqRNVOVEpVOm3yqmMPwg
         iU7WkbybwgU+/J1rlcrD/CPhm2n42NakZudaREId+2p7WCXvarUn24EGvsDqh8B+zNCj
         w1dYbCXLw4TN1SD6DBFBmacnWSh5e7euIJoVQjEEfevtyx5oGljcswFStoNTLB5ZBV3L
         HTC62P0Z002Oj79e4nxjvhwJvS5NgSq2ubXGfymFag0Lgw7m/GkK4968GSHx/B+auAU5
         A6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746809603; x=1747414403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvftcXXxC+RA38DZ97cxLVbR/d27myTWn86O+uHVzlc=;
        b=rxFNQgB4N4ATM385OW8W76Ek4+3o7mtSgFDsJ23xbJ1KUscVajvH6eXqAyr0J3bUfV
         h6Nsd/OAITTkd8BRF54+BQ9NjQcSGJLTt6vZsuwtoHtd2ApzhfXUqIRorzqfLptew15x
         gl4p5+orkCqfnA2BMdQFSQOYFt11MpzOyVAKzrpvZ0drfN/jGMCI75FA3R4AL07epm9P
         mLMBPARnhvjXdo8auvZDHXnsup2tfQ7YbLPVitP486NIXJ4A4b15SjHX0fqqWw2cA1mJ
         NQtwTyVg39AmJe0E/QnCL+XziySKDLbr8ySIz/LmhPkAeq73k/vkkJ/w2F8z0gCN9agT
         LE/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZufLXgfIK2tuiq8AZ/P+ICDg4p5fX1ZH3flDwYNcJp4heFlZ0XLrFZIucm6BpHjB0rt9Ekj1j38pTFCr6OKzLWM+/9J0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpdGxVrBA6Y0eyRxcWDC60MwBguBE6IdKSqqX0DG7u8OwbNEV8
	/Jg2NE9MvsS+V6Ji0/58NEmTU4NmoQJeFSi5zmrCvox/yzRMUUisY++vSE/8LQgCfP5vOGnCuW+
	KcVyFtu8cvZLzPqMGzukrV7VFi/1UWHD0WBEfFQ==
X-Gm-Gg: ASbGncvJ66MrZfFOxkvi+D4zjLcIzCIeXZa2pvz0oG0+42Xt5wiC8zEhSlKxmHYaKi5
	apH03k84IncuFPlJazNYj8N0mVXSCWw/bcNyFCdItT05RjB+E5VFGkJGtPzP1a6PXlQbbB5xgi+
	wZFGxHqDmOg3L3jLb2RJ4hpbJem+CnjrY/eijhfSJOG3V11neoTfM=
X-Google-Smtp-Source: AGHT+IEhGi2LQFwvFRnaQacV1MVwRNQX6iJFqdq8RTHLH5cJ5UYZlyhVM7R4mWOQ9PxvwUNpMYblc6WfEAt3Ca+JqI4=
X-Received: by 2002:a17:907:c717:b0:ac7:81b0:62c9 with SMTP id
 a640c23a62f3a-ad21b42627amr364284266b.20.1746809603331; Fri, 09 May 2025
 09:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <20250309151907.GA178120@mail.hallyn.com> <CAKPOu+_vTuZqsBLfRH+kyphiWAtRfWq=nKAcAYu=Wn2JBAkkYg@mail.gmail.com>
 <20250506132158.GA682102@mail.hallyn.com> <CAKPOu+9JCLVpJ-g_0WwLm5oy=9sq=c9rmoAJD6kNatpMZbbw9w@mail.gmail.com>
 <aB0sVcjFZaCVEirH@lei> <CAKPOu+89=+SFk1hKGLheMtPq+K47E9FRCo1DBQo9zGMwW=Tr2w@mail.gmail.com>
 <87h61t7siv.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87h61t7siv.fsf@email.froward.int.ebiederm.org>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 9 May 2025 18:53:11 +0200
X-Gm-Features: ATxdqUFC9_hHEUoh5M3wGZU19wIBs4HyJyr3wHdymfUQLj3BgYhzKvRJc8bf1HM
Message-ID: <CAKPOu+8uw6SCO_hhOy_Kc_XihTDvJGoPrC1ujAHPYuiBghUb1g@mail.gmail.com>
Subject: Re: [PATCH] security/commoncap: don't assume "setid" if all ids are identical
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: sergeh@kernel.org, "Serge E. Hallyn" <serge@hallyn.com>, Andy Lutomirski <luto@kernel.org>, 
	paul@paul-moore.com, jmorris@namei.org, kees@kernel.org, morgan@kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 4:45=E2=80=AFPM Eric W. Biederman <ebiederm@xmission=
.com> wrote:
> In particular __is_setuid or __is_setgid being true guarantees
> that has_identical_uids_gids will be false.

Sorry, no, that's completely wrong!

__is_setXid() compares effective with real.
has_identical_uids_gids() compares effective with effective, real with real=
 etc.

See the difference?

> Which means has_identical_uids_gids adds nothing, and the patch is
> pointless.

Also wrong. If that were correct, then my patch would not have an
observable effect. But it does. Try it, try the small program I
posted!

It seems your whole email is based on this misunderstanding. Please reconsi=
der.

> If your concern is LD_PRELOAD and the like please don't play with
> the uids/gids and instead just make certain bprm->secureexec gets
> set.

LD_PRELOAD is not my concern at all. I just observed that the current
kernel behavior can annul the LD_PRELOAD/suid protection as
implemented in glibc.

> I see no evidence
> in this conversation that anyone has surveyed the users of NO_NEW_PRIVS
> and verified how anyone actually uses it.  Without such evidence we
> have to assume that userspace depends upon the current behavior.

That's fine for me. But this behavior should be documented, because it
is rather surprising.

(In any case, we will keep the patch in our kernel fork because we
need this part of the kernel to work properly. Our machines don't run
any code that depends on the buggy behavior.)

Max
