Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DB73BB12D
	for <linux-security-module@vger.kernel.org>; Fri, 26 Jun 2026 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509413; cv=none; b=a4Tuzb6NtKX/u8DcVPOZzH1yI/IATUT1s9hMnaVHvE7PfRY3bhXUw2JT+ZUB23sdc1nCq+CQBWnLghySZTD6+Izq1qeO+8QGkksC+D23GJ42J7/cG2GVlLoiM9/AWLgdv9kVhySu/xPncgku+OW6R7Vn2mlW9GRPnNlxdtCL5Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509413; c=relaxed/simple;
	bh=30k/EqGAorSVjoOSk9ip3EDqNZjX6yjL8m37IxBctxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LulAxyxuoFtNQC5xwrw+NpOHzkNfCeKKKRWtM6jRJpUCsQ97+IyBoquEtK9E4cxSgdkbc0jSpQ/8X6LW9TAqCC4ZIIhmxooOqQW4tdUdZcT6Vp8ehtlP17FHpSvJF1yDumQkSv1MDzXpRONom5djzlNdS1usPR319HBiaI3qQsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FU5QH7ox; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="FU5QH7ox"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gn7qT0X87zn9;
	Fri, 26 Jun 2026 23:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1782508804;
	bh=c0NaLpnIYrB3GZw7BCcXSauBvaVEunE3KzxssDSer20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FU5QH7oxPHL+JAAcaCHPYySWN7Rlxx2weRfaPRLH/u6TS1+DEBA4ivpaL0At0526Y
	 57Sn3kl+GValSBMYNWiuxvcmmVeTTihyPNNb7d6rFJRESfTcxJZwb1ZxIBnURFETwH
	 TjEu7O7pHL4dfH7V2T5OYS8sE///Eo2F93jI4DSE=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gn7qS2MKnz5G1;
	Fri, 26 Jun 2026 23:20:04 +0200 (CEST)
Date: Fri, 26 Jun 2026 23:19:58 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: Bryam Vargas <hexlabsecurity@proton.me>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, linux-security-module@vger.kernel.org, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Paul Moore <paul@paul-moore.com>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] selftests/landlock: Add test for TCP fast open
Message-ID: <20260626.Ahk8pe9boong@digikod.net>
References: <20260617.eemahv8ui7Ee@digikod.net>
 <20260617180526.15627-1-matthieu@buffet.re>
 <20260617180526.15627-3-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617180526.15627-3-matthieu@buffet.re>
X-Infomaniak-Routing: alpha

On Wed, Jun 17, 2026 at 08:05:24PM +0200, Matthieu Buffet wrote:
> Enforce that TCP Fast Open is controlled by
> LANDLOCK_ACCESS_NET_CONNECT_TCP. Semantics of connect() and
> sendmsg(MSG_FASTOPEN) should be identical from Landlock's perspective.
> Also enforce error code consistency, since UDP sockets ignore
> the MSG_FASTOPEN flag while Unix sockets reject it.
> 
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  tools/testing/selftests/landlock/net_test.c | 155 ++++++++++++++++++++
>  1 file changed, 155 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
> index 0c256e7c8675..177ed28e70f6 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -258,6 +258,64 @@ static int connect_variant(const int sock_fd,
>  	return connect_variant_addrlen(sock_fd, srv, get_addrlen(srv, false));
>  }
>  
> +static int sendto_variant_addrlen(const int sock_fd,
> +				  const struct service_fixture *const srv,
> +				  const socklen_t addrlen, void *buf,
> +				  size_t len, size_t flags)
> +{
> +	const struct sockaddr *dst = NULL;
> +	ssize_t ret;
> +
> +	/*
> +        * We never want our processes to be killed by SIGPIPE: we check return
> +        * codes and errno, so that we have actual error messages.
> +        */

There are some extra spaces above.

> +	flags |= MSG_NOSIGNAL;
> +
> +	if (srv != NULL) {

Just `if (srv) {`

> +		switch (srv->protocol.domain) {
> +		case AF_UNSPEC:
> +		case AF_INET:
> +			dst = (const struct sockaddr *)&srv->ipv4_addr;
> +			break;
> +
> +		case AF_INET6:
> +			dst = (const struct sockaddr *)&srv->ipv6_addr;
> +			break;
> +
> +		case AF_UNIX:
> +			dst = (const struct sockaddr *)&srv->unix_addr;
> +			break;
> +
> +		default:
> +			errno = EAFNOSUPPORT;
> +			return -errno;
> +		}
> +	}
> +
> +	ret = sendto(sock_fd, buf, len, flags, dst, addrlen);
> +	if (ret < 0)
> +		return -errno;
> +
> +	/* errno is not set in cases of partial writes. */
> +	if (ret != len)
> +		return -EINTR;
> +
> +	return 0;
> +}
> +
> +static int sendto_variant(const int sock_fd,
> +			  const struct service_fixture *const srv, void *buf,
> +			  size_t len, size_t flags)
> +{
> +	socklen_t addrlen = 0;
> +
> +	if (srv != NULL)

ditto

> +		addrlen = get_addrlen(srv, false);
> +
> +	return sendto_variant_addrlen(sock_fd, srv, addrlen, buf, len, flags);
> +}
> +
>  FIXTURE(protocol)
>  {
>  	struct service_fixture srv0, srv1, srv2, unspec_any0, unspec_srv0;
> @@ -950,6 +1008,103 @@ TEST_F(protocol, connect_unspec)
>  	EXPECT_EQ(0, close(bind_fd));
>  }
>  
> +TEST_F(protocol, tcp_fastopen)
> +{
> +	const bool restricted = variant->sandbox == TCP_SANDBOX &&
> +				variant->prot.type == SOCK_STREAM &&
> +				(variant->prot.protocol == IPPROTO_TCP ||
> +				 variant->prot.protocol == IPPROTO_IP) &&
> +				(variant->prot.domain == AF_INET ||
> +				 variant->prot.domain == AF_INET6);
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.handled_access_net = LANDLOCK_ACCESS_NET_CONNECT_TCP,
> +	};
> +	int bind_fd, client_fd, status;
> +	char buf;
> +	pid_t child;
> +
> +	bind_fd = socket_variant(&self->srv0);
> +	ASSERT_LE(0, bind_fd);
> +	EXPECT_EQ(0, bind_variant(bind_fd, &self->srv0));
> +	if (self->srv0.protocol.type == SOCK_STREAM)
> +		EXPECT_EQ(0, listen(bind_fd, backlog));
> +
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		int connect_fd, ret;
> +
> +		/* Closes listening socket for the child. */
> +		EXPECT_EQ(0, close(bind_fd));
> +
> +		connect_fd = socket_variant(&self->srv0);
> +		ASSERT_LE(0, connect_fd);
> +
> +		if (variant->sandbox == TCP_SANDBOX) {
> +			const int ruleset_fd = landlock_create_ruleset(
> +				&ruleset_attr, sizeof(ruleset_attr), 0);
> +			ASSERT_LE(0, ruleset_fd);
> +
> +			enforce_ruleset(_metadata, ruleset_fd);
> +			EXPECT_EQ(0, close(ruleset_fd));
> +		}
> +
> +		/* Fast Open with no address. */
> +		ret = sendto_variant(connect_fd, NULL, NULL, 0, MSG_FASTOPEN);


> +		if (self->srv0.protocol.domain == AF_UNIX) {
> +			ASSERT_EQ(-ENOTCONN, ret);
> +		} else if (self->srv0.protocol.type == SOCK_DGRAM) {
> +			ASSERT_EQ(-EDESTADDRREQ, ret);
> +		} else {
> +			ASSERT_EQ(-EINVAL, ret);
> +		}
> +
> +		/* Fast Open to a denied address. */
> +		ret = sendto_variant(connect_fd, &self->srv0, "A", 1,
> +				     MSG_FASTOPEN);
> +		if (restricted) {
> +			ASSERT_EQ(-EACCES, ret);
> +		} else if (self->srv0.protocol.domain == AF_UNIX &&
> +			   self->srv0.protocol.type == SOCK_STREAM) {
> +			ASSERT_EQ(-EOPNOTSUPP, ret);
> +		} else {
> +			ASSERT_EQ(0, ret);
> +		}

All these ret checks should be done with EXPECT_EQ because they don't
block the test itself and we can get more info by checking more after
that.

> +
> +		EXPECT_EQ(0, close(connect_fd));
> +		_exit(_metadata->exit_code);
> +		return;
> +	}
> +
> +	client_fd = bind_fd;
> +	if (!restricted && self->srv0.protocol.type == SOCK_STREAM &&
> +	    self->srv0.protocol.domain != AF_UNIX) {
> +		client_fd = accept(bind_fd, NULL, 0);
> +		ASSERT_LE(0, client_fd);
> +	}
> +
> +	if (restricted) {
> +		EXPECT_EQ(-1, read(client_fd, &buf, 1));
> +		EXPECT_EQ(ENOTCONN, errno);
> +	} else if (self->srv0.protocol.domain == AF_UNIX &&
> +		   self->srv0.protocol.type == SOCK_STREAM) {
> +		EXPECT_EQ(-1, read(client_fd, &buf, 1));
> +		EXPECT_EQ(EINVAL, errno);
> +	} else {
> +		EXPECT_EQ(1, read(client_fd, &buf, 1));
> +		EXPECT_EQ('A', buf);
> +	}
> +
> +	EXPECT_EQ(child, waitpid(child, &status, 0));
> +	EXPECT_EQ(1, WIFEXITED(status));
> +	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
> +
> +	if (client_fd != bind_fd)
> +		EXPECT_LE(0, close(client_fd));
> +
> +	EXPECT_EQ(0, close(bind_fd));
> +}
> +
>  FIXTURE(ipv4)
>  {
>  	struct service_fixture srv0, srv1;
> -- 
> 2.47.3
> 
> 
