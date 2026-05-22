Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2911027AC31
	for <linux-security-module@vger.kernel.org>; Fri, 22 May 2026 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484283; cv=none; b=LcpksOfmmJo4VH+Ix10CEJ7Y36Cu4G/oVS7PBIaUv9/7mU7gX1azealIpuIxde5/Ox4SxqvOQehCgrlqPZ2VtZAIlInk35ZwXpdRCljtrBQGMXshNkErup10QhS3s3CLgAx1zBNDasK6A9wFEUxMHtGjM8+gjM5rm4tOFWHVCkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484283; c=relaxed/simple;
	bh=h2GFs1INwVAMS2sqRnj9t3IUItHFsf2ChtRROEDhMw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXcWtQcQ+sbFRcWYydx7y8746BnjnlIyaBCkFSiLwRpV4sKB3MK8AdlsfwQevAYKOR+9UQ0JbwVqjTwk7IP1CD/Gurxvv/EMx4jWhPEXC9p+wBv8vb6Zm/QzEWmn2KezUp5+jiVO/tIxOZ1SCTN0n7tVZOJJejw6irZUEXbcJaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=saTeML+n; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="saTeML+n"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gMdHP3bnJz9RW;
	Fri, 22 May 2026 23:11:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1779484273;
	bh=FwPqpug3mhni2511ExYt2r69AMlAupYN5pc73wELsto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=saTeML+nuZCuAyauazFcabFoMzaeykq4Qd4aOnXSEMOjb4LIOkDZ3TfN8NXU1M9G7
	 2sG5TH+n3fVq2+v2six5/7P+qpLzPV8ZGsHwpu3EqPNsTexpKoUvnbx8ILn5uLCJkq
	 dbu5285sJ02D2i+iB+HcsU4gqe5GAmqTFEwC/sw8=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gMdHN58qdzmTp;
	Fri, 22 May 2026 23:11:12 +0200 (CEST)
Date: Fri, 22 May 2026 23:11:11 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Tingmao Wang <m@maowtm.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 7/7] landlock: Add documentation for UDP support
Message-ID: <20260522.ieng0AeLahx1@digikod.net>
References: <20260502124306.3975990-1-matthieu@buffet.re>
 <20260502124306.3975990-8-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260502124306.3975990-8-matthieu@buffet.re>
X-Infomaniak-Routing: alpha

On Sat, May 02, 2026 at 02:43:06PM +0200, Matthieu Buffet wrote:
> Add example of UDP usage, without detailing the two access right.
> Slightly change the example used in code blocks: build a ruleset for a
> DNS client, so that it uses both TCP and UDP.
> 
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  Documentation/userspace-api/landlock.rst | 89 ++++++++++++++++++------
>  1 file changed, 68 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index fd8b78c31f2f..9d5da9896628 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -40,8 +40,8 @@ Filesystem rules
>      and the related filesystem actions are defined with
>      `filesystem access rights`.
>  
> -Network rules (since ABI v4)
> -    For these rules, the object is a TCP port,
> +Network rules (since ABI v4 for TCP and v10 for UDP)
> +    For these rules, the object is a TCP or UDP port,
>      and the related actions are defined with `network access rights`.
>  
>  Defining and enforcing a security policy
> @@ -49,11 +49,11 @@ Defining and enforcing a security policy
>  
>  We first need to define the ruleset that will contain our rules.
>  
> -For this example, the ruleset will contain rules that only allow filesystem
> -read actions and establish a specific TCP connection. Filesystem write
> -actions and other TCP actions will be denied.
> +For this example, the ruleset will contain rules that only allow some
> +filesystem read actions and some specific UDP and TCP actions. Filesystem
> +write actions and other TCP/UDP actions will be denied.
>  
> -The ruleset then needs to handle both these kinds of actions.  This is
> +The ruleset then needs to handle all these kinds of actions.  This is
>  required for backward and forward compatibility (i.e. the kernel and user
>  space may not know each other's supported restrictions), hence the need
>  to be explicit about the denied-by-default access rights.
> @@ -81,7 +81,9 @@ to be explicit about the denied-by-default access rights.
>              LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
>          .handled_access_net =
>              LANDLOCK_ACCESS_NET_BIND_TCP |
> -            LANDLOCK_ACCESS_NET_CONNECT_TCP,
> +            LANDLOCK_ACCESS_NET_CONNECT_TCP |
> +            LANDLOCK_ACCESS_NET_BIND_UDP |
> +            LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
>          .scoped =
>              LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
>              LANDLOCK_SCOPE_SIGNAL,
> @@ -132,6 +134,12 @@ version, and only use the available subset of access rights:
>      case 6 ... 8:
>          /* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 9 */
>          ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
> +        __attribute__((fallthrough));
> +    case 9:
> +        /* Removes LANDLOCK_ACCESS_*_UDP for ABI < 10 */
> +        ruleset_attr.handled_access_net &=
> +            ~(LANDLOCK_ACCESS_NET_BIND_UDP |
> +              LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
>      }
>  
>  This enables the creation of an inclusive ruleset that will contain our rules.
> @@ -180,21 +188,50 @@ this file descriptor.
>  
>  It may also be required to create rules following the same logic as explained
>  for the ruleset creation, by filtering access rights according to the Landlock
> -ABI version.  In this example, this is not required because all of the requested
> -``allowed_access`` rights are already available in ABI 1.
> +ABI version.  So far, this was not required because all of the requested
> +``allowed_access`` rights have always been available, from ABI 1.
>  
> -For network access-control, we can add a set of rules that allow to use a port
> -number for a specific action: HTTPS connections.
> +For network access-control, we will add a set of rules to allow DNS
> +queries, which requires both UDP and TCP. For TCP, we need to allow
> +outbound connections to port 53, which can be handled and granted starting
> +with ABI 4:
>  
>  .. code-block:: c
>  
> -    struct landlock_net_port_attr net_port = {
> -        .allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
> -        .port = 443,
> -    };
> +    if (ruleset_attr.handled_access_net & LANDLOCK_ACCESS_NET_CONNECT_TCP) {
> +        struct landlock_net_port_attr net_port = {
> +            .allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
> +            .port = 53,
> +        };
>  
> -    err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
> -                            &net_port, 0);
> +        err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
> +                                &net_port, 0);
> +
> +We also need to be able to send UDP datagrams to port 53, which requires
> +granting ``LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP``. Since our DNS client will
> +emit datagrams without explicitly binding to a specific source port, its UDP
> +socket will automatically bind an ephemeral port. To allow this behaviour,
> +we also need to grant ``LANDLOCK_ACCESS_NET_BIND_UDP`` on port 0, as if
> +the program explicitly called :manpage:`bind(2)` on port 0.

Please follow the pattern in this new patch (already in my next branch):
https://lore.kernel.org/all/20260513151856.148423-1-mic@digikod.net/

> +
> +.. code-block:: c
> +
> +    if (ruleset_attr.handled_access_net & LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP) {
> +        const struct landlock_net_port_attr send_dst_port = {
> +            .allowed_access = LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
> +            .port = 53,
> +        };
> +        err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
> +                                &send_dst_port, 0);
> +        [...]
> +
> +    if (ruleset_attr.handled_access_net & LANDLOCK_ACCESS_NET_BIND_UDP) {
> +        const struct landlock_net_port_attr bind_src_port = {
> +            .allowed_access = LANDLOCK_ACCESS_NET_BIND_UDP,
> +            .port = 0,
> +        };
> +        err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
> +                                &bind_src_port, 0);
>  
>  When passing a non-zero ``flags`` argument to ``landlock_restrict_self()``, a
>  similar backwards compatibility check is needed for the restrict flags
> @@ -228,7 +265,7 @@ similar backwards compatibility check is needed for the restrict flags
>  The next step is to restrict the current thread from gaining more privileges
>  (e.g. through a SUID binary).  We now have a ruleset with the first rule
>  allowing read and execute access to ``/usr`` while denying all other handled
> -accesses for the filesystem, and a second rule allowing HTTPS connections.
> +accesses for the filesystem, and two more rules allowing DNS queries.
>  
>  .. code-block:: c
>  
> @@ -716,6 +753,16 @@ Starting with the Landlock ABI version 9, it is possible to restrict
>  connections to pathname UNIX domain sockets (:manpage:`unix(7)`) using
>  the new ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX`` right.
>  
> +UDP bind, connect, sendto, sendmsg and sendmmsg (ABI < 10)

nit: Make it a bit shorter because it is also use in link (#).  Maybe
something like this:

  UDP bind, connect and send* (ABI < 10)

...and specifying each syscall in the text below.

> +----------------------------------------------------------
> +
> +Starting with the Landlock ABI version 10, it is possible to restrict
> +setting the local port of UDP sockets with the
> +``LANDLOCK_ACCESS_NET_BIND_UDP`` right.
> +The ``LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP`` right controls setting the
> +remote port of UDP sockets, and sending datagrams to an explicit remote
> +port (ignoring any destination set on UDP sockets).
> +
>  .. _kernel_support:
>  
>  Kernel support
> @@ -778,10 +825,10 @@ the boot loader.
>  Network support
>  ---------------
>  
> -To be able to explicitly allow TCP operations (e.g., adding a network rule with
> -``LANDLOCK_ACCESS_NET_BIND_TCP``), the kernel must support TCP
> +To be able to explicitly allow TCP or UDP operations (e.g., adding a network rule with
> +``LANDLOCK_ACCESS_NET_BIND_TCP``), the kernel must support the TCP/IP protocol suite
>  (``CONFIG_INET=y``).  Otherwise, sys_landlock_add_rule() returns an
> -``EAFNOSUPPORT`` error, which can safely be ignored because this kind of TCP
> +``EAFNOSUPPORT`` error, which can safely be ignored because this kind of TCP or UDP
>  operation is already not possible.
>  
>  Questions and answers
> -- 
> 2.39.5
> 
> 
