Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.16.66.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439725;
	b=DcYFt8d6xqDCIA+KAqxdcJhUqFlC6JJwoNomy2Xv5xrQvA+e6v8ROdxez20rLiJIx4CE
	 96libHGwC5JfQadCh5AEvEtiF8QVWToEmBxWRZLVYyux+S3+6gkB5WfS9+akZaNv3ybB1
	 wulzVhWe7LQ0LLUFAUoHTFWfhQNsZQV3REPNVUMwrgMZZjUUP1IlUVM9cRak7Pf/hg85k
	 MxjwvYYHhN9te3oy0kGGR8fbFBBiDsWxAmx0tERs6hKVOj2TflNoL7TF5WZ5M3rik2KJV
	 CI+AddG+yDaiYrodo8LezWiye/KX5qH7v1PuoBPunX9J7WYP2GIPoUMpGFD7PELa+fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439725;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Infomaniak-Routing;
	bh=UJEHxXF/5pMLfBqyK2opmHzobbKfrsrl25vYEW02sVg=;
	b=MzHFVFwOFdgw36snRYMZxFd+SlY0yMQlsyowjSVnDwTtLbWJwKIBTVimfM6tm9Hnyv/p
	 068Kq19ZJ534zOyg/vwfPxjXAulSf/9TkPbWmP5pliIkluWEsC4oFeAwWqoAnBIkMxPjq
	 orhlWSqsj5FRM94joxWgMgAzeLH7N/IobbzW9suTYa9+P7DByTVyncxwX+IxAO+QdA2Yp
	 05xlfyq+AfLvKmgmVhrtYMtfXIKbTT5CgEW+5nb3I/auawPMhDFPb0OuHlEkZLbUyND9K
	 BNmPsIxlxq9YLfKqlCdNzaOc+EYqblW04bCnJoYj4a5xZ6ecrgSEs2o2Xdv+Nq3melw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=q2xRatod;
	arc=none smtp.remote-ip=84.16.66.174
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D89606A31A
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 13:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59D89606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=q2xRatod
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jY5yq2jrjzgLG;
	Mon, 23 Nov 2026 14:15:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1795439715;
	bh=UJEHxXF/5pMLfBqyK2opmHzobbKfrsrl25vYEW02sVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q2xRatodVs0aVY5gvrIZedGIV2AmdavchdO+ISnVK/wgv3rrUJeCxzDuJ+UYz7lX+
	 dXGQVFHFB27+Zh9896JHqbAMIvPDi7FkqH12wPGw/NUUkedhM/Q9Af6eXYMLFL1KDs
	 RhqwZBX+NahvV8/UGW/i0qjRn1Saly9oGiajI/OI=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4jY5yl0F5hzTSL;
	Mon, 23 Nov 2026 14:15:10 +0100 (CET)
Date: Mon, 23 Nov 2026 14:15:07 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>, 
	Cen Zhang <blbllhy@gmail.com>, James Morris <jmorris@namei.org>, 
	Lee Seong Hyeon <ihopenre@gmail.com>, Marco Elver <elver@google.com>, NeilBrown <neil@brown.name>, 
	Nickolai Zeldovich <nickolai@csail.mit.edu>, Paul Moore <paul@paul-moore.com>, 
	Peter Zijlstra <peterz@infradead.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Yihan Ding <dingyihan@uniontech.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] landlock: Do not hold exec_update_lock across the TSYNC
 wait
Message-ID: <20261123.ungeuh7Taish@digikod.net>
References: <20261120151554.2651743-1-mic@digikod.net>
 <awMn0L7RaQO_6qUc@redhat.com>
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
In-Reply-To: <awMn0L7RaQO_6qUc@redhat.com>
X-Infomaniak-Routing: alpha

On Sun, Nov 22, 2026 at 06:35:12PM +0100, Oleg Nesterov wrote:
> On 11/20, Mickaël Salaün wrote:
> >
> > @@ -492,6 +533,19 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
> >  	size_t newly_discovered_threads;
> >  	bool found_more_threads;
> >  
> > +	/*
> > +	 * Serialize concurrent TSYNC operations to prevent deadlocks when
> > +	 * multiple threads call landlock_restrict_self() simultaneously.  If
> > +	 * another operation got there first, gracefully yield by restarting the
> > +	 * syscall.  This allows the current thread to process pending
> > +	 * task_works before retrying.
> > +	 *
> > +	 * sighand->siglock protects only the marker, not the wait below.
> > +	 */
> > +	CLASS(current_tsync_marker, marker)();
> > +	if (!marker)
> > +		return restart_syscall();
> > +
> >  	atomic_set(&shared_ctx.preparation_error, 0);
> >  	init_completion(&shared_ctx.all_prepared);
> >  	init_completion(&shared_ctx.ready_to_commit);
> > @@ -503,16 +557,6 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
> >  		(restrict_flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS) ||
> >  		task_no_new_privs(current);
> >  
> > -	/*
> > -	 * Serialize concurrent TSYNC operations to prevent deadlocks when
> > -	 * multiple threads call landlock_restrict_self() simultaneously.
> > -	 * If the lock is already held, we gracefully yield by restarting the
> > -	 * syscall. This allows the current thread to process pending
> > -	 * task_works before retrying.
> > -	 */
> > -	if (!down_write_trylock(&current->signal->exec_update_lock))
> > -		return restart_syscall();
> 
> Just in case, the patch looks obviously correct, so feel free to add
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Thanks for the review.

> 
> -------------------------------------------------------------------------------
> But when I look at this code...
> 
> Well, if we change landlock_restrict_sibling_threads() to rely on ->siglock,
> it seems that it can be greatly simplified? I mean, it can roughly do:
> 
> 	...
> 
> 	for (nt nr_threads = 0;; tsync_works_grow_by(&works, nr_threads))
> 	{
> 		guard(spinlock_irq)(&current->sighand->siglock);
> 
> 		if (!nr_threads) {
> 			if (signal->flags & SIGNAL_LANDLOCK_TSYNC || ...)
> 				return restart_syscall();
> 			else
> 				signal->flags |= SIGNAL_LANDLOCK_TSYNC;
> 		}
> 
> 		if (nr_threads < get_nr_threads(current)) {
> 			nr_threads = get_nr_threads(current));
> 			continue;
> 		}
> 
> 		for_other_threads(current, thread) {
> 			if (thread->flags & PF_EXITING)	// stable under siglock
> 				continue;
> 
> 			ctx = tsync_works_provide(...); // can't fail
> 
> 			...
> 
> 			task_work_add(thread, &ctx->work, TWA_SIGNAL); // can't fail
> 		}
> 
> 		break;
> 	}
> 
> 	complete_all(&shared_ctx.ready_to_commit);
> 	...
> 
> We can kill tsync_works_trim/tsync_works_contains_task/count_additional_threads/etc.

That would indeed be simpler, but a single pass would misses threads
that a sibling is creating at the same time: the cred is copied before
taking siglock and only fatal_signal_pending is checked.

Keeping the rescan loop and walking under siglock would be correct and
would drop tsync_works_trim() and count_additional_threads().  However,
it would hold siglock with IRQ disabled across a task_work_add() for
every thread, which /proc/<pid>/stat readers would then wait for.  That
is bounded and not worse than what SIGCONT already does, but the RCU
walk avoids it entirely, so I'm wondering if it's worth it.

> 
> Sure, this needs another change even if I am right.

Yes, I'll send a follow-up if needed.

> 
> Oleg.
> 
> 
