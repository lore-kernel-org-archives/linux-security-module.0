Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6B6DF76
	for <linux-security-module@vger.kernel.org>; Sun, 28 Dec 2025 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766945757; cv=none; b=SAo9XJFfj2DefrI0y47cHaoj8B7v3yn7eVPbHxF1YdkrN3+QOCoH3hd4y7VY6jOgj0WpTOrs8pnyufSgHP/6BXm0NQJx0bDmhFycMHFfJ420A+AZ3bjT5KBIAg6Kp3NnHYEBP1vxqI+j9ic25k4mjwk0x9x5q4aoVhFggmbrR5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766945757; c=relaxed/simple;
	bh=0cJqk+L8JN3pJrcsFE4Rp6MU5sCW3CScCqDlGZkhHUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJHdnbeIWr5RSBWxkEsxT891cyNhg1jqZAJTikDwDSSz3mOeHeKHfeTR4N4mzMCtqwbunIdAt49vwAM+Xk3+VOLUh9yKJhtrrmIknrEdjxUmhcb/HcUx0jPAbLmSSBL2MTcuvE/UL8cBe9fs9429g7paOpy5d4epYoHGiXQrPEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=esMfLZIa; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="esMfLZIa"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dfSFx1D3BzNBT;
	Sun, 28 Dec 2025 19:15:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1766945748;
	bh=MlDRQw5ipd9OYq5WAQReFZgHV+1QJqC9uJKv8Jh9R6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=esMfLZIaGizL/Vg37nqi5oY2l0FSrNbJZhqN/iuFLT5kExAdHvcl6CXlGnn9nmHLR
	 80nebOb185qSi+60n0twMqcgQauZuA0h2LwD3Sj8sJzQ7wNNmrh1/dR/3aE8xF2Wc0
	 ZR5dYt34w3WtZtx0h8nu32G1wMolfpTjmaxVPS1o=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dfSFv3LgDzKFr;
	Sun, 28 Dec 2025 19:15:47 +0100 (CET)
Date: Sun, 28 Dec 2025 19:15:45 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, linux-security-module@vger.kernel.org, 
	Justin Suess <utilityemal77@gmail.com>
Subject: Re: [PATCH 2/6] landlock: Implement
 LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
Message-ID: <20251228.aeX5Aighashi@digikod.net>
References: <cover.1766925301.git.m@maowtm.org>
 <be315d8ff7544fd91bdb922e8afc7c8154e3594d.1766925301.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be315d8ff7544fd91bdb922e8afc7c8154e3594d.1766925301.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Sun, Dec 28, 2025 at 12:45:41PM +0000, Tingmao Wang wrote:
> Extend the existing abstract UNIX socket scoping to pathname sockets as
> well.  Basically all of the logic is reused between the two types, just
> that pathname sockets scoping are controlled by another bit, and has its
> own audit request type (since the current one is named
> "abstract_unix_socket").
> 
> Closes: https://github.com/landlock-lsm/linux/issues/51
> Signed-off-by: Tingmao Wang <m@maowtm.org>

Great, thanks!

> ---
> 
> There is an argument that there should only really be one audit request
> type for both sockets, since the only difference is whether path= is
> followed by a normal path, or by a hex string starting with 00.  But I'm
> not sure if we can change this at this point, so I have created a new
> request type.

It is the correct approach to add a dedicated request type, which
enables to filter on it, and doesn't have performance impact.

> 
>  security/landlock/audit.c |  4 +++
>  security/landlock/audit.h |  1 +
>  security/landlock/task.c  | 74 ++++++++++++++++++++++++++++++---------
>  3 files changed, 62 insertions(+), 17 deletions(-)

> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index 6dfcc1860d6e..9fbb0ada440b 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c

> +/*
> + * UNIX sockets can have three types of addresses: pathname (a filesystem path),
> + * unnamed (not bound to an address), and abstract (sun_path[0] is '\0').
> + * Unnamed sockets include those created with socketpair() and unbound sockets.
> + * We do not restrict unnamed sockets since they have no address to identify.
> + */
>  static int hook_unix_stream_connect(struct sock *const sock,
>  				    struct sock *const other,
>  				    struct sock *const newsk)
>  {
>  	size_t handle_layer;
> +	access_mask_t scope;
> +	enum landlock_request_type request_type;
>  	const struct landlock_cred_security *const subject =
>  		landlock_get_applicable_subject(current_cred(), unix_scope,
>  						&handle_layer);
> +	const struct unix_address *addr;
>  
>  	/* Quick return for non-landlocked tasks. */
>  	if (!subject)
>  		return 0;
>  


> -	if (!is_abstract_socket(other))
> +	addr = unix_sk(other)->addr;
> +	/* Unnamed sockets are not restricted. */
> +	if (!addr)
>  		return 0;
>  
> -	if (!sock_is_scoped(other, subject->domain))
> +	if (sock_addr_is_abstract(addr)) {
> +		scope = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
> +		request_type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET;
> +	} else {
> +		/* Pathname socket. */
> +		scope = LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET;
> +		request_type = LANDLOCK_REQUEST_SCOPE_PATHNAME_UNIX_SOCKET;
> +	}
> +
> +	if (!sock_is_scoped(other, subject->domain, scope))
>  		return 0;

We should be able to factor out this hunk for both hooks, and then also
fold is_abstract_socket() in this new helper.

>  
>  	landlock_log_denial(subject, &(struct landlock_request) {
> -		.type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
> +		.type = request_type,
>  		.audit = {
>  			.type = LSM_AUDIT_DATA_NET,
>  			.u.net = &(struct lsm_network_audit) {
> @@ -299,9 +326,12 @@ static int hook_unix_may_send(struct socket *const sock,
>  			      struct socket *const other)
>  {
>  	size_t handle_layer;
> +	access_mask_t scope;
> +	enum landlock_request_type request_type;
>  	const struct landlock_cred_security *const subject =
>  		landlock_get_applicable_subject(current_cred(), unix_scope,
>  						&handle_layer);
> +	const struct unix_address *addr;
>  
>  	if (!subject)
>  		return 0;
> @@ -313,14 +343,24 @@ static int hook_unix_may_send(struct socket *const sock,
>  	if (unix_peer(sock->sk) == other->sk)
>  		return 0;
>  
> -	if (!is_abstract_socket(other->sk))
> +	addr = unix_sk(other->sk)->addr;
> +	/* Unnamed sockets are not restricted. */
> +	if (!addr)
>  		return 0;
>  
> -	if (!sock_is_scoped(other->sk, subject->domain))
> +	if (sock_addr_is_abstract(addr)) {
> +		scope = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
> +		request_type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET;
> +	} else {
> +		scope = LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET;
> +		request_type = LANDLOCK_REQUEST_SCOPE_PATHNAME_UNIX_SOCKET;
> +	}
> +
> +	if (!sock_is_scoped(other->sk, subject->domain, scope))
>  		return 0;
>  
>  	landlock_log_denial(subject, &(struct landlock_request) {
> -		.type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
> +		.type = request_type,
>  		.audit = {
>  			.type = LSM_AUDIT_DATA_NET,
>  			.u.net = &(struct lsm_network_audit) {
> -- 
> 2.52.0
> 
