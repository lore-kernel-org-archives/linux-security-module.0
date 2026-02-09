Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD22238885B
	for <linux-security-module@vger.kernel.org>; Mon,  9 Feb 2026 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658164; cv=none; b=YIRDMIEqTeZeIfCMRTQ60r6ZzxoVdglsHTtSuNfvAP3ssD8wUAog9WOyzaam3Rr1B98G/OLh6C42U75PJK5wVlS8jR22/uMWwv9SJEcCPjfn3+Aa/LClkuFZQu5iRilW4EKVZjAxYu7ZG3HNrHc3ZsBgecJRYZVfRVJG8mCx0gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658164; c=relaxed/simple;
	bh=RT2Xrpa0wrOjdOluDw2VyG1IMYUH7mSUhnkucBG0fAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBmEwQBZZxOi+vzJ+bT9lDelibQ81Xkg4PLdMHsg9wAqoMwY+NndUxdcuv7dzqtzivG7zjJFDMKXxl8TQm4RQ7Njph+1FtLd1plhgtFjqhB10jqJUCNV1Em9l2R+eRIpwoESmryEWTWMWObtSV3tNHwPZoQOt51hOX2SzoDYemA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=BCvDqeJS; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="BCvDqeJS"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f8sBM5blFzr5k;
	Mon,  9 Feb 2026 18:29:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770658155;
	bh=bJosAoYnKvGNArsOWT1QLuXu9Ve3NglP9OWn6/qNN3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BCvDqeJSOAQ30fRbl+PSIwFL1WqN0sUX+Odu9QwrSscIBDvUSkp/K/nmfxhx9GJ0m
	 uK/caGqWS1Y+v5Ojll6Cc6JyTyycmT0FKdi4NsrpxUdDuC6w+ZBYEs93HlnKiCbkPI
	 Dwx+W/JC823FficWJMazOA89M9rhL650e6nLQhOE=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f8sBM1LbtzTcZ;
	Mon,  9 Feb 2026 18:29:15 +0100 (CET)
Date: Mon, 9 Feb 2026 18:29:13 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, 
	Tingmao Wang <m@maowtm.org>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v4 4/6] landlock/selftests: Test named UNIX domain socket
 restrictions
Message-ID: <20260209.Noh6thae5cho@digikod.net>
References: <20260208231017.114343-1-gnoack3000@gmail.com>
 <20260208231017.114343-5-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260208231017.114343-5-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Feb 09, 2026 at 12:10:14AM +0100, Günther Noack wrote:
> * Exercise the access right for connect() and sendmsg() on named UNIX
>   domain sockets, in various combinations of Landlock domains and
>   socket types.
> * Extract common helpers from an existing IOCTL test that
>   also uses pathname unix(7) sockets.
> 
> The tested combinations are the cross product of these sets of fixture
> fields:
> 
> * {{.handled=RESOLVE_UNIX},
>    {.handled=RESOLVE_UNIX, .allowed=RESOLVE_UNIX}}
> * {{.sock_type=SOCK_STREAM},
>    {.sock_type=SOCK_DGRAM},
>    {.sock_type=SOCK_DGRAM, .use_sendto=true},
>    {.sock_type=SOCK_SEQPACKET}}
> * {{.server_in_same_domain=false},
>    {.server_in_same_domain=true}}

It would improve test clarity to follow the same approach as Tingmao to
check the scope, especially to use the scoped_base_variant.h:
https://lore.kernel.org/all/88de5bed60b06ba97088d87803f7bb3dbcc9a808.1767115163.git.m@maowtm.org/
Even if there is no more explicit scoped flag anymore, this test suite
is still relevant.

The fs_test.c part would then mostly check the
LANDLOCK_ACCESS_FS_RESOLVE_UNIX rules/exceptions.

> 
> Some additional fixtures exercise scenarios with two nested domains.
> 
> Cc: Justin Suess <utilityemal77@gmail.com>
> Cc: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 381 ++++++++++++++++++++-
>  1 file changed, 365 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index b318627e7561..9d3f5dab4567 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -4358,30 +4358,61 @@ TEST_F_FORK(layout1, named_pipe_ioctl)
>  	ASSERT_EQ(child_pid, waitpid(child_pid, NULL, 0));
>  }
>  
> +/*
> + * set_up_named_unix_server - Create a pathname unix socket
> + *
> + * If the socket type is not SOCK_DGRAM, also invoke listen(2).
> + *
> + * Return: The listening FD - it is the caller responsibility to close it.
> + */
> +static int set_up_named_unix_server(struct __test_metadata *const _metadata,
> +				    int type, const char *const path)
> +{
> +	int fd;
> +	struct sockaddr_un addr = {
> +		.sun_family = AF_UNIX,
> +	};
> +
> +	fd = socket(AF_UNIX, type, 0);
> +	ASSERT_LE(0, fd);
> +
> +	strncpy(addr.sun_path, path, sizeof(addr.sun_path));
> +	ASSERT_EQ(0, bind(fd, (struct sockaddr *)&addr, sizeof(addr)));
> +
> +	if (type != SOCK_DGRAM)
> +		ASSERT_EQ(0, listen(fd, 10 /* qlen */));
> +	return fd;
> +}
> +
> +/*
> + * test_connect_named_unix - connect to the given named UNIX socket
> + *
> + * Return: The errno from connect(), or 0
> + */
> +static int test_connect_named_unix(int fd, const char *const path)
> +{
> +	struct sockaddr_un addr = {
> +		.sun_family = AF_UNIX,
> +	};
> +	strncpy(addr.sun_path, path, sizeof(addr.sun_path));
> +
> +	if (connect(fd, (struct sockaddr *)&addr, sizeof(addr)) == -1)
> +		return errno;
> +	return 0;
> +}
> +
>  /* For named UNIX domain sockets, no IOCTL restrictions apply. */
>  TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
>  {
>  	const char *const path = file1_s1d1;
>  	int srv_fd, cli_fd, ruleset_fd;
> -	struct sockaddr_un srv_un = {
> -		.sun_family = AF_UNIX,
> -	};
> -	struct sockaddr_un cli_un = {
> -		.sun_family = AF_UNIX,
> -	};
>  	const struct landlock_ruleset_attr attr = {
>  		.handled_access_fs = LANDLOCK_ACCESS_FS_IOCTL_DEV,
>  	};
>  
>  	/* Sets up a server */
>  	ASSERT_EQ(0, unlink(path));
> -	srv_fd = socket(AF_UNIX, SOCK_STREAM, 0);
> -	ASSERT_LE(0, srv_fd);
> -
> -	strncpy(srv_un.sun_path, path, sizeof(srv_un.sun_path));
> -	ASSERT_EQ(0, bind(srv_fd, (struct sockaddr *)&srv_un, sizeof(srv_un)));
> -
> -	ASSERT_EQ(0, listen(srv_fd, 10 /* qlen */));
> +	srv_fd = set_up_named_unix_server(_metadata, SOCK_STREAM, path);
>  
>  	/* Enables Landlock. */
>  	ruleset_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
> @@ -4393,9 +4424,7 @@ TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
>  	cli_fd = socket(AF_UNIX, SOCK_STREAM, 0);
>  	ASSERT_LE(0, cli_fd);
>  
> -	strncpy(cli_un.sun_path, path, sizeof(cli_un.sun_path));
> -	ASSERT_EQ(0,
> -		  connect(cli_fd, (struct sockaddr *)&cli_un, sizeof(cli_un)));
> +	ASSERT_EQ(0, test_connect_named_unix(cli_fd, path));
>  
>  	/* FIONREAD and other IOCTLs should not be forbidden. */
>  	EXPECT_EQ(0, test_fionread_ioctl(cli_fd));
> @@ -4570,6 +4599,326 @@ TEST_F_FORK(ioctl, handle_file_access_file)
>  	ASSERT_EQ(0, close(file_fd));
>  }
>  
> +/* clang-format off */
> +FIXTURE(unix_socket) {};
> +
> +FIXTURE_SETUP(unix_socket) {};
> +
> +FIXTURE_TEARDOWN(unix_socket) {};
> +/* clang-format on */
> +
> +FIXTURE_VARIANT(unix_socket)
> +{
> +	const __u64 handled;
> +	const __u64 allowed;
> +	const __u64 handled2;
> +	const __u64 allowed2;
> +	const int sock_type;
> +	const int expected;
> +	const bool use_sendto;
> +	const bool server_in_same_domain;
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, stream_handled_not_allowed)
> +{
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed = 0,
> +	.sock_type = SOCK_STREAM,
> +	.expected = EACCES,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, stream_handled_and_allowed)
> +{
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.sock_type = SOCK_STREAM,
> +	.expected = 0,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, dgram_handled_not_allowed)
> +{
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed = 0,
> +	.sock_type = SOCK_DGRAM,
> +	.expected = EACCES,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, dgram_handled_and_allowed)
> +{
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.sock_type = SOCK_DGRAM,
> +	.expected = 0,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, dgram_sendto_handled_not_allowed)
> +{
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed = 0,
> +	.sock_type = SOCK_DGRAM,
> +	.use_sendto = true,
> +	.expected = EACCES,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, dgram_sendto_handled_and_allowed)
> +{
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.sock_type = SOCK_DGRAM,
> +	.use_sendto = true,
> +	.expected = 0,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, seqpacket_handled_not_allowed)
> +{
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed = 0,
> +	.sock_type = SOCK_SEQPACKET,
> +	.expected = EACCES,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, seqpacket_handled_and_allowed)
> +{
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.sock_type = SOCK_SEQPACKET,
> +	.expected = 0,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, stream_handled_not_allowed_and_same_scope)
> +{
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed = 0,
> +	.sock_type = SOCK_STREAM,
> +	.expected = 0,
> +	.server_in_same_domain = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, stream_handled_and_allowed_and_same_scope)
> +{
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.sock_type = SOCK_STREAM,
> +	.expected = 0,
> +	.server_in_same_domain = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, dgram_handled_not_allowed_and_same_scope)
> +{
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed = 0,
> +	.sock_type = SOCK_DGRAM,
> +	.expected = 0,
> +	.server_in_same_domain = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, dgram_handled_and_allowed_and_same_scope)
> +{
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.sock_type = SOCK_DGRAM,
> +	.expected = 0,
> +	.server_in_same_domain = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, dgram_sendto_handled_not_allowed_and_same_scope)
> +{
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed = 0,
> +	.sock_type = SOCK_DGRAM,
> +	.use_sendto = true,
> +	.expected = 0,
> +	.server_in_same_domain = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, dgram_sendto_handled_and_allowed_and_same_scope)
> +{
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.sock_type = SOCK_DGRAM,
> +	.use_sendto = true,
> +	.expected = 0,
> +	.server_in_same_domain = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, seqpacket_handled_not_allowed_and_same_scope)
> +{
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed = 0,
> +	.sock_type = SOCK_SEQPACKET,
> +	.expected = 0,
> +	.server_in_same_domain = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, seqpacket_handled_and_allowed_and_same_scope)
> +{
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.sock_type = SOCK_SEQPACKET,
> +	.expected = 0,
> +	.server_in_same_domain = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, stream_nested_domains_scope_path)
> +{
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed = 0,
> +	.server_in_same_domain = true,
> +	.handled2 = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed2 = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.sock_type = SOCK_STREAM,
> +	.expected = 0,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, stream_nested_domains_path_scope)
> +{
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.server_in_same_domain = true,
> +	.handled2 = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed2 = 0,
> +	.sock_type = SOCK_STREAM,
> +	.expected = EACCES,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, stream_nested_domains_scope_scope)
> +{
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed = 0,
> +	.server_in_same_domain = true,
> +	.handled2 = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed2 = 0,
> +	.sock_type = SOCK_STREAM,
> +	.expected = EACCES,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(unix_socket, stream_nested_domains_path_path)
> +{
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.server_in_same_domain = true,
> +	.handled2 = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.allowed2 = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	.sock_type = SOCK_STREAM,
> +	.expected = 0,
> +};
> +
> +/*
> + * test_sendto_named_unix - sendto to the given named UNIX socket
> + *
> + * sendto() is equivalent to sendmsg() in this respect.
> + *
> + * Return: The errno from sendto(), or 0
> + */
> +static int test_sendto_named_unix(int fd, const char *const path)
> +{
> +	static const char buf[] = "dummy";
> +	struct sockaddr_un addr = {
> +		.sun_family = AF_UNIX,
> +	};
> +	strncpy(addr.sun_path, path, sizeof(addr.sun_path));
> +
> +	if (sendto(fd, buf, sizeof(buf), 0, (struct sockaddr *)&addr,
> +		   sizeof(addr)) == -1)
> +		return errno;
> +	return 0;
> +}
> +
> +TEST_F_FORK(unix_socket, test)
> +{
> +	const char *const path = "sock";
> +	int cli_fd, srv_fd, ruleset_fd, res;
> +	struct rule rules[] = {
> +		{
> +			.path = ".",
> +			.access = variant->allowed,
> +		},
> +		{},
> +	};
> +
> +	/* Sets up a server (in the case where the server is in the parent domain) */
> +	if (!variant->server_in_same_domain)
> +		srv_fd = set_up_named_unix_server(_metadata, variant->sock_type,
> +						  path);
> +
> +	/* Enables Landlock. */
> +	ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* Sets up a server (in the case where the server is in the same domain) */
> +	if (variant->server_in_same_domain)
> +		srv_fd = set_up_named_unix_server(_metadata, variant->sock_type,
> +						  path);
> +
> +	if (variant->handled2) {
> +		/* Enables Landlock another time, if needed. */
> +		rules[0].access = variant->allowed2;
> +		ruleset_fd =
> +			create_ruleset(_metadata, variant->handled2, rules);
> +		ASSERT_LE(0, ruleset_fd);
> +		enforce_ruleset(_metadata, ruleset_fd);
> +		ASSERT_EQ(0, close(ruleset_fd));
> +	}
> +
> +	/* Sets up a client connection to it */
> +	cli_fd = socket(AF_UNIX, variant->sock_type, 0);
> +	ASSERT_LE(0, cli_fd);
> +
> +	/* Connecting or sendto to the Unix socket is denied. */
> +	if (variant->use_sendto)
> +		res = test_sendto_named_unix(cli_fd, path);
> +	else
> +		res = test_connect_named_unix(cli_fd, path);
> +	EXPECT_EQ(variant->expected, res);
> +
> +	/* Clean up. */
> +	EXPECT_EQ(0, close(cli_fd));
> +	EXPECT_EQ(0, close(srv_fd));
> +	EXPECT_EQ(0, unlink(path));
> +}
> +
>  /* clang-format off */
>  FIXTURE(layout1_bind) {};
>  /* clang-format on */
> -- 
> 2.52.0
> 
> 
