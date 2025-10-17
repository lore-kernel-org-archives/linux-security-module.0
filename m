Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C73D3370FA
	for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713530; cv=none; b=Nkv9GXu7E6kcEpd4xooxQroa1uTApsFTSE+R+vgNgUplniOsppYVsHK3nGpXvp809aWDQ1zj6bwfJXzAC+SZEpElF8SfixK/0XceqlmiBZZh1pIOnVGyW+OwUbY1GnHy9u8SH77HVRr1A5nLtPPdgLn7XC09dONf9f6srkdvwVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713530; c=relaxed/simple;
	bh=Cq85M0M8xZMgn8HqX+dKzN2+r+rgUyQoSdj16v6Znl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBIZfX/fioZ/byu5E81ZShSVkJiDd/breebBq1aZVYH6mya8GnDuLlQ10kphw03lHm2KYzZ8XVhejTi9CBvTfEStTe3DNe8yQ0X8rwZMByNrvZCfqzkDli4SW72MImF/RRDC0Wx8BG+AWwIPx1eZifl784Zl84+l3SSyzXKGjro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=f31i72Rd; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="f31i72Rd"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cp7RR2BJlzqmP;
	Fri, 17 Oct 2025 17:05:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1760713523;
	bh=NlKj+Or43XE72p83CusZCiNxlqEzdl7J76/BGPLWbRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f31i72RdxoXQBcdbXRTzarfIvUejmpZ54AMynlSmLVLb817fj3AnVV//LCDhBbZZH
	 69fGNEzI1ncE6s0z/opncySve1tN9TgtSrN3OF3VpOAwyycP3ladI+PHXO4bOxkK7D
	 mcd5IZBklqUT8UE44+taA1RpsuQ5gUtwSqPenFls=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4cp7RQ4C22zdWH;
	Fri, 17 Oct 2025 17:05:22 +0200 (CEST)
Date: Fri, 17 Oct 2025 17:05:22 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Tingmao Wang <m@maowtm.org>, Paul Moore <paul@paul-moore.com>, 
	linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 2/2] landlock: selftests for
 LANDLOCK_RESTRICT_SELF_TSYNC
Message-ID: <20251017.ee0ooZiegh7o@digikod.net>
References: <20251001111807.18902-1-gnoack@google.com>
 <20251001111807.18902-3-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251001111807.18902-3-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Wed, Oct 01, 2025 at 01:18:07PM +0200, Günther Noack wrote:
> Exercise various scenarios where Landlock domains are enforced across
> all of a processes' threads.
> 
> Cc: Mickaël Salaün <mic@digikod.net>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  tools/testing/selftests/landlock/base_test.c  |  6 +-
>  tools/testing/selftests/landlock/tsync_test.c | 99 +++++++++++++++++++
>  2 files changed, 102 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/landlock/tsync_test.c
> 
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index 7b69002239d7..b9be6dcb7e8c 100644
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
> index 000000000000..356e20de352f
> --- /dev/null
> +++ b/tools/testing/selftests/landlock/tsync_test.c
> @@ -0,0 +1,99 @@
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
> +	ASSERT_LE(0, ruleset_fd);
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
> +void *idle(void *data)
> +{
> +	while (true)
> +		sleep(1);

while (!usleep(1));

> +}
> +
> +TEST(multi_threaded_success)
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
> +	EXPECT_EQ(0, landlock_restrict_self(ruleset_fd,
> +					    LANDLOCK_RESTRICT_SELF_TSYNC));
> +
> +	ASSERT_EQ(0, pthread_cancel(t1));
> +	ASSERT_EQ(0, pthread_cancel(t2));
> +	ASSERT_EQ(0, pthread_join(t1, NULL));
> +	ASSERT_EQ(0, pthread_join(t2, NULL));
> +	ASSERT_EQ(0, close(ruleset_fd));
> +}

It would be useful for these multi_* tests to actually test the
restrictions.

A dedicated (positive and negative) test for ptrace and signal scoping
(back and forth) would also demonstrate that they are in the same
domain.

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
> +TEST_HARNESS_MAIN
> -- 
> 2.51.0.618.g983fd99d29-goog
> 
> 
