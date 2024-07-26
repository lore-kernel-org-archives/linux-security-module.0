Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0DA45009
	for <linux-security-module@vger.kernel.org>; Fri, 26 Jul 2024 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981093; cv=none; b=D/6ZT/tTsbnsn76e2r/r2m4eDBqC9osveSJzOMSGFGjKeB3hudtRv3EHBIHQY4N3g4u2rXJr9ryQgsgZN6xK+CfPa8v3r4CFSLor+VxSRnUeUWDuqr0nSVUdJf5YnaOEU4ODkBaxr8s/qkzjk6XscWfVCO0fXsn/93WdgsWMDOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981093; c=relaxed/simple;
	bh=nNt0zpC/6tOUSkyx0tkZG4O0/vc2H4GqqHBXub0k7sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiVD7Eozgw+xQhA9PYRuni7e/RgSM2sDF8tM/lPlP0dCI1VUplLKEuN178uByBPnuoXS6rXGLn56c+GQIG+HKSmE3x/AA755W/MQ8gBXBXwi/pfk8cLDFRhJCubJILhmCyZspovzLlx00LDTYDAzo4lvqq+7LqcxfGIyVwVKDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=NRX8m5gm; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="NRX8m5gm"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WVgJq1f42zFf5;
	Fri, 26 Jul 2024 10:04:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721981083;
	bh=+TAdx9l6iazb3Rz8qM4APrxPXViKUEuBFt8myb3aPqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NRX8m5gm1Wh1lzkAloWaMpdUObfxCI2cgpTHB4JU8iAGqBZoj5BEr/0qdT8CgQ98V
	 AtMeHHc6gHwQB8ElkStFtErF1bwowhXvI9q8w9MajwJQdJDOPyIyNhVJM8BfSKw2OZ
	 4hzyBPz+T2o7cfpMhDbMXdNiwBCSnw7jT5BUMaSg=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WVgJp1x3pz25K;
	Fri, 26 Jul 2024 10:04:42 +0200 (CEST)
Date: Fri, 26 Jul 2024 10:04:40 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	outreachy@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v7 4/4] documentation/landlock: Adding scoping mechanism
 documentation
Message-ID: <20240726.weu3Ee5aiTha@digikod.net>
References: <cover.1721269836.git.fahimitahera@gmail.com>
 <319fd95504a9e491fa756c56048e63791ecd2aed.1721269836.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <319fd95504a9e491fa756c56048e63791ecd2aed.1721269836.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Jul 17, 2024 at 10:15:22PM -0600, Tahera Fahimi wrote:
> - Defining ABI version 6 that supports IPC restriction.
> - Adding "scoped" to the "Access rights".
> - In current limitation, unnamed sockets are specified as
>   sockets that are not restricted.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
>  Documentation/userspace-api/landlock.rst | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 07b63aec56fa..61b91cc03560 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -8,7 +8,7 @@ Landlock: unprivileged access control
>  =====================================
>  
>  :Author: Mickaël Salaün
> -:Date: April 2024
> +:Date: July 2024
>  
>  The goal of Landlock is to enable to restrict ambient rights (e.g. global
>  filesystem or network access) for a set of processes.  Because Landlock
> @@ -306,6 +306,16 @@ To be allowed to use :manpage:`ptrace(2)` and related syscalls on a target
>  process, a sandboxed process should have a subset of the target process rules,
>  which means the tracee must be in a sub-domain of the tracer.
>  
> +IPC Scoping
> +-----------
> +
> +Similar to Ptrace, a sandboxed process should not be able to access the resources
> +(like abstract unix sockets, or signals) outside of the sandbox domain. For example,
> +a sandboxed process should not be able to :manpage:`connect(2)` to a non-sandboxed
> +process through abstract unix sockets (:manpage:`unix(7)`). This restriction is
> +applicable by optionally specifying ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET`` in
> +the ruleset.
> +
>  Truncating files
>  ----------------
>  
> @@ -404,7 +414,7 @@ Access rights
>  -------------
>  
>  .. kernel-doc:: include/uapi/linux/landlock.h
> -    :identifiers: fs_access net_access
> +    :identifiers: fs_access net_access scoped

If you look at the generated documentation, you'll see that the `Scope
flags` links are broken, and the related section is missing.  This is
because it should not be "scoped" but "scope" here.

With `make htmldocs` you'll also see that there are formating issues in
this (missing) section.
