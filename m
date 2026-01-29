Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2C635C1A2
	for <linux-security-module@vger.kernel.org>; Thu, 29 Jan 2026 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769722040; cv=none; b=JZpF0k5xpn9cqN5ekSscS5noraSoe/H1Px4oGYkJPrMPyO5Ey3StJrZYE/nRgr6omIb7X5ZGzGBDEVfyv0gW0AOxuMB2So4zybzvXz5Eq49aH3yKVwDN/YYHMFIDMp1ay2v7P8fkwDSUFxZ+4NUcbM58PUn/Wu5BMwW+KOD+vOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769722040; c=relaxed/simple;
	bh=yemhb4VCupH2JWXQB1vol+NVYcjVNrgq3ffPdAtHsjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOeq4lrGMffFdoOaoLxISBGz5rLLZHr6F0f9kwMDZv0sEK/A9yioAOG36yfLM17PP76tmSUroe5I2Qse0tHK67VxuZuRLC5jqOjpAxHNrJ71hWN8XSKHvBK+/sicjyYNBixn7Z6iJGTHZI4SS3TmgRlUgEnePC7J6RyDqCHNyys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=oN0ry0Qs; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="oN0ry0Qs"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f2C020D8mzhK3;
	Thu, 29 Jan 2026 22:27:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1769722033;
	bh=4YSvjoGmBm4c4yCcpZuTBpdHeR9ZvnZgdbXtUjF6J5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oN0ry0Qsr+C1RpLUak0eDde21IW9sKavwpHv+HzvgOTLmbP2RP3yU3Nx++9vlbIHi
	 1Uf8MiN/elmTFf6CvFzGmCzjMboc0STrIBaQrk9zZuUGrSbrs8qLtJfTCjB2tXIReL
	 x6DPDe6Gakbzvst9HQqhqP/wVpkUUPnKafwzYJe0=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4f2C012r7tzVxk;
	Thu, 29 Jan 2026 22:27:13 +0100 (CET)
Date: Thu, 29 Jan 2026 22:27:08 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Justin Suess <utilityemal77@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/6] landlock: Add LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
 scope bit to uAPI
Message-ID: <20260129.Gie0HaenguiG@digikod.net>
References: <cover.1767115163.git.m@maowtm.org>
 <88f914eb2024fa1fffe219e34c33a835b31730b8.1767115163.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88f914eb2024fa1fffe219e34c33a835b31730b8.1767115163.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Tue, Dec 30, 2025 at 05:20:19PM +0000, Tingmao Wang wrote:
> Add the new scope bit to the uAPI header, add documentation, and bump ABI
> version to 8.

This patch and the next one should be fold together.  If a new UAPI is
added, it should come with the kernel implementation.

> 
> This documentation edit specifically calls out the security implications of
> not restricting sockets.
> 
> Fix some minor cosmetic issue in landlock.h around the changed lines as
> well.
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
> 
> Changes in v2:
> - Fix grammar
> 
> Note that in the code block in "Defining and enforcing a security policy"
> the switch case currently jumps from 5 to 7.  This should be fixed by
> https://lore.kernel.org/all/20251216210248.4150777-1-samasth.norway.ananda@oracle.com/
> 
>  Documentation/userspace-api/landlock.rst      | 37 ++++++++++++++++---
>  include/uapi/linux/landlock.h                 |  8 +++-
>  security/landlock/limits.h                    |  2 +-
>  security/landlock/syscalls.c                  |  2 +-
>  tools/testing/selftests/landlock/base_test.c  |  2 +-
>  .../testing/selftests/landlock/scoped_test.c  |  2 +-
>  6 files changed, 42 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 1d0c2c15c22e..5620a2be1091 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -83,7 +83,8 @@ to be explicit about the denied-by-default access rights.
>              LANDLOCK_ACCESS_NET_CONNECT_TCP,
>          .scoped =
>              LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
> -            LANDLOCK_SCOPE_SIGNAL,
> +            LANDLOCK_SCOPE_SIGNAL |
> +            LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET,
>      };
>  
>  Because we may not know which kernel version an application will be executed
> @@ -127,6 +128,10 @@ version, and only use the available subset of access rights:
>          /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
>          ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
>                                   LANDLOCK_SCOPE_SIGNAL);
> +        __attribute__((fallthrough));
> +    case 7:
> +        /* Removes LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET for ABI < 8 */
> +        ruleset_attr.scoped &= ~LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET;
>      }
>  
>  This enables the creation of an inclusive ruleset that will contain our rules.
> @@ -328,10 +333,15 @@ The operations which can be scoped are:
>      This limits the sending of signals to target processes which run within the
>      same or a nested Landlock domain.
>  
> -``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``
> -    This limits the set of abstract :manpage:`unix(7)` sockets to which we can
> -    :manpage:`connect(2)` to socket addresses which were created by a process in
> -    the same or a nested Landlock domain.
> +``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET`` and ``LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET``
> +    This limits the set of :manpage:`unix(7)` sockets to which we can
> +    :manpage:`connect(2)` to socket addresses which were created by a
> +    process in the same or a nested Landlock domain.
> +    ``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET`` applies to abstract sockets,
> +    and ``LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET`` applies to pathname
> +    sockets.

The following part is not needed:
> Even though pathname sockets are represented in the
> +    filesystem, Landlock filesystem rules do not currently control access
> +    to them.

>  
>      A :manpage:`sendto(2)` on a non-connected datagram socket is treated as if
>      it were doing an implicit :manpage:`connect(2)` and will be blocked if the
> @@ -604,6 +614,23 @@ Landlock audit events with the ``LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF``,
>  sys_landlock_restrict_self().  See Documentation/admin-guide/LSM/landlock.rst
>  for more details on audit.
>  
> +Pathname UNIX socket (ABI < 8)
> +------------------------------
> +
> +Starting with the Landlock ABI version 8, it is possible to restrict
> +connections to a pathname (non-abstract) :manpage:`unix(7)` socket by
> +setting ``LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET`` to the ``scoped`` ruleset
> +attribute.  This works the same way as the abstract socket scoping.
> +
> +This allows sandboxing applications using only Landlock to protect against
> +bypasses relying on connecting to Unix sockets of other services running
> +under the same user.  These services typically assume that any process
> +capable of connecting to a local Unix socket, or connecting with the
> +expected user credentials, is trusted.  Without this protection, sandbox
> +escapes may be possible, especially when running in a standard desktop
> +environment, such as by using systemd-run, or sockets exposed by other
> +common applications.
> +
>  .. _kernel_support:
>  
>  Kernel support
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index f030adc462ee..590c6d4171a0 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -364,10 +364,14 @@ struct landlock_net_port_attr {
>   *   related Landlock domain (e.g., a parent domain or a non-sandboxed process).
>   * - %LANDLOCK_SCOPE_SIGNAL: Restrict a sandboxed process from sending a signal
>   *   to another process outside the domain.
> + * - %LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET: Restrict a sandboxed process from
> + *   connecting to a pathname UNIX socket created by a process outside the
> + *   related Landlock domain.
>   */
>  /* clang-format off */
>  #define LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
> -#define LANDLOCK_SCOPE_SIGNAL		                (1ULL << 1)
> -/* clang-format on*/
> +#define LANDLOCK_SCOPE_SIGNAL				(1ULL << 1)
> +#define LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET		(1ULL << 2)
> +/* clang-format on */
>  
>  #endif /* _UAPI_LINUX_LANDLOCK_H */
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 65b5ff051674..d653e14dba10 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -27,7 +27,7 @@
>  #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
>  
> -#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPE_SIGNAL
> +#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
>  #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
>  #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
>  
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 0116e9f93ffe..66fd196be85a 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -161,7 +161,7 @@ static const struct file_operations ruleset_fops = {
>   * Documentation/userspace-api/landlock.rst should be updated to reflect the
>   * UAPI change.
>   */
> -const int landlock_abi_version = 7;
> +const int landlock_abi_version = 8;
>  
>  /**
>   * sys_landlock_create_ruleset - Create a new ruleset
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index 7b69002239d7..f4b1a275d8d9 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -76,7 +76,7 @@ TEST(abi_version)
>  	const struct landlock_ruleset_attr ruleset_attr = {
>  		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
>  	};
> -	ASSERT_EQ(7, landlock_create_ruleset(NULL, 0,
> +	ASSERT_EQ(8, landlock_create_ruleset(NULL, 0,
>  					     LANDLOCK_CREATE_RULESET_VERSION));
>  
>  	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
> diff --git a/tools/testing/selftests/landlock/scoped_test.c b/tools/testing/selftests/landlock/scoped_test.c
> index b90f76ed0d9c..7f83512a328d 100644
> --- a/tools/testing/selftests/landlock/scoped_test.c
> +++ b/tools/testing/selftests/landlock/scoped_test.c
> @@ -12,7 +12,7 @@
>  
>  #include "common.h"
>  
> -#define ACCESS_LAST LANDLOCK_SCOPE_SIGNAL
> +#define ACCESS_LAST LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
>  
>  TEST(ruleset_with_unknown_scope)
>  {
> -- 
> 2.52.0
> 
