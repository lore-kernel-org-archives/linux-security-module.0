Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AFA1946B5
	for <linux-security-module@vger.kernel.org>; Fri,  9 Aug 2024 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207488; cv=none; b=FeykRZMINDkgTOtdfDdB6N18LhNq14BlipZh7Sm/m8acoM+ddRfZoEmvMoYSUkKh+hAiClNsSpyB10XoeIG5js/VKCFw8nmIvynpII5qeyUMvT2M4fi1t7Kq3ftnenOZRhPsLXWapl5j38IAjFJYRmjXHOuHnLUTlcER2zOVF4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207488; c=relaxed/simple;
	bh=2/DDVJBVkCpRnFNqBHr62x55+suuaZ/r5f5HokdFtIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmk7oiifwUwzkvu1H6m+8s1AlDqgVlFpa865cyS3t5eEEBNL5gNn8xk350DsPKCu/eeMVu1+E+GrYtE8ppqrlbDqi1c7q3oQ+BvzgiZRMNl62hyeW//e+ieGaNzYAVhDPjHW8XFCONyo7MLHcrboUWoHokZnZn0iuEK31s5VGCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KeNHyOnb; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KeNHyOnb"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso11186a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 09 Aug 2024 05:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723207485; x=1723812285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNWmJ63K/g1Gs1zaO6juVoies4SldaAL74cgcheK2PI=;
        b=KeNHyOnb5zmtQA1Fip6aS7dqkiYNd6dl1u23nJ7KX1hBue+MImnZVNrsPAN5B+M+MN
         gbBYZqeAoXapRbLfWDtQOTo6EhToEw9VB4kp2OmhA5QLVLmptKz7JX8jh5LqMKpRnNv8
         Hlr4KRFksqBgrug2oNZsya1+6FzV2TH0n4jkgBsb6262lQDgRxKwpvXKw5a3fZY03jzl
         jwfsWbMwZIpPkkxNazkuJtpbgDo+OENqNGE2yCMnmcJ4UyO187YqiKqXQU+ZVZhqcGtT
         AXmRBLwRF2jEBEoiSN4xcut03ZDCi7y2o6lQXbTs9IGj7tr0oEOYFCLXq7jcPsrUjxGi
         naZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723207485; x=1723812285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNWmJ63K/g1Gs1zaO6juVoies4SldaAL74cgcheK2PI=;
        b=s50JayJAspBALWzmftj5iiSSm70yHhy+QRzuZadTyVJr+SZZS51auJaX1mk+N3ZHmU
         LnX24QFJMcRr2jqxRAVPeK8n61J/XB90kF1RBWGgzOAaypS9qjLlZXXJyZd6q3e3Q7+w
         T26m43gXR0fxw8rvslKheti3AxV0LNgDYW/v2EINVQ72AM0LNim0RV0HR56y5w9dEQ9L
         7LWbXi3/94sZ9kEhNNLyE+CsY7qM+CD7+nw436iexbGb+DTLBbnceyWDeHldoNUHwR0/
         kqrfiSscfSVajl3NELpN7o6NMsEI9vka9O46OqLt2YHMUITGmGDRDzCnWFTV6vRmdLGd
         h1Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXnxOuWBh4U3NA0fNqOyQRA01EU6fnA6WPdIDiQXHnTS6v8nFMm+bmQVP1wHf1ehcQPTnkjYRzJnMKUd9z95wPPmmggCTvI/g68uKITmLZnwG/7qlzR
X-Gm-Message-State: AOJu0Yxe8hbSSdO/V9LFk3Z0BI1sf/tuf2CZhMo08u16VUeZtgvno5LB
	izeP3P+oCZ8D+OSWE/T9DvKTZtZwBQp5Wwh0/rDRs8oeZdUcreO8T+TJRBx11LnjU34JS96P+JU
	yEREMXzVrV1KHTpqA3y6uBR/Fa+T/xwVFCnY6
X-Google-Smtp-Source: AGHT+IFfubo1A9OtB5Zv3D20oL+yL4T4y/DKd2LPIcoCBBj242HAjyTGEmJQ8k2TSM4viqQY5+Af7T8ljFC/VQc4LC8=
X-Received: by 2002:a05:6402:40cc:b0:5a7:7f0f:b70b with SMTP id
 4fb4d7f45d1cf-5bbbc38adbemr187182a12.0.1723207484019; Fri, 09 Aug 2024
 05:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1722966592.git.fahimitahera@gmail.com> <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
 <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
 <CAG48ez1jufy8iwP=+DDY662veqBdv9VbMxJ69Ohwt8Tns9afOw@mail.gmail.com>
 <20240807.Yee4al2lahCo@digikod.net> <ZrQE+d2b/FWxIPoA@tahera-OptiPlex-5000>
 <CAG48ez1q80onUxoDrFFvGmoWzOhjRaXzYpu+e8kNAHzPADvAAg@mail.gmail.com>
 <20240808.kaiyaeZoo1ha@digikod.net> <CAG48ez34C2pv7qugcYHeZgp5P=hOLyk4p5RRgKwhU5OA4Dcnuw@mail.gmail.com>
 <20240809.eejeekoo4Quo@digikod.net>
In-Reply-To: <20240809.eejeekoo4Quo@digikod.net>
From: Jann Horn <jannh@google.com>
Date: Fri, 9 Aug 2024 14:44:06 +0200
Message-ID: <CAG48ez2Cd3sjzv5rKT1YcMi1AzBxwN8r-jTbWy0Lv89iik-Y4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Landlock: Add signal control
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Tahera Fahimi <fahimitahera@gmail.com>, outreachy@lists.linux.dev, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bjorn3_gh@protonmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 12:59=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Thu, Aug 08, 2024 at 04:42:23PM +0200, Jann Horn wrote:
> > On Thu, Aug 8, 2024 at 4:09=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@di=
gikod.net> wrote:
> > > On Thu, Aug 08, 2024 at 03:10:54AM +0200, Jann Horn wrote:
> > > > On Thu, Aug 8, 2024 at 1:36=E2=80=AFAM Tahera Fahimi <fahimitahera@=
gmail.com> wrote:
> > > > > On Wed, Aug 07, 2024 at 08:16:47PM +0200, Micka=C3=ABl Sala=C3=BC=
n wrote:
> > > > > > On Tue, Aug 06, 2024 at 11:55:27PM +0200, Jann Horn wrote:
> > > > > > > On Tue, Aug 6, 2024 at 8:56=E2=80=AFPM Jann Horn <jannh@googl=
e.com> wrote:
> > > > > > > > On Tue, Aug 6, 2024 at 8:11=E2=80=AFPM Tahera Fahimi <fahim=
itahera@gmail.com> wrote:
> > > > > > > > > Currently, a sandbox process is not restricted to send a =
signal
> > > > > > > > > (e.g. SIGKILL) to a process outside of the sandbox enviro=
nment.
> > > > > > > > > Ability to sending a signal for a sandboxed process shoul=
d be
> > > > > > > > > scoped the same way abstract unix sockets are scoped. The=
refore,
> > > > > > > > > we extend "scoped" field in a ruleset with
> > > > > > > > > "LANDLOCK_SCOPED_SIGNAL" to specify that a ruleset will d=
eny
> > > > > > > > > sending any signal from within a sandbox process to its
> > > > > > > > > parent(i.e. any parent sandbox or non-sandboxed procsses)=
.
> > > > > > > [...]
> > > > > > > > > +       if (is_scoped)
> > > > > > > > > +               return 0;
> > > > > > > > > +
> > > > > > > > > +       return -EPERM;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static int hook_file_send_sigiotask(struct task_struct *=
tsk,
> > > > > > > > > +                                   struct fown_struct *f=
own, int signum)
> > > > > >
> > > > > > I was wondering if we should handle this case, but I guess it m=
akes
> > > > > > sense to have a consistent policy for all kind of user-triggera=
ble
> > > > > > signals.
> > > > > >
> > > > > > > > > +{
> > > > > > > > > +       bool is_scoped;
> > > > > > > > > +       const struct landlock_ruleset *dom, *target_dom;
> > > > > > > > > +       struct task_struct *result =3D get_pid_task(fown-=
>pid, fown->pid_type);
> > > > > > > >
> > > > > > > > I'm not an expert on how the fowner stuff works, but I thin=
k this will
> > > > > > > > probably give you "result =3D NULL" if the file owner PID h=
as already
> > > > > > > > exited, and then the following landlock_get_task_domain() w=
ould
> > > > > > > > probably crash? But I'm not entirely sure about how this wo=
rks.
> > > > > > > >
> > > > > > > > I think the intended way to use this hook would be to inste=
ad use the
> > > > > > > > "file_set_fowner" hook to record the owning domain (though =
the setup
> > > > > > > > for that is going to be kind of a pain...), see the Smack a=
nd SELinux
> > > > > > > > definitions of that hook. Or alternatively maybe it would b=
e even
> > > > > > > > nicer to change the fown_struct to record a cred* instead o=
f a uid and
> > > > > > > > euid and then use the domain from those credentials for thi=
s hook...
> > > > > > > > I'm not sure which of those would be easier.
> > > > > > >
> > > > > > > (For what it's worth, I think the first option would probably=
 be
> > > > > > > easier to implement and ship for now, since you can basically=
 copy
> > > > > > > what Smack and SELinux are already doing in their implementat=
ions of
> > > > > > > these hooks. I think the second option would theoretically re=
sult in
> > > > > > > nicer code, but it might require a bit more work, and you'd h=
ave to
> > > > > > > include the maintainers of the file locking code in the revie=
w of such
> > > > > > > refactoring and have them approve those changes. So if you wa=
nt to get
> > > > > > > this patchset into the kernel quickly, the first option might=
 be
> > > > > > > better for now?)
> > > > > > >
> > > > > >
> > > > > > I agree, let's extend landlock_file_security with a new "fown" =
pointer
> > > > > > to a Landlock domain. We'll need to call landlock_get_ruleset()=
 in
> > > > > > hook_file_send_sigiotask(), and landlock_put_ruleset() in a new
> > > > > > hook_file_free_security().
> > > > > I think we should add a new hook (hook_file_set_owner()) to initi=
alize
> > > > > the "fown" pointer and call landlock_get_ruleset() in that?
> > > >
> > > > Yeah. Initialize the pointer in the file_set_fowner hook, and read =
the
> > > > pointer in the file_send_sigiotask hook.
> > > >
> > > > Note that in the file_set_fowner hook, you'll probably need to use
> > > > both landlock_get_ruleset() (to take a reference on the ruleset you=
're
> > > > storing in the fown pointer) and landlock_put_ruleset() (to drop th=
e
> > > > reference to the ruleset that the fown pointer was pointing to
> > > > before). And you'll need to use some kind of lock to protect the fo=
wn
> > > > pointer - either by adding an appropriate lock next to your fown
> > > > pointer or by using some appropriate existing lock in "struct file"=
.
> > > > Probably it's cleanest to have your own lock for this? (This lock w=
ill
> > > > have to be something like a spinlock, not a mutex, since you need t=
o
> > > > be able to acquire it in the file_set_fowner hook, which runs insid=
e
> > > > an RCU read-side critical section, where sleeping is forbidden -
> > > > acquiring a mutex can sleep and therefore is forbidden in this
> > > > context, acquiring a spinlock can't sleep.)
> > >
> > > Yes, I think this should work for file_set_fowner:
> > >
> > > struct landlock_ruleset *prev_dom, *new_dom;
> > >
> > > new_dom =3D landlock_get_current_domain();
> > > landlock_get_ruleset(new_dom);
> > >
> > > /* Cf. f_modown() */
> > > write_lock_irq(&filp->f_owner.lock);
> > > prev_dom =3D rcu_replace_pointer(&landlock_file(file)->fown_domain,
> > >         new_dom, lockdep_is_held(&filp->f_owner.lock));
> > > write_unlock_irq(&filp->f_owner.lock);
> > >
> > > landlock_put_ruleset_rcu(prev_dom);
> > >
> > >
> > > With landlock_put_ruleset_rcu() define with this:
> > >
> > > diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.=
c
> > > index a93bdbf52fff..897116205520 100644
> > > --- a/security/landlock/ruleset.c
> > > +++ b/security/landlock/ruleset.c
> > > @@ -524,6 +524,20 @@ void landlock_put_ruleset_deferred(struct landlo=
ck_ruleset *const ruleset)
> > >         }
> > >  }
> > >
> > > +static void free_ruleset_rcu(struct rcu_head *const head)
> > > +{
> > > +       struct landlock_ruleset *ruleset;
> > > +
> > > +       ruleset =3D container_of(head, struct landlock_ruleset, rcu);
> > > +       free_ruleset(ruleset);
> > > +}
> >
> > free_ruleset() can block but RCU callbacks aren't allowed to block,
> > that's why landlock_put_ruleset_deferred() exists.
>
> Yes, but landlock_put_ruleset_deferred() doesn't wait for RCU read-side
> critical sections.

Ah, I phrased that badly - I didn't mean to suggest that you should
use landlock_put_ruleset_deferred() as a replacement for call_rcu().

[...]
> > So if you want to use RCU lifetime for this, I think you'll have to
> > turn landlock_put_ruleset() and landlock_put_ruleset_deferred() into
> > one common function that always, when reaching refcount 0, schedules
> > an RCU callback which then schedules a work_struct which then does
> > free_ruleset().
> >
> > I think that would be a little ugly, and it would look nicer to just
> > use normal locking in the file_send_sigiotask hook?
>
> I don't see how we can do that without delaying the free_ruleset() call
> to after the RCU read-side critical section in f_setown().

It should work if you used landlock_put_ruleset_deferred() instead of
landlock_put_ruleset().

> What about calling refcount_dec_and_test() in free_ruleset_rcu()?  That
> would almost always queue this call but it looks safe.

Every queued RCU invocation needs to have its own rcu_head - I think
the approach you're suggesting could end up queuing the same rcu_head
multiple times?

> An alternative might be to call synchronize_rcu() in free_ruleset(), but
> it's a big ugly too.
>
> BTW, I don't understand why neither SELinux nor Smack use (explicit)
> atomic operations nor lock.

Yeah, I think they're sloppy and kinda wrong - but it sorta works in
practice mostly because they don't have to do any refcounting around
this?

> And it looks weird that
> security_file_set_fowner() isn't called by f_modown() with the same
> locking to avoid races.

True. I imagine maybe the thought behind this design could have been
that LSMs should have their own locking, and that calling an LSM hook
with IRQs off is a little weird? But the way the LSMs actually use the
hook now, it might make sense to call the LSM with the lock held and
IRQs off...
