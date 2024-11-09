Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B1519D8A7
	for <linux-security-module@vger.kernel.org>; Sat,  9 Nov 2024 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731179122; cv=none; b=UQfSF7qBcEVgRjuAUfa9wG6iVeieOG2IxadE4lq1dHtz8INBAZ57XMoFW0JS2VFQqsdpiGgrJCV04pwelpR3T8pLUphbEupS+gUhaxzd+uT5mXerszjaeVj0ytr/4alQlpXItwqA9rZ3FBSz4fdXOeYddRJGi59yLjyil6yfM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731179122; c=relaxed/simple;
	bh=KwXfnL/HO7mdnXq5fa9Bf01OnaWZcijShx+DAR0ot1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJw0PtsLKaPIBxpZd2K7qYoCbl9c40OZfx4oyFXqG+jGEtXQ1xR5vLFW79S3dq+7h1b+668/87FVmcwVQYIZgZp5eKc/f8s0URxScc4nL3yVb1rKR5H4Mq76eyKPz94zc7LUymkn8LFqRVdU2QMJZf5aJzHBGAPYRBTyzH+4U1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=UNv6jCbr; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="UNv6jCbr"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Xm4Yq0rDFzm30;
	Sat,  9 Nov 2024 19:47:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1731178063;
	bh=XEwLQUqvrOlFLOgH2zBFraykcy0Wb4QL0FN5JWXgc+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UNv6jCbrCKF8T9j6GKju7/pklegF3FVOUKm03ULC2cLAH4ZqrekrribIDRJZVQrJs
	 rqSAMuoG5GGSqcwHR5teTWFCkmxIKJCe6MZwpmgmPb5jLuvj9yga+PhawRzkHmwtBx
	 E+lxmOi0mEXhRIlNQjeKqAxWKeAfhw8HZmx55F4Y=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Xm4Yp0jfYzv1Y;
	Sat,  9 Nov 2024 19:47:42 +0100 (CET)
Date: Sat, 9 Nov 2024 19:47:35 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Paul Moore <paul@paul-moore.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 3/3] landlock: Optimize scope enforcement
Message-ID: <20241109.oiyaa0Woh0Ee@digikod.net>
References: <20241109110856.222842-1-mic@digikod.net>
 <20241109110856.222842-4-mic@digikod.net>
 <Zy-qROSRm1rb_pww@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zy-qROSRm1rb_pww@google.com>
X-Infomaniak-Routing: alpha

On Sat, Nov 09, 2024 at 07:30:28PM +0100, Günther Noack wrote:
> On Sat, Nov 09, 2024 at 12:08:56PM +0100, Mickaël Salaün wrote:
> > Do not walk through the domain hierarchy when the required scope is not
> > supported by this domain.  This is the same approach as for filesystem
> > and network restrictions.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> > Cc: Tahera Fahimi <fahimitahera@gmail.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20241109110856.222842-4-mic@digikod.net
> > ---
> > 
> > Changes since v2:
> > * Make the unix_scope variable global to the file and remove
> >   previous get_current_unix_scope_domain().
> > ---
> >  security/landlock/task.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> > 
> > diff --git a/security/landlock/task.c b/security/landlock/task.c
> > index 4acbd7c40eee..dc7dab78392e 100644
> > --- a/security/landlock/task.c
> > +++ b/security/landlock/task.c
> > @@ -204,12 +204,17 @@ static bool is_abstract_socket(struct sock *const sock)
> >  	return false;
> >  }
> >  
> > +static const struct access_masks unix_scope = {
> > +	.scope = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
> > +};
> 
> Optional nit: You could probably inline these two struct access_masks values
> into the respective functions where they are used.  (But it's just a minor code
> style matter IMHO; both ways are fine.)

That was the case in a previous version, but because we'll need to have
it global for a next patch series, I already put it there to avoid
useless code change:
https://lore.kernel.org/all/20241022161009.982584-14-mic@digikod.net/

> 
> > +
> >  static int hook_unix_stream_connect(struct sock *const sock,
> >  				    struct sock *const other,
> >  				    struct sock *const newsk)
> >  {
> >  	const struct landlock_ruleset *const dom =
> > -		landlock_get_current_domain();
> > +		landlock_get_applicable_domain(landlock_get_current_domain(),
> > +					       unix_scope);
> >  
> >  	/* Quick return for non-landlocked tasks. */
> >  	if (!dom)
> > @@ -225,7 +230,8 @@ static int hook_unix_may_send(struct socket *const sock,
> >  			      struct socket *const other)
> >  {
> >  	const struct landlock_ruleset *const dom =
> > -		landlock_get_current_domain();
> > +		landlock_get_applicable_domain(landlock_get_current_domain(),
> > +					       unix_scope);
> >  
> >  	if (!dom)
> >  		return 0;
> > @@ -243,6 +249,10 @@ static int hook_unix_may_send(struct socket *const sock,
> >  	return 0;
> >  }
> >  
> > +static const struct access_masks signal_scope = {
> > +	.scope = LANDLOCK_SCOPE_SIGNAL,
> > +};
> > +
> >  static int hook_task_kill(struct task_struct *const p,
> >  			  struct kernel_siginfo *const info, const int sig,
> >  			  const struct cred *const cred)
> > @@ -256,6 +266,7 @@ static int hook_task_kill(struct task_struct *const p,
> >  	} else {
> >  		dom = landlock_get_current_domain();
> >  	}
> > +	dom = landlock_get_applicable_domain(dom, signal_scope);
> >  
> >  	/* Quick return for non-landlocked tasks. */
> >  	if (!dom)
> > @@ -279,7 +290,8 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
> >  
> >  	/* Lock already held by send_sigio() and send_sigurg(). */
> >  	lockdep_assert_held(&fown->lock);
> > -	dom = landlock_file(fown->file)->fown_domain;
> > +	dom = landlock_get_applicable_domain(
> > +		landlock_file(fown->file)->fown_domain, signal_scope);
> >  
> >  	/* Quick return for unowned socket. */
> >  	if (!dom)
> > -- 
> > 2.47.0
> > 
> 
> Reviewed-by: Günther Noack <gnoack@google.com>
> 
> Looks good!

Thanks!

> 
> —Günther
> 
