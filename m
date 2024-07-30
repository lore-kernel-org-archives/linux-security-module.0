Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B262718C918
	for <linux-security-module@vger.kernel.org>; Tue, 30 Jul 2024 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355531; cv=none; b=LduCG0a213mU3sT1DZsCQwWXtq3I3TdWLFawJLpP38zZXHH9Ic5Bq4hOFipYWlAIyxPjnQBR9WMo1rBN+oGRZEY80t1bJvcTNqV/FIMwTR8UF7ddsOqjsmZeH+RYSaxUFXIG++egEa8fUn9tqcMEmA7wBG6PsUMvO7dP+tbz6BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355531; c=relaxed/simple;
	bh=iL/1cZktHy5qJxMzNjP7tyzxRAqgZ/9A2Ah+Uai6D00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RazmuW618PxUIqoTiPa9Lgi0aL201bTZYr2DkEyRVns4haMXUZxQ4pQ6Fq768tBWgjHBHzDu8wKzZP2laE2qiamyWsnWMzZ0VVcG7V3IkuzlU6KlE5Z8AS48Yb7YFQJK/B8S4qaEBd9kfu8iUvTm8lFhOY4Eknx7IQgJLcJ4C7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=wmuYjO3g; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="wmuYjO3g"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WYKnW2xwTzMTQ;
	Tue, 30 Jul 2024 18:05:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1722355519;
	bh=rTkmaqgdA0hdziNZA+MweCBjOsXyU7Gte0DKWRTiXhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wmuYjO3g5TlA5TYk5f6t/dx/+FdwJi0TW9qKG1ekU8d6tEnSIByj3RHiX2VGjn7+I
	 1jtfcCLN383fdmHaoa1ikY09offYfOC8UgVpuS7wr7muGU7cEcJPvwJO1dG9j3adJU
	 Fbf6mGubRwKwVamBsvHvR2dZLb1ZdEkwnOkJo4/Q=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WYKnV2MTvzvRd;
	Tue, 30 Jul 2024 18:05:18 +0200 (CEST)
Date: Tue, 30 Jul 2024 18:05:15 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	outreachy@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v7 1/4] Landlock: Add abstract unix socket connect
 restriction
Message-ID: <20240730.Quei5io6sesh@digikod.net>
References: <cover.1721269836.git.fahimitahera@gmail.com>
 <d7bad636c2e3609ade32fd02875fa43ec1b1d526.1721269836.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7bad636c2e3609ade32fd02875fa43ec1b1d526.1721269836.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Jul 17, 2024 at 10:15:19PM -0600, Tahera Fahimi wrote:
> The patch introduces a new "scoped" attribute to the
> landlock_ruleset_attr that can specify "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET"
> to scope abstract unix sockets from connecting to a process outside of
> the same landlock domain.
> 
> This patch implement two hooks, "unix_stream_connect" and "unix_may_send" to
> enforce this restriction.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> 
> -------
> v7:
>  - Using socket's file credentials for both connected(STREAM) and
>    non-connected(DGRAM) sockets.
>  - Adding "domain_sock_scope" instead of the domain scoping mechanism used in
>    ptrace ensures that if a server's domain is accessible from the client's
>    domain (where the client is more privileged than the server), the client
>    can connect to the server in all edge cases.
>  - Removing debug codes.
> v6:
>  - Removing curr_ruleset from landlock_hierarchy, and switching back to use
>    the same domain scoping as ptrace.
>  - code clean up.
> v5:
>  - Renaming "LANDLOCK_*_ACCESS_SCOPE" to "LANDLOCK_*_SCOPE"
>  - Adding curr_ruleset to hierarachy_ruleset structure to have access from
>    landlock_hierarchy to its respective landlock_ruleset.
>  - Using curr_ruleset to check if a domain is scoped while walking in the
>    hierarchy of domains.
>  - Modifying inline comments.
> V4:
>  - Rebased on Günther's Patch:
>    https://lore.kernel.org/all/20240610082115.1693267-1-gnoack@google.com/
>    so there is no need for "LANDLOCK_SHIFT_ACCESS_SCOPE", then it is removed.
>  - Adding get_scope_accesses function to check all scoped access masks in a ruleset.
>  - Using file's FD credentials instead of credentials stored in peer_cred
>    for datagram sockets. (see discussion in [1])
>  - Modifying inline comments.
> V3:
>  - Improving commit description.
>  - Introducing "scoped" attribute to landlock_ruleset_attr for IPC scoping
>    purpose, and adding related functions.
>  - Changing structure of ruleset based on "scoped".
>  - Removing rcu lock and using unix_sk lock instead.
>  - Introducing scoping for datagram sockets in unix_may_send.
> V2:
>  - Removing wrapper functions
> 
> [1]https://lore.kernel.org/outreachy/Zmi8Ydz4Z6tYtpY1@tahera-OptiPlex-5000/T/#m8cdf33180d86c7ec22932e2eb4ef7dd4fc94c792
> -------
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
>  include/uapi/linux/landlock.h |  29 +++++++++
>  security/landlock/limits.h    |   3 +
>  security/landlock/ruleset.c   |   7 ++-
>  security/landlock/ruleset.h   |  23 ++++++-
>  security/landlock/syscalls.c  |  14 +++--
>  security/landlock/task.c      | 112 ++++++++++++++++++++++++++++++++++
>  6 files changed, 181 insertions(+), 7 deletions(-)

> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index 849f5123610b..597d89e54aae 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c

> +static int hook_unix_stream_connect(struct sock *const sock,
> +				    struct sock *const other,
> +				    struct sock *const newsk)
> +{

We must check if the unix sockets use an abstract address.  We need a
new test to check against a the three types of addresse: pathname,
unnamed (socketpair), and abstract.  This should result into 6 variants
because of the stream-oriented or dgram-oriented sockets to check both
hooks.  The test can do 3 checks: without any Landlock domain, with the
client being sandboxed with a Landlock domain for filesystem
restrictions only, and with a domain scoped for abstract unix sockets.

For pathname you'll need to move the TMP_DIR define from fs_test.c into
common.h and create a static path for the named socket.  A fixture
teardown should remove the socket and the directory.

> +	if (sock_is_scoped(other))
> +		return 0;
> +
> +	return -EPERM;
> +}
> +
> +static int hook_unix_may_send(struct socket *const sock,
> +			      struct socket *const other)
> +{

Same here

> +	if (sock_is_scoped(other->sk))
> +		return 0;
> +
> +	return -EPERM;
> +}
> +
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
> +	LSM_HOOK_INIT(unix_stream_connect, hook_unix_stream_connect),
> +	LSM_HOOK_INIT(unix_may_send, hook_unix_may_send),

Future access controls dedicated to pathname unix sockets may need these
hooks too, but I guess we'll see where tehy fit the best when we'll be
there.

>  };
>  
>  __init void landlock_add_task_hooks(void)
> -- 
> 2.34.1
> 
> 
