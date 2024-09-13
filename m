Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B776F2E2
	for <linux-security-module@vger.kernel.org>; Fri, 13 Sep 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726245206; cv=none; b=Z8aKPAJ54rTz2v2gi8lo+Ge3oZrIT5HCe1ssevmWeP6jqcxR+LgU/pzC6Pw4C2MLOjmtQ2iq0sLMcU7bo+AMSGj6uuVHTFQic83UqE/Cj83rLB5ITniiY7X/D2XBRuo0TGYoqIO+sKugvR9DRA2S3Fr6/oYK8LaqRXsVYNn8w7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726245206; c=relaxed/simple;
	bh=f+359BLhYQ/Pg24mzq1ifHF0ls/rX9zTnkmJM6Jpxkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUZTeZOzlKc+xSILsdVyyF97WT8Lj1w/o0Q2DD+9MjCJFBV/uHPJi4RVfS+K9ixliS57YrF/TsYwfJU18TKMs1+y5Pf8y4+xBfZRgV0D58POto6+qBMxujgk4PgxkR0sWHfOhl3lNrcgPEcwzn6z2v5JFtEfSUs1PwuLYbaRHKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=WIY7Z/3I; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="WIY7Z/3I"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4X50Gw0wvPz9ZT;
	Fri, 13 Sep 2024 18:33:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1726245192;
	bh=jL3SgGv5TLclTQUubcFPqq833ZrkKmojbZCL1JIDaHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WIY7Z/3IAa1GQIu+Lv08iD0+3zMhCcwthtjR8rC73MwiT6LKOiStafOZpFbSedAeJ
	 DVXoy+jV6k49dVfznUPANh0X3SbBACoUO38ERyTmWkEyCKp4PvWuPS33Vu6pklZBuA
	 HYn/eLOZsxDQPDEcJiB+Ir1yXUiVUDJLEckTDRCo=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4X50Gv0fyVzJ4f;
	Fri, 13 Sep 2024 18:33:11 +0200 (CEST)
Date: Fri, 13 Sep 2024 18:33:03 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v11 0/8] Landlock: Add abstract UNIX socket restriction
Message-ID: <20240913.Doof4aiK8soh@digikod.net>
References: <cover.1725494372.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1725494372.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

I have reworked a bit the patches, including the signal scoping ones,
and they are here:
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next

This is based on a manual merge of some VFS changes and LSM changes
required for this patch series:
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/commit/?h=next&id=24dfe95e493086a99acf7df1ef23d9f21f8cdec7

My changes are explained in the "[mic: ...]" part of the commit
messages. Please send two last patch series, with this changes and reply
to it with your comments if any.

On Wed, Sep 04, 2024 at 06:13:54PM -0600, Tahera Fahimi wrote:
> This patch series adds scoping mechanism for abstract UNIX sockets.
> Closes: https://github.com/landlock-lsm/linux/issues/7
> 
> Problem
> =======
> 
> Abstract UNIX sockets are used for local inter-process communications
> independent of the filesystem. Currently, a sandboxed process can
> connect to a socket outside of the sandboxed environment, since Landlock
> has no restriction for connecting to an abstract socket address(see more
> details in [1,2]). Access to such sockets for a sandboxed process should
> be scoped the same way ptrace is limited.
> 
> [1] https://lore.kernel.org/all/20231023.ahphah4Wii4v@digikod.net/
> [2] https://lore.kernel.org/all/20231102.MaeWaepav8nu@digikod.net/
> 
> Solution
> ========
> 
> To solve this issue, we extend the user space interface by adding a new
> "scoped" field to Landlock ruleset attribute structure. This field can
> contains different rights to restrict different functionalities. For
> abstract UNIX sockets, we introduce
> "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" field to specify that a ruleset
> will deny any connection from within the sandbox domain to its parent
> (i.e. any parent sandbox or non-sandbox processes).
> 
> Example
> =======
> 
> Starting a listening socket with socat(1):
>         socat abstract-listen:mysocket -
> 
> Starting a sandboxed shell from $HOME with samples/landlock/sandboxer:
>         LL_FS_RO=/ LL_FS_RW=. LL_SCOPED="a" ./sandboxer /bin/bash
> 
> If we try to connect to the listening socket, the connection gets
> refused.
>         socat - abstract-connect:mysocket --> fails
> 
> 
> Notes of Implementation
> =======================
> 
> * Using the "scoped" field provides enough compatibility and flexibility
>   to extend the scoping mechanism for other IPCs(e.g. signals).
> 
> * To access the domain of a socket, we use its credentials of the file's
>   FD which point to the credentials of the process that created the
>   socket (see more details in [3]). Cases where the process using the
>   socket has a different domain than the process created it are covered
>   in the "outside_socket" test.
> 
> [3]https://lore.kernel.org/all/20240611.Pi8Iph7ootae@digikod.net/
> 
> Previous Versions
> =================
> v10:https://lore.kernel.org/all/cover.1724125513.git.fahimitahera@gmail.com/
> v9: https://lore.kernel.org/all/cover.1723615689.git.fahimitahera@gmail.com/
> v8: https://lore.kernel.org/all/cover.1722570749.git.fahimitahera@gmail.com/
> v7: https://lore.kernel.org/all/cover.1721269836.git.fahimitahera@gmail.com/
> v6: https://lore.kernel.org/all/Zn32CYZiu7pY+rdI@tahera-OptiPlex-5000/
> and https://lore.kernel.org/all/Zn32KKIJrY7Zi51K@tahera-OptiPlex-5000/
> v5: https://lore.kernel.org/all/ZnSZnhGBiprI6FRk@tahera-OptiPlex-5000/
> v4: https://lore.kernel.org/all/ZnNcE3ph2SWi1qmd@tahera-OptiPlex-5000/
> v3: https://lore.kernel.org/all/ZmJJ7lZdQuQop7e5@tahera-OptiPlex-5000/
> v2: https://lore.kernel.org/all/ZgX5TRTrSDPrJFfF@tahera-OptiPlex-5000/
> v1: https://lore.kernel.org/all/ZgXN5fi6A1YQKiAQ@tahera-OptiPlex-5000/
> 
> Tahera Fahimi (8):
>   Landlock: Add abstract UNIX socket restriction
>   selftests/landlock: Add test for handling unknown scope
>   selftests/landlock: Add abstract UNIX socket restriction tests
>   selftests/landlock: Add tests for UNIX sockets with any address
>     formats
>   selftests/landlock: Test connected vs non-connected datagram UNIX
>     socket
>   selftests/landlock: Restrict inherited datagram UNIX socket to connect
>   sample/landlock: Add support abstract UNIX socket restriction
>   Landlock: Document LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET and ABI
>     version
> 
>  Documentation/userspace-api/landlock.rst      |  45 +-
>  include/uapi/linux/landlock.h                 |  28 +
>  samples/landlock/sandboxer.c                  |  61 +-
>  security/landlock/limits.h                    |   3 +
>  security/landlock/ruleset.c                   |   7 +-
>  security/landlock/ruleset.h                   |  24 +-
>  security/landlock/syscalls.c                  |  17 +-
>  security/landlock/task.c                      | 136 +++
>  tools/testing/selftests/landlock/base_test.c  |   2 +-
>  tools/testing/selftests/landlock/common.h     |  38 +
>  tools/testing/selftests/landlock/net_test.c   |  31 +-
>  .../landlock/scoped_abstract_unix_test.c      | 993 ++++++++++++++++++
>  .../selftests/landlock/scoped_base_variants.h | 154 +++
>  .../selftests/landlock/scoped_common.h        |  28 +
>  .../scoped_multiple_domain_variants.h         | 154 +++
>  .../testing/selftests/landlock/scoped_test.c  |  33 +
>  16 files changed, 1709 insertions(+), 45 deletions(-)
>  create mode 100644 tools/testing/selftests/landlock/scoped_abstract_unix_test.c
>  create mode 100644 tools/testing/selftests/landlock/scoped_base_variants.h
>  create mode 100644 tools/testing/selftests/landlock/scoped_common.h
>  create mode 100644 tools/testing/selftests/landlock/scoped_multiple_domain_variants.h
>  create mode 100644 tools/testing/selftests/landlock/scoped_test.c
> 
> -- 
> 2.34.1
> 
