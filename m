Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99245346FDA
	for <linux-security-module@vger.kernel.org>; Wed, 18 Feb 2026 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771442291; cv=none; b=RNfbXD/AaEEaJ8WwgMrCrzSBfjJHoUNraME0hTqLamsqgSxVLJiONBI0hVvfbhfBpkfl/KBJ3lr2m9pAw9+ijkvICFFFqOoBMsmTw2VG8azBkI78F2CQfQl1V/rvV4R+Kt6+hnqCLw/rJlSyQONDjUzzzH1/KlvSKEArCQ4QMyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771442291; c=relaxed/simple;
	bh=AeQ7xjqyJGeQQZlLVQNj29NYcXNrH+CBHOEHyvHRNi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDYwQAbEHKny52mcLErgcTO6E5QMgEYbypFhhsekJE/B84JE8vKiSDjC24LmYioHucq8c0kkYoP41dTFy5XV7atZ2+U635PtnN/fokRNRzXg4PnGYS8hPd+Lvo1jxAk9fG4VC77viXwlG9KPeOC40792++AXHa7DzZ2MMOqPf4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Eo/inXc5; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Eo/inXc5"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fGR2C2PnrzQ4n;
	Wed, 18 Feb 2026 20:11:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1771441891;
	bh=79+aj51njAfDV0RlYlLFoDxORntODlEA62DIupvkb/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eo/inXc558PRMqODzq+uGdo6F6ucd815BkW5ClvwczTXtryj+e/CQkI3BO9oupuzB
	 pNwU7a+zG1bg+6BeHZM7NOoS5S+w4ucXh2l7XAvahcvd+/v/XCs907o87GDp68TU+R
	 Qy+fBFWgkyUdnhjkxX4GlJSFJiqSkdNJwe3cYVaA=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fGR2B1FF6zNQg;
	Wed, 18 Feb 2026 20:11:30 +0100 (CET)
Date: Wed, 18 Feb 2026 20:11:26 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Justin Suess <utilityemal77@gmail.com>, Tingmao Wang <m@maowtm.org>, 
	linux-security-module@vger.kernel.org, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v5 4/9] landlock/selftests: Test
 LANDLOCK_ACCESS_FS_RESOLVE_UNIX
Message-ID: <20260218.aser1cu7Aewi@digikod.net>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
 <20260215105158.28132-5-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260215105158.28132-5-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Sun, Feb 15, 2026 at 11:51:52AM +0100, Günther Noack wrote:
> * Extract common helpers from an existing IOCTL test that
>   also uses pathname unix(7) sockets.
> * These tests use the common scoped domains fixture which is also used
>   in other Landlock scoping tests and which was used in Tingmao Wang's
>   earlier patch set in [1].
> 
> These tests exercise the cross product of the following scenarios:
> 
> * Stream connect(), Datagram connect(), Datagram sendmsg() and
>   Seqpacket connect().
> * Child-to-parent and parent-to-child communication
> * The Landlock policy configuration as listed in the scoped_domains
>   fixture.
>   * In the default variant, Landlock domains are only placed where
>     prescribed in the fixture.
>   * In the "ALL_DOMAINS" variant, Landlock domains are also placed in
>     the places where the fixture says to omit them, but with a
>     LANDLOCK_RULE_PATH_BENEATH that allows connection.
> 
> Cc: Justin Suess <utilityemal77@gmail.com>
> Cc: Tingmao Wang <m@maowtm.org>
> Cc: Mickaël Salaün <mic@digikod.net>
> Link[1]: https://lore.kernel.org/all/53b9883648225d5a08e82d2636ab0b4fda003bc9.1767115163.git.m@maowtm.org/
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 384 ++++++++++++++++++++-
>  1 file changed, 368 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index b318627e7561..bdeff2e0e029 100644
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

fs_test.c: In function ‘set_up_named_unix_server’:
fs_test.c:4125:9: error: ‘strncpy’ specified bound 108 equals destination size [-Werror=stringop-truncation]
 4125 |         strncpy(addr.sun_path, path, sizeof(addr.sun_path));
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We should also ASSERT the result to make sure path's length is not too big.

> +	ASSERT_EQ(0, bind(fd, (struct sockaddr *)&addr, sizeof(addr)));
> +
> +	if (type != SOCK_DGRAM)
> +		ASSERT_EQ(0, listen(fd, 10 /* qlen */));
> +	return fd;
> +}
