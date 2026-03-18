Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011FF13D638
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852829; cv=none; b=ZWUX4gH+u9ps4MccYeAWkeBhNgR80xiDrM7Qb/BpJTvirZ+ki9wcS9S+vUYBsBynb/Zm/IZd3yefZRcOaTg4wgsysTGJcfCTkgbJ6hynIs82x2aNDoaEWflAb0hnhXxMcYuNxrYOTfQghSsot7i6alZMPCMAagOOd9zeh7abb9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852829; c=relaxed/simple;
	bh=zuI5oTiwMWPoZAgePtXaJ+Qf8B4nyuGck1ZCuhepibs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ebd0lKKqL52k4Clqky34lgaHGmJZOO4cz0f2Y3BmmIPRHE6z9+rZ50xUE4aOI9wxTUdotIWFif2uQm9mBO07Kr6NMaHNa8M0cmexQ6rqbDc/lHQLa2UKeISG2S06inBZza9xyBRZ1jmbwTEoEBPAxQ2ha/gmLw/qyuhCl2XSLgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=HwUMkHlb; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="HwUMkHlb"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fbZfD270bzSB3;
	Wed, 18 Mar 2026 17:53:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773852820;
	bh=nMeuWJ+jr5E/sPD3DNf7U1KYDfgR1xRs5BtzUidRVmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HwUMkHlbfXG92tpyz7uLc1s4y7WJOw4D0N7R1sjzSJmjDAPCcbJ8nhnUdlpqcQuxa
	 UDwWuZrrDyQzn3WPuaftQLZeRGgSZPVmIlxHlKWj/d44c1i5pnDAooTwOil3ssYNq2
	 XUWL1W8RxrrZpcc+Nbd0t930KLByRbELi/ZgbZog=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fbZfC55pGzxr6;
	Wed, 18 Mar 2026 17:53:39 +0100 (CET)
Date: Wed, 18 Mar 2026 17:53:38 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH v6 6/9] landlock/selftests: Audit test for
 LANDLOCK_ACCESS_FS_RESOLVE_UNIX
Message-ID: <20260318.chiMaiyuf6mo@digikod.net>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-7-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315222150.121952-7-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Sun, Mar 15, 2026 at 11:21:47PM +0100, Günther Noack wrote:
> Add an audit test to check that Landlock denials from
> LANDLOCK_ACCESS_FS_RESOLVE_UNIX result in audit logs in the expected
> format.  (There is one audit test for each filesystem access right, so
> we should add one for LANDLOCK_ACCESS_FS_RESOLVE_UNIX as well.)
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 43 +++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index fdbb024da774..4198148e172f 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -7538,7 +7538,8 @@ static const __u64 access_fs_16 =
>  	LANDLOCK_ACCESS_FS_MAKE_SYM |
>  	LANDLOCK_ACCESS_FS_REFER |
>  	LANDLOCK_ACCESS_FS_TRUNCATE |
> -	LANDLOCK_ACCESS_FS_IOCTL_DEV;
> +	LANDLOCK_ACCESS_FS_IOCTL_DEV |
> +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX;

The variable access_fs_16 contains 16 access rights.  The idea was to
not need to change this variable with new FS access rights because the
tests should not change.  I guess that was not a good choice because
new tests like audit_layout1.resolve_unix may not change the result of
existing tests (and then improve coverage).  This variable can then be
replaced with ACCESS_ALL (in a dedicated patch please).  If we need
exceptions we can mask the problematic access rights (see
audit_layout1.ioctl_dev).

>  /* clang-format on */
>  
>  TEST_F(audit_layout1, execute_read)
> @@ -7983,6 +7984,46 @@ TEST_F(audit_layout1, ioctl_dev)
>  	EXPECT_EQ(1, records.domain);
>  }
>  
> +TEST_F(audit_layout1, resolve_unix)
> +{
> +	struct audit_records records;
> +	const char *const path = "sock";
> +	int srv_fd, cli_fd, status;
> +	pid_t child_pid;
> +
> +	srv_fd = set_up_named_unix_server(_metadata, SOCK_STREAM, path);
> +
> +	child_pid = fork();
> +	ASSERT_LE(0, child_pid);
> +	if (!child_pid) {
> +		drop_access_rights(_metadata,
> +				   &(struct landlock_ruleset_attr){
> +					   .handled_access_fs = access_fs_16,
> +				   });
> +
> +		cli_fd = socket(AF_UNIX, SOCK_STREAM, 0);
> +		ASSERT_LE(0, cli_fd);
> +		EXPECT_EQ(EACCES,
> +			  test_connect_named_unix(_metadata, cli_fd, path));
> +
> +		EXPECT_EQ(0, close(cli_fd));
> +		_exit(_metadata->exit_code);
> +	}
> +
> +	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
> +	EXPECT_EQ(1, WIFEXITED(status));
> +	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
> +
> +	EXPECT_EQ(0, matches_log_fs_extra(_metadata, self->audit_fd,
> +					  "fs\\.resolve_unix", path, NULL));
> +
> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +	EXPECT_EQ(0, records.access);
> +	EXPECT_EQ(1, records.domain);
> +
> +	EXPECT_EQ(0, close(srv_fd));
> +}
> +
>  TEST_F(audit_layout1, mount)
>  {
>  	struct audit_records records;
> -- 
> 2.53.0
> 
