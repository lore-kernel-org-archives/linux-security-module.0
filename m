Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62FA78F2B
	for <linux-security-module@vger.kernel.org>; Fri, 26 Jun 2026 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509710; cv=none; b=kZWtAPnEaNds/nVz4GohgbRBATLHG36XdpDluAz/VCSJOsfePZREO3mTxURXERKU/SGKPg9M296wq6Tdxb9kyidH0KQ3jKspJjq9Va+eiOOedQ7x19qQyoXyqOVKrcfXtij77yo3aOtwB2F4hiZOp9JQRpEPYVVBEBgS6dHuHCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509710; c=relaxed/simple;
	bh=ANWck8WLbRAXZ361J9dhNik1il372xldklrcJQiz0+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhRMQtNxH0EfJdFP/ZKyv+XYvYxbIwQYUskzA1O1SWZqVJ2g9rd56vwDDzUZ2U/t4cYEa7Lx5k6plkwg4/6Z65JciVZFvTZmWWTzypQUfDAfRCxe+h9yk7rW6OVZOgBOVXQWo2L5vUA67tyLYVnJbsfs62ASRwQOtj/F5dSkyu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vy+Tatby; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vy+Tatby"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gn6xQ3cdrzrTS;
	Fri, 26 Jun 2026 22:40:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1782506410;
	bh=+VmxfcqJWx2b/sUIHGbG0OEVcTdIR7OEfECFfcjnP4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vy+TatbysO9/4zv2ZAaEeC3RSyJfmSUEGS58qiVY7kOayCvk25FG0p2n3hCoZj/zT
	 r8bF6GwIcl16dMclkbNGdRf4vt33Gfcnch9q0Fc9+tFNZOEBKSSrDG2wn01QT226k/
	 D/09kwO0Qq6h9ViZq5Kb6DYpf9m9FeNAin24KsGQ=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gn6xP1qnLzRhj;
	Fri, 26 Jun 2026 22:40:09 +0200 (CEST)
Date: Fri, 26 Jun 2026 22:40:04 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: Bryam Vargas <hexlabsecurity@proton.me>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, linux-security-module@vger.kernel.org, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Paul Moore <paul@paul-moore.com>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] landlock: fix TCP Fast Open connection bypass
Message-ID: <20260626.taijohThood1@digikod.net>
References: <20260617.eemahv8ui7Ee@digikod.net>
 <20260617180526.15627-1-matthieu@buffet.re>
 <20260617180526.15627-2-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617180526.15627-2-matthieu@buffet.re>
X-Infomaniak-Routing: alpha

Thanks Matthieu, could you please rebase this serise on the master
branch (especially on top of your UDP changes)?

This patch will be useful for backports though.

On Wed, Jun 17, 2026 at 08:05:23PM +0200, Matthieu Buffet wrote:
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
>  security/landlock/net.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index 4ee4002a8f56..a2375762c18b 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -246,9 +246,26 @@ static int hook_socket_connect(struct socket *const sock,
>  					   access_request);
>  }
>  
> +static int hook_socket_sendmsg(struct socket *const sock,
> +			       struct msghdr *const msg, const int size)
> +{
> +	struct sockaddr *const address = msg->msg_name;
> +	const int addrlen = msg->msg_namelen;
> +
> +	if (sk_is_tcp(sock->sk) && address != NULL &&
> +	    (msg->msg_flags & MSG_FASTOPEN) != 0) {

This might be a bit better:

  if ((msg->msg_flags & MSG_FASTOPEN) && address && sk_is_tcp(sock->sk))

> +		return current_check_access_socket(
> +			sock, address, addrlen,
> +			LANDLOCK_ACCESS_NET_CONNECT_TCP);
> +	}
> +
> +	return 0;
> +}
> +
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(socket_bind, hook_socket_bind),
>  	LSM_HOOK_INIT(socket_connect, hook_socket_connect),
> +	LSM_HOOK_INIT(socket_sendmsg, hook_socket_sendmsg),
>  };
>  
>  __init void landlock_add_net_hooks(void)
> -- 
> 2.47.3
> 
> 
