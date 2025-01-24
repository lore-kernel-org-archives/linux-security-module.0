Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8D615623A
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jan 2025 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734342; cv=none; b=FeOBa1wR4Co885IUB1yROE/9O+f6I7Gg7o+fPJ8n+pOwie9gSDQFydceluwzmJdWnbTJ0DJ/A8hhXFV6Lf0d7RKdcitoP6IaovM1Pk5Ru9H5uMXsBcbmzLxVyY10YwSYhIY5Qrm9LuGx/DfA6BEv87sGHTVIm8l4b8cNXowZI34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734342; c=relaxed/simple;
	bh=IYeE0sfSviNaVOVE61gM2ZZ2ygSrM0ssE85qVGnpVkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdmSCSG2QOKr33Cno6fVcxJLMnjDV9y+x4Kr0lpMahHPIweQrhFLr1T3fiWG0OeF1vL2qRdK5CAlE9g1JrtLDSv182zKcBzZjGwTxTDNQtAINYe7iGeaQgJ7idQgV0O5JBqCo80rB8YB9c8C3xQr29TC1g7G67s7sWkWnYyTgD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QCJw2ms7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QCJw2ms7"
Received: from [192.168.1.13] (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id 532D3210D0C1;
	Fri, 24 Jan 2025 07:59:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 532D3210D0C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737734340;
	bh=jonuxcHXeZaS2wc9aXWqOgA6pI+/a6iRsFuCvLcldKw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QCJw2ms74CmHAg2iSiqH1XecNJOMz4PVX/8JzTu4nu0KHmu8xaWpftn0d1nugwwia
	 Q3Uxf90nL+3TAehEfQTqrUBmGb4FzpEWr/x87Zb9AIJxNrba8KNjYljVJBpd3hcVPm
	 s6As27/nBk33Nd5AgOU/QjpH0H+Q6cJ/aBk+vGmA=
Message-ID: <976783c4-408d-4758-a864-f75d959ffd90@linux.microsoft.com>
Date: Fri, 24 Jan 2025 10:58:59 -0500
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] landlock: Clarify IPC scoping documentation
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Tahera Fahimi <fahimitahera@gmail.com>,
 Tanya Agarwal <tanyaagarwal25699@gmail.com>
References: <20250124154445.162841-1-gnoack@google.com>
 <20250124154445.162841-2-gnoack@google.com>
Content-Language: en-US
From: Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20250124154445.162841-2-gnoack@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/24/2025 10:44 AM, Günther Noack wrote:
> * Clarify terminology
> * Stop mixing the unix(7) and signal(7) aspects in the explanation.
> 
> Terminology:
> 
> * The *IPC Scope* of a Landlock domain is that Landlock domain and its
>    nested domains.
> * An *operation* (e.g., signaling, connecting to abstract UDS) is said
>    *to be scoped within a domain* when the flag for that operation was
>    *set at ruleset creation time.  This means that for the purpose of
>    *this operation, only processes within the domain's IPC scope are
>    *reachable.
> 
> Cc: Mickaël Salaün <mic@digikod.net>
> Cc: Tahera Fahimi <fahimitahera@gmail.com>
> Cc: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>   Documentation/userspace-api/landlock.rst | 53 ++++++++++++------------
>   1 file changed, 26 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index ca8b325d53e5..6b80106d33de 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -317,33 +317,32 @@ IPC scoping
>   -----------
>   
>   Similar to the implicit `Ptrace restrictions`_, we may want to further restrict
> -interactions between sandboxes. Each Landlock domain can be explicitly scoped
> -for a set of actions by specifying it on a ruleset.  For example, if a
> -sandboxed process should not be able to :manpage:`connect(2)` to a
> -non-sandboxed process through abstract :manpage:`unix(7)` sockets, we can
> -specify such a restriction with ``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``.
> -Moreover, if a sandboxed process should not be able to send a signal to a
> -non-sandboxed process, we can specify this restriction with
> -``LANDLOCK_SCOPE_SIGNAL``.
> -
> -A sandboxed process can connect to a non-sandboxed process when its domain is
> -not scoped. If a process's domain is scoped, it can only connect to sockets
> -created by processes in the same scope.
> -Moreover, if a process is scoped to send signal to a non-scoped process, it can
> -only send signals to processes in the same scope.
> -
> -A connected datagram socket behaves like a stream socket when its domain is
> -scoped, meaning if the domain is scoped after the socket is connected, it can
> -still :manpage:`send(2)` data just like a stream socket.  However, in the same
> -scenario, a non-connected datagram socket cannot send data (with
> -:manpage:`sendto(2)`) outside its scope.
> -
> -A process with a scoped domain can inherit a socket created by a non-scoped
> -process. The process cannot connect to this socket since it has a scoped
> -domain.
> -
> -IPC scoping does not support exceptions, so if a domain is scoped, no rules can
> -be added to allow access to resources or processes outside of the scope.
> +interactions between sandboxes.  Therefore, at ruleset creation time, each
> +Landlock domain can restrict the scope for certain operations, so that these
> +operations can only reach out to processes within the same Landlock domain or in
> +a nested Landlock domain (the "scope").
> +
> +The operations which can be scoped are:
> +
> +``LANDLOCK_SCOPE_SIGNAL``
> +    When set, this limits the sending of signals to target processes which run
> +    within the same or a nested Landlock domain.
> +
> +``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``
> +    When set, this limits the set of abstract :manpage:`unix(7)` sockets we can
> +    :manpage:`connect(2)` to to socket addresses which were created by a process

The "to to" takes a couple of reads to parse.  Would "...this limits the 
set of abstract :manpage:`unix(7)` sockets to which we can 
:manpage:`connect(2)` to socket addresses which were..." perhaps be 
easier to read?

> +    in the same or a nested Landlock domain.
> +
> +    A :manpage:`send(2)` on a non-connected datagram socket is treated like an
> +    implicit :manpage:`connect(2)` and will be blocked when the remote end does
> +    not stem from the same or a nested Landlock domain.
> +
> +    A :manpage:`send(2)` on a socket which was previously connected will work.

Maybe overly pedantic, but I wonder if something like "will not be 
restricted" instead of "will work" would be clearer?  "Work" just has a 
lot of meanings.  I don't think it's actually ambiguous as written, I 
just think that a more precise word could avoid the potential for confusion.

-Daniel

> +    This works for both datagram and stream sockets.
> +
> +IPC scoping does not support exceptions via :manpage:`landlock_add_rule(2)`.
> +If an operation is scoped within a domain, no rules can be added to allow access
> +to resources or processes outside of the scope.
>   
>   Truncating files
>   ----------------

