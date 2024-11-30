Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE29820330;
	Sat, 30 Nov 2024 04:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732939733; cv=none; b=QS4QDk9bKBbfQ/GREpCOrvYD+37kEa3A7Uma7gXT7iuFcawJZV70wpbKthU0k5i/mi/rx4dntrhWkkzB8EWLN8sSszO9pXM/FWQeq/WGoS2SSHI7jwkz0EHgtWUynSVYBW4eNsORUpvqdocRpV3APBQ+v7g+crzeZ8tgzYAPmHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732939733; c=relaxed/simple;
	bh=Ra/qEqGylz90/Ef1ecdWd7CfA5ffLRvRAFot+tP+KTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hze5IrXAasFcfraG5gqaIJVVwrQ4hdrgkW4oSaDCk0LEggCm4vrEzN8G3H1R1CUPMW6ksD5tIblIpQ5OK6v5MfgKqrUH6QWOYpvqg798GFdUgBYJ7h79pDpztbRHQoLtr7XoGIfITHyVOprJwBSzfbzinhZfltkOk4kXV7FvK1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 118AD654; Fri, 29 Nov 2024 22:08:42 -0600 (CST)
Date: Fri, 29 Nov 2024 22:08:42 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: cgzones@googlemail.com
Cc: linux-security-module@vger.kernel.org, Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
	cocci@inria.fr
Subject: Re: [PATCH 01/11] coccinelle: Add script to reorder capable() calls
Message-ID: <20241130040842.GB65112@mail.hallyn.com>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
 <20241125104011.36552-11-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241125104011.36552-11-cgoettsche@seltendoof.de>

On Mon, Nov 25, 2024 at 11:40:04AM +0100, Christian Göttsche wrote:
> From: Christian Göttsche <cgzones@googlemail.com>
> 
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore
>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited
>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit
>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Hi,

these all look good to me.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

Except for, in fact, this patch, as I'm not versed in .cocci and
can't tell whether it's doing the right thing.  Looks like it is,
based on the patches you sent...

> ---
>  MAINTAINERS                                |  1 +
>  scripts/coccinelle/api/capable_order.cocci | 98 ++++++++++++++++++++++
>  2 files changed, 99 insertions(+)
>  create mode 100644 scripts/coccinelle/api/capable_order.cocci
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e7f017097701..ab5ea47b61e2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5106,6 +5106,7 @@ S:	Supported
>  F:	include/linux/capability.h
>  F:	include/uapi/linux/capability.h
>  F:	kernel/capability.c
> +F:	scripts/coccinelle/api/capable_order.cocci
>  F:	security/commoncap.c
>  
>  CAPELLA MICROSYSTEMS LIGHT SENSOR DRIVER
> diff --git a/scripts/coccinelle/api/capable_order.cocci b/scripts/coccinelle/api/capable_order.cocci
> new file mode 100644
> index 000000000000..4150d91b0f33
> --- /dev/null
> +++ b/scripts/coccinelle/api/capable_order.cocci
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Checks for capable() calls of the left side of a binary expression.
> +/// Reordering might avoid needless checks, LSM log messages, and more
> +/// restrictive LSM security policies (e.g. SELinux).
> +/// Can report false positives if the righthand side contains a nested
> +/// capability check or has side effects.
> +///
> +// Confidence: Moderate
> +// Copyright: (C) 2024 Christian Göttsche.
> +// Options: --no-includes --include-headers
> +// Keywords: capable, ns_capable, sockopt_ns_capable
> +//
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> +//----------------------------------------------------------
> +//  Pattern to ignore
> +//----------------------------------------------------------
> +
> +@ignore@
> +identifier F1 = { capable, ns_capable, sockopt_ns_capable };
> +identifier F2 = { capable, ns_capable, sockopt_ns_capable };
> +binary operator op,op1,op2;
> +expression E;
> +position p;
> +@@
> +
> +(
> +F1@p(...) op F2(...)
> +|
> +E op1 F1@p(...) op2 F2(...)
> +)
> +
> +
> +//----------------------------------------------------------
> +//  For patch mode
> +//----------------------------------------------------------
> +
> +@ depends on patch@
> +identifier F = { capable, ns_capable, sockopt_ns_capable };
> +binary operator op,op1,op2;
> +expression E,E1,E2;
> +expression list EL;
> +position p != ignore.p;
> +@@
> +
> +(
> +-  F@p(EL) op E
> ++  E op F(EL)
> +|
> +-  E1 op1 F@p(EL) op2 E2
> ++  E1 op1 E2 op2 F(EL)
> +)
> +
> +
> +//----------------------------------------------------------
> +//  For context mode
> +//----------------------------------------------------------
> +
> +@r1 depends on !patch exists@
> +identifier F = { capable, ns_capable, sockopt_ns_capable };
> +binary operator op,op1,op2;
> +expression E, E1, E2;
> +position p != ignore.p;
> +@@
> +
> +(
> +*  F@p(...) op E
> +|
> +*  E1 op1 F@p(...) op2 E2
> +)
> +
> +
> +//----------------------------------------------------------
> +//  For org mode
> +//----------------------------------------------------------
> +
> +@script:python depends on org@
> +p << r1.p;
> +@@
> +
> +cocci.print_main("WARNING opportunity for capable reordering",p)
> +
> +
> +//----------------------------------------------------------
> +//  For report mode
> +//----------------------------------------------------------
> +
> +@script:python depends on report@
> +p << r1.p;
> +@@
> +
> +msg = "WARNING opportunity for capable reordering"
> +coccilib.report.print_report(p[0], msg)
> -- 
> 2.45.2
