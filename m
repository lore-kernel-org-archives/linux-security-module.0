Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F4819D897
	for <linux-security-module@vger.kernel.org>; Tue, 16 Jul 2024 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140682; cv=none; b=GiZplf/yOlBwNb0TVD6iJs5wDzRUL0+DpCv3NgsX905RK3GBZrle0uPMPG4swZF/m04xRgGLl5R0Uy9kh7myOq2s3G2Z8aBTDNabtV3vpxMFAgE9Yg8472WstiivKFDfmnJYK+8aGsFzaInEtQ94Uc5FEtveR+u7lARHX1hI5vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140682; c=relaxed/simple;
	bh=LioEcFHEgf0jKt9ArwCwBpWqli8Isc8EkIa6Vp+UnII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0W/hw9rNt5UXH/kUg1ts4pHICPt7RTAdKC5tRtxrJLflCLpVkexhYy2L4RDH5OrmDycs0indA7V+4NGHX4cXkyTz2TFlHhvlQRRm+NW3bsdWo72eLedmS7Ff5Pc0SaL9rW/MmQOUweRUwhcJyRecDXxgJ7tOtwfkg+BWOxlt3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=TNac3cAw; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="TNac3cAw"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WNhW246PjzlcH;
	Tue, 16 Jul 2024 16:37:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721140670;
	bh=qynRMZcAUvCoePX2iuk2j7/6DeSNHVVQ88NDNcTQgIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TNac3cAwuEvMLIhViMslI6Pr8c5kjZOjAsLcYFT5060oMVgqhFn/+xlyyxDcyBimg
	 1vRIZ0f3U+42NcVjUTyAgmlipgWHlENa7Em4O+CHXGZepBfbT+8LlGBuwnAwkf51n8
	 3a9Ty7InT/9Rw+0vQHmIryLjNRnAT36vJNxLY60c=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WNhW20VP3z6jT;
	Tue, 16 Jul 2024 16:37:50 +0200 (CEST)
Date: Tue, 16 Jul 2024 16:37:48 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Alejandro Colomar <alx@kernel.org>
Subject: Re: [PATCH] landlock: Various documentation improvements
Message-ID: <20240716.pu0fei6Aix6o@digikod.net>
References: <20240715160328.2792835-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240715160328.2792835-2-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Mon, Jul 15, 2024 at 04:03:29PM +0000, Günther Noack wrote:
> * Fix some typos, incomplete or confusing phrases.
> * Split paragraphs where appropriate.
> * List the same error code multiple times,
>   if it has multiple possible causes.
> * Bring wording closer to the man page wording,
>   which has undergone more thorough review
>   (esp. for LANDLOCK_ACCESS_FS_WRITE_FILE).
> * Small semantic clarifications
>   * Call the ephemeral port range "ephemeral"
>   * Clarify reasons for EFAULT in landlock_add_rule()
>   * Clarify @rule_type doc for landlock_add_rule()
> 
> This is a collection of small fixes which I collected when preparing the
> corresponding man pages (see link below).
> 
> Link: https://lore.kernel.org/all/20240715155554.2791018-1-gnoack@google.com/
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Cc: Mickaël Salaün <mic@digikod.net>
> Cc: Alejandro Colomar <alx@kernel.org>
> Signed-off-by: Günther Noack <gnoack@google.com>

Thanks, applied!

> ---
>  include/uapi/linux/landlock.h | 27 ++++++++++++++-------------
>  security/landlock/syscalls.c  | 17 +++++++++--------
>  2 files changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index e76186da3260..2c8dbc74b955 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -104,20 +104,21 @@ struct landlock_path_beneath_attr {
>   */
>  struct landlock_net_port_attr {
>  	/**
> -	 * @allowed_access: Bitmask of allowed access network for a port
> +	 * @allowed_access: Bitmask of allowed network actions for a port
>  	 * (cf. `Network flags`_).
>  	 */
>  	__u64 allowed_access;
>  	/**
>  	 * @port: Network port in host endianness.
>  	 *
> -	 * It should be noted that port 0 passed to :manpage:`bind(2)` will
> -	 * bind to an available port from a specific port range. This can be
> -	 * configured thanks to the ``/proc/sys/net/ipv4/ip_local_port_range``
> -	 * sysctl (also used for IPv6). A Landlock rule with port 0 and the
> -	 * ``LANDLOCK_ACCESS_NET_BIND_TCP`` right means that requesting to bind
> -	 * on port 0 is allowed and it will automatically translate to binding
> -	 * on the related port range.
> +	 * It should be noted that port 0 passed to :manpage:`bind(2)` will bind
> +	 * to an available port from the ephemeral port range.  This can be
> +	 * configured with the ``/proc/sys/net/ipv4/ip_local_port_range`` sysctl
> +	 * (also used for IPv6).
> +	 *
> +	 * A Landlock rule with port 0 and the ``LANDLOCK_ACCESS_NET_BIND_TCP``
> +	 * right means that requesting to bind on port 0 is allowed and it will
> +	 * automatically translate to binding on the related port range.
>  	 */
>  	__u64 port;
>  };
> @@ -138,10 +139,10 @@ struct landlock_net_port_attr {
>   * The following access rights apply only to files:
>   *
>   * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
> - * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access. Note that
> - *   you might additionally need the %LANDLOCK_ACCESS_FS_TRUNCATE right in order
> - *   to overwrite files with :manpage:`open(2)` using ``O_TRUNC`` or
> - *   :manpage:`creat(2)`.
> + * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access.  When
> + *   opening files for writing, you will often additionally need the
> + *   %LANDLOCK_ACCESS_FS_TRUNCATE right.  In many cases, these system calls
> + *   truncate existing files when overwriting them (e.g., :manpage:`creat(2)`).
>   * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
>   * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file with :manpage:`truncate(2)`,
>   *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` with
> @@ -263,7 +264,7 @@ struct landlock_net_port_attr {
>   * These flags enable to restrict a sandboxed process to a set of network
>   * actions. This is supported since the Landlock ABI version 4.
>   *
> - * TCP sockets with allowed actions:
> + * The following access rights apply to TCP port numbers:
>   *
>   * - %LANDLOCK_ACCESS_NET_BIND_TCP: Bind a TCP socket to a local port.
>   * - %LANDLOCK_ACCESS_NET_CONNECT_TCP: Connect an active TCP socket to
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 03b470f5a85a..352c34b327d3 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -378,8 +378,7 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
>   *		with the new rule.
>   * @rule_type: Identify the structure type pointed to by @rule_attr:
>   *             %LANDLOCK_RULE_PATH_BENEATH or %LANDLOCK_RULE_NET_PORT.
> - * @rule_attr: Pointer to a rule (only of type &struct
> - *             landlock_path_beneath_attr for now).
> + * @rule_attr: Pointer to a rule (matching the @rule_type).
>   * @flags: Must be 0.
>   *
>   * This system call enables to define a new rule and add it to an existing
> @@ -390,18 +389,20 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
>   * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
>   * - %EAFNOSUPPORT: @rule_type is %LANDLOCK_RULE_NET_PORT but TCP/IP is not
>   *   supported by the running kernel;
> - * - %EINVAL: @flags is not 0, or inconsistent access in the rule (i.e.
> + * - %EINVAL: @flags is not 0;
> + * - %EINVAL: The rule accesses are inconsistent (i.e.
>   *   &landlock_path_beneath_attr.allowed_access or
> - *   &landlock_net_port_attr.allowed_access is not a subset of the
> - *   ruleset handled accesses), or &landlock_net_port_attr.port is
> - *   greater than 65535;
> - * - %ENOMSG: Empty accesses (e.g. &landlock_path_beneath_attr.allowed_access);
> + *   &landlock_net_port_attr.allowed_access is not a subset of the ruleset
> + *   handled accesses)
> + * - %EINVAL: &landlock_net_port_attr.port is greater than 65535;
> + * - %ENOMSG: Empty accesses (e.g. &landlock_path_beneath_attr.allowed_access is
> +      0);
>   * - %EBADF: @ruleset_fd is not a file descriptor for the current thread, or a
>   *   member of @rule_attr is not a file descriptor as expected;
>   * - %EBADFD: @ruleset_fd is not a ruleset file descriptor, or a member of
>   *   @rule_attr is not the expected file descriptor type;
>   * - %EPERM: @ruleset_fd has no write access to the underlying ruleset;
> - * - %EFAULT: @rule_attr inconsistency.
> + * - %EFAULT: @rule_attr was not a valid address.
>   */
>  SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
>  		const enum landlock_rule_type, rule_type,
> -- 
> 2.45.2.993.g49e7a77208-goog
> 
> 
