Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6059F2163B1;
	Fri, 20 Dec 2024 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705399; cv=none; b=GpY2/F4OxRZGhJJAy39N73nK7VcU7vqT9zZGyuVG+h6vG+tSXHh9i1yPkS0hk9p5ts3ziYDETE/KrILcLW4b9eiJIPsSaFfvKT4/KHchk9TMyeAi80pP88wgZG0l5J60yOSu3kkG+KfKdkn042GQeZn/qf8xy6kRs/goohr4wgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705399; c=relaxed/simple;
	bh=sKnf/L+/sxejxxicuDEQ7s3/TY+ULghVzwJwofnD87Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/HVetcNzoUeUnPwWQ0FhrToDv4Zcx3NzlJiD/VCGParzwdk5VXYV2ik5lw+ORWZVrewNDsTl3LAHg0eOE3I5WW5SJzR8515VRCIE5xcURYGzSEfWqIYzt91tdc24puRza7YTksniL3KztSVPwjY0e8u9jihsGCMSKKClaDuKVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qturSBJJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qturSBJJ"
Received: from pwmachine.localnet (230.60.66.37.rev.sfr.net [37.66.60.230])
	by linux.microsoft.com (Postfix) with ESMTPSA id C992B20D4DE3;
	Fri, 20 Dec 2024 06:36:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C992B20D4DE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734705396;
	bh=1DI8teXTJXo2gn82FY39tZLfhm5cU54dzruAzRVcwIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qturSBJJc7KRHsnb/GW/tlK9DbtfSv7tYvACySvfwUgooc2BJVcw5CxTtVajp2wwE
	 7yY73jCfuTaSTukEMK6Z/SeLGjrWFruQDXYeDim/XlFYxL34dA1OwrtC91PBVhHHZo
	 0FEBnhL+W1kKOmMjfXHMZZM/5z/XQYN1ANL3peik=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 20/23] samples/landlock: Do not log denials from the sandboxer by default
Date: Fri, 20 Dec 2024 15:36:30 +0100
Message-ID: <13663278.uLZWGnKmhe@pwmachine>
In-Reply-To: <20241122143353.59367-21-mic@digikod.net>
References: <20241122143353.59367-1-mic@digikod.net> <20241122143353.59367-21-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Le vendredi 22 novembre 2024, 15:33:50 CET Micka=EBl Sala=FCn a =E9crit :
> Do not pollute audit logs because of unknown sandboxed programs.
> Indeed, the sandboxer's security policy might not be fitted to the set
> of sandboxed processes that could be spawned (e.g. from a shell).
>=20
> The LANDLOCK_RESTRICT_SELF_LOGLESS flag should be used for all similar
> sandboxer tools by default.  Only natively-sandboxed programs should not
> use this flag.
>=20
> For test purpose, parse the LL_FORCE_LOG environment variable to still
> log denials.
>=20
> Cc: G=FCnther Noack <gnoack@google.com>
> Signed-off-by: Micka=EBl Sala=FCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241122143353.59367-21-mic@digikod.net
> ---
>=20
> Changes since v2:
> - New patch.
> ---
>  samples/landlock/sandboxer.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
>=20
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index 57565dfd74a2..49fd4fdb1dcf 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -58,6 +58,7 @@ static inline int landlock_restrict_self(const int
> ruleset_fd, #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
>  #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
>  #define ENV_SCOPED_NAME "LL_SCOPED"
> +#define ENV_FORCE_LOG_NAME "LL_FORCE_LOG"
>  #define ENV_DELIMITER ":"
>=20
>  static int str2num(const char *numstr, __u64 *num_dst)
> @@ -288,7 +289,7 @@ static bool check_ruleset_scope(const char *const
> env_var,
>=20
>  /* clang-format on */
>=20
> -#define LANDLOCK_ABI_LAST 6
> +#define LANDLOCK_ABI_LAST 7
>=20
>  #define XSTR(s) #s
>  #define STR(s) XSTR(s)
> @@ -315,6 +316,9 @@ static const char help[] =3D
>  	"  - \"a\" to restrict opening abstract unix sockets\n"
>  	"  - \"s\" to restrict sending signals\n"
>  	"\n"
> +	"A sandboxer should not log denied access requests to avoid spamming=20
logs,
> " +	"but to test audit we can set " ENV_FORCE_LOG_NAME "=3D1\n"
> +	"\n"
>  	"Example:\n"
>  	ENV_FS_RO_NAME "=3D\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
>  	ENV_FS_RW_NAME "=3D\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
> @@ -333,7 +337,7 @@ int main(const int argc, char *const argv[], char *co=
nst
> *const envp) const char *cmd_path;
>  	char *const *cmd_argv;
>  	int ruleset_fd, abi;
> -	char *env_port_name;
> +	char *env_port_name, *env_force_log;
>  	__u64 access_fs_ro =3D ACCESS_FS_ROUGHLY_READ,
>  	      access_fs_rw =3D ACCESS_FS_ROUGHLY_READ | ACCESS_FS_ROUGHLY_WRITE;
>=20
> @@ -344,6 +348,8 @@ int main(const int argc, char *const argv[], char *co=
nst
> *const envp) .scoped =3D LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
>  			  LANDLOCK_SCOPE_SIGNAL,
>  	};
> +	/* Do not pollute audit logs because of unknown sandboxed programs. */
> +	int restrict_flags =3D LANDLOCK_RESTRICT_SELF_LOGLESS;
>=20
>  	if (argc < 2) {
>  		fprintf(stderr, help, argv[0]);
> @@ -415,6 +421,12 @@ int main(const int argc, char *const argv[], char
> *const *const envp) /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
>  		ruleset_attr.scoped &=3D ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
>  					 LANDLOCK_SCOPE_SIGNAL);
> +		__attribute__((fallthrough));
> +	case 6:
> +		/* Removes LANDLOCK_RESTRICT_SELF_LOGLESS for ABI < 7 */
> +		restrict_flags &=3D ~LANDLOCK_RESTRICT_SELF_LOGLESS;
> +
> +		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
>  		fprintf(stderr,
>  			"Hint: You should update the running kernel "
>  			"to leverage Landlock features "
> @@ -449,6 +461,23 @@ int main(const int argc, char *const argv[], char
> *const *const envp) if (check_ruleset_scope(ENV_SCOPED_NAME,
> &ruleset_attr))
>  		return 1;
>=20
> +	/* Enables optional logs. */
> +	env_force_log =3D getenv(ENV_FORCE_LOG_NAME);
> +	if (env_force_log) {
> +		if (strcmp(env_force_log, "1") !=3D 0) {
> +			fprintf(stderr,
> +				"Unknown value for " ENV_FORCE_LOG_NAME "\n");

"Unknown value for " ENV_FORCE_LOG_NAME ", got %s, expected 1\n",=20
env_force_log)
This really helps users to figure out what they made wrong.
> +			return 1;
> +		}
> +		if (!(restrict_flags & LANDLOCK_RESTRICT_SELF_LOGLESS)) {
> +			fprintf(stderr,
> +				"Audit logs not supported by current kernel\n");
> +			return 1;
> +		}
> +		restrict_flags &=3D ~LANDLOCK_RESTRICT_SELF_LOGLESS;
> +		unsetenv(ENV_FORCE_LOG_NAME);
> +	}
> +
>  	ruleset_fd =3D
>  		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr),=20
0);
>  	if (ruleset_fd < 0) {
> @@ -476,7 +505,7 @@ int main(const int argc, char *const argv[], char *co=
nst
> *const envp) perror("Failed to restrict privileges");
>  		goto err_close_ruleset;
>  	}
> -	if (landlock_restrict_self(ruleset_fd, 0)) {
> +	if (landlock_restrict_self(ruleset_fd, restrict_flags)) {
>  		perror("Failed to enforce ruleset");
>  		goto err_close_ruleset;
>  	}



