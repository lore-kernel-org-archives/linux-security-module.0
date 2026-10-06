Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1FF381E8B
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280679; cv=none; b=Q2Bgq4/CNNpC9QXB29/5skojrJJcGGvzKF1twNc8pZK2gysAz0WaH8M0Uf2rPh98Jxs38whzaQhLIsERcQHKUeRNr0/sx3CiRWcKz9sPFCCLb6Uz5qfPIUk1N0xsiyGhf9w21Y3YoYukIM/BxxlEujtPqtWbyqwJ2XxSUren6rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280679; c=relaxed/simple;
	bh=YNcRnPEVP+qc0WGUwQzbE068+g8DJVqvvtACuLU8VXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xb1RYW1zFEJkPW4l+O47rlIX8GWmxDUfnk5vYkpZhOmklbl6jCoXbasxTEwFSXQiWdDGD8pVrFKsd8BXLTq7CiDBzTLRuUJDpMaHMBMtSAn1cSfFQfriPOfGLExHVPWx9pGrnQcw8fd0B0kDJOcRorLFsT+VTwYedhCbSJt9Ulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=b8xsTaYQ; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="b8xsTaYQ"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hzWs81Lh5zx5k;
	Tue,  6 Oct 2026 11:57:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1791280668;
	bh=RbgEgqgxRxR4ygPWO3HOXHZyC2gErfjPlV6vBFA+BJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b8xsTaYQ6P9x83/R4WxHJhwy2jmu/vN27AU5vx9FtaBWR/JYQrTduw/v/WIShWHT4
	 sNlEx3cIfzUeDMRWwQFS1KnvZGGB3FZBpdWTZ4yGFekn6a32g7pGOZ4JwDQxILM1x3
	 3czVhH+XnuAk7nN6iZu9O3PtoFEIruuqzg+ZkeBo=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hzWs73rl3zwgv;
	Tue,  6 Oct 2026 11:57:47 +0200 (CEST)
Date: Tue, 6 Oct 2026 11:57:46 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 7/8] samples/landlock: Add capability and namespace
 restriction support
Message-ID: <20261006.FaeKaeteefe4@digikod.net>
References: <20261002124409.1277970-1-mic@digikod.net>
 <20261002124409.1277970-8-mic@digikod.net>
 <20261002125330.A4FA11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002125330.A4FA11F000FF@smtp.kernel.org>
X-Infomaniak-Routing: alpha

On Fri, Oct 02, 2026 at 12:53:30PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Low] build: sample landlock fails on systems without libcap-dev
> - [Low] build: missing fallback for CLONE_NEWTIME breaks build on glibc < 2.33
> --
> 
> commit c88aebdbd55f6c34b61885d4e3d918bc61983af0
> Author: Mickaël Salaün <mic@digikod.net>
> 
> samples/landlock: Add capability and namespace restriction support
> 
> This commit extends the sandboxer sample to demonstrate new Landlock
> capability and namespace restriction features. It allows parsing allowed
> namespaces and capabilities using libcap, adding appropriate command line
> arguments for testing.
> 
> > diff --git a/samples/Kconfig b/samples/Kconfig
> > index a75e8e78330da..b18efc19b85d0 100644
> > --- a/samples/Kconfig
> > +++ b/samples/Kconfig
> > @@ -166,8 +166,10 @@ config SAMPLE_LANDLOCK
> >  	bool "Landlock example"
> >  	depends on CC_CAN_LINK && HEADERS_INSTALL
> >  	help
> > -	  Build a simple Landlock sandbox manager able to start a process
> > -	  restricted by a user-defined filesystem access control policy.
> > +	  Build a Landlock sandbox manager able to start a process restricted
> > +	  by user-defined filesystem, network, scope, namespace, and capability
> > +	  policies.  This sample requires the libcap development headers and
> > +	  library.
> >  
> >  config SAMPLE_PIDFD
> >  	bool "pidfd sample"
> 
> [ ... ]
> 
> > diff --git a/samples/landlock/Makefile b/samples/landlock/Makefile
> > index 5d601e51c2ebf..b30239c8a281c 100644
> > --- a/samples/landlock/Makefile
> > +++ b/samples/landlock/Makefile
> > @@ -3,6 +3,7 @@
> >  userprogs-always-y := sandboxer
> >  
> >  userccflags += -I usr/include
> > +userldlibs += -lcap
> 
> [Severity: Low]
> Does this unconditional linking cause build failures during make allmodconfig
> or make samples if the host system lacks the libcap-dev library?
> 
> Since the Kconfig does not verify the presence of the libcap library (for
> example, using a $(success,...) check), the build will unconditionally
> attempt to link against it and fail when the dependency is missing. Could a
> dependency check be added in the Kconfig to prevent breaking automated 
> testing on minimal host environments?

I'll make libcap-dev optional.

> 
> >  
> >  .PHONY: all clean
> 
> [ ... ]
> 
> > diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> > index 030583273f3f7..4a86ae6d4552d 100644
> > --- a/samples/landlock/sandboxer.c
> > +++ b/samples/landlock/sandboxer.c
> > @@ -232,6 +241,166 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
> >  	return ret;
> >  }
> >  
> > +static __u64 str2ns(const char *const name)
> > +{
> > +	static const struct {
> > +		const char *name;
> > +		__u64 value;
> > +	} ns_map[] = {
> > +		/* clang-format off */
> > +		{ "cgroup",	CLONE_NEWCGROUP },
> > +		{ "ipc",	CLONE_NEWIPC },
> > +		{ "mnt",	CLONE_NEWNS },
> > +		{ "net",	CLONE_NEWNET },
> > +		{ "pid",	CLONE_NEWPID },
> > +		{ "time",	CLONE_NEWTIME },
> 
> [Severity: Low]
> Will this missing fallback macro for CLONE_NEWTIME cause compilation failures
> on older host environments?
> 
> The CLONE_NEWTIME macro was added to the glibc sched.h header starting in
> version 2.33. If the sample is built on a system with an older glibc, it
> fails to compile. Can we add a fallback preprocessor definition for 
> CLONE_NEWTIME so the sample can still build on older distributions?

I'll use the kernel headers.

> 
> > +		{ "user",	CLONE_NEWUSER },
> > +		{ "uts",	CLONE_NEWUTS },
> > +		/* clang-format on */
> > +	};
> > +	size_t i;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261002124409.1277970-1-mic@digikod.net?part=7
> 
