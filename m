Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02DE3624CE
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 02:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780022099; cv=none; b=dmdeMtfoNOmNj3zPlX4g8hQfKplVmdKRd1l7l16zVsUzR6+cahM4H0YxdTPXUSgJO5QLDP/JgrCIhXxtgsKNDMXoIS7bBniisukJ2GShScNJL/ORxYmBVs5mqfaS28hnV2mpBZXAVQ3pV4e1JWxn5ZXplVBIpbmIR+2O5RTbbUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780022099; c=relaxed/simple;
	bh=IjYhkuXxJNgqiZV19YmUCxNCpukjVKBHoXeiYC1mc2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRoVALY0xBdX/Kie9UxL2I+dozAj9CUJeDUAfk1YSZoo6ySDqGOISEreP06T+42zqB4l08RLzTkAU80+waoLp7Jr5uzx7kZZor/Npi7BOxfVfH7LrNoKdKbDJxM73ahkyILvRD2W3N58J/fXTvULf6Pt0qTyGmvDoZ5D/onTCbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+efjSvo; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+efjSvo"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-654672a6d68so12976069d50.0
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 19:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780022097; x=1780626897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wog0a+h/Fd7sPpu8myI61TyAozYuz6RSWee3RRt/TOs=;
        b=b+efjSvomcHpVEoup4XEewAMpI9X8ZyXLB7R6jbhg6G7S/LbGEWAs46FsqIoDKDuY3
         JRv92erCPTIzKtMv2IgsrnvAhPa0Gqn6iZrSBVRSkyy2XJ6Gd9c5pXLAxc+7xh3MwLXN
         Uh68rN9NCTOPml0ttyESUhm6sVz8kz5ueGi28VE2jv1YxV2H6p4qsosVxjADBvLLpKcF
         9X77g3UBVd5aKH+N8UTZwEj/QxB2Ba5u1/3nRq77SJ+eTQRitYV/4gUsNxZhfOfHhDe4
         xqy+TXrQfmaOJOD+PrPPkW2b2tZIg/wFSHh39OkRuWh53DUGXAoGeNY/1Hiucrg4hHy/
         ZzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780022097; x=1780626897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wog0a+h/Fd7sPpu8myI61TyAozYuz6RSWee3RRt/TOs=;
        b=mkrxoS1xoe4N1Sld1rFfKrj3a4a2640qj96ge/hpBvErRRwZm6l6rhMhIUBIBEZPui
         /J6oek6Wja3ZKaU/NpglBf7dHimTQnUOAP2ahugECTZIrvt74ub7Zzu/E1tif4eTkV3y
         mVEBsazjp3lHHT98NuDOCSWnUrX/6ytQMQWA+maFLq6/Z0J+i6Cq6Icy5l2Jj8rO8Wa5
         QEJcJfj09N6QWKJzZJu1l+dY2GXHU2OMc/KYqzfPD9o4A1+d+u0Qrn7n57JX5xawLLfg
         RmrtXLr2s0qOP+HWpB3Sgo+5KKMeT3cNhA9FJa+SsvCWqVd9Nhc6C+Jfbx7+9g/L0Hdg
         vt+A==
X-Forwarded-Encrypted: i=1; AFNElJ9zBUCOTxCFvzgGAjzsise7YPjY3GbuhjmQDBjOe7yzk2tE+eggpAkP3DpKlhLZTpW3H9SuGmTJUcLObEtkGq2RkdZcJYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIEnzNMuZJ/aX9BVQXOjOKwIUfdEdr98KuxVW54u2aVqOvEfck
	wP6L+CtzDJcRfMFpXmy2gjos0POBKmpQSMDHCndEIdLQnqDxXkvAkcrN
X-Gm-Gg: Acq92OGvhPdkRUz5DPw39ydp/OxYWNUG6YZN7c3dGPfxxdG136IhGduo3Z+zj2i0OVb
	REqSdNeYwoAsWNjUvmrWLZ+uTPv0SB4Bijel6D+P1JlyhHph+Y+C1+dCmU/RnPYfxfzVMkyK2sh
	kaBuurHzGKPw+nIwTXLrH86hRp7dzsYa0+sqIVmGRDDz+DiJY4V7j0vjrsO8uW2yDSsiwgLhF1J
	ENUI90ObJMxnToFiBeyEHXhbqvF3VuqW5FwUwkhrXYdjCORJ8TD5cMDNwpLkWMSzUeZbspX//KX
	tVPYQRbLW3lVCiQJctzlElSJHjEcR3yPLp90pc7KB61466k5LqWmkOu6WNYldcvZP4Mgc13vr/A
	8SiQ9E4wyJEiVaAhQgHqcDTBhFNhDU67kYEIXMyIFHvaneCuLaJ5jNy4JXdIu+qOJIYogzOL0q2
	RB8zA30PexqI06r78uQ4MndDpn8Ulh0yhBI6UP3lzbh1T/w58iN4HKvPiSm66sMwFdIpQmW8dx2
	m/uTro=
X-Received: by 2002:a05:690e:4808:b0:660:2fbf:528c with SMTP id 956f58d0204a3-66052eabdb9mr394782d50.40.1780022096692;
        Thu, 28 May 2026 19:34:56 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:7a41:d368:8442:1cb2])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66053d74a4csm151554d50.20.2026.05.28.19.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 19:34:56 -0700 (PDT)
Date: Thu, 28 May 2026 22:34:55 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v9 4/9] samples/landlock: Add quiet flag support to
 sandboxer
Message-ID: <ahj6gwXIbb58VFsZ@zenbox>
References: <cover.1779843375.git.m@maowtm.org>
 <7d5ad9631a51df6c2b857ff9c0122ff8ed491b7d.1779843375.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d5ad9631a51df6c2b857ff9c0122ff8ed491b7d.1779843375.git.m@maowtm.org>

On Wed, May 27, 2026 at 02:01:14AM +0100, Tingmao Wang wrote:
> Adds ability to set which access bits to quiet via LL_*_QUIET_ACCESS (FS,
> NET or SCOPED), and attach quiet flags to individual objects via
> LL_*_QUIET for FS and NET.
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
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
>  samples/landlock/sandboxer.c | 134 ++++++++++++++++++++++++++++++++---
>  1 file changed, 123 insertions(+), 11 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index 94e399e6b146..74ee53afed6a 100644
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
> +		else if (strcmp(str_access, "c") == 0)
> +			*quiet_access |= LANDLOCK_ACCESS_NET_CONNECT_TCP;
> +		else if (strcmp(str_access, "ub") == 0)
> +			*quiet_access |= LANDLOCK_ACCESS_NET_BIND_UDP;
> +		else if (strcmp(str_access, "uc") == 0)
> +			*quiet_access |= LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
> +		else if (strcmp(str_access, "a") == 0)
> +			*quiet_access |= LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
> +		else if (strcmp(str_access, "s") == 0)
> +			*quiet_access |= LANDLOCK_SCOPE_SIGNAL;
You don't need to do it in this patch but these strings should probably
be centrally defined somewhere... as we add more they could be easy to
mix up.
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
> +	bool quiet_supported = true;
>  	int supported_restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
>  	int set_restrict_flags = 0;
>  
> @@ -459,6 +537,9 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  		ruleset_attr.handled_access_net &=
>  			~(LANDLOCK_ACCESS_NET_BIND_UDP |
>  			  LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
> +		__attribute__((fallthrough));
The fallthrough should be the last statement in the switch case;
otherwise this causes a build warning.
> +		/* Don't add quiet flags for ABI < 10 later on. */
> +		quiet_supported = false;
>  
>  		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
>  		fprintf(stderr,
> @@ -525,6 +606,25 @@ int main(const int argc, char *const argv[], char *const *const envp)
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
> @@ -532,30 +632,42 @@ int main(const int argc, char *const argv[], char *const *const envp)
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
