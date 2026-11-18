Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.16.66.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021900;
	b=OWHEydgvi3uBEazd2M+7HZaOrD82OGDVp+5yk5pMqLwTfGxpPdMsYaxHmgkHJs9cUjsy
	 wuw0wJ6dtqUGubkFyH2vEStYgOpHIfRu3s67h6oFYOe/xbxx/18Gu7MpAhWAN3XglV8tp
	 xkPXpzWMF4gW5AH3YEXZt+bhbMsLC6FDhuW1DCahquuGEtTzvsmRV3dnJvynWgr7f+ymr
	 JgA8JwY9UDOfaZc8NSa7HZqQ0sVbe08fJ24AS6L4khhUL+LALn0RtZOgdHnck09SLJ3GD
	 xU4z/A2pQM01dMYwJus5B5yxDIXg9eXhYSgqa+sZi2v+O23aZq0fDJFc65udbH2ArVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021900;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Infomaniak-Routing;
	bh=7jx+RlrY6hDpG8QT3cFVyASFCwKqa6uSd484Aq4omxY=;
	b=goiiyd0B3kieNeHK5AKE3lcMBA4e6WOqRRJyWws/HTfh0k9CCZuC4W4FbN18j5XFvOh+
	 Wic/VY1fTFSWOTw3MNqCWaBRXYKTFqZjPzrjawYL6b/qWCMG/0KykiaXFaJe1mZ26Hxdk
	 dFJAPe824QaaQ+Z/mOjF3RYVoOfEjYVkGu+pl+kB+vaqEH7vmHoVw60CmHd/QPvpdJQds
	 JG+SyYJtPkwxG7GnXp7CqONC8vd8zreWDzgZlEgq896N063ypNom1leVGs1DrMtD89e9g
	 UKq0AM28CbK9ScM2yfZqmcHeuAM0piu2+ZHn5K0lqbmqpoMCGNV1OoOU4g23jJNaP7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=zu2Jn0fa;
	arc=none smtp.remote-ip=84.16.66.168
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81C8606A334
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 17:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D81C8606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=zu2Jn0fa
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jV7Rq6FRvzKR;
	Wed, 18 Nov 2026 18:11:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1795021895;
	bh=7jx+RlrY6hDpG8QT3cFVyASFCwKqa6uSd484Aq4omxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zu2Jn0fa8u5u18uihYuSzHQIIUL2cQiGbptCFr4vhw8itb0vRYiEjTcu2wp3dTILe
	 TkmE3FDRnpgVW9Y6bd/5w34wGkmx0KBsgPN5Qn5xZYSIoTihD3m9PqTGBt7yBBeRhp
	 izzsq/IfFugIAK/KIetaSusUXgH4uaTvzP9Cy1qg=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jV7Rp3y56zBLc;
	Wed, 18 Nov 2026 18:11:34 +0100 (CET)
Date: Wed, 18 Nov 2026 18:11:31 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Ada Smith <adasmithgt@gmail.com>, Hungyu Lin <dennylin0707@gmail.com>, 
	James Morris <jmorris@namei.org>, Josef Bacik <josef@toxicpanda.com>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>, 
	Serge Hallyn <sergeh@kernel.org>, kernel-team@cloudflare.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 6/6] landlock: Fix capability restriction documentation
Message-ID: <20261118.Ee0ahpae0Qui@digikod.net>
References: <20261117101157.2520463-1-mic@digikod.net>
 <20261117101157.2520463-7-mic@digikod.net>
 <avx_49eHcDPjyuDU@google.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avx_49eHcDPjyuDU@google.com>
X-Infomaniak-Routing: alpha

On Tue, Nov 17, 2026 at 05:25:07PM +0100, Günther Noack wrote:
> On Tue, Nov 17, 2026 at 11:11:56AM +0100, Mickaël Salaün wrote:
> > Some documented claims about LANDLOCK_PERMISSION_CAPABILITY_USE do not
> > hold for every capability check.  Remove them instead of listing their
> > exceptions, and call it a permission instead of a hook.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Serge Hallyn <serge@hallyn.com>
> > Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
> > Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> > 
> > Changes since v1:
> > https://patch.msgid.link/20261110202436.2408244-7-mic@digikod.net
> > - Add Serge Hallyn's Acked-by.
> > ---
> >  Documentation/security/landlock.rst      | 8 ++++----
> >  Documentation/userspace-api/landlock.rst | 8 ++++----
> >  include/uapi/linux/landlock.h            | 6 +++---
> >  3 files changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
> > index d81f1c2cd236..98c2e7139e8d 100644
> > --- a/Documentation/security/landlock.rst
> > +++ b/Documentation/security/landlock.rst
> > @@ -8,7 +8,7 @@ Landlock LSM: kernel documentation
> >  ==================================
> >  
> >  :Author: Mickaël Salaün
> > -:Date: October 2026
> > +:Date: November 2026
> >  
> >  Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
> >  harden a whole system, this feature should be available to any process,
> > @@ -359,9 +359,9 @@ framework in ``log.c``, compiled under ``CONFIG_SECURITY_LANDLOCK_LOG``
> >  (automatically selected by ``CONFIG_AUDIT`` or ``CONFIG_TRACEPOINTS``).
> >  
> >  Audit records respect audit configuration, the domain's Landlock log
> > -flags, and ``LANDLOCK_LOG_DISABLED``.  Tracepoints fire unconditionally,
> > -independent of these settings.  The denial counter (``num_denials``) is
> > -always incremented regardless of logging configuration.
> > +flags, and ``LANDLOCK_LOG_DISABLED``.  Tracepoints fire independently of
> > +these settings.  The denial counter (``num_denials``) is
> > +incremented regardless of logging configuration.
> >  
> >  Each denial tracepoint carries a ``logged`` field reporting the
> >  audit-logging verdict: whether the denial would be written to the audit
> > diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> > index 3d45b956b640..d00e94d8ed37 100644
> > --- a/Documentation/userspace-api/landlock.rst
> > +++ b/Documentation/userspace-api/landlock.rst
> > @@ -8,7 +8,7 @@ Landlock: unprivileged access control
> >  =====================================
> >  
> >  :Author: Mickaël Salaün
> > -:Date: October 2026
> > +:Date: November 2026
> >  
> >  The goal of Landlock is to enable restriction of ambient rights (e.g. global
> >  filesystem or network access) for a set of processes.  Because Landlock
> > @@ -532,7 +532,7 @@ acquisition via :manpage:`open_tree(2)` / :manpage:`fsmount(2)`.  Namespaces
> >  the process is already a member of when the domain is enforced are implicitly
> >  allowed (the process could not continue running otherwise); rules describe
> >  which new namespace types the process may acquire.
> > -``LANDLOCK_PERMISSION_CAPABILITY_USE`` gates every exercise of a capability
> > +``LANDLOCK_PERMISSION_CAPABILITY_USE`` gates the exercise of capabilities
> >  after the domain is enforced, regardless
> >  of how the capability was obtained (inherited credentials, ``CLONE_NEWUSER``
> >  grant, ``setuid``/file-cap-bearing :manpage:`execve(2)`, etc.).  Configuring
> > @@ -641,9 +641,9 @@ after a domain is enforced through user namespace entry or :manpage:`capset(2)`;
> >  privileged sandboxes that did not set ``PR_SET_NO_NEW_PRIVS`` may also gain
> >  capabilities through :manpage:`execve(2)` of binaries with file capabilities.
> >  In all cases, :manpage:`capget(2)` will report the credential's capability sets,
> > -but any denied capability will fail with ``EPERM`` when exercised.  Do not rely
> > +but any denied capability will fail when exercised.  Do not rely
> >  on :manpage:`capget(2)` to determine whether the policy permits a given
> > -capability; only the actual operation will return ``EPERM`` upon denial.
> > +capability.
> >  
> >  Truncating files
> >  ----------------
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index 24510e5d8479..c9e4ce23778b 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -622,9 +622,9 @@ struct landlock_capability_attr {
> >   * - %LANDLOCK_PERMISSION_CAPABILITY_USE: Restrict the use of specific Linux
> >   *   capabilities.  A process in a Landlock domain that handles this permission
> >   *   is denied from exercising capabilities that are not explicitly allowed by a
> > - *   %LANDLOCK_RULE_CAPABILITY rule.  This hook is purely restrictive: it can
> > - *   deny capabilities that the kernel would otherwise grant, but it can never
> > - *   grant capabilities that the kernel already denied.  Support added in
> > + *   %LANDLOCK_RULE_CAPABILITY rule.  This permission is purely restrictive: it
> 
> "The permission is purely restrictive"... that sounds like an
> oxymoron, similar for "[The permission] can deny capabilities..." in
> the sentence below.
> 
> It is not complicated though; How about just shortening the sentences
> "This hook is purely restrictive: it can deny ..., but it can never
> grant capabilities that the kernel already denied" down to
> 
>   Landlock only reduces the capabilities that processes can use.  It
>   does not let processes use capabilities that they don't already have
>   without Landlock.

Much better, thanks!

> 
> ?
> 
> > + *   can deny capabilities that the kernel would otherwise grant, but it can
> > + *   never grant capabilities that the kernel already denied.  Support added in
> >   *   Landlock ABI version 12.
> >   */
> >  #define LANDLOCK_PERMISSION_NAMESPACE_USE			(1ULL << 0)
> > -- 
> > 2.56.0
> > 
> 
> Reviewed-by: Günther Noack <gnoack@google.com>
> 
