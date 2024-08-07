Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5C5535D4
	for <linux-security-module@vger.kernel.org>; Wed,  7 Aug 2024 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055115; cv=none; b=Jp6RUTSrD6KHKp3TpOqhmE2I6YyirKLnQ05+xk7zwpPpsbuo355RFLZaavkM7RP3wmSwJH0+b1OOsSWaAGAnIsaHtpTXJh4C8URaKDnJrJCoRsq9/DVESAv1kW6I0z5PsWr/GFZ5ZvRyHcqK/d28l03bBYl9JpM3cdD422VsaJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055115; c=relaxed/simple;
	bh=t0UbQCNoIRW1BDPtlmscIk4bNj5SvbNJmJAQ2vzhIc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOhBF6ZyRBJ8Z+DrtQ3RbrCZBAx+djxlUeM3yHSXuuc/USpOVALnKoqyyqK7thGiiKugdjMjF1bGm35PJF/g6tyYM37o9qcMbstJITsGXEKejY/sTJg8yISU/6vs4FvkTfxNqmHrCUyaUBJR1smvij/3b6pQDAzjkvumSnAh6Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vK+s93Bm; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vK+s93Bm"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WfJKd1mlCzktY;
	Wed,  7 Aug 2024 20:16:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1723054613;
	bh=e4v4cHOXu3daGmidLDolI+XJc3ecJMkNhgA4af0TWPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vK+s93BmP2oAOoj2R9uGVJ7Br4v+ZNBu36lRhvJPJET0Y85vV2KMDzm/WEfoA9Urc
	 ZrkUXZlJobyUnFsDFM8Zxc07xn6rO9p1lPqc0RhQtDBet2XsN12CPuGDP9ebGpoxuu
	 fv+ETOOBKBQraJiyFD8Oc0StWnt68JlhkUcw9wxI=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WfJKb6kN3zr9f;
	Wed,  7 Aug 2024 20:16:51 +0200 (CEST)
Date: Wed, 7 Aug 2024 20:16:47 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jann Horn <jannh@google.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>, outreachy@lists.linux.dev, 
	gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/4] Landlock: Add signal control
Message-ID: <20240807.Yee4al2lahCo@digikod.net>
References: <cover.1722966592.git.fahimitahera@gmail.com>
 <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
 <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
 <CAG48ez1jufy8iwP=+DDY662veqBdv9VbMxJ69Ohwt8Tns9afOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1jufy8iwP=+DDY662veqBdv9VbMxJ69Ohwt8Tns9afOw@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Aug 06, 2024 at 11:55:27PM +0200, Jann Horn wrote:
> On Tue, Aug 6, 2024 at 8:56 PM Jann Horn <jannh@google.com> wrote:
> > On Tue, Aug 6, 2024 at 8:11 PM Tahera Fahimi <fahimitahera@gmail.com> wrote:
> > > Currently, a sandbox process is not restricted to send a signal
> > > (e.g. SIGKILL) to a process outside of the sandbox environment.
> > > Ability to sending a signal for a sandboxed process should be
> > > scoped the same way abstract unix sockets are scoped. Therefore,
> > > we extend "scoped" field in a ruleset with
> > > "LANDLOCK_SCOPED_SIGNAL" to specify that a ruleset will deny
> > > sending any signal from within a sandbox process to its
> > > parent(i.e. any parent sandbox or non-sandboxed procsses).
> [...]
> > > +       if (is_scoped)
> > > +               return 0;
> > > +
> > > +       return -EPERM;
> > > +}
> > > +
> > > +static int hook_file_send_sigiotask(struct task_struct *tsk,
> > > +                                   struct fown_struct *fown, int signum)

I was wondering if we should handle this case, but I guess it makes
sense to have a consistent policy for all kind of user-triggerable
signals.

> > > +{
> > > +       bool is_scoped;
> > > +       const struct landlock_ruleset *dom, *target_dom;
> > > +       struct task_struct *result = get_pid_task(fown->pid, fown->pid_type);
> >
> > I'm not an expert on how the fowner stuff works, but I think this will
> > probably give you "result = NULL" if the file owner PID has already
> > exited, and then the following landlock_get_task_domain() would
> > probably crash? But I'm not entirely sure about how this works.
> >
> > I think the intended way to use this hook would be to instead use the
> > "file_set_fowner" hook to record the owning domain (though the setup
> > for that is going to be kind of a pain...), see the Smack and SELinux
> > definitions of that hook. Or alternatively maybe it would be even
> > nicer to change the fown_struct to record a cred* instead of a uid and
> > euid and then use the domain from those credentials for this hook...
> > I'm not sure which of those would be easier.
> 
> (For what it's worth, I think the first option would probably be
> easier to implement and ship for now, since you can basically copy
> what Smack and SELinux are already doing in their implementations of
> these hooks. I think the second option would theoretically result in
> nicer code, but it might require a bit more work, and you'd have to
> include the maintainers of the file locking code in the review of such
> refactoring and have them approve those changes. So if you want to get
> this patchset into the kernel quickly, the first option might be
> better for now?)
> 

I agree, let's extend landlock_file_security with a new "fown" pointer
to a Landlock domain. We'll need to call landlock_get_ruleset() in
hook_file_send_sigiotask(), and landlock_put_ruleset() in a new
hook_file_free_security().

I would be nice to to replace the redundant informations in fown_struct
but that can wait.
