Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7124A3B3894
	for <linux-security-module@vger.kernel.org>; Mon,  8 Jun 2026 22:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780959062; cv=none; b=s09PaZvH0Kd7QWcuMjuTEvQVMruCwXgFmdMAjfefXNn6OUwHhHKDjzIIC/0UNE5vlS5qi6pXPqjIV93UpotGYWsnsfdMs+Mp/JaDlCpCeeg9yAEE8xFQJnkjVLjZwzNe9IQuEeMqmiZTHgf80IfXn3v7iFB7m+/U+5qniGUxJc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780959062; c=relaxed/simple;
	bh=QRpzV8tLzRFWj8tttzd2Cogv2rwIbP35WXxcwV/LBf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRQsXL3QMMI5JhwcIM38OlF20Hs4lwPoBK6JZw96nizNozYU8bHkpj44M1UxIlYKusKrThDA6JxoN5WfDFNK5bFT4ul0AYVylHbdWa7MNqQv2QLgR9ybXsHtaHft1RQB2BvIPdAVTpCmDileNRt1eQQ4/IfMEygMwegjpngtA9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=dx9wcTWM; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="dx9wcTWM"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gZ6V454XszPFk;
	Tue,  9 Jun 2026 00:41:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1780958508;
	bh=FyhpIAWJGwrcxwhSm89prKx/bF+rpFV3Z4VmXTiW2kQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dx9wcTWM95BjXg30pOAjzMIByOwCKuC66k36nzQvOXRAe+CRBzMumLLm2nbNg2sUJ
	 yERMemrMMcJzyRKzClgZJuZ1LR1NH3sBGC6xR1DsiJYjMt2SCrG4aUdWC2UaHp33W7
	 e1lnVKQIluFfIBVnFpgRTT9IgeT8IPUvwVqHvyoI=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gZ6V40VGmz2vD;
	Tue,  9 Jun 2026 00:41:48 +0200 (CEST)
Date: Tue, 9 Jun 2026 00:41:47 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Justin Suess <utilityemal77@gmail.com>, Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v10 4/9] samples/landlock: Add quiet flag support to
 sandboxer
Message-ID: <20260609.Pi8aiyae5nee@digikod.net>
References: <cover.1780272022.git.m@maowtm.org>
 <9a90a123beb481c5be345e0d169eb14295803678.1780272022.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a90a123beb481c5be345e0d169eb14295803678.1780272022.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

As for LL_FORCE_LOG, using a QUIET flag not supported should exit with
an error.

On Mon, Jun 01, 2026 at 01:00:38AM +0100, Tingmao Wang wrote:
> Adds ability to set which access bits to quiet via LL_*_QUIET_ACCESS (FS,
> NET or SCOPED), and attach quiet flags to individual objects via
> LL_*_QUIET for FS and NET.
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
> 
> Changes in v10:
> - Remove stray __attribute__((fallthrough)); (Thanks Justin for
>   spotting)
> 
> Changes in v9:
> - Add udp connect / bind quiet flag support
> 
> Changes in v8:
> - Rebase on top of mic/next
> - populate_ruleset_net() already does not require the env var to be
>   present, so remove redundant comment and check above
>   populate_ruleset_net(ENV_NET_QUIET_NAME, ...).
> 
> Changes in v6:
> - Make populate_ruleset_{fs,net} take a flags argument instead of a bool
>   quiet (suggested by Justin Suess)
> - Fix if braces style
> 
> Changes in v3:
> - Minor change to the above commit message.
> 
> Changes in v2:
> - Added new environment variables to control which quiet access bits to
>   set on the rule, and populate quiet_access_* from it.
> - Added support for quieting net rules and scoped access.  Renamed patch
>   title.
> - Increment ABI version
> 
>  samples/landlock/sandboxer.c | 133 ++++++++++++++++++++++++++++++++---
>  1 file changed, 122 insertions(+), 11 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index 94e399e6b146..73a81ecd3696 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -58,9 +58,14 @@ static inline int landlock_restrict_self(const int ruleset_fd,
>  
>  #define ENV_FS_RO_NAME "LL_FS_RO"
>  #define ENV_FS_RW_NAME "LL_FS_RW"
> +#define ENV_FS_QUIET_NAME "LL_FS_QUIET"
> +#define ENV_FS_QUIET_ACCESS_NAME "LL_FS_QUIET_ACCESS"
>  #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
>  #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
> +#define ENV_NET_QUIET_NAME "LL_NET_QUIET"
> +#define ENV_NET_QUIET_ACCESS_NAME "LL_NET_QUIET_ACCESS"
>  #define ENV_SCOPED_NAME "LL_SCOPED"
> +#define ENV_SCOPED_QUIET_ACCESS_NAME "LL_SCOPED_QUIET_ACCESS"
>  #define ENV_FORCE_LOG_NAME "LL_FORCE_LOG"
>  #define ENV_UDP_BIND_NAME "LL_UDP_BIND"
>  #define ENV_UDP_CONNECT_SEND_NAME "LL_UDP_CONNECT_SEND"
> @@ -119,7 +124,7 @@ static int parse_path(char *env_path, const char ***const path_list)
>  /* clang-format on */
>  
>  static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
> -			       const __u64 allowed_access)
> +			       const __u64 allowed_access, __u32 flags)
>  {
>  	int num_paths, i, ret = 1;
>  	char *env_path_name;
> @@ -169,7 +174,7 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
>  		if (!S_ISDIR(statbuf.st_mode))
>  			path_beneath.allowed_access &= ACCESS_FILE;
>  		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
> -				      &path_beneath, 0)) {
> +				      &path_beneath, flags)) {
>  			fprintf(stderr,
>  				"Failed to update the ruleset with \"%s\": %s\n",
>  				path_list[i], strerror(errno));
> @@ -187,7 +192,7 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
>  }
>  
>  static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
> -				const __u64 allowed_access)
> +				const __u64 allowed_access, __u32 flags)
>  {
>  	int ret = 1;
>  	char *env_port_name, *env_port_name_next, *strport;
> @@ -215,7 +220,7 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
>  		}
>  		net_port.port = port;
>  		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
> -				      &net_port, 0)) {
> +				      &net_port, flags)) {
>  			fprintf(stderr,
>  				"Failed to update the ruleset with port \"%llu\": %s\n",
>  				net_port.port, strerror(errno));
> @@ -303,6 +308,58 @@ static bool check_ruleset_scope(const char *const env_var,
>  
>  /* clang-format on */
>  
> +static int add_quiet_access(__u64 *const quiet_access,
> +			    const __u64 handled_access,
> +			    const char *const env_var, const bool default_all)
> +{
> +	char *env_quiet_access, *env_quiet_access_next, *str_access;
> +
> +	if (default_all)
> +		*quiet_access = handled_access;
> +	else
> +		*quiet_access = 0;
> +
> +	env_quiet_access = getenv(env_var);
> +	if (!env_quiet_access)
> +		return 0;
> +
> +	env_quiet_access = strdup(env_quiet_access);
> +	env_quiet_access_next = env_quiet_access;
> +	unsetenv(env_var);
> +	*quiet_access = 0;
> +
> +	while ((str_access = strsep(&env_quiet_access_next, ENV_DELIMITER))) {
> +		if (strcmp(str_access, "") == 0)
> +			continue;
> +		else if (strcmp(str_access, "r") == 0)
> +			*quiet_access |= ACCESS_FS_ROUGHLY_READ;
> +		else if (strcmp(str_access, "w") == 0)
> +			*quiet_access |= ACCESS_FS_ROUGHLY_WRITE;
> +		else if (strcmp(str_access, "b") == 0)
> +			*quiet_access |= LANDLOCK_ACCESS_NET_BIND_TCP;

What happen if we set "b" in LL_FS_QUIET_ACCESS?

> +		else if (strcmp(str_access, "c") == 0)
> +			*quiet_access |= LANDLOCK_ACCESS_NET_CONNECT_TCP;
> +		else if (strcmp(str_access, "ub") == 0)

I don't really like these access-right names, they are not consistent.
All these env variables add a lot of complexity too.  What about just
being able to quiet a path or a port?  That would mean renaming
LL_FS_QUIET_ACCESS to LL_FS_QUIET.

Anyway, all should be unsetenv() unconditionally.

> +			*quiet_access |= LANDLOCK_ACCESS_NET_BIND_UDP;
> +		else if (strcmp(str_access, "uc") == 0)
> +			*quiet_access |= LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
> +		else if (strcmp(str_access, "a") == 0)
> +			*quiet_access |= LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
> +		else if (strcmp(str_access, "s") == 0)
> +			*quiet_access |= LANDLOCK_SCOPE_SIGNAL;
> +		else {
> +			fprintf(stderr, "Unknown quiet access \"%s\"\n",
> +				str_access);
> +			free(env_quiet_access);
> +			return -1;
> +		}
> +	}
> +
> +	free(env_quiet_access);
> +	*quiet_access &= handled_access;
> +	return 0;
> +}
> +
>  #define LANDLOCK_ABI_LAST 10
>  
>  #define XSTR(s) #s
> @@ -336,6 +393,22 @@ static const char help[] =
>  	"\n"
>  	"A sandboxer should not log denied access requests to avoid spamming logs, "
>  	"but to test audit we can set " ENV_FORCE_LOG_NAME "=1\n"
> +	ENV_FS_QUIET_NAME " and " ENV_NET_QUIET_NAME ", both optional, can then be used "
> +	"to make access to some denied paths or network ports not trigger audit logging.\n"
> +	ENV_FS_QUIET_ACCESS_NAME " and " ENV_NET_QUIET_ACCESS_NAME " can be used to specify "
> +	"which accesses should be quieted (defaults to all):\n"
> +	"* " ENV_FS_QUIET_ACCESS_NAME ": file system accesses to quiet\n"
> +	"  - \"r\" to quiet all file/dir read accesses\n"
> +	"  - \"w\" to quiet all file/dir write accesses\n"
> +	"* " ENV_NET_QUIET_ACCESS_NAME ": network accesses to quiet\n"
> +	"  - \"b\" to quiet tcp bind denials\n"
> +	"  - \"c\" to quiet tcp connect denials\n"
> +	"  - \"ub\" to quiet udp bind denials\n"
> +	"  - \"uc\" to quiet udp connect / send denials\n"
> +	"In addition, " ENV_SCOPED_QUIET_ACCESS_NAME " can be set to quiet all denials for "
> +	"scoped actions (defaults to none).\n"
> +	"  - \"a\" to quiet abstract unix socket denials\n"
> +	"  - \"s\" to quiet signal denials\n"
>  	"\n"
>  	"Example:\n"
>  	ENV_FS_RO_NAME "=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
> @@ -368,7 +441,12 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  				      LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
>  		.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
>  			  LANDLOCK_SCOPE_SIGNAL,
> +		.quiet_access_fs = 0,
> +		.quiet_access_net = 0,
> +		.quiet_scoped = 0,
>  	};
> +

Why this new line?

> +	bool quiet_supported = true;
>  	int supported_restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
>  	int set_restrict_flags = 0;
>  
> @@ -459,6 +537,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  		ruleset_attr.handled_access_net &=
>  			~(LANDLOCK_ACCESS_NET_BIND_UDP |
>  			  LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
> +		/* Don't add quiet flags for ABI < 10 later on. */

/* Removes quiet flags...

> +		quiet_supported = false;
>  
>  		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
>  		fprintf(stderr,
> @@ -525,6 +605,25 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  		unsetenv(ENV_FORCE_LOG_NAME);
>  	}
>  
> +	/*
> +	 * Add quiet for fs/net handled access bits.  Doing this alone has no
> +	 * effect unless we later add quiet rules per FS_QUIET/NET_QUIET.
> +	 */
> +	if (quiet_supported) {
> +		if (add_quiet_access(&ruleset_attr.quiet_access_fs,
> +				     ruleset_attr.handled_access_fs,
> +				     ENV_FS_QUIET_ACCESS_NAME, true))
> +			return 1;
> +		if (add_quiet_access(&ruleset_attr.quiet_access_net,
> +				     ruleset_attr.handled_access_net,
> +				     ENV_NET_QUIET_ACCESS_NAME, true))
> +			return 1;
> +		if (add_quiet_access(&ruleset_attr.quiet_scoped,
> +				     ruleset_attr.scoped,
> +				     ENV_SCOPED_QUIET_ACCESS_NAME, false))
> +			return 1;
> +	}
> +
>  	ruleset_fd =
>  		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
>  	if (ruleset_fd < 0) {
> @@ -532,30 +631,42 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  		return 1;
>  	}
>  
> -	if (populate_ruleset_fs(ENV_FS_RO_NAME, ruleset_fd, access_fs_ro)) {
> +	if (populate_ruleset_fs(ENV_FS_RO_NAME, ruleset_fd, access_fs_ro, 0))
>  		goto err_close_ruleset;
> -	}
> -	if (populate_ruleset_fs(ENV_FS_RW_NAME, ruleset_fd, access_fs_rw)) {
> +	if (populate_ruleset_fs(ENV_FS_RW_NAME, ruleset_fd, access_fs_rw, 0))
>  		goto err_close_ruleset;
> +
> +	/* Don't require this env to be present. */
> +	if (quiet_supported && getenv(ENV_FS_QUIET_NAME)) {
> +		if (populate_ruleset_fs(ENV_FS_QUIET_NAME, ruleset_fd, 0,
> +					LANDLOCK_ADD_RULE_QUIET))
> +			goto err_close_ruleset;
>  	}
>  
>  	if (populate_ruleset_net(ENV_TCP_BIND_NAME, ruleset_fd,
> -				 LANDLOCK_ACCESS_NET_BIND_TCP)) {
> +				 LANDLOCK_ACCESS_NET_BIND_TCP, 0)) {
>  		goto err_close_ruleset;
>  	}
>  	if (populate_ruleset_net(ENV_TCP_CONNECT_NAME, ruleset_fd,
> -				 LANDLOCK_ACCESS_NET_CONNECT_TCP)) {
> +				 LANDLOCK_ACCESS_NET_CONNECT_TCP, 0)) {
>  		goto err_close_ruleset;
>  	}
>  	if (populate_ruleset_net(ENV_UDP_BIND_NAME, ruleset_fd,
> -				 LANDLOCK_ACCESS_NET_BIND_UDP)) {
> +				 LANDLOCK_ACCESS_NET_BIND_UDP, 0)) {
>  		goto err_close_ruleset;
>  	}
>  	if (populate_ruleset_net(ENV_UDP_CONNECT_SEND_NAME, ruleset_fd,
> -				 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP)) {
> +				 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP, 0)) {
>  		goto err_close_ruleset;
>  	}
>  
> +	if (quiet_supported) {
> +		if (populate_ruleset_net(ENV_NET_QUIET_NAME, ruleset_fd, 0,
> +					 LANDLOCK_ADD_RULE_QUIET)) {
> +			goto err_close_ruleset;
> +		}
> +	}
> +
>  	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
>  		perror("Failed to restrict privileges");
>  		goto err_close_ruleset;
> -- 
> 2.54.0
