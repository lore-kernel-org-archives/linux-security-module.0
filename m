Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A83615530C;
	Wed, 18 Dec 2024 22:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734559915; cv=none; b=Ake/5R8Q4yhvP1Sf4E/sqUFgHoVH6r+BX9iSS3WN3BbcgMyqkobNZ4corRAg5CkekCs8hA337TVa4vpIVPczbFPYqD6QDBV9qy/t3wvvcVgwu+jD781qcjdU1U202j9tDSUZQSD0ZD3gP9axSYvHdjbdG2CmTRziYADPuPzlasA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734559915; c=relaxed/simple;
	bh=fx1KxyN3t1fk9+SNN/4C5N01G7cTxy8LSzeV3kyCuCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHwp8UEBlnXH0XZTppayb9eKQ0g9XjjDMCOugET3KwAZbwbPS93O2wp/NZmEfZFWeqK1oAgUpFN7ZJuCLbQTxipbBBaOJlcy+vPLVTAsQFl08zR7zSLF1dHfF91MlAZV4Y0VEDg1lJMshnbE4rmfOpO+okpgdiY7xbFFwBb+FNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=oP+ntu7N; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="oP+ntu7N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=m/7B4q3plNeKH74AEQgF5wDXcRfYYtD1XudqbN8b5yA=; b=oP+ntu7NQ6wvtVud
	bXslLg8Ko8WYXG+ESw0hsxWjD2+1pD4TYYVsZYe6vZbrmpRLFD/7m9ry0ucq42Vhz35Ih5X7ubN7d
	XytX6JppENF6ieBXVukvZl5uYVaAkbubCNjH7x1K6BzXIG6j/nkNNzArLf8URVnkhEnBkhNKMbOgW
	VN/p0kM1dmAb8zIfY3sHq+auZVpj5kCF/7x1xHfkNSXom9qBQMq6dvpZyASnYkdQWOKcC5kMV05KH
	xgzgZ5L1maYQV7W+TqpFU0Ii58pbC6xSuQBl0F/EpOCRWJP06ub8lIzKXCKohh8Kpro7tUrlyqIFc
	AKcj13a/DbZWXUPkAQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tO2Gj-006Bi5-2B;
	Wed, 18 Dec 2024 22:11:49 +0000
Date: Wed, 18 Dec 2024 22:11:49 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Paul Moore <paul@paul-moore.com>
Cc: serge@hallyn.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capability: Remove unused has_capability
Message-ID: <Z2NIpSZ9iY0q1EAl@gallifrey>
References: <20241215165352.186692-1-linux@treblig.org>
 <CAHC9VhRyf8Jo54gnz2Nu17eHFOEqeXd3B5_HoXbz9uLYDba=HA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRyf8Jo54gnz2Nu17eHFOEqeXd3B5_HoXbz9uLYDba=HA@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 21:51:59 up 224 days,  9:06,  1 user,  load average: 0.00, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Paul Moore (paul@paul-moore.com) wrote:
> On Sun, Dec 15, 2024 at 11:54 AM <linux@treblig.org> wrote:
> >
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > The vanilla has_capability() function has been unused since 2018's
> > commit dcb569cf6ac9 ("Smack: ptrace capability use fixes")
> >
> > Remove it.
> >
> > (There is still mention in a comment in security/commoncap.c
> > but I suspect rather than removing the entry it might be better
> > to expand the comment to talk about the other
> > has_[ns_]capability[_noaudit] variants).

Hi Paul,
  Thanks for the review,

> I would suggest that this patch would be an excellent place to change
> that comment.  Without historical knowledge, the comment will be hard
> to understand after this patch is merged as inspecting
> has_capability() will be much more difficult, and including the
> comment change with the function removal will bind the two changes
> nicely in the git log.

Yeh, how would you like it? The existing comment is:

'
 * NOTE WELL: cap_has_capability() cannot be used like the kernel's capable()
 * and has_capability() functions.  That is, it has the reverse semantics:
 * cap_has_capability() returns 0 when a task has a capability, but the
 * kernel's capable() and has_capability() returns 1 for this case.
'

For a start I think that's wrong; the function it's above is
'cap_capable()' not 'cap_has_capability()' - and has been for 15 years :-)

How about:
'
 * NOTE WELL: cap_capable() has reverse semantics to the other kernel
 * functions. That is cap_capable() returns 0 when a task has a capability,
 * the kernel's capable(), has_ns_capability(), has_ns_capability_noaudit(),
 * and has_capability_noaudit() return 1 for this case.
'

(It's curious how rarely most of these are used...)

> Otherwise, this seems fine to me.
> 
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Thanks,

Dave

> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >  include/linux/capability.h |  5 -----
> >  kernel/capability.c        | 16 ----------------
> >  2 files changed, 21 deletions(-)
> >
> > diff --git a/include/linux/capability.h b/include/linux/capability.h
> > index 0c356a517991..1fb08922552c 100644
> > --- a/include/linux/capability.h
> > +++ b/include/linux/capability.h
> > @@ -139,7 +139,6 @@ static inline kernel_cap_t cap_raise_nfsd_set(const kernel_cap_t a,
> >  }
> >
> >  #ifdef CONFIG_MULTIUSER
> > -extern bool has_capability(struct task_struct *t, int cap);
> >  extern bool has_ns_capability(struct task_struct *t,
> >                               struct user_namespace *ns, int cap);
> >  extern bool has_capability_noaudit(struct task_struct *t, int cap);
> > @@ -150,10 +149,6 @@ extern bool ns_capable(struct user_namespace *ns, int cap);
> >  extern bool ns_capable_noaudit(struct user_namespace *ns, int cap);
> >  extern bool ns_capable_setid(struct user_namespace *ns, int cap);
> >  #else
> > -static inline bool has_capability(struct task_struct *t, int cap)
> > -{
> > -       return true;
> > -}
> >  static inline bool has_ns_capability(struct task_struct *t,
> >                               struct user_namespace *ns, int cap)
> >  {
> > diff --git a/kernel/capability.c b/kernel/capability.c
> > index dac4df77e376..67094b628ea9 100644
> > --- a/kernel/capability.c
> > +++ b/kernel/capability.c
> > @@ -289,22 +289,6 @@ bool has_ns_capability(struct task_struct *t,
> >         return (ret == 0);
> >  }
> >
> > -/**
> > - * has_capability - Does a task have a capability in init_user_ns
> > - * @t: The task in question
> > - * @cap: The capability to be tested for
> > - *
> > - * Return true if the specified task has the given superior capability
> > - * currently in effect to the initial user namespace, false if not.
> > - *
> > - * Note that this does not set PF_SUPERPRIV on the task.
> > - */
> > -bool has_capability(struct task_struct *t, int cap)
> > -{
> > -       return has_ns_capability(t, &init_user_ns, cap);
> > -}
> > -EXPORT_SYMBOL(has_capability);
> > -
> >  /**
> >   * has_ns_capability_noaudit - Does a task have a capability (unaudited)
> >   * in a specific user ns.
> > --
> > 2.47.1
> 
> -- 
> paul-moore.com
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
