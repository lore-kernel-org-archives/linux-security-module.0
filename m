Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E871513D297
	for <linux-security-module@vger.kernel.org>; Tue, 24 Dec 2024 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735052417; cv=none; b=iwuj4P/rmt5fPbj1f0O0/AVhDZaJcKSXFHVv8Hs03VaMiUtztN9AiCYxZyJysyyfHMMhZ2/2f7LmdJJHeq16fCVkiZ+BqUy8CIb4qj/PVD1vvpZR6eYLkZIvCtkGg0dj46DHa/j5JI8S8SHC0oUD5wYc+YZxdUPYD5xeOtzxAFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735052417; c=relaxed/simple;
	bh=/l2+xgkgO9ZOfO3XKC4+IMvXULmDwNx6sJQxZczWxyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWBDzJ8G8xU7cyz3fBSL24qzielzmXtlKFK56MWZr2xyTHrd9TWZ+o0MNdYLDOnFZwzCpRyrcgHeayDPw6SO+RF4r0UTicyC4KTB9mBKwV0ZvhYJg7JMODTpxBx8PRXOF74o5UDhuwyOK8Hirr5U+b/uK1sRzHaU6FkQp47sKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=mNQY3cUP; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="mNQY3cUP"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YHd79099szc39;
	Tue, 24 Dec 2024 15:48:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1735051716;
	bh=JGWOy/MC7MeXaj0JXftEppDx/WTOWGCNSglof3I0OBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mNQY3cUPBHRoHddylktp9e4ab9nrERzQTqGcsAFhUP9g6KiNTedjcPjmrDkcU8idr
	 IgyWJc9pN/8MtsmYDMPoE2R63PsVxj0Bjvj5P8RYdQJnVVWnajavskBGCH7TgUdp3h
	 saiqvZXbYQi71Xx3H0luJpkkeKcedQqWW9z7H4UQ=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YHd781Cmdzpjs;
	Tue, 24 Dec 2024 15:48:36 +0100 (CET)
Date: Tue, 24 Dec 2024 15:48:35 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Charles Zaffery <czaffery@roblox.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, 
	Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, 
	Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, 
	Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 20/23] samples/landlock: Do not log denials from the
 sandboxer by default
Message-ID: <20241224.eiK1Kiexei6e@digikod.net>
References: <20241122143353.59367-1-mic@digikod.net>
 <20241122143353.59367-21-mic@digikod.net>
 <13663278.uLZWGnKmhe@pwmachine>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13663278.uLZWGnKmhe@pwmachine>
X-Infomaniak-Routing: alpha

On Fri, Dec 20, 2024 at 03:36:30PM +0100, Francis Laniel wrote:
> Le vendredi 22 novembre 2024, 15:33:50 CET Mickaël Salaün a écrit :
> > Do not pollute audit logs because of unknown sandboxed programs.
> > Indeed, the sandboxer's security policy might not be fitted to the set
> > of sandboxed processes that could be spawned (e.g. from a shell).
> > 
> > The LANDLOCK_RESTRICT_SELF_LOGLESS flag should be used for all similar
> > sandboxer tools by default.  Only natively-sandboxed programs should not
> > use this flag.
> > 
> > For test purpose, parse the LL_FORCE_LOG environment variable to still
> > log denials.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20241122143353.59367-21-mic@digikod.net
> > ---
> > 
> > Changes since v2:
> > - New patch.
> > ---
> >  samples/landlock/sandboxer.c | 35 ++++++++++++++++++++++++++++++++---
> >  1 file changed, 32 insertions(+), 3 deletions(-)
> > 
> > diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> > index 57565dfd74a2..49fd4fdb1dcf 100644
> > --- a/samples/landlock/sandboxer.c
> > +++ b/samples/landlock/sandboxer.c
> > @@ -58,6 +58,7 @@ static inline int landlock_restrict_self(const int
> > ruleset_fd, #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
> >  #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
> >  #define ENV_SCOPED_NAME "LL_SCOPED"
> > +#define ENV_FORCE_LOG_NAME "LL_FORCE_LOG"
> >  #define ENV_DELIMITER ":"
> > 
> >  static int str2num(const char *numstr, __u64 *num_dst)
> > @@ -288,7 +289,7 @@ static bool check_ruleset_scope(const char *const
> > env_var,
> > 
> >  /* clang-format on */
> > 
> > -#define LANDLOCK_ABI_LAST 6
> > +#define LANDLOCK_ABI_LAST 7
> > 
> >  #define XSTR(s) #s
> >  #define STR(s) XSTR(s)
> > @@ -315,6 +316,9 @@ static const char help[] =
> >  	"  - \"a\" to restrict opening abstract unix sockets\n"
> >  	"  - \"s\" to restrict sending signals\n"
> >  	"\n"
> > +	"A sandboxer should not log denied access requests to avoid spamming 
> logs,
> > " +	"but to test audit we can set " ENV_FORCE_LOG_NAME "=1\n"
> > +	"\n"
> >  	"Example:\n"
> >  	ENV_FS_RO_NAME "=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
> >  	ENV_FS_RW_NAME "=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
> > @@ -333,7 +337,7 @@ int main(const int argc, char *const argv[], char *const
> > *const envp) const char *cmd_path;
> >  	char *const *cmd_argv;
> >  	int ruleset_fd, abi;
> > -	char *env_port_name;
> > +	char *env_port_name, *env_force_log;
> >  	__u64 access_fs_ro = ACCESS_FS_ROUGHLY_READ,
> >  	      access_fs_rw = ACCESS_FS_ROUGHLY_READ | ACCESS_FS_ROUGHLY_WRITE;
> > 
> > @@ -344,6 +348,8 @@ int main(const int argc, char *const argv[], char *const
> > *const envp) .scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
> >  			  LANDLOCK_SCOPE_SIGNAL,
> >  	};
> > +	/* Do not pollute audit logs because of unknown sandboxed programs. */
> > +	int restrict_flags = LANDLOCK_RESTRICT_SELF_LOGLESS;
> > 
> >  	if (argc < 2) {
> >  		fprintf(stderr, help, argv[0]);
> > @@ -415,6 +421,12 @@ int main(const int argc, char *const argv[], char
> > *const *const envp) /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
> >  		ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
> >  					 LANDLOCK_SCOPE_SIGNAL);
> > +		__attribute__((fallthrough));
> > +	case 6:
> > +		/* Removes LANDLOCK_RESTRICT_SELF_LOGLESS for ABI < 7 */
> > +		restrict_flags &= ~LANDLOCK_RESTRICT_SELF_LOGLESS;
> > +
> > +		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
> >  		fprintf(stderr,
> >  			"Hint: You should update the running kernel "
> >  			"to leverage Landlock features "
> > @@ -449,6 +461,23 @@ int main(const int argc, char *const argv[], char
> > *const *const envp) if (check_ruleset_scope(ENV_SCOPED_NAME,
> > &ruleset_attr))
> >  		return 1;
> > 
> > +	/* Enables optional logs. */
> > +	env_force_log = getenv(ENV_FORCE_LOG_NAME);
> > +	if (env_force_log) {
> > +		if (strcmp(env_force_log, "1") != 0) {
> > +			fprintf(stderr,
> > +				"Unknown value for " ENV_FORCE_LOG_NAME "\n");
> 
> "Unknown value for " ENV_FORCE_LOG_NAME ", got %s, expected 1\n", 
> env_force_log)
> This really helps users to figure out what they made wrong.

Indeed, I'll extend this message in the next version. Thanks.

> > +			return 1;
> > +		}
> > +		if (!(restrict_flags & LANDLOCK_RESTRICT_SELF_LOGLESS)) {
> > +			fprintf(stderr,
> > +				"Audit logs not supported by current kernel\n");
> > +			return 1;
> > +		}
> > +		restrict_flags &= ~LANDLOCK_RESTRICT_SELF_LOGLESS;
> > +		unsetenv(ENV_FORCE_LOG_NAME);
> > +	}
> > +
> >  	ruleset_fd =
> >  		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 
> 0);
> >  	if (ruleset_fd < 0) {
> > @@ -476,7 +505,7 @@ int main(const int argc, char *const argv[], char *const
> > *const envp) perror("Failed to restrict privileges");
> >  		goto err_close_ruleset;
> >  	}
> > -	if (landlock_restrict_self(ruleset_fd, 0)) {
> > +	if (landlock_restrict_self(ruleset_fd, restrict_flags)) {
> >  		perror("Failed to enforce ruleset");
> >  		goto err_close_ruleset;
> >  	}
> 
> 
> 
> 
