Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E1513DBA0
	for <linux-security-module@vger.kernel.org>; Sat, 14 Mar 2026 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773522633; cv=none; b=aqWoUYuf5gL/EjbWfgWC2mrC1BphmmuBJ6TUWJkr4OXUfMTaFhPMsGuFh6eHQt6swq2xZGOQhg+aFJjS8/qlBh8WdudvpjBxSVH2E1lvZc56Aq3WKFx5mo6zpBKH0bCYnDAMCfCuMs/6JG/5h4AJvTvOnh1O4P3R65EB1F1gPMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773522633; c=relaxed/simple;
	bh=4iO2Vj7sXzusNoafkmY5a7ASzORSXWcHu/TIMCACxEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wn4PtL86USEfEgKlb6GO0b1J9U3PKK54YPyCLoO1KXJuhi88oDjPeWdKNEU8vFWsRToe8AYxF5fBI0LNk6alg8h6XdB1PAvFwGWMfPpQpHb3yRMD8iSuhjgzC4pnL0P5gFj6sFyuhU1Km5oxOJGpB79HSSTDlvFPn6tMQqK7xgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDVb9d8l; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDVb9d8l"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso28905675e9.2
        for <linux-security-module@vger.kernel.org>; Sat, 14 Mar 2026 14:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773522630; x=1774127430; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TsdFVQFh9Z76IVamlV5XZxwv4TyCyQKPWeUh9VXzjgE=;
        b=HDVb9d8l/RuaADLb4XrVl8sxi80scADvP5eY8TKlsdQt3X7VTuu08umcbEWQx2wjTM
         U2obE6PP3PzBsKn4Ga9IbYgK46lH99Hs1l4M/MZzjpQvtss8pGpSwXyJFv6qpOUtfKXC
         Iy1y7I7O/05/6+8V4bTVxDVz82mt0xObMEC8Qwalwj5ZFL1OqST4Kop8rWDvBTw8VbvY
         ZZuIfWb5MXmDzQKbYTZJ0nARG795VhFL2tAFw/AmICI/+GoFWgbDtNPToq5/Cf/m5A7j
         IcFxEWRCnYo+aJdG5P2P6GUACmdSsYIdR2eFYWz4/+LN6gsLYIGNMXXR9FrS584UtVQf
         iUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773522630; x=1774127430;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TsdFVQFh9Z76IVamlV5XZxwv4TyCyQKPWeUh9VXzjgE=;
        b=G+47Nf/BDSx7XwBqeSxfx+c/tNGQXiOrocXouMmqve5hU/wN1UqZ4H4+DLHNhk1+Tx
         7hjae6nHx5Tv9bvsFLvvwaWTEJstqGt0cgf2pfz8JFo2f40vajQwsUV7U/Cw6H/fvcgU
         qsPx6huhYLi7kmID9ColufX2UhXKkEI/GbF7AU3zvktyJOuxz7Th8np0Bu2jaPHhcfqP
         l2BLOXJmMvq9TdypO4xwLidCjY1uOAAp7aIjs6gsn77js7u6c5KZDVPBQuQScOOZz8xC
         DC0Ag8RvZt0sNjf51BB8UFavytWV9Dko6sSmo+MbK0oNAj1ocoqupSVtgO3QJpmwg8RT
         CDFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLvdpidt+jLDAhpb+PxkHMEhEZwzfpqU5h/n7D6pC6dpmFyzXSDkK7RAn7ziON0RluZjlwlUDvJ/o9f4CIFvBszPQuchQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Ige6BIHDjbSrkbFzP49b9mMPUaBsMUZ3D8JC//ZOSfOFY3Se
	noV2cuCd4Rx75mz5YVxub7KaphmjGdxSkNRHpy4KTXNa2Ml47peAR3IObCNNv/e+
X-Gm-Gg: ATEYQzzeHkFxGUDjJoNubWCU5O1+XCtuB7XN7Txo+OCdIFiOiXjVLtkosQRMglDbFro
	oMCiWe7OSclamMvT91ClWBfmWgJs2e/mZyK710+kFIsFDK6Zgv2M5B6EJIqnpKGBmXP113D9vfM
	0ihHE0gnunah7vF0O2ORI1spzbXj+y0fXsmxKJzlQ/7oVd+qHEdOzcyNiHvdLtVXbIjKtdAFaGz
	p0qE4qoI0LdErz5cFlj8IP5xBS3goNpUzkgn/iXhZh2QODCddTQifIgaBp/EmRLNamNCOviAIUH
	LRhcTLMLYuDGD3JGUwg14S2qijkn1+v92yMFwJ26cLcVP1U61T3N7ShGvjqGPQ7eU/8TuVGJ7YW
	TLI4HiwWt0lmzcv7g6da3PKJltSUqEphcq9Z4/zbWI+bEak0S2qfq25iUffdl8YOcqNhE4fHM0P
	PJi1DeUr663/eWGFRUz/S/xv9WxG2MSK4gNg8l+tcWsc25lqMG
X-Received: by 2002:a05:600c:c8f:b0:485:3c05:24dc with SMTP id 5b1f17b1804b1-48556710c02mr123766845e9.33.1773522629804;
        Sat, 14 Mar 2026 14:10:29 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3e9a4fcdsm936397f8f.8.2026.03.14.14.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 14:10:29 -0700 (PDT)
Date: Sat, 14 Mar 2026 22:10:23 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>, Tingmao Wang <m@maowtm.org>,
	Yihan Ding <dingyihan@uniontech.com>
Subject: Re: [PATCH v1] selftests/landlock: Test tsync interruption and
 cancellation paths
Message-ID: <20260314.61cb1f2dc01d@gnoack.org>
References: <20260310190416.1913908-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310190416.1913908-1-mic@digikod.net>

Hello Mickaël!

On Tue, Mar 10, 2026 at 08:04:15PM +0100, Mickaël Salaün wrote:
> Add tsync_interrupt test to exercise the signal interruption path in
> landlock_restrict_sibling_threads().  When a signal interrupts
> wait_for_completion_interruptible() while the calling thread waits for
> sibling threads to finish credential preparation, the kernel:
> 
> 1. Sets ERESTARTNOINTR to request a transparent syscall restart.
> 2. Calls cancel_tsync_works() to opportunistically dequeue task works
>    that have not started running yet.
> 3. Breaks out of the preparation loop, then unblocks remaining
>    task works via complete_all() and waits for them to finish.
> 4. Returns the error, causing abort_creds() in the syscall handler.
> 
> Specifically, cancel_tsync_works() in its entirety, the ERESTARTNOINTR
> error branch in landlock_restrict_sibling_threads(), and the
> abort_creds() error branch in the landlock_restrict_self() syscall
> handler are timing-dependent and not exercised by the existing tsync
> tests, making code coverage measurements non-deterministic.
> 
> The test spawns a signaler thread that rapidly sends SIGUSR1 to the
> calling thread while it performs landlock_restrict_self() with
> LANDLOCK_RESTRICT_SELF_TSYNC.  Since ERESTARTNOINTR causes a
> transparent restart, userspace always sees the syscall succeed.
> 
> This is a best-effort coverage test: the interruption path is exercised
> when the signal lands during the preparation wait, which depends on
> thread scheduling.  The test creates enough idle sibling threads (200)
> to ensure multiple serialized waves of credential preparation even on
> machines with many cores (e.g., 64), widening the window for the
> signaler.  Deterministic coverage would require wrapping the wait call
> with ALLOW_ERROR_INJECTION() and using CONFIG_FAIL_FUNCTION.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Justin Suess <utilityemal77@gmail.com>
> Cc: Tingmao Wang <m@maowtm.org>
> Cc: Yihan Ding <dingyihan@uniontech.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  tools/testing/selftests/landlock/tsync_test.c | 91 ++++++++++++++++++-
>  1 file changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/landlock/tsync_test.c b/tools/testing/selftests/landlock/tsync_test.c
> index 37ef0d2270db..2b9ad4f154f4 100644
> --- a/tools/testing/selftests/landlock/tsync_test.c
> +++ b/tools/testing/selftests/landlock/tsync_test.c
> @@ -6,9 +6,10 @@
>   */
>  
>  #define _GNU_SOURCE
> +#include <linux/landlock.h>
>  #include <pthread.h>
> +#include <signal.h>
>  #include <sys/prctl.h>
> -#include <linux/landlock.h>
>  
>  #include "common.h"
>  
> @@ -158,4 +159,92 @@ TEST(competing_enablement)
>  	EXPECT_EQ(0, close(ruleset_fd));
>  }
>  
> +static void signal_nop_handler(int sig)
> +{
> +}
> +
> +struct signaler_data {
> +	pthread_t target;
> +	volatile bool stop;
> +};
> +
> +static void *signaler_thread(void *data)
> +{
> +	struct signaler_data *sd = data;
> +
> +	while (!sd->stop)
> +		pthread_kill(sd->target, SIGUSR1);
> +
> +	return NULL;
> +}
> +
> +/*
> + * Number of idle sibling threads.  This must be large enough that even on
> + * machines with many cores, the sibling threads cannot all complete their
> + * credential preparation in a single parallel wave, otherwise the signaler
> + * thread has no window to interrupt wait_for_completion_interruptible().
> + * 200 threads on a 64-core machine yields ~3 serialized waves, giving the
> + * tight signal loop enough time to land an interruption.
> + */
> +#define NUM_IDLE_THREADS 200
> +
> +/*
> + * Exercises the tsync interruption and cancellation paths in tsync.c.
> + *
> + * When a signal interrupts the calling thread while it waits for sibling
> + * threads to finish their credential preparation
> + * (wait_for_completion_interruptible in landlock_restrict_sibling_threads),
> + * the kernel sets ERESTARTNOINTR, cancels queued task works that have not
> + * started yet (cancel_tsync_works), then waits for the remaining works to
> + * finish.  On the error return, syscalls.c aborts the prepared credentials.
> + * The kernel automatically restarts the syscall, so userspace sees success.
> + */
> +TEST(tsync_interrupt)
> +{
> +	size_t i;
> +	pthread_t threads[NUM_IDLE_THREADS];
> +	pthread_t signaler;
> +	struct signaler_data sd;
> +	struct sigaction sa = {};
> +	const int ruleset_fd = create_ruleset(_metadata);
> +
> +	disable_caps(_metadata);
> +
> +	/* Install a no-op SIGUSR1 handler so the signal does not kill us. */
> +	sa.sa_handler = signal_nop_handler;
> +	sigemptyset(&sa.sa_mask);
> +	ASSERT_EQ(0, sigaction(SIGUSR1, &sa, NULL));
> +
> +	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> +
> +	for (i = 0; i < NUM_IDLE_THREADS; i++)
> +		ASSERT_EQ(0, pthread_create(&threads[i], NULL, idle, NULL));
> +
> +	/*
> +	 * Start a signaler thread that continuously sends SIGUSR1 to the
> +	 * calling thread.  This maximizes the chance of interrupting
> +	 * wait_for_completion_interruptible() in the kernel's tsync path.
> +	 */
> +	sd.target = pthread_self();
> +	sd.stop = false;
> +	ASSERT_EQ(0, pthread_create(&signaler, NULL, signaler_thread, &sd));
> +
> +	/*
> +	 * The syscall may be interrupted and transparently restarted by the
> +	 * kernel (ERESTARTNOINTR).  From userspace, it should always succeed.
> +	 */
> +	EXPECT_EQ(0, landlock_restrict_self(ruleset_fd,
> +					    LANDLOCK_RESTRICT_SELF_TSYNC));
> +
> +	sd.stop = true;
> +	ASSERT_EQ(0, pthread_join(signaler, NULL));
> +
> +	for (i = 0; i < NUM_IDLE_THREADS; i++) {
> +		ASSERT_EQ(0, pthread_cancel(threads[i]));
> +		ASSERT_EQ(0, pthread_join(threads[i], NULL));
> +	}
> +
> +	EXPECT_EQ(0, close(ruleset_fd));
> +}
> +
>  TEST_HARNESS_MAIN
> -- 
> 2.53.0

The purpose of a test is to catch errors, so I broke the
ERESTARTNOINTR error handling code path, but I could not get the test
to fail.  Did you manage to reproduce any of these bugs with it, by
any chance, and in what configuration did that work?  I tried with
both QEMU (a bit more) and UML (a bit less), but had no luck.

(Does this need to run in a loop like the Syzkaller-generated deadlock
reproducer, so that we have a chance of catching these bugs at all?)

–Günther
