Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E1F3090C6
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770317674; cv=none; b=acETsGBTsSfRkxMFGvhbVLU6ZhS0iXpUuJDCVobZIWGly+afj60EjJ91uHXJ7HhWbss5QmSG4+SkYO9bjFqQksQghBWTScllh2m8s90hLX1i6NzWfwSFYBNzeYycbWnrQO/H3c0tZJA84d5U00hurfVLtem76h6Y3F6UUNxvkeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770317674; c=relaxed/simple;
	bh=bzRoH2ZIDByGPtruvzAdtsR3wsV1PF6AknwMB9wDZNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKicrG8VsOW/fFwwFACyFZu9Gtg6a1sI8bCXzptUTypD1cLWOIvUPI+nDp4Dnu8nhBtqxRwkqt+cLL+aEi4JrOP2gNt7VTgyCcwx8heuUYSZr6rW0ZT4fwUHEXvZWYH/pHXhlBb2IIDRSxURkLS4ZHrhIYr6HsDJ7dQ12g6q0JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=iU1o5YOH; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="iU1o5YOH"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f6RGT2RcKztmd;
	Thu,  5 Feb 2026 19:54:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770317665;
	bh=xQ8hydhWYtc/Pzn63JtyLXFT7tigb6xTA1gbC1Qa0Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iU1o5YOHKAqHvI2E27kfZLT7uvoTz/4MyrqWsKnOMlYzV/Fv6rkP7ZGczeLQ4TPrn
	 fUZU8kbWbZSB87WKx6F4ZNMjQvZenffc+BU4rMCF1R6s5WQdtO4/iuZWM9lLQfUMqg
	 Ks+ecXiR8qSnOxZAdNYuCzMAIGhOf/2o7noWYVpE=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4f6RGS5HwhzTwm;
	Thu,  5 Feb 2026 19:54:24 +0100 (CET)
Date: Thu, 5 Feb 2026 19:54:23 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Serge Hallyn <sergeh@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Tingmao Wang <m@maowtm.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH v3 2/3] landlock: selftests for
 LANDLOCK_RESTRICT_SELF_TSYNC
Message-ID: <20260205.yooDuch4phae@digikod.net>
References: <20251127115136.3064948-1-gnoack@google.com>
 <20251127115136.3064948-3-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251127115136.3064948-3-gnoack@google.com>
X-Infomaniak-Routing: alpha

These tests are useful but there are two missing parts:
- testing the restriction of each thread;
- testing the domain ID of each thread.

I'll merge this whole series but could you please extend this test file
with a new patch?

On Thu, Nov 27, 2025 at 12:51:35PM +0100, Günther Noack wrote:
> Exercise various scenarios where Landlock domains are enforced across
> all of a processes' threads.
> 
> Cc: Andrew G. Morgan <morgan@kernel.org>
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: Mickaël Salaün <mic@digikod.net>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  tools/testing/selftests/landlock/base_test.c  |   6 +-
>  tools/testing/selftests/landlock/tsync_test.c | 161 ++++++++++++++++++
>  2 files changed, 164 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/landlock/tsync_test.c
> 
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index f4b1a275d8d9..0fea236ef4bd 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -288,7 +288,7 @@ TEST(restrict_self_fd)
>  	EXPECT_EQ(EBADFD, errno);
>  }
>  
> -TEST(restrict_self_fd_flags)
> +TEST(restrict_self_fd_logging_flags)
>  {
>  	int fd;
>  
> @@ -304,9 +304,9 @@ TEST(restrict_self_fd_flags)
>  	EXPECT_EQ(EBADFD, errno);
>  }
>  
> -TEST(restrict_self_flags)
> +TEST(restrict_self_logging_flags)
>  {
> -	const __u32 last_flag = LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF;
> +	const __u32 last_flag = LANDLOCK_RESTRICT_SELF_TSYNC;
>  
>  	/* Tests invalid flag combinations. */
>  
> diff --git a/tools/testing/selftests/landlock/tsync_test.c b/tools/testing/selftests/landlock/tsync_test.c
> new file mode 100644
> index 000000000000..3971e0f02c49
> --- /dev/null
> +++ b/tools/testing/selftests/landlock/tsync_test.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Landlock tests - Enforcing the same restrictions across multiple threads
> + *
> + * Copyright © 2025 Günther Noack <gnoack3000@gmail.com>
> + */
> +
> +#define _GNU_SOURCE
> +#include <pthread.h>
> +#include <sys/prctl.h>
> +#include <linux/landlock.h>
> +
> +#include "common.h"
> +
> +/* create_ruleset - Create a simple ruleset FD common to all tests */
> +static int create_ruleset(struct __test_metadata *const _metadata)
> +{
> +	struct landlock_ruleset_attr ruleset_attr = {
> +		.handled_access_fs = (LANDLOCK_ACCESS_FS_WRITE_FILE |
> +				      LANDLOCK_ACCESS_FS_TRUNCATE),
> +	};
> +	const int ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +
> +	ASSERT_LE(0, ruleset_fd)
> +	{
> +		TH_LOG("landlock_create_ruleset: %s", strerror(errno));
> +	}
> +	return ruleset_fd;
> +}
> +
> +TEST(single_threaded_success)
> +{
> +	const int ruleset_fd = create_ruleset(_metadata);
> +
> +	disable_caps(_metadata);
> +
> +	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> +	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd,
> +					    LANDLOCK_RESTRICT_SELF_TSYNC));
> +
> +	ASSERT_EQ(0, close(ruleset_fd));
> +}
> +
> +void store_no_new_privs(void *data)

I fixed the helpers to make them static.

> +{
> +	bool *nnp = data;
> +
> +	if (!nnp)
> +		return;
> +	*nnp = prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0);
> +}
> +
> +void *idle(void *data)
> +{
> +	pthread_cleanup_push(store_no_new_privs, data);
> +
> +	while (true)
> +		sleep(1);
> +
> +	pthread_cleanup_pop(1);
> +}
> +
> +TEST(multi_threaded_success)
> +{
> +	pthread_t t1, t2;
> +	bool no_new_privs1, no_new_privs2;
> +	const int ruleset_fd = create_ruleset(_metadata);
> +
> +	disable_caps(_metadata);
> +
> +	ASSERT_EQ(0, pthread_create(&t1, NULL, idle, &no_new_privs1));
> +	ASSERT_EQ(0, pthread_create(&t2, NULL, idle, &no_new_privs2));
> +
> +	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> +
> +	EXPECT_EQ(0, landlock_restrict_self(ruleset_fd,
> +					    LANDLOCK_RESTRICT_SELF_TSYNC));
> +
> +	ASSERT_EQ(0, pthread_cancel(t1));
> +	ASSERT_EQ(0, pthread_cancel(t2));
> +	ASSERT_EQ(0, pthread_join(t1, NULL));
> +	ASSERT_EQ(0, pthread_join(t2, NULL));
> +
> +	/* The no_new_privs flag was implicitly enabled on all threads. */
> +	EXPECT_TRUE(no_new_privs1);
> +	EXPECT_TRUE(no_new_privs2);
> +
> +	ASSERT_EQ(0, close(ruleset_fd));
> +}
> +
> +TEST(multi_threaded_success_despite_diverging_domains)
> +{
> +	pthread_t t1, t2;
> +	const int ruleset_fd = create_ruleset(_metadata);
> +
> +	disable_caps(_metadata);
> +
> +	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> +
> +	ASSERT_EQ(0, pthread_create(&t1, NULL, idle, NULL));
> +	ASSERT_EQ(0, pthread_create(&t2, NULL, idle, NULL));
> +
> +	/*
> +	 * The main thread enforces a ruleset,
> +	 * thereby bringing the threads' Landlock domains out of sync.
> +	 */
> +	EXPECT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
> +
> +	/* Still, TSYNC succeeds, bringing the threads in sync again. */
> +	EXPECT_EQ(0, landlock_restrict_self(ruleset_fd,
> +					    LANDLOCK_RESTRICT_SELF_TSYNC));
> +
> +	ASSERT_EQ(0, pthread_cancel(t1));
> +	ASSERT_EQ(0, pthread_cancel(t2));
> +	ASSERT_EQ(0, pthread_join(t1, NULL));
> +	ASSERT_EQ(0, pthread_join(t2, NULL));
> +	ASSERT_EQ(0, close(ruleset_fd));
> +}
> +
> +struct thread_restrict_data {
> +	pthread_t t;
> +	int ruleset_fd;
> +	int result;
> +};
> +
> +void *thread_restrict(void *data)
> +{
> +	struct thread_restrict_data *d = data;
> +
> +	d->result = landlock_restrict_self(d->ruleset_fd,
> +					   LANDLOCK_RESTRICT_SELF_TSYNC);
> +	return NULL;
> +}
> +
> +TEST(competing_enablement)
> +{
> +	const int ruleset_fd = create_ruleset(_metadata);
> +	struct thread_restrict_data d[] = {
> +		{ .ruleset_fd = ruleset_fd },
> +		{ .ruleset_fd = ruleset_fd },
> +	};
> +
> +	disable_caps(_metadata);
> +
> +	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> +	ASSERT_EQ(0, pthread_create(&d[0].t, NULL, thread_restrict, &d[0]));
> +	ASSERT_EQ(0, pthread_create(&d[1].t, NULL, thread_restrict, &d[1]));
> +
> +	/* Wait for threads to finish. */
> +	ASSERT_EQ(0, pthread_join(d[0].t, NULL));
> +	ASSERT_EQ(0, pthread_join(d[1].t, NULL));
> +
> +	/* Expect that both succeeded. */
> +	EXPECT_EQ(0, d[0].result);
> +	EXPECT_EQ(0, d[1].result);
> +
> +	ASSERT_EQ(0, close(ruleset_fd));
> +}
> +
> +TEST_HARNESS_MAIN
> -- 
> 2.52.0.177.g9f829587af-goog
> 
> 
