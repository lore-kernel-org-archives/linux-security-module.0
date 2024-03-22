Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F49B12E56
	for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2024 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711093725; cv=none; b=t1qZySDmDbcRP5ahq3bMGPLZVzeAUndYs3Qf20VaLQ1tExsCXX4ZfUHXmZqGxTzqZlaEnSmc2qLBrBZ1Y26ksGHUEWJAVwFZ99sjbzzurifgfe4MYZ1KE2mJ++SFIupToVhnDnEpIEZkfZhHwC/aw8ygGGBDFZ2YZb316LOIHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711093725; c=relaxed/simple;
	bh=QFbVBBB5G5qzDlHvX5d3rwWm7GUCbHO+K5Tpyrtfw4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSYopNLBU2+EwQZLFgfPCVht7FmHJ/lIbfYcZ/Hvn94PQXb3a6hLnE5ygjRb2are0vUM9ch/SPqlZLBiREdA7yif+h430x3Xhm1s6m/rUW036pVQBmTAb+t2rSpXDd7yu0Ujifr5LMPJHlTYAUT9/0iXJZACV9R2CBCp3CxYiEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Cr7atj2+; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Cr7atj2+"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V1DwG2wM5zNsx;
	Fri, 22 Mar 2024 08:48:30 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4V1DwF4TbwzMpnPm;
	Fri, 22 Mar 2024 08:48:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1711093710;
	bh=QFbVBBB5G5qzDlHvX5d3rwWm7GUCbHO+K5Tpyrtfw4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cr7atj2+i8AePXN9uSNpBJy66K22508/oXhry1on575iHZaG8m0vlidfOWmZKellt
	 724fp1cFivLQO+fNduHf2zSCvgoYHv2JRoVVQ/Wz2KSn7bh/ams3g8V7ebWDXSVlLw
	 1gDcEh5KdHGKUGXwQ8FyJLb0Etax3rCxyoFgpx5o=
Date: Fri, 22 Mar 2024 08:48:29 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v10 6/9] selftests/landlock: Test IOCTLs on named pipes
Message-ID: <20240322.axashie2ooJ1@digikod.net>
References: <20240309075320.160128-1-gnoack@google.com>
 <20240309075320.160128-7-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240309075320.160128-7-gnoack@google.com>
X-Infomaniak-Routing: alpha

It might be interesting to create a layout with one file of each type
and use that for the IOCTL tests.

On Sat, Mar 09, 2024 at 07:53:17AM +0000, Günther Noack wrote:
> Named pipes should behave like pipes created with pipe(2),
> so we don't want to restrict IOCTLs on them.
> 
> Suggested-by: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 61 ++++++++++++++++++----
>  1 file changed, 52 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 5c47231a722e..d991f44875bc 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -3924,6 +3924,58 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
>  	ASSERT_EQ(0, close(fd));
>  }
>  
> +static int test_fionread_ioctl(int fd)
> +{
> +	size_t sz = 0;
> +
> +	if (ioctl(fd, FIONREAD, &sz) < 0 && errno == EACCES)
> +		return errno;
> +	return 0;
> +}
> +
> +/*
> + * Named pipes are not governed by the LANDLOCK_ACCESS_FS_IOCTL_DEV right,
> + * because they are not character or block devices.
> + */
> +TEST_F_FORK(layout1, named_pipe_ioctl)
> +{
> +	pid_t child_pid;
> +	int fd, ruleset_fd;
> +	const char *const path = file1_s1d1;
> +	const struct landlock_ruleset_attr attr = {
> +		.handled_access_fs = LANDLOCK_ACCESS_FS_IOCTL_DEV,
> +	};
> +
> +	ASSERT_EQ(0, unlink(path));
> +	ASSERT_EQ(0, mkfifo(path, 0600));
> +
> +	/* Enables Landlock. */
> +	ruleset_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* The child process opens the pipe for writing. */
> +	child_pid = fork();
> +	ASSERT_NE(-1, child_pid);
> +	if (child_pid == 0) {

What is the purpose of this child's code?

> +		fd = open(path, O_WRONLY);
> +		close(fd);
> +		exit(0);
> +	}
> +
> +	fd = open(path, O_RDONLY);
> +	ASSERT_LE(0, fd);
> +
> +	/* FIONREAD is implemented by pipefifo_fops. */
> +	EXPECT_EQ(0, test_fionread_ioctl(fd));
> +
> +	ASSERT_EQ(0, close(fd));
> +	ASSERT_EQ(0, unlink(path));
> +
> +	ASSERT_EQ(child_pid, waitpid(child_pid, NULL, 0));
> +}
> +
>  /* clang-format off */
>  FIXTURE(ioctl) {};
>  
> @@ -3997,15 +4049,6 @@ static int test_tcgets_ioctl(int fd)
>  	return 0;
>  }
>  
> -static int test_fionread_ioctl(int fd)
> -{
> -	size_t sz = 0;
> -
> -	if (ioctl(fd, FIONREAD, &sz) < 0 && errno == EACCES)
> -		return errno;
> -	return 0;
> -}
> -

You should add test_fionread_ioctl() at the right place from the start.

>  TEST_F_FORK(ioctl, handle_dir_access_file)
>  {
>  	const int flag = 0;
> -- 
> 2.44.0.278.ge034bb2e1d-goog
> 
> 
