Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C9E2505A3
	for <linux-security-module@vger.kernel.org>; Wed,  5 Mar 2025 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199416; cv=none; b=i8ro2MqNXVuis28rDzrpVqcAEKxxtJiJWJxXHICjfO2TyipKC1SFgD34KWSuJtWX7TOTovzIGKb78+JZWkK3dR9jU+IFsBxNjAaDBgxrWGTpnYeXKYy6b97U7BDnFt3bzBULPH6dMnYsxYUkkbvh+XggcRSLKrqqu5jt3OjWTbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199416; c=relaxed/simple;
	bh=wLWi5c/ZwmzHO4JFeetW+eKnSYxSIZ97PQhJRU4XN/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1uzl4+aenbuG3kOmERUfPtqzTrBdTN+EJAEZPtgtnGUA/cIiGu0oW5FtLriXtFafsbPvsC1sx+TSCqEAEXwI0f+IAUe/A1NqZ8HORqdtDnPPu1L0N0QlbJJ17triOWGJapwbgAqBhJLaZnE9JoVYZYfUFDwS8x5Yd56Lw6l5wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=IeZk+fHP; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="IeZk+fHP"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z7Lgy2yM0zfwC;
	Wed,  5 Mar 2025 19:30:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741199406;
	bh=Nxj9GUL1zS/L4XDk/1D1kbsX3zE4FiRZ7+zcpnCjOTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IeZk+fHPcbRUMGz874J9GHHLwgWVRWWr1YG05pPYAGRz1+KgEbfCOQNqZ7VBFEBGh
	 xW8TDrnS8ZZU5/wp4UPMxopjVDxpC91RK9ziALFYS6dKSZbsQxnXL2aN8tSIYJD1TP
	 MViJRaZFCI+jXU9JYtBEIzRBSa8Tzt2bH2B7MjxU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z7Lgx4k1zz9xC;
	Wed,  5 Mar 2025 19:30:05 +0100 (CET)
Date: Wed, 5 Mar 2025 19:30:04 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>, 
	Alejandro Colomar <alx@kernel.org>, Tanya Agarwal <tanyaagarwal25699@gmail.com>, 
	linux-security-module@vger.kernel.org, Daniel Burgener <dburgener@linux.microsoft.com>
Subject: Re: [PATCH v3 1/1] landlock: Clarify IPC scoping documentation
Message-ID: <20250305.hahLai5hahku@digikod.net>
References: <20250303194510.135506-2-gnoack@google.com>
 <20250303194510.135506-4-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303194510.135506-4-gnoack@google.com>
X-Infomaniak-Routing: alpha

Thanks! Applied.

On Mon, Mar 03, 2025 at 08:45:12PM +0100, Günther Noack wrote:
> * Clarify terminology
> * Stop mixing the unix(7) and signal(7) aspects in the explanation.
> 
> Terminology:
> 
> * The *IPC Scope* of a Landlock domain is that Landlock domain and its
>   nested domains.
> * An *operation* (e.g., signaling, connecting to abstract UDS) is said to
>   be *scoped within a domain* when the flag for that operation was set at
>   ruleset creation time.  This means that for the purpose of this
>   operation, only processes within the domain's IPC scope are reachable.
> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  Documentation/userspace-api/landlock.rst | 45 ++++++++++++------------
>  1 file changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index ad587f53fe41..4832b16deedb 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -317,33 +317,32 @@ IPC scoping
>  -----------
>  
>  Similar to the implicit `Ptrace restrictions`_, we may want to further restrict
> -interactions between sandboxes. Each Landlock domain can be explicitly scoped
> -for a set of actions by specifying it on a ruleset.  For example, if a
> -sandboxed process should not be able to :manpage:`connect(2)` to a
> -non-sandboxed process through abstract :manpage:`unix(7)` sockets, we can
> -specify such a restriction with ``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``.
> -Moreover, if a sandboxed process should not be able to send a signal to a
> -non-sandboxed process, we can specify this restriction with
> -``LANDLOCK_SCOPE_SIGNAL``.
> +interactions between sandboxes.  Therefore, at ruleset creation time, each
> +Landlock domain can restrict the scope for certain operations, so that these
> +operations can only reach out to processes within the same Landlock domain or in
> +a nested Landlock domain (the "scope").
>  
> -A sandboxed process can connect to a non-sandboxed process when its domain is
> -not scoped. If a process's domain is scoped, it can only connect to sockets
> -created by processes in the same scope.
> -Moreover, if a process is scoped to send signal to a non-scoped process, it can
> -only send signals to processes in the same scope.
> +The operations which can be scoped are:
>  
> -A connected datagram socket behaves like a stream socket when its domain is
> -scoped, meaning if the domain is scoped after the socket is connected, it can
> -still :manpage:`send(2)` data just like a stream socket.  However, in the same
> -scenario, a non-connected datagram socket cannot send data (with
> -:manpage:`sendto(2)`) outside its scope.
> +``LANDLOCK_SCOPE_SIGNAL``
> +    This limits the sending of signals to target processes which run within the
> +    same or a nested Landlock domain.
>  
> -A process with a scoped domain can inherit a socket created by a non-scoped
> -process. The process cannot connect to this socket since it has a scoped
> -domain.
> +``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``
> +    This limits the set of abstract :manpage:`unix(7)` sockets to which we can
> +    :manpage:`connect(2)` to socket addresses which were created by a process in
> +    the same or a nested Landlock domain.
>  
> -IPC scoping does not support exceptions, so if a domain is scoped, no rules can
> -be added to allow access to resources or processes outside of the scope.
> +    A :manpage:`sendto(2)` on a non-connected datagram socket is treated as if
> +    it were doing an implicit :manpage:`connect(2)` and will be blocked if the
> +    remote end does not stem from the same or a nested Landlock domain.
> +
> +    A :manpage:`sendto(2)` on a socket which was previously connected will not
> +    be restricted.  This works for both datagram and stream sockets.
> +
> +IPC scoping does not support exceptions via :manpage:`landlock_add_rule(2)`.
> +If an operation is scoped within a domain, no rules can be added to allow access
> +to resources or processes outside of the scope.
>  
>  Truncating files
>  ----------------
> -- 
> 2.48.1.711.g2feabab25a-goog
> 
> 
