Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795297616;
	b=E3WfW6anp7SpClJ+dD+ZiwJVP+6gkuBJ75NPlPYfK9+aDOxdOBcm3Ov0VvcW47zm/tuG
	 ChulYWsJy09dp6lPv/dJGyZ2hF0Yaos0ffgj5zNsDtySWLVAAgELm9TK47R4evF8h3FHR
	 UAS4U5lqB/Egsc9DFTBDhXxNourIfJT1U92FOFb8IixpF9ndMUNcwZ3i1etsHy8WnlFSu
	 ExqqR86KHXFUKDDIuI2TFtLY6VoFdUTuT/fwh5XgoCQCPMdMECkUwgrKxeZvOiTKt+jO1
	 JCQ+mlLfcSA2xWpQ79MYVInVxOiTSZPs42lc4FANaXK010LkPgluYrK7n+pKWAKNdPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795297616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=TWNBM4X5o3GcOyIN6ILVF1WfQ9yHkncXfpMuWBwbaI0=;
	b=19DMozrHYeF3rz/H9Sll9XIR31aLqUcED6jcwzHxDI9wAfyHa6hldyA25S/eaCdPHVJh
	 nLyQ0oX16Fer2Pgihv/OXve/yHEzyhHD4A/3RC3M2MrnohBNmEYNk9ftfZwGwJ0mWIB1Y
	 0ww2V9V0C3JDXLKlbpCP6sXQtA8Y+45vkSfZiHuPyiO8f8VUifQfvLO/ghT2sTdXxpy20
	 LVKyI/FLEoxrFk7bTti6lh2EDdmr+cmY9MTuVt/at4o33J9Xu62O2gxqUPSox0E2cFm1I
	 JrkEAKUU2rMc0aOYBtOyjE/k2zVDih7njNiZMhUX29akLjjNUt9VSikmyvEHNVpUpIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jSsSuIyv;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE5A606A320
	for <linux-security-module@vger.kernel.org>; Sat, 21 Nov 2026 21:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEE5A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jSsSuIyv
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso17514225e9.1
        for <linux-security-module@vger.kernel.org>; Sat, 21 Nov 2026 13:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795297614; x=1795902414; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TWNBM4X5o3GcOyIN6ILVF1WfQ9yHkncXfpMuWBwbaI0=;
        b=jSsSuIyv+nr0WU2tkwLYJqsObng/5bFZYVRN7hJwQZJdjy9JHvI9MlUHcLrpUhkzKQ
         cClPDOemgU9H/pXDSRDs/UcL6r37lycX57cBVTcxRMimY1Aa075NxhBjPVDTj670AByL
         dxYs4x3o/9mYTzoShOtazjfrQdkmcUZFgqOl9aTnm8gA3rgk113M4mE7ZvnEGyX+Ky5D
         uMsg17vkPH/Rph2ZifV/CtfxxPUuTtP7MQdlP1gWPxo2GzP7H8x0VlLJzefr9CBc+Ayc
         7NSWD9V+GDaBqwR6jGwFz7SUGOTv9+pQsC8jx3UC/Zs6vTJOW+YemaDs2/AQ8b6Ocy+H
         149g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795297614; x=1795902414;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TWNBM4X5o3GcOyIN6ILVF1WfQ9yHkncXfpMuWBwbaI0=;
        b=M39GiueGUYVgk85Nx8qvQn8oSEX79GVkaFRgJVehi9LVe1QO8H4s0ckHpbjm277Gz3
         TDxu5/r2PSRKYNEuYl1zymo7vio/1uEiDEWvaUBkE3NZ05bPcSbJMu3f/afC3bLRCg6+
         +f7w3Pqvw9FAd+G0z9WeM+rIPmBeTWE6awmc26hjDleBf3oQwmF6rJy75IbIEoQ0yEqU
         Ky9W+Ky6jTL7qbqJ/Qc3UcWTNEm/d6HMsIKhneIs9AujfwROceDLumsn9U1fweiz8Vf4
         WlOtT0gMkQrCbrZD4ELDhTeshW5YRfvGbbuUnnLXKmQzKkwz0JP4BgVUQERl7J440mpY
         F1GQ==
X-Forwarded-Encrypted: i=1; AL+hErEusiE6D6sEz71A/cUE2dmPcrDz70roNpThYHYH/I8tQW5GeIbq50+RplsIez9eswFN049flzAxMOfwPSW+mXDCQ7ayOa4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LVdQD/z9E3Z2NT7p+Lx0+Y3ADNuftKQqfpD1oWVgkijgckaNF
	I2fbGNNUnH3DRGGvyzsRjHzkL3N1xCKgCrVQ3zxCgmG62SvyDDXffpa8iFjmys9G
X-Gm-Gg: AZFdTZfiF1+NXZCX1D7jkvNsrrXSzqKtYYV4UzmTZ3GScmAGxjWktU7vQPGBR/7wgWP
	LRnDVec5X4b6cS2uqG0cuIpaadnAxCFIVMD0NPvdxtWsaEQf7Y1P/TG3RqW2+RapFiSZem03j2+
	OG+wymqMS64DzSgM0wheRy/VbeWWnFWjsioOmKcYMkhrenKpeb9HICVvsSkAlt8eHinKEIkS0UD
	N9hq6yUCD1HBDn/v6JXDpg3Es/N4mpxySjLjs2xg/XvzBgubVzRdgPw37u+rnwqpY+MpMmdTo/7
	NiK7mdZcsiDw9o6d2RfXnWIqt1KbaLavwjHfZbr+ke/aeRDRI2KCTv2VSdPigROaduXYyy9Qcoz
	r2SAOAVBrjYAswgNjIrMtFURsz3aV/33Vt7sfevzaQRmS3xnT0wzsg1jmx4KBJ7y457IWKBcaXs
	mrUmAovyHx/44WFLukKklEq7sroEeCnruQay92bHBzxaeb/muHotZ6CIUgMAqEqkPwRPqL6sLfp
	14k1LolICwPajSTwZqOAUwRZmhkWtxcZr1CLnEpQE5ZqbfGXSjeBKcdxyFrF+Nhu4kxwNaqUlnw
	Bai7iq49RUrr5/6iQ+4xXxjU/ob4VbWbFEnh/xY3ZC7oqn7//ML75g==
X-Received: by 2002:a05:600c:3b1d:b0:4bb:6991:2330 with SMTP id 5b1f17b1804b1-4bb8881a890mr155037435e9.22.1795297613938;
        Sat, 21 Nov 2026 13:46:53 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a15absm182082365e9.9.2026.11.21.13.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:46:53 -0800 (PST)
Date: Sat, 21 Nov 2026 22:46:49 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>, Cen Zhang <blbllhy@gmail.com>,
	James Morris <jmorris@namei.org>,
	Lee Seong Hyeon <ihopenre@gmail.com>,
	Marco Elver <elver@google.com>, NeilBrown <neil@brown.name>,
	Nickolai Zeldovich <nickolai@csail.mit.edu>,
	Paul Moore <paul@paul-moore.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Yihan Ding <dingyihan@uniontech.com>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] landlock: Do not hold exec_update_lock across the TSYNC
 wait
Message-ID: <20261121.bd9ab1ba5f9f@gnoack.org>
References: <20261120151554.2651743-1-mic@digikod.net>
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
In-Reply-To: <20261120151554.2651743-1-mic@digikod.net>

On Fri, Nov 20, 2026 at 04:15:52PM +0100, Mickaël Salaün wrote:
> landlock_restrict_sibling_threads() write-locks
> current->signal->exec_update_lock to serialize TSYNC callers, and holds
> it until every sibling thread has run its task_work.  This wait is
> unbounded: TWA_SIGNAL does not wake a TASK_KILLABLE sleeper, so a
> sibling blocked as a vfork() parent runs it only once its child execs or
> exits.
> 
> Meanwhile, readers of this lock block, mostly in D state:
> /proc/<pid>/stat, mm_access(), pidfd_getfd(), kcmp(), perf_event_open(),
> etc.  An unprivileged process can thus stall tools run by other users,
> including root, such as ps and top.
> 
> Only a per-process "TSYNC in progress" marker is needed.  Use an unused
> signal_struct.flags bit, protected by sighand->siglock, which is held
> only to set or clear the marker.  A second caller still restarts the
> syscall, and a cleanup class releases the marker on every return.
> 
> Like de_thread(), treat a group exit or an ongoing exec as a held
> marker: a group exit may overwrite the flags, and both kill the other
> threads, which the restart lets the caller handle.
> 
> Add KUnit tests for taking a free marker and for rejecting a held one.
> A concurrent TSYNC caller cannot be started deterministically from user
> space, but a KUnit thread has no sibling and can hold the marker itself.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Günther Noack <gnoack@google.com>
> Cc: Nickolai Zeldovich <nickolai@csail.mit.edu>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Yihan Ding <dingyihan@uniontech.com>
> Cc: stable@vger.kernel.org
> Reported-by: Lee Seong Hyeon <ihopenre@gmail.com>
> Suggested-by: Lee Seong Hyeon <ihopenre@gmail.com>
> Fixes: ff88df67dbf7 ("landlock: Serialize TSYNC thread restriction")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since the initial report from Lee Seong Hyeon:
> - Rewrite the fix, storing the marker in an unused signal_struct.flags
>   bit protected by sighand->siglock instead of adding a signal_struct
>   field.
> - Treat group exit and ongoing exec as a held marker, because group exit
>   may overwrite the flags.
> - Release the marker with a cleanup class.

It's not clear to me why the cleanup class and the fix are bundled in
one commit here.  (I do find the cleanup class useful, but shouldn't a
bugfix commit be as minimal as possible so that it is easy for people
to apply to their downstream kernels?)

–Günther

> - Clarify that not all readers wait in D state: perf_event_open() waits
>   interruptibly.
> - Add KUnit tests.
> - Credit Lee Seong Hyeon with Reported-by and Suggested-by instead of
>   authorship, because the implementation was rewritten.
> 
> Christian, Oleg, and Tejun, this patch reserves a signal_struct.flags
> bit for Landlock and relies on group-exit paths overwriting these flags
> under siglock.  Please check that this use of signal-core state is
> acceptable.
> 
> Lee, this rewrites the patch you sent with your report, so it credits
> you with Reported-by and Suggested-by.  Please tell me if you prefer a
> different credit.
> ---
>  include/linux/sched/signal.h |   1 +
>  security/landlock/tsync.c    | 134 +++++++++++++++++++++++++++++++----
>  2 files changed, 122 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 0adb51ab1542..f68bbaa3527a 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -262,6 +262,7 @@ struct signal_struct {
>  #define SIGNAL_STOP_STOPPED	0x00000001 /* job control stop in effect */
>  #define SIGNAL_STOP_CONTINUED	0x00000002 /* SIGCONT since WCONTINUED reap */
>  #define SIGNAL_GROUP_EXIT	0x00000004 /* group exit in progress */
> +#define SIGNAL_LANDLOCK_TSYNC	0x00000008 /* Landlock TSYNC in progress */
>  /*
>   * Pending notifications to parent.
>   */
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index cfa73a2a67ca..a6fa9ce0ac78 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -5,6 +5,7 @@
>   * Copyright © 2025 Google LLC
>   */
>  
> +#include <kunit/test.h>
>  #include <linux/atomic.h>
>  #include <linux/cleanup.h>
>  #include <linux/completion.h>
> @@ -479,6 +480,46 @@ static void cancel_tsync_works(const struct tsync_works *works,
>  	}
>  }
>  
> +/*
> + * try_set_current_tsync_marker - mark the current thread group as under TSYNC
> + *
> + * Returns false if another TSYNC operation, group exit, or exec is in progress.
> + */
> +static bool try_set_current_tsync_marker(void)
> +{
> +	struct signal_struct *const signal = current->signal;
> +
> +	guard(spinlock_irq)(&current->sighand->siglock);
> +
> +	/*
> +	 * Group-exit paths may replace all signal flags, including an active
> +	 * marker.  Treat SIGNAL_GROUP_EXIT as a held marker to prevent another
> +	 * TSYNC operation from starting during group teardown.
> +	 *
> +	 * Like de_thread(), also treat an ongoing exec as a group action in
> +	 * progress.  de_thread() sets group_exec_task in the same siglock
> +	 * critical section that sends SIGKILL to all other threads, including
> +	 * current.  Instead of queuing task_work for exiting threads,
> +	 * restart_syscall() lets current handle its pending SIGKILL.
> +	 */
> +	if ((signal->flags & (SIGNAL_GROUP_EXIT | SIGNAL_LANDLOCK_TSYNC)) ||
> +	    signal->group_exec_task)
> +		return false;
> +
> +	signal->flags |= SIGNAL_LANDLOCK_TSYNC;
> +	return true;
> +}
> +
> +static void clear_current_tsync_marker(void)
> +{
> +	guard(spinlock_irq)(&current->sighand->siglock);
> +
> +	current->signal->flags &= ~SIGNAL_LANDLOCK_TSYNC;
> +}
> +
> +DEFINE_CLASS(current_tsync_marker, bool, if (_T) clear_current_tsync_marker(),
> +	     try_set_current_tsync_marker(), void)
> +
>  /*
>   * restrict_sibling_threads - enables a Landlock policy for all sibling threads
>   */
> @@ -492,6 +533,19 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  	size_t newly_discovered_threads;
>  	bool found_more_threads;
>  
> +	/*
> +	 * Serialize concurrent TSYNC operations to prevent deadlocks when
> +	 * multiple threads call landlock_restrict_self() simultaneously.  If
> +	 * another operation got there first, gracefully yield by restarting the
> +	 * syscall.  This allows the current thread to process pending
> +	 * task_works before retrying.
> +	 *
> +	 * sighand->siglock protects only the marker, not the wait below.
> +	 */
> +	CLASS(current_tsync_marker, marker)();
> +	if (!marker)
> +		return restart_syscall();
> +
>  	atomic_set(&shared_ctx.preparation_error, 0);
>  	init_completion(&shared_ctx.all_prepared);
>  	init_completion(&shared_ctx.ready_to_commit);
> @@ -503,16 +557,6 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  		(restrict_flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS) ||
>  		task_no_new_privs(current);
>  
> -	/*
> -	 * Serialize concurrent TSYNC operations to prevent deadlocks when
> -	 * multiple threads call landlock_restrict_self() simultaneously.
> -	 * If the lock is already held, we gracefully yield by restarting the
> -	 * syscall. This allows the current thread to process pending
> -	 * task_works before retrying.
> -	 */
> -	if (!down_write_trylock(&current->signal->exec_update_lock))
> -		return restart_syscall();
> -
>  	/*
>  	 * We schedule a pseudo-signal task_work for each of the calling task's
>  	 * sibling threads.  In the task work, each thread:
> @@ -536,8 +580,9 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  	 * 5) signals that it's done altogether (barrier synchronization
>  	 *    "all_finished")
>  	 *
> -	 * Unlike seccomp, which modifies sibling tasks directly, we do not
> -	 * need to acquire the cred_guard_mutex and sighand->siglock:
> +	 * Unlike seccomp, which modifies sibling tasks directly, we do not need
> +	 * to hold the cred_guard_mutex or sighand->siglock around the thread
> +	 * walk:
>  	 *
>  	 * - As in our case, all threads are themselves exchanging their own
>  	 *   struct cred through the credentials API, no locks are needed for
> @@ -634,6 +679,69 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  		wait_for_completion(&shared_ctx.all_finished);
>  
>  	tsync_works_release(&works);
> -	up_write(&current->signal->exec_update_lock);
>  	return atomic_read(&shared_ctx.preparation_error);
>  }
> +
> +#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
> +
> +static bool is_current_tsync_marker_set(void)
> +{
> +	return current->signal->flags & SIGNAL_LANDLOCK_TSYNC;
> +}
> +
> +static void test_tsync_marker_free(struct kunit *const test)
> +{
> +	const struct cred *const cred = current_cred();
> +
> +	KUNIT_ASSERT_TRUE(test, thread_group_empty(current));
> +	KUNIT_ASSERT_FALSE(test, is_current_tsync_marker_set());
> +
> +	KUNIT_EXPECT_TRUE(test, try_set_current_tsync_marker());
> +	KUNIT_EXPECT_TRUE(test, is_current_tsync_marker_set());
> +	clear_current_tsync_marker();
> +	KUNIT_EXPECT_FALSE(test, is_current_tsync_marker_set());
> +
> +	/* Takes and releases the marker. */
> +	KUNIT_EXPECT_EQ(test, 0,
> +			landlock_restrict_sibling_threads(cred, cred, 0));
> +	KUNIT_EXPECT_FALSE(test, is_current_tsync_marker_set());
> +}
> +
> +static void test_tsync_marker_held(struct kunit *const test)
> +{
> +	const struct cred *const cred = current_cred();
> +
> +	KUNIT_ASSERT_TRUE(test, thread_group_empty(current));
> +	KUNIT_ASSERT_TRUE(test, try_set_current_tsync_marker());
> +
> +	KUNIT_EXPECT_FALSE(test, try_set_current_tsync_marker());
> +	KUNIT_EXPECT_TRUE(test, is_current_tsync_marker_set());
> +
> +	/* Restarts without releasing the marker held by another caller. */
> +	KUNIT_EXPECT_EQ(test, -ERESTARTNOINTR,
> +			landlock_restrict_sibling_threads(cred, cred, 0));
> +	KUNIT_EXPECT_TRUE(test, is_current_tsync_marker_set());
> +
> +	/* Clears TIF_SIGPENDING set by restart_syscall(). */
> +	scoped_guard(spinlock_irq, &current->sighand->siglock)
> +		recalc_sigpending();
> +
> +	clear_current_tsync_marker();
> +}
> +
> +static struct kunit_case test_cases[] = {
> +	/* clang-format off */
> +	KUNIT_CASE(test_tsync_marker_free),
> +	KUNIT_CASE(test_tsync_marker_held),
> +	{}
> +	/* clang-format on */
> +};
> +
> +static struct kunit_suite test_suite = {
> +	.name = "landlock_tsync",
> +	.test_cases = test_cases,
> +};
> +
> +kunit_test_suite(test_suite);
> +
> +#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> 
> base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
> -- 
> 2.56.0
> 
