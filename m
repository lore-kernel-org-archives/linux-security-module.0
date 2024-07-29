Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E726A14F9CF
	for <linux-security-module@vger.kernel.org>; Mon, 29 Jul 2024 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262209; cv=none; b=eWZIXF3UpPhdRftM9Jlq84j0ty4ORUeLK/UADv1Im+RZAxkjENKZeDoXBDTHK/aWH9+FQ9f1KXoQSgq2cOKc1zT/VGgREgCuYkYNm/ZyOSIWZiSQfxeOubjLmsZLDlUns6PpGEzETA1U0LOay88klS6TAAP3HksEYLBHupRLeps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262209; c=relaxed/simple;
	bh=vyFLUUl3RqBsYrKATy7kglM3lc3UZ7rHLTHg7tKfzYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rmfy2BrFoViusE2q8vY7t1Eq1z9kWhvy2iXLol59Bzss8bgo5dzWNh4hK23p5OEdLWhPFmyQW3T0ONdnBAdusPONjCD12zMzhC+mbrUEDZR9FGuzQrQVwuY6YwoqQYzboUqAXtjN2djSHbTvZfKUDoMrkCcPnr0aDzGB40k0Zys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=JLaeGXNk; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="JLaeGXNk"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WXgGv2Q5yzHBp;
	Mon, 29 Jul 2024 16:09:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1722262199;
	bh=SIWtCB8Vnu1NtLQ2ovdqmSr4f6/uzaKar+Jlyb4V5Ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JLaeGXNk5g2EqmYDsO5/GLJzLkp3Zqbq00iwlNsEmkVnVfRnCQI8FzHv2AarIn47/
	 roCNajCc+rcety/GEYRv+KxCpE7ZnH2b8ql9frpq2REcpoVO0ZOkcgmSn/Y4SydR4g
	 5vfH71J9TGVJmjAuYhXF1O3QMIMxDQzccIuaO8Ww=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WXgGt2HdNzCSQ;
	Mon, 29 Jul 2024 16:09:58 +0200 (CEST)
Date: Mon, 29 Jul 2024 16:09:56 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jann Horn <jannh@google.com>
Cc: David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	James Morris <jmorris@namei.org>, Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1] keys: Restrict KEYCTL_SESSION_TO_PARENT according to
 ptrace_may_access()
Message-ID: <20240729.cho6saegoHei@digikod.net>
References: <20240729125846.1043211-1-mic@digikod.net>
 <CAG48ez3DzxGMWN9GDhSqpHrDJnZDg2k=VEMD_DFiET5yDr07rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3DzxGMWN9GDhSqpHrDJnZDg2k=VEMD_DFiET5yDr07rw@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Jul 29, 2024 at 03:49:29PM +0200, Jann Horn wrote:
> On Mon, Jul 29, 2024 at 2:59 PM Mickaël Salaün <mic@digikod.net> wrote:
> > A process can modify its parent's credentials with
> > KEYCTL_SESSION_TO_PARENT when their EUID and EGID are the same.  This
> > doesn't take into account all possible access controls.
> >
> > Enforce the same access checks as for impersonating a process.
> >
> > The current credentials checks are untouch because they check against
> > EUID and EGID, whereas ptrace_may_access() checks against UID and GID.
> 
> FWIW, my understanding is that the intended usecase of
> KEYCTL_SESSION_TO_PARENT is that command-line tools (like "keyctl
> new_session" and "e4crypt new_session") want to be able to change the
> keyring of the parent process that spawned them (which I think is
> usually a shell?); and Yama LSM, which I think is fairly widely used
> at this point, by default prevents a child process from using
> PTRACE_MODE_ATTACH on its parent.

About Yama, the patched keyctl_session_to_parent() function already
check if the current's and the parent's credentials are the same before
this new ptrace_may_access() check.  So this change should be OK with
Yama and most use cases.

> 
> I think KEYCTL_SESSION_TO_PARENT is not a great design, but I'm not
> sure if we can improve it much without risking some breakage.
> 

I think this is a security issue that a process can change another
process's credentials.  If the main use cases is for shell commands, it
should be OK.

The alternative would be to restore the key_session_to_parent LSM hook
[1], and update most LSMs to block this kind of credential tampering,
which will lead to the same result but with only partial users being
protected.

[1] commit 3011a344cdcd ("security: remove dead hook key_session_to_parent")
