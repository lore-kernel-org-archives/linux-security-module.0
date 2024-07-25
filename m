Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA5E19D072
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jul 2024 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917151; cv=none; b=TjVT8OFKhh6IkLZjelkhAh7CiLhjhcaQp7ETAK5c8su97cHYbvAJazCMLXkUXH/8k8YVO7rM74r7UoZCRT0sQyUKMtZOOaXwZzDxeSOjOX78iEhsg95ZoXHQzevx8cXtu2u3MxB9KIJXpnzCZy1z2wfD43FuflRdynt71xSYrQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917151; c=relaxed/simple;
	bh=cyEcSr+BhonFVEnaLt8EGxFa7DNtRZULsVk42jLsu3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJNNJSYJoHtvRSFK/AKHIiNgU+YthwmWPUUHxZTzpRd0EqdJ88hbe/wcBmXwBVirkAh+XN1VCWQ+Jh6Jg2Ox7bTmupkA6QVNkR/VTdM6sLjY5q+RgLxbi+t/4qvoYAPqoqZf+8Clt6VurH9hD216OO1+3NCtuP8YTmK5A6q7nOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=zcFW9nQ7; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="zcFW9nQ7"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WVCg75W6Vz6mt;
	Thu, 25 Jul 2024 16:18:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721917139;
	bh=A637sdMYYX6WYQ5znC+hqJDdcWKIM518ApZarQd9nwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zcFW9nQ7pI98dhdsjoDJXcYXA0xWq1pKaQp2dgMZRLQPY1XICzqreGW5nNnFNVt9g
	 t+xSTi5rrQEj9HyDotsxUooDtgmwl0jAXhouWM8GVVlnzyWcX7D04UyT8auVzoKKez
	 a7hN/QlVDcWRJMq3msmH2ZWUQvkMYuomZjUzRTZc=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WVCg71zk6zwKy;
	Thu, 25 Jul 2024 16:18:59 +0200 (CEST)
Date: Thu, 25 Jul 2024 16:18:57 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	outreachy@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v7 3/4] samples/landlock: Support abstract unix socket
 restriction
Message-ID: <20240725.dei1Kaimi8ze@digikod.net>
References: <cover.1721269836.git.fahimitahera@gmail.com>
 <4f533a80d56d9f57d50a87d55101cfdeb03404c3.1721269836.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f533a80d56d9f57d50a87d55101cfdeb03404c3.1721269836.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Jul 17, 2024 at 10:15:21PM -0600, Tahera Fahimi wrote:
> - Adding IPC scoping to the sandbox demo by defining a new "LL_SCOPED"
>   environment variable. "LL_SCOPED" gets value "a" to restrict abstract
>   unix sockets.
> - Change to LANDLOCK_ABI_LAST to 6.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
>  samples/landlock/sandboxer.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index e8223c3e781a..d280616585d4 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -14,6 +14,7 @@
>  #include <fcntl.h>
>  #include <linux/landlock.h>
>  #include <linux/prctl.h>
> +#include <linux/socket.h>
>  #include <stddef.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -55,6 +56,7 @@ static inline int landlock_restrict_self(const int ruleset_fd,
>  #define ENV_FS_RW_NAME "LL_FS_RW"
>  #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
>  #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
> +#define ENV_SCOPED_NAME "LL_SCOPED"
>  #define ENV_DELIMITER ":"
>  
>  static int parse_path(char *env_path, const char ***const path_list)
> @@ -208,7 +210,7 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
>  
>  /* clang-format on */
>  
> -#define LANDLOCK_ABI_LAST 5
> +#define LANDLOCK_ABI_LAST 6
>  
>  int main(const int argc, char *const argv[], char *const *const envp)
>  {
> @@ -216,6 +218,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  	char *const *cmd_argv;
>  	int ruleset_fd, abi;
>  	char *env_port_name;
> +	char *env_scoped_name;
>  	__u64 access_fs_ro = ACCESS_FS_ROUGHLY_READ,
>  	      access_fs_rw = ACCESS_FS_ROUGHLY_READ | ACCESS_FS_ROUGHLY_WRITE;
>  
> @@ -223,14 +226,15 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  		.handled_access_fs = access_fs_rw,
>  		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
>  				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
> +		.scoped = LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET,
>  	};
>  
>  	if (argc < 2) {
>  		fprintf(stderr,
> -			"usage: %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\"%s "
> +			"usage: %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s "
>  			"<cmd> [args]...\n\n",
>  			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
> -			ENV_TCP_CONNECT_NAME, argv[0]);
> +			ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv[0]);
>  		fprintf(stderr,
>  			"Execute a command in a restricted environment.\n\n");
>  		fprintf(stderr,
> @@ -251,15 +255,18 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  		fprintf(stderr,
>  			"* %s: list of ports allowed to connect (client).\n",
>  			ENV_TCP_CONNECT_NAME);
> +		fprintf(stderr, "* %s: list of allowed restriction on IPCs.\n",

"allowed restrictions" or "restrictions"?

> +			ENV_SCOPED_NAME);
>  		fprintf(stderr,
>  			"\nexample:\n"
>  			"%s=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
>  			"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
>  			"%s=\"9418\" "
>  			"%s=\"80:443\" "
> +			"%s=\"a\" "
>  			"%s bash -i\n\n",
>  			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
> -			ENV_TCP_CONNECT_NAME, argv[0]);
> +			ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv[0]);
>  		fprintf(stderr,
>  			"This sandboxer can use Landlock features "
>  			"up to ABI version %d.\n",
> @@ -326,7 +333,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  	case 4:
>  		/* Removes LANDLOCK_ACCESS_FS_IOCTL_DEV for ABI < 5 */
>  		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
> -

No need to remove this line.

> +		__attribute__((fallthrough));
> +	case 5:
> +		/* Removes IPC scoping mechanism for ABI < 6 */
> +		ruleset_attr.scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;

There is an inconsistency here, please take a look at previous similar
changes.

>  		fprintf(stderr,
>  			"Hint: You should update the running kernel "
>  			"to leverage Landlock features "
> @@ -357,7 +367,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  		ruleset_attr.handled_access_net &=
>  			~LANDLOCK_ACCESS_NET_CONNECT_TCP;
>  	}
> -
> +	/* Removes IPC scoping attribute if not supported by a user. */
> +	env_scoped_name = getenv(ENV_SCOPED_NAME);
> +	if (!env_scoped_name)
> +		ruleset_attr.scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
>  	ruleset_fd =
>  		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
>  	if (ruleset_fd < 0) {
> -- 
> 2.34.1
> 
> 
