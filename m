Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13B412F584
	for <linux-security-module@vger.kernel.org>; Thu,  7 Mar 2024 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824935; cv=none; b=JjONfs9guPsSP6OKYdhI5QtxHamqwEbb+9JAFOE1lP+JoaAQwWTUg48ED48OqnWsFB2f0mZ2rbv8WBUOcihnO8GCxWua9j+HZLEDbzkgvwaORy9JuvF0AUjX0e6JQbc1nR8v6t4QGc6g4FE6AhGFwzhFrJXA0iq/ktO/Ar90EpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824935; c=relaxed/simple;
	bh=QuzVFkRNM0tjAFgkLhycwpcKPQHxl89XeD0+7SLcW9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6teUkvTZlyrVMmQ9rx55ob5rFH2qU9dmaDIdB4X2p4bqQfxgIxCSPnpVZdJKD2jyGMcXvVGs4eCyLse41igNZO7YBEIjstjCtFj0i32USpSF36zYxDimGOSMG1PZLfqilSaDRw4wZ7wfz1aORFdCojSWGAfbbX1hZsZlgSjMPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=TbsSdk36; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="TbsSdk36"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TrChf1dpszZFR;
	Thu,  7 Mar 2024 16:22:10 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TrChd5CNnzMppG4;
	Thu,  7 Mar 2024 16:22:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709824930;
	bh=QuzVFkRNM0tjAFgkLhycwpcKPQHxl89XeD0+7SLcW9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TbsSdk36quyBeLJ/JQYtZ/1X5Jw8iegz07OO/w8xatlavdd1hAxQ+45cWhJ/O9deu
	 OXIKHdzjPCqTPvZMx8UpTLZ5OmisSNHJFPNyrKFIT4PrU2gifnwsDx0gWT3giq2fz/
	 Qeq2tF86nPD9ydPLc9ZAdQspBWL5gNed2mFAqF98=
Date: Thu, 7 Mar 2024 16:21:58 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] samples/landlock: Don't error out if a file path cannot
 be opened
Message-ID: <20240307.ae4aeGhai5so@digikod.net>
References: <20240307143849.1517218-1-mic@digikod.net>
 <ZenaEzgGLkmwILUO@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZenaEzgGLkmwILUO@google.com>
X-Infomaniak-Routing: alpha

On Thu, Mar 07, 2024 at 04:15:31PM +0100, Günther Noack wrote:
> On Thu, Mar 07, 2024 at 03:38:49PM +0100, Mickaël Salaün wrote:
> > Instead of creating a hard error and aborting the sandbox creation,
> > accept file path not usable in the LL_FS_RO and LL_FS_RW environment
> > variables but only print a warning.  This makes it easier to test, for
> > instance with LL_FS_RO="${PATH}:/usr/lib:/lib"
> > 
> > Print that we are going to execute the command in the sandbox before
> > doing so.
> > 
> > Rename "launch" to "execute".
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  samples/landlock/sandboxer.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> > index d7323e5526be..22e8c35103ce 100644
> > --- a/samples/landlock/sandboxer.c
> > +++ b/samples/landlock/sandboxer.c
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: BSD-3-Clause
> >  /*
> > - * Simple Landlock sandbox manager able to launch a process restricted by a
> > + * Simple Landlock sandbox manager able to execute a process restricted by a
> >   * user-defined filesystem access control policy.
> 
> Slightly out of scope, but I think it should be "...restricted by user-defined
> file system and network access control policies."

Good catch. I integrated your suggestion. Thanks.

> 
> >   *
> >   * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
> > @@ -121,9 +121,11 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
> >  		if (path_beneath.parent_fd < 0) {
> >  			fprintf(stderr, "Failed to open \"%s\": %s\n",
> >  				path_list[i], strerror(errno));
> > -			goto out_free_name;
> > +			continue;
> >  		}
> >  		if (fstat(path_beneath.parent_fd, &statbuf)) {
> > +			fprintf(stderr, "Failed to stat \"%s\": %s\n",
> > +				path_list[i], strerror(errno));
> >  			close(path_beneath.parent_fd);
> >  			goto out_free_name;
> >  		}
> > @@ -229,7 +231,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
> >  			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
> >  			ENV_TCP_CONNECT_NAME, argv[0]);
> >  		fprintf(stderr,
> > -			"Launch a command in a restricted environment.\n\n");
> > +			"Execute a command in a restricted environment.\n\n");
> >  		fprintf(stderr,
> >  			"Environment variables containing paths and ports "
> >  			"each separated by a colon:\n");
> > @@ -250,7 +252,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
> >  			ENV_TCP_CONNECT_NAME);
> >  		fprintf(stderr,
> >  			"\nexample:\n"
> > -			"%s=\"/bin:/lib:/usr:/proc:/etc:/dev/urandom\" "
> > +			"%s=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
> >  			"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
> >  			"%s=\"9418\" "
> >  			"%s=\"80:443\" "
> > @@ -390,6 +392,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
> >  
> >  	cmd_path = argv[1];
> >  	cmd_argv = argv + 1;
> > +	fprintf(stderr, "Executing the sandboxed command...\n");
> >  	execvpe(cmd_path, cmd_argv, envp);
> >  	fprintf(stderr, "Failed to execute \"%s\": %s\n", cmd_path,
> >  		strerror(errno));
> > -- 
> > 2.44.0
> > 
> 
> Reviewed-by: Günther Noack <gnoack@google.com>
> 
