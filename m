Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741E3433E74
	for <linux-security-module@vger.kernel.org>; Thu,  2 Jul 2026 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783004378; cv=none; b=OQl2QTfqihhgT4E2z+H8O2pdUplAVl2W2pWtC0a2Wi4zduabSr7v6XbXqQhXOQuhfJzW8D48CvmxZqi8ejSgr/FLIfud5PaD0Pp2sewPMxtBRSXUm3BpCKX9250WcdDJsCVFHKHZ7upeI+wjB6bQQCGpMx1HcdRd5cnwERXF9oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783004378; c=relaxed/simple;
	bh=TvpB4ituHUE/4G151rVesx7/g7lIOt8ozx/LciKPu58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiB1Td3u4X67wBsUrjsYmUv2RbEAmHVm/21CNSqaRtZ8FYdFH7q8sJTy1IHOFDicAE7VUQ0Gntxb93D2105rEhAHDRCbfSzQIRi5lwtYgNGJrbfd968ZL7Qek5NuWMSpM8NLcb9Go+6Yvy6t5Kd0NDQ37vioYTj1QljqefKp9IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=sQJF5vlo; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="sQJF5vlo"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4grg5T6jKLzX2P;
	Thu,  2 Jul 2026 16:59:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1783004365;
	bh=ECl3lQKgr0XzjfmQWRB2AMBbtcwDvjdjFf1tBBQFAtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sQJF5vloPdRpu5S6AD1mT6MdQj9YC4wiDk/PWN0anDxVTtUTwDjG2EVkJBEkzjpp1
	 jqphKhh8ZQaTAaCJHJkK+UtJ3k0NWBr9Nc1K6df6bWUA3DSvhQIxkSGrMSabcRIqRb
	 C8z03PgHVhqcpO5z/gPtiWnIOc9Bgyib+qGkj3zI=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4grg5S606NzQTK;
	Thu,  2 Jul 2026 16:59:24 +0200 (CEST)
Date: Thu, 2 Jul 2026 16:59:20 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: Bryam Vargas <hexlabsecurity@proton.me>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, linux-security-module@vger.kernel.org, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Paul Moore <paul@paul-moore.com>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] landlock: fix TCP Fast Open connection bypass
Message-ID: <20260702.EiNg0kiph4ew@digikod.net>
References: <c21cf4f3-6c21-4170-b578-13c1bfd48b87@buffet.re>
 <20260701214628.33319-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701214628.33319-1-matthieu@buffet.re>
X-Infomaniak-Routing: alpha

Thanks, applied!

On Wed, Jul 01, 2026 at 11:46:27PM +0200, Matthieu Buffet wrote:
> The documentation of the socket_connect() LSM hook states that it
> controls connecting a socket to a remote address. It has not been the
> case since the addition of TCP Fast Open (RFC 7413) support, which allows
> opening a TCP connection (thus, setting a socket's destination address)
> via the MSG_FASTOPEN flag passed to sendto()/sendmsg()/sendmmsg(). The
> problem then got duplicated into MPTCP.
> 
> Landlock did not take it into account when its TCP support was added,
> leaving a bypass of TCP connect policy.
> 
> Ideally a call to the LSM hook would be added in the fastopen code path,
> in order to fix this generically. But connect() hooks are designed to run
> with the socket locked, unlike sendmsg() hooks.
> 
> Closes: https://github.com/landlock-lsm/linux/issues/41
> Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  security/landlock/net.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index cbff59ec3aba..46c17116fcf4 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -351,6 +351,14 @@ static int hook_socket_sendmsg(struct socket *const sock,
>  	access_mask_t access_request;
>  	int ret = 0;
>  
> +	if ((msg->msg_flags & MSG_FASTOPEN) && address && sk_is_tcp(sock->sk)) {
> +		ret = current_check_access_socket(
> +			sock, address, addrlen, LANDLOCK_ACCESS_NET_CONNECT_TCP,
> +			true);
> +		if (ret != 0)
> +			return ret;
> +	}
> +
>  	if (sk_is_udp(sock->sk))
>  		access_request = LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
>  	else
> -- 
> 2.47.3
> 
> 
