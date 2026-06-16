Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CDA478E26;
	Tue, 16 Jun 2026 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630397; cv=none; b=cvpGsXOEBiBWzVEiEAyXx0vUV9h2M0lCcPHf9l32N75xESaxrJpgmSDWRjO5ry4dUrkyd0x3YAw6RAHAqOGUXzbm6b7N5+VQKM+RhwDn6A/fChpqxySjB+wXLXmbdO5YbpHXI15QZVb1GTtohlucf9HR0+ya0cy22zkz8L7y22A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630397; c=relaxed/simple;
	bh=CKP3jvF7EV0nA+nwJcnJlDDzrclTxYQczOeQGo5kG/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUfrD5wiVqYIf7l6tTihWjAQ40xcYhcRWwm1D1Y9isgAOn1TlGJn2WF+8JvrVMFI5AqSmKm80XcLwZ5YcsSkZzO+QPcFfeTt1xG2R2Up2PFSS5kFjK7ttgiti3DiHOk9iYaoU5F7W2HoliONpAp3/YExqhHX26n0COGqar8aWaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=cvEMEG4K; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="cvEMEG4K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1781630076; bh=CKP3jvF7EV0nA+nwJcnJlDDzrclTxYQczOeQGo5kG/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cvEMEG4KbdC6VIu+lmxwDnThhbng+KMtR0wiHWLqAAJedhAKVkQsAyv4gywhdtcUE
	 JbApsft9EjpIBwZO9rRCZFl+7UCTL+wWiQvvZWgW5rvEDC2iTevJaGgbI85UAcDSJm
	 sk34/TsL4pbP75zrU1QcqzlM2jg1FPv/SBwKnMSFNvWVQF31mmuMeOmrbY7x5tjlLr
	 GSg7D6BNeQ77ZcvPAUsb6u6xE6PkXww8SPXSiat7WY3211BNLE/PX+25IClq0PXA7O
	 6Uac2I/VKRFQLkla/TNFfsjWLf1KE6kpwMWDQjPXmmme3hW/2Lre1Y8nD9i1NtZjyh
	 j5qEU//Gp08rg==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id E759B4BE; Tue, 16 Jun 2026 12:14:36 -0500 (CDT)
Date: Tue, 16 Jun 2026 12:14:36 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Bill Roberts <bill.roberts@arm.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: clarify task_prctl hook documentation
Message-ID: <ajGEfFZF6qgsquQs@mail.hallyn.com>
References: <20260615200325.260057-1-bill.roberts@arm.com>
 <bdf7591c-4078-4ee5-9e63-e5dc27602fb6@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdf7591c-4078-4ee5-9e63-e5dc27602fb6@schaufler-ca.com>

On Tue, Jun 16, 2026 at 09:07:40AM -0700, Casey Schaufler wrote:
> On 6/15/2026 1:03 PM, Bill Roberts wrote:
> > The task_prctl hook comment incorrectly described the hook as checking
> > whether a prctl operation is allowed. In reality, the hook exists for
> > LSMs to handle LSM-specific prctl operations.
> >
> > Update the function description and kernel-doc comment to reflect the
> > actual behavior. The old wording appears to have been copied from other
> > permission-check hooks despite differing semantics.
> >
> > Signed-off-by: Bill Roberts <bill.roberts@arm.com>
> 
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Yeah, this is an important distinction, thanks.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> > ---
> >  security/security.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/security/security.c b/security/security.c
> > index 4e999f023651..96e6ef088801 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -3301,15 +3301,14 @@ int security_task_kill(struct task_struct *p, struct kernel_siginfo *info,
> >  }
> >  
> >  /**
> > - * security_task_prctl() - Check if a prctl op is allowed
> > + * security_task_prctl() - Handle an LSM specific prctl call
> >   * @option: operation
> >   * @arg2: argument
> >   * @arg3: argument
> >   * @arg4: argument
> >   * @arg5: argument
> >   *
> > - * Check permission before performing a process control operation on the
> > - * current process.
> > + * Handle lsm specific prctl operations.
> >   *
> >   * Return: Return -ENOSYS if no-one wanted to handle this op, any other value
> >   *         to cause prctl() to return immediately with that value.
