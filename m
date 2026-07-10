Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91835413220
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jul 2026 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681814; cv=none; b=oI/F3tEDJ18VikrwTOPlI0XiLJV1l2potdjDaTlsoRKR5KMKhWUpfdcw37tXN4m0xyU9n76qs94Du/MK6JXmqMRI7o3A2vhpePwhDO/iRp+qwdscSMt6faxh2LklPfMdvhzamdVXo2cERvzL8mnvcfSGXusYFlyeiapAYC9gfT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681814; c=relaxed/simple;
	bh=KEp1AMyryYhUge8PND3TbWoobQrjJ6UnXXvN7a0wGLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXObxq+UOT8ZcPV1S4C1a+jWqnoeJextbNcVhNvrLyzfLpjBBPiBXJ2P/QHNuFQiEP2cJAMEhzwcz62OfnOmoV1XFfy6EfNaBK69y4ouDnI7aee0/qBxxaqTj+FhgcEkXjy9Z+tB2PA24sWwuWLSB2POdyv+f1lLo0BWcJ70KcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QqKKoYOc; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QqKKoYOc"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gxTd53YbSzJQM;
	Fri, 10 Jul 2026 13:10:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1783681801;
	bh=43+ELjAOn+JDbZ1pkoZ9+pdyhdBGnnfDGLYu7ucwcZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QqKKoYOcr/Y5Pk8o17VrEiYlrGGIzSkJmeVUTlufsbZRrst3jat5zx0j774og3DlS
	 EIrqIv65Mh+RJpiKsrWfTcLQioOC3nz7w81tf7+JDR3QFpaSUEnZzENUlsPahT8n10
	 nNVe4q+wDJ7LT9a5LtM28slfCS2gxGttZn7/EeQc=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gxTd44m6HzRXf;
	Fri, 10 Jul 2026 13:10:00 +0200 (CEST)
Date: Fri, 10 Jul 2026 13:09:55 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Thomas Huth <thuth@redhat.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rbriggs@redhat.com
Subject: Re: [PATCH] selftests/landlock: Fix screwed up pointers in the
 scoped_signal_test
Message-ID: <20260710.aeLeem2aR4ue@digikod.net>
References: <20260709164340.339656-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709164340.339656-1-thuth@redhat.com>
X-Infomaniak-Routing: alpha

Applied (with a Fixes tag), thanks!

On Thu, Jul 09, 2026 at 06:43:40PM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The scoped_signal_test uses pthread_join(..., (void **)&ret)) in
> a couple of places, i.e. the return value of the thread is stored
> in the shape of a "void *" into the memory location of &ret.
> Pointers are 64-bit on modern computers, but the ret variable is
> declared as a simple "enum thread_return" which is only 32 bits.
> So the pthread_join() will overflow the ret variable by 4 byte.
> 
> The problem is very visible on big endian systems like s390x
> where the test is failing: The least significant byte that carries
> the return code of the thread is not written into the ret variable
> here, but somewhere else in the stack frame, so the comparison
> for the right return code is failing here.
> 
> Fix it by getting rid of the enum and defining the THREAD_* constants
> and "ret" variables as proper "void *" pointers. This way we can
> also get rid of some ugly (void *) castings in a couple of spots.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .../selftests/landlock/scoped_signal_test.c   | 44 +++++++++----------
>  1 file changed, 21 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
> index f24f2c28f62e5..58d25157fe781 100644
> --- a/tools/testing/selftests/landlock/scoped_signal_test.c
> +++ b/tools/testing/selftests/landlock/scoped_signal_test.c
> @@ -249,12 +249,10 @@ TEST_F(scoped_domains, check_access_signal)
>  		_metadata->exit_code = KSFT_FAIL;
>  }
>  
> -enum thread_return {
> -	THREAD_INVALID = 0,
> -	THREAD_SUCCESS = 1,
> -	THREAD_ERROR = 2,
> -	THREAD_TEST_FAILED = 3,
> -};

I just added clang-format markups.

> +#define THREAD_INVALID		((void *)0)
> +#define THREAD_SUCCESS		((void *)1)
> +#define THREAD_ERROR		((void *)2)
> +#define THREAD_TEST_FAILED	((void *)3)
>  
>  static void *thread_sync(void *arg)
>  {
> @@ -262,15 +260,15 @@ static void *thread_sync(void *arg)
>  	char buf;
>  
>  	if (read(pipe_read, &buf, 1) != 1)
> -		return (void *)THREAD_ERROR;
> +		return THREAD_ERROR;
>  
> -	return (void *)THREAD_SUCCESS;
> +	return THREAD_SUCCESS;
>  }
>  
>  TEST(signal_scoping_thread_before)
>  {
>  	pthread_t no_sandbox_thread;
> -	enum thread_return ret = THREAD_INVALID;
> +	void *ret = THREAD_INVALID;
>  	int thread_pipe[2];
>  
>  	drop_caps(_metadata);
> @@ -285,7 +283,7 @@ TEST(signal_scoping_thread_before)
>  	EXPECT_EQ(0, pthread_kill(no_sandbox_thread, 0));
>  	EXPECT_EQ(1, write(thread_pipe[1], ".", 1));
>  
> -	EXPECT_EQ(0, pthread_join(no_sandbox_thread, (void **)&ret));
> +	EXPECT_EQ(0, pthread_join(no_sandbox_thread, &ret));
>  	EXPECT_EQ(THREAD_SUCCESS, ret);
>  
>  	EXPECT_EQ(0, close(thread_pipe[0]));
> @@ -295,7 +293,7 @@ TEST(signal_scoping_thread_before)
>  TEST(signal_scoping_thread_after)
>  {
>  	pthread_t scoped_thread;
> -	enum thread_return ret = THREAD_INVALID;
> +	void *ret = THREAD_INVALID;
>  	int thread_pipe[2];
>  
>  	drop_caps(_metadata);
> @@ -310,7 +308,7 @@ TEST(signal_scoping_thread_after)
>  	EXPECT_EQ(0, pthread_kill(scoped_thread, 0));
>  	EXPECT_EQ(1, write(thread_pipe[1], ".", 1));
>  
> -	EXPECT_EQ(0, pthread_join(scoped_thread, (void **)&ret));
> +	EXPECT_EQ(0, pthread_join(scoped_thread, &ret));
>  	EXPECT_EQ(THREAD_SUCCESS, ret);
>  
>  	EXPECT_EQ(0, close(thread_pipe[0]));
> @@ -327,20 +325,20 @@ void *thread_setuid(void *ptr)
>  	char buf;
>  
>  	if (read(arg->pipe_read, &buf, 1) != 1)
> -		return (void *)THREAD_ERROR;
> +		return THREAD_ERROR;
>  
>  	/* libc's setuid() should update all thread's credentials. */
>  	if (getuid() != arg->new_uid)
> -		return (void *)THREAD_TEST_FAILED;
> +		return THREAD_TEST_FAILED;
>  
> -	return (void *)THREAD_SUCCESS;
> +	return THREAD_SUCCESS;
>  }
>  
>  TEST(signal_scoping_thread_setuid)
>  {
>  	struct thread_setuid_args arg;
>  	pthread_t no_sandbox_thread;
> -	enum thread_return ret = THREAD_INVALID;
> +	void *ret = THREAD_INVALID;
>  	int pipe_parent[2];
>  	int prev_uid;
>  
> @@ -367,7 +365,7 @@ TEST(signal_scoping_thread_setuid)
>  	EXPECT_EQ(arg.new_uid, getuid());
>  	EXPECT_EQ(1, write(pipe_parent[1], ".", 1));
>  
> -	EXPECT_EQ(0, pthread_join(no_sandbox_thread, (void **)&ret));
> +	EXPECT_EQ(0, pthread_join(no_sandbox_thread, &ret));
>  	EXPECT_EQ(THREAD_SUCCESS, ret);
>  
>  	clear_cap(_metadata, CAP_SETUID);
> @@ -667,20 +665,20 @@ static void *thread_setown_scoped(void *arg)
>  	ruleset_fd =
>  		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
>  	if (ruleset_fd < 0)
> -		return (void *)THREAD_ERROR;
> +		return THREAD_ERROR;
>  	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) ||
>  	    landlock_restrict_self(ruleset_fd, 0)) {
>  		close(ruleset_fd);
> -		return (void *)THREAD_ERROR;
> +		return THREAD_ERROR;
>  	}
>  	close(ruleset_fd);
>  
>  	/* Makes this process group own the SIGIO source. */
>  	if (fcntl(fd, F_SETSIG, SIGURG) || fcntl(fd, F_SETOWN, -getpgrp()) ||
>  	    fcntl(fd, F_SETFL, O_ASYNC))
> -		return (void *)THREAD_ERROR;
> +		return THREAD_ERROR;
>  
> -	return (void *)THREAD_SUCCESS;
> +	return THREAD_SUCCESS;
>  }
>  
>  /*
> @@ -702,7 +700,7 @@ TEST(sigio_to_pgid_self)
>  {
>  	int trigger[2];
>  	pthread_t thread;
> -	enum thread_return ret = THREAD_INVALID;
> +	void *ret = THREAD_INVALID;
>  	int i;
>  
>  	drop_caps(_metadata);
> @@ -722,7 +720,7 @@ TEST(sigio_to_pgid_self)
>  	 */
>  	ASSERT_EQ(0, pthread_create(&thread, NULL, thread_setown_scoped,
>  				    &trigger[0]));
> -	ASSERT_EQ(0, pthread_join(thread, (void **)&ret));
> +	ASSERT_EQ(0, pthread_join(thread, &ret));
>  	ASSERT_EQ(THREAD_SUCCESS, ret);
>  
>  	/* Fans SIGURG out to the process group. */
> -- 
> 2.55.0
> 
> 
