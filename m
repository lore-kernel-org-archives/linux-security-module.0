Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E50E314D17
	for <linux-security-module@vger.kernel.org>; Thu, 29 Jan 2026 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769723223; cv=none; b=XOo5UznUw4G+bjAcbzljSD31mPU8rZEUCCLgzcCwUHOh0mAjoAc3+3TdofJNd5wiOuZFGHuJaGaEgyPynpjdnfbUFiXQWp9u4Uo/uV38c5tzXrY8iDlw/181JqIXZBOmR7QVaYdwM8N1e7xKgOeITNShoTgfWQ0BDvAofxNFmAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769723223; c=relaxed/simple;
	bh=dSXYHrwHroAarAJKnKVPvXXj5UN/7ZF+2KgIb3iLzVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ru4chHtuR2h2Prx2NATtrhMrFAeKcG6hPc/qMPOftCR5w+iQwWGuI1Wr0o5bqlskFtX9RX2V7yR3QhkSn3cZ7v5ANyFANU+f61vYpE/x7pz25cmTzDXm1HOocwcM6IcPmU5u4A8V4RL3I7I6U/M1lP6goVTRPyUcyNZkoI1yEuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=xSEu740h; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="xSEu740h"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f2C0Q62CdzjKy;
	Thu, 29 Jan 2026 22:27:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1769722054;
	bh=OPoVRGlEg8/GxtBQjVri+hG2DCjE1B7pQ+kkPMKIQt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xSEu740h+Zc1nenj3UeY00KP8AtjVNpfD2gpEf6RXOfzFEkr9yJkNwq5GNlpiAKPJ
	 jC2SM4GvyitsUyTSk4F6HBGpPj5m4RtPTV2D/Tozz7HP9iF54HmPsi3tnXNfOQyDh1
	 8V4eVdaPM1iLQyXWNato3/APpcmrmxQYkALeKliU=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f2C0Q1zkfzd0k;
	Thu, 29 Jan 2026 22:27:34 +0100 (CET)
Date: Thu, 29 Jan 2026 22:27:33 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Justin Suess <utilityemal77@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 2/6] landlock: Implement
 LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
Message-ID: <20260129.iCah3fash9ch@digikod.net>
References: <cover.1767115163.git.m@maowtm.org>
 <a6d6479888d9d216a3f2e7bb133523f856f92461.1767115163.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6d6479888d9d216a3f2e7bb133523f856f92461.1767115163.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Tue, Dec 30, 2025 at 05:20:20PM +0000, Tingmao Wang wrote:
> Extend the existing abstract UNIX socket scoping to pathname sockets as
> well.  Basically all of the logic is reused between the two types, just
> that pathname sockets scoping are controlled by another bit, and has its
> own audit request type (since the current one is named
> "abstract_unix_socket").
> 
> Closes: https://github.com/landlock-lsm/linux/issues/51
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
> 
> Changes in v2:
> - Factor out common code in hook_unix_stream_connect and
>   hook_unix_may_send into check_socket_access(), and inline
>   is_abstract_socket().
> 
>  security/landlock/audit.c |   4 ++
>  security/landlock/audit.h |   1 +
>  security/landlock/task.c  | 109 ++++++++++++++++++++++----------------
>  3 files changed, 67 insertions(+), 47 deletions(-)
> 
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index e899995f1fd5..0626cc553ab0 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -75,6 +75,10 @@ get_blocker(const enum landlock_request_type type,
>  		WARN_ON_ONCE(access_bit != -1);
>  		return "scope.abstract_unix_socket";
>  
> +	case LANDLOCK_REQUEST_SCOPE_PATHNAME_UNIX_SOCKET:
> +		WARN_ON_ONCE(access_bit != -1);
> +		return "scope.pathname_unix_socket";
> +
>  	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
>  		WARN_ON_ONCE(access_bit != -1);
>  		return "scope.signal";
> diff --git a/security/landlock/audit.h b/security/landlock/audit.h
> index 92428b7fc4d8..1c9ce8588102 100644
> --- a/security/landlock/audit.h
> +++ b/security/landlock/audit.h
> @@ -21,6 +21,7 @@ enum landlock_request_type {
>  	LANDLOCK_REQUEST_NET_ACCESS,
>  	LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
>  	LANDLOCK_REQUEST_SCOPE_SIGNAL,
> +	LANDLOCK_REQUEST_SCOPE_PATHNAME_UNIX_SOCKET,
>  };
>  
>  /*
> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index 833bc0cfe5c9..10dc356baf6f 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c
> @@ -232,35 +232,81 @@ static bool domain_is_scoped(const struct landlock_ruleset *const client,
>  	return false;
>  }
>  
> +/**
> + * sock_is_scoped - Check if socket connect or send should be restricted
> + *    based on scope controls.
> + *
> + * @other: The server socket.
> + * @domain: The client domain.
> + * @scope: The relevant scope bit to check (i.e. pathname or abstract).
> + *
> + * Returns: True if connect should be restricted, false otherwise.
> + */
>  static bool sock_is_scoped(struct sock *const other,
> -			   const struct landlock_ruleset *const domain)
> +			   const struct landlock_ruleset *const domain,
> +			   access_mask_t scope)
>  {
>  	const struct landlock_ruleset *dom_other;
>  
>  	/* The credentials will not change. */
>  	lockdep_assert_held(&unix_sk(other)->lock);
>  	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
> -	return domain_is_scoped(domain, dom_other,
> -				LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
> +	return domain_is_scoped(domain, dom_other, scope);
>  }
>  
> -static bool is_abstract_socket(struct sock *const sock)
> +/* Allow us to quickly test if the current domain scopes any form of socket */

Missing final dot.

> +static const struct access_masks unix_scope = {
> +	.scope = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
> +		 LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET,
> +};
> +
> +/*
> + * UNIX sockets can have three types of addresses: pathname (a filesystem path),
> + * unnamed (not bound to an address), and abstract (sun_path[0] is '\0').
> + * Unnamed sockets include those created with socketpair() and unbound sockets.
> + * We do not restrict unnamed sockets since they have no address to identify.

Not because they have no address but because they cannot be used to
reach a new peer, right?

> + */
> +static int
> +check_socket_access(struct sock *const other,
> +		    const struct landlock_cred_security *const subject,
> +		    const size_t handle_layer)
>  {
> -	struct unix_address *addr = unix_sk(sock)->addr;
> +	const struct unix_address *addr = unix_sk(other)->addr;
> +	access_mask_t scope;
> +	enum landlock_request_type request_type;
>  
> +	/* Unnamed sockets are not restricted. */
>  	if (!addr)
> -		return false;
> +		return 0;
>  
> +	/*
> +	 * Abstract and pathname Unix sockets have separate scope and audit

UNIX

> +	 * request type.
> +	 */
>  	if (addr->len >= offsetof(struct sockaddr_un, sun_path) + 1 &&
> -	    addr->name->sun_path[0] == '\0')
> -		return true;
> +	    addr->name->sun_path[0] == '\0') {
> +		scope = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
> +		request_type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET;
> +	} else {
> +		scope = LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET;
> +		request_type = LANDLOCK_REQUEST_SCOPE_PATHNAME_UNIX_SOCKET;
> +	}
>  
> -	return false;
> -}
> +	if (!sock_is_scoped(other, subject->domain, scope))
> +		return 0;
>  
> -static const struct access_masks unix_scope = {
> -	.scope = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
> -};
> +	landlock_log_denial(subject, &(struct landlock_request) {
> +		.type = request_type,
> +		.audit = {
> +			.type = LSM_AUDIT_DATA_NET,
> +			.u.net = &(struct lsm_network_audit) {
> +				.sk = other,
> +			},
> +		},
> +		.layer_plus_one = handle_layer + 1,
> +	});
> +	return -EPERM;
> +}
>  
>  static int hook_unix_stream_connect(struct sock *const sock,
>  				    struct sock *const other,
> @@ -275,23 +321,7 @@ static int hook_unix_stream_connect(struct sock *const sock,
>  	if (!subject)
>  		return 0;
>  
> -	if (!is_abstract_socket(other))
> -		return 0;
> -
> -	if (!sock_is_scoped(other, subject->domain))
> -		return 0;
> -
> -	landlock_log_denial(subject, &(struct landlock_request) {
> -		.type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
> -		.audit = {
> -			.type = LSM_AUDIT_DATA_NET,
> -			.u.net = &(struct lsm_network_audit) {
> -				.sk = other,
> -			},
> -		},
> -		.layer_plus_one = handle_layer + 1,
> -	});
> -	return -EPERM;
> +	return check_socket_access(other, subject, handle_layer);
>  }
>  
>  static int hook_unix_may_send(struct socket *const sock,
> @@ -302,6 +332,7 @@ static int hook_unix_may_send(struct socket *const sock,
>  		landlock_get_applicable_subject(current_cred(), unix_scope,
>  						&handle_layer);
>  
> +	/* Quick return for non-landlocked tasks. */
>  	if (!subject)
>  		return 0;
>  
> @@ -312,23 +343,7 @@ static int hook_unix_may_send(struct socket *const sock,
>  	if (unix_peer(sock->sk) == other->sk)
>  		return 0;
>  
> -	if (!is_abstract_socket(other->sk))
> -		return 0;
> -
> -	if (!sock_is_scoped(other->sk, subject->domain))
> -		return 0;
> -
> -	landlock_log_denial(subject, &(struct landlock_request) {
> -		.type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
> -		.audit = {
> -			.type = LSM_AUDIT_DATA_NET,
> -			.u.net = &(struct lsm_network_audit) {
> -				.sk = other->sk,
> -			},
> -		},
> -		.layer_plus_one = handle_layer + 1,
> -	});
> -	return -EPERM;
> +	return check_socket_access(other->sk, subject, handle_layer);
>  }
>  
>  static const struct access_masks signal_scope = {
> -- 
> 2.52.0
> 
