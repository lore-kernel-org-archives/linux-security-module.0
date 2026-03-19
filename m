Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB333D34A0
	for <linux-security-module@vger.kernel.org>; Thu, 19 Mar 2026 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942483; cv=none; b=mY0ijufUw+0vBvQn41JrPjlFxYCxQK4pAoDl/l0qBiLFVC5w4L+3MHwvlpzz5m3LY/Mr0yC36tQwiSi6xu7CFL+LO3vXV6LdW1ONs9q2PdbHuSf5ECJDSQ22Bg5jsQP9W/9luVaqeH+at7xGQLK0knfTLo5GAWyCfHU8gKN/i40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942483; c=relaxed/simple;
	bh=AynbVbF1FtlpDaskwHeUHn4zohSv5D+sAGblfymXqF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDrCs7aXcI4Zws1/NorflwBHgt1VimQGf3e0IWlpnd3HoS+aIMVKhrg2vuavt5KuVwXwvI3RGlTT4bK+37riFyDetxHoBUw26EuDeKQaMAWvt8sVYkL5lW4n25cSgWMy8/fnSXyTL6HaEmNk96iYkQRKOLok+ld9ZCF07zqZGq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=syvbwr4w; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="syvbwr4w"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fcCpC07YGzmnQ;
	Thu, 19 Mar 2026 18:47:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773942466;
	bh=1+Q04fJ0jT/nenfplninVye4mdQMNSzbm7XUcoTUtIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=syvbwr4wYYWFOekEpoBj9NCnApksCprlfSqYmy5WZgS2HrtlgjsSk5cwEPGd3MjHC
	 R51JrYtCuWTaohuaZAKrDRcdX0tPy5zVuViXiycy8xwpxt+3MC4S21hSB36STMMo3e
	 XqWqF7NpbsOFYc0S30qd+C/pU8QehsFOIQW+v4y8=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fcCpB3cjkzP1k;
	Thu, 19 Mar 2026 18:47:46 +0100 (CET)
Date: Thu, 19 Mar 2026 18:47:45 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Justin Suess <utilityemal77@gmail.com>, 
	Tingmao Wang <m@maowtm.org>, Yihan Ding <dingyihan@uniontech.com>
Subject: Re: [PATCH v1] selftests/landlock: Test tsync interruption and
 cancellation paths
Message-ID: <20260319.eicheNg3ooxu@digikod.net>
References: <20260310190416.1913908-1-mic@digikod.net>
 <20260314.61cb1f2dc01d@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260314.61cb1f2dc01d@gnoack.org>
X-Infomaniak-Routing: alpha

On Sat, Mar 14, 2026 at 10:10:23PM +0100, Günther Noack wrote:
> Hello Mickaël!
> 
> On Tue, Mar 10, 2026 at 08:04:15PM +0100, Mickaël Salaün wrote:
> > Add tsync_interrupt test to exercise the signal interruption path in
> > landlock_restrict_sibling_threads().  When a signal interrupts
> > wait_for_completion_interruptible() while the calling thread waits for
> > sibling threads to finish credential preparation, the kernel:
> > 
> > 1. Sets ERESTARTNOINTR to request a transparent syscall restart.
> > 2. Calls cancel_tsync_works() to opportunistically dequeue task works
> >    that have not started running yet.
> > 3. Breaks out of the preparation loop, then unblocks remaining
> >    task works via complete_all() and waits for them to finish.
> > 4. Returns the error, causing abort_creds() in the syscall handler.
> > 
> > Specifically, cancel_tsync_works() in its entirety, the ERESTARTNOINTR
> > error branch in landlock_restrict_sibling_threads(), and the
> > abort_creds() error branch in the landlock_restrict_self() syscall
> > handler are timing-dependent and not exercised by the existing tsync
> > tests, making code coverage measurements non-deterministic.
> > 
> > The test spawns a signaler thread that rapidly sends SIGUSR1 to the
> > calling thread while it performs landlock_restrict_self() with
> > LANDLOCK_RESTRICT_SELF_TSYNC.  Since ERESTARTNOINTR causes a
> > transparent restart, userspace always sees the syscall succeed.
> > 
> > This is a best-effort coverage test: the interruption path is exercised
> > when the signal lands during the preparation wait, which depends on
> > thread scheduling.  The test creates enough idle sibling threads (200)
> > to ensure multiple serialized waves of credential preparation even on
> > machines with many cores (e.g., 64), widening the window for the
> > signaler.  Deterministic coverage would require wrapping the wait call
> > with ALLOW_ERROR_INJECTION() and using CONFIG_FAIL_FUNCTION.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Justin Suess <utilityemal77@gmail.com>
> > Cc: Tingmao Wang <m@maowtm.org>
> > Cc: Yihan Ding <dingyihan@uniontech.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  tools/testing/selftests/landlock/tsync_test.c | 91 ++++++++++++++++++-
> >  1 file changed, 90 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/landlock/tsync_test.c b/tools/testing/selftests/landlock/tsync_test.c
> > index 37ef0d2270db..2b9ad4f154f4 100644
> > --- a/tools/testing/selftests/landlock/tsync_test.c
> > +++ b/tools/testing/selftests/landlock/tsync_test.c
> > @@ -6,9 +6,10 @@
> >   */
> >  
> >  #define _GNU_SOURCE
> > +#include <linux/landlock.h>
> >  #include <pthread.h>
> > +#include <signal.h>
> >  #include <sys/prctl.h>
> > -#include <linux/landlock.h>
> >  
> >  #include "common.h"
> >  
> > @@ -158,4 +159,92 @@ TEST(competing_enablement)
> >  	EXPECT_EQ(0, close(ruleset_fd));
> >  }
> >  
> > +static void signal_nop_handler(int sig)
> > +{
> > +}
> > +
> > +struct signaler_data {
> > +	pthread_t target;
> > +	volatile bool stop;
> > +};
> > +
> > +static void *signaler_thread(void *data)
> > +{
> > +	struct signaler_data *sd = data;
> > +
> > +	while (!sd->stop)
> > +		pthread_kill(sd->target, SIGUSR1);
> > +
> > +	return NULL;
> > +}
> > +
> > +/*
> > + * Number of idle sibling threads.  This must be large enough that even on
> > + * machines with many cores, the sibling threads cannot all complete their
> > + * credential preparation in a single parallel wave, otherwise the signaler
> > + * thread has no window to interrupt wait_for_completion_interruptible().
> > + * 200 threads on a 64-core machine yields ~3 serialized waves, giving the
> > + * tight signal loop enough time to land an interruption.
> > + */
> > +#define NUM_IDLE_THREADS 200
> > +
> > +/*
> > + * Exercises the tsync interruption and cancellation paths in tsync.c.
> > + *
> > + * When a signal interrupts the calling thread while it waits for sibling
> > + * threads to finish their credential preparation
> > + * (wait_for_completion_interruptible in landlock_restrict_sibling_threads),
> > + * the kernel sets ERESTARTNOINTR, cancels queued task works that have not
> > + * started yet (cancel_tsync_works), then waits for the remaining works to
> > + * finish.  On the error return, syscalls.c aborts the prepared credentials.
> > + * The kernel automatically restarts the syscall, so userspace sees success.
> > + */
> > +TEST(tsync_interrupt)
> > +{
> > +	size_t i;
> > +	pthread_t threads[NUM_IDLE_THREADS];
> > +	pthread_t signaler;
> > +	struct signaler_data sd;
> > +	struct sigaction sa = {};
> > +	const int ruleset_fd = create_ruleset(_metadata);
> > +
> > +	disable_caps(_metadata);
> > +
> > +	/* Install a no-op SIGUSR1 handler so the signal does not kill us. */
> > +	sa.sa_handler = signal_nop_handler;
> > +	sigemptyset(&sa.sa_mask);
> > +	ASSERT_EQ(0, sigaction(SIGUSR1, &sa, NULL));
> > +
> > +	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> > +
> > +	for (i = 0; i < NUM_IDLE_THREADS; i++)
> > +		ASSERT_EQ(0, pthread_create(&threads[i], NULL, idle, NULL));
> > +
> > +	/*
> > +	 * Start a signaler thread that continuously sends SIGUSR1 to the
> > +	 * calling thread.  This maximizes the chance of interrupting
> > +	 * wait_for_completion_interruptible() in the kernel's tsync path.
> > +	 */
> > +	sd.target = pthread_self();
> > +	sd.stop = false;
> > +	ASSERT_EQ(0, pthread_create(&signaler, NULL, signaler_thread, &sd));
> > +
> > +	/*
> > +	 * The syscall may be interrupted and transparently restarted by the
> > +	 * kernel (ERESTARTNOINTR).  From userspace, it should always succeed.
> > +	 */
> > +	EXPECT_EQ(0, landlock_restrict_self(ruleset_fd,
> > +					    LANDLOCK_RESTRICT_SELF_TSYNC));
> > +
> > +	sd.stop = true;
> > +	ASSERT_EQ(0, pthread_join(signaler, NULL));
> > +
> > +	for (i = 0; i < NUM_IDLE_THREADS; i++) {
> > +		ASSERT_EQ(0, pthread_cancel(threads[i]));
> > +		ASSERT_EQ(0, pthread_join(threads[i], NULL));
> > +	}
> > +
> > +	EXPECT_EQ(0, close(ruleset_fd));
> > +}
> > +
> >  TEST_HARNESS_MAIN
> > -- 
> > 2.53.0
> 
> The purpose of a test is to catch errors, so I broke the
> ERESTARTNOINTR error handling code path, but I could not get the test
> to fail.  Did you manage to reproduce any of these bugs with it, by
> any chance, and in what configuration did that work?  I tried with
> both QEMU (a bit more) and UML (a bit less), but had no luck.
> 
> (Does this need to run in a loop like the Syzkaller-generated deadlock
> reproducer, so that we have a chance of catching these bugs at all?)

There is no bug and the test should always pass, it's just to improve
test coverage in the new kernel code introduced by the tsync feature.

Without this patch, most of the time we get: 90.2% of 2105 lines.

With this patch, we always get: 91.1% of 2105 lines.
