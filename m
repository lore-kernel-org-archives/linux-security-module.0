Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8453A8F0
	for <linux-security-module@vger.kernel.org>; Sun,  6 Oct 2024 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728246056; cv=none; b=Railg1yFInRPO61D/H3kEWDb+fpnmQqEqjFzN1QtoaGL1gZsvKz4AqSqv4QPXZ2sh3BFWm70gTcy0XmNfA0HXnhzbExL7rEpp7cPrJb4Pncs5DH69t8EeET1AH/UL+Sem3feVCMkoV42rUEd3yy8IeD8KOf4JvARhsYc2swHnK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728246056; c=relaxed/simple;
	bh=vd4y/8BISLiFsF1bjwIk+kEupZCElRABwenOkPnJ0YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVy7UzEeIoj6e4BzJYCunB8eCtiq2pEzAyCz38IUi6dXp8WLw5Gklf6OAT1gkk8fcyzWZXcv05vGe2kg3VSkPtakanypVkxUNhrJ68uxMwF7GA2mfU8bhhVGlyncWm+quM6KoSlV7+PqueAi37909YXruVh1hHHBtyTWLaMn87A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YrTr8EN3; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YrTr8EN3"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e260850140fso3604363276.2
        for <linux-security-module@vger.kernel.org>; Sun, 06 Oct 2024 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728246054; x=1728850854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVPEMWcKoXw4mj6m5AJkOtdPhIXokT+ySe2Ab3hZO4o=;
        b=YrTr8EN3PCBvZ+lcWf87QtKLS9ub09qKE3ADcwW7yEhyKUzetkgONP9qnOnbRUqFgq
         3QY0+TUK6A2DxXAt98WWfz4U4ogroUU6xsMOzGtyOoqAyJg5M0FfwkLRsHI+wsffMs0J
         wx25yWqmcNr9K5/qkYmmqnxj2EGzjtcYikk5MGMNHkNxUimLlYmzhZdsUyL/KlfBI7QE
         HOYRUgWCbwUK/7h9Ba6OlSAij83Ixo3xLTUKJezKSiyoy+bZdfIugtcgWHZ7GW/S6u4A
         O76ImK9+RQwQLiC8Uhkxi6FRPFEjmXTuxVrF4RG2oyZ0ARQsa8Hq+PyPfUb4BLnxeuwg
         uDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728246054; x=1728850854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVPEMWcKoXw4mj6m5AJkOtdPhIXokT+ySe2Ab3hZO4o=;
        b=RDullaRxbQP/jsOLlMIPWVYIi3IHLsH4jNbLbphYv9cgtFnnaGIotWT4/zCTP1wWi1
         C8YUWk8IRAJjagKH1jase9wEtTrQuBL16HYfruCIGs9zApD0K3vKB+CwVgLWiaheuhnn
         3ZEPKYLY9gG8quXZbHSUiwGSsAjbvsxbgYvmqNueVd03JgGfne062FOAW9FbINxx23yp
         WU91n9PivIrvgCHedwhK/cU831/IL3MtSho9aCa9nTGFU2hP4WOYoDo5lyAKTj4JXEcc
         uLLba+iNPIg9BxSbWPqzPK/DZs6zBk6V4mwavqN82avxHvVA0BW9xqFy+oZo9mwC5Bln
         yA6w==
X-Forwarded-Encrypted: i=1; AJvYcCWrxyrZfejMNYuA5FxpGS0QKe3CXC6rum/9kRQWjPabGYDlUxf0PNDwxwgIGlgKKlONFdj/EKr8VAt6ZE8fgbRL+D51dQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2fgS6uu732e/N1eAimi1Hgp+eCcXiDN20A0bK5hCk5+IT89Nq
	rY3KaRjImrXmYlqLoSkjDIySbjgD5tUIXflm/cVAdgMjruIakRmNvztbhp6efctq/1lUOX4VvzT
	Tm8QwPv8BYnFB0YCxy8yIbc6iH7ezoNlfAqyg
X-Google-Smtp-Source: AGHT+IF4eogRmJvWuS1cofUR/l7St0eZxsKsRgmE4EEQVFaKVrZaPfT4bszUYTrjImM58eUHyb8DtaTnBG4Sghdv86E=
X-Received: by 2002:a05:6902:1b07:b0:e26:384f:d38f with SMTP id
 3f1490d57ef6-e28937e2ce4mr7514553276.29.1728246053983; Sun, 06 Oct 2024
 13:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <202410041305.544EA7E4E@keescook> <ece0c7bd-0d28-4562-8760-c54b0077583a@I-love.SAKURA.ne.jp>
 <202410041645.27A48DA@keescook> <5b09909b-fe43-4a9c-b9a7-2e1122b2cdb6@I-love.SAKURA.ne.jp>
 <4eaea237-d259-44bb-a546-26a0558a4453@schaufler-ca.com> <20241005170235.GA24016@wind.enjellic.com>
 <034409ae-5d36-49d6-8073-adbff2a4404c@schaufler-ca.com> <20241006161835.GA29292@wind.enjellic.com>
In-Reply-To: <20241006161835.GA29292@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 6 Oct 2024 16:20:43 -0400
Message-ID: <CAHC9VhQ44xEQZekVDDxPxQe-R1GynkzUPtaQP3wPg9NQ8r49LQ@mail.gmail.com>
Subject: Re: TOMOYO's pull request for v6.12
To: "Dr. Greg" <greg@enjellic.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Kees Cook <kees@kernel.org>, 
	Fan Wu <wufan@linux.microsoft.com>, "Micka??l Sala??n" <mic@digikod.net>, 
	Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>, 
	John Johansen <john.johansen@canonical.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	KP Singh <kpsingh@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 12:20=E2=80=AFPM Dr. Greg <greg@enjellic.com> wrote:
>
> There was an LSM list thread started by, I believe a Korean Linux
> integrator.  I believe they were on an Ubuntu OS base platform running
> AppArmor and running a containerized Fedora implementation to
> experiment with SeLinux, I don't remember all the details, the
> exchange would be on lore.  They were somewhat disconcerted by the
> fact that when they threw the switch on SeLinux in the Fedora
> implementation things pretty much collapsed around them.
>
> Paul replied back and said that the LSM doesn't know anything about
> namespaces, so the impact of enabling SeLinux was OS wide.  He
> commented further that the above scheme could be implemented but there
> would have to be very sophisticated mutual exception policies in place
> between the two modeling strategies and composing something like that
> would be the domain of experts in the field.
>
> I had replied back to Paul and indicated that it was our understanding
> that with LSM stacking you get the union of all the implemented
> security models.  We had posed the question, in this hypothetical, if
> an unconfined system wide SeLinux policy would be needed to disallow
> all action by SeLinux, except for subject/object interactions that
> would occur in the subordinate OS instance, but I don't remember
> seeing a response, we may have missed it.

When multiple LSMs are enabled on a system the goal is for every
access decision to be only as permissive as the least permissive LSM.
This is a pattern seen in other places in the kernel as well,
including seccomp and the single LSM case when one considers the
combination of both the legacy DAC controls and the additional
controls implemented in the LSM.

The issue that sometimes confuses people is that there is no singular
LSM namespace mechanism implemented at the LSM framework level (that's
an intentional decision).  On a system that enables LSMs A and B, with
LSM A implementing a A-specific namespace, switching to a
second/child/etc. namespace in the A LSM does not mean you have
switched out of the B LSM; operations in the secondary A LSM namespace
must still satisfy the access control rules in the B LSM.

--=20
paul-moore.com
