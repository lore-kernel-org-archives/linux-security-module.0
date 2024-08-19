Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3134145341;
	Mon, 19 Aug 2024 19:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097517; cv=none; b=UMufE4IsbI4BFGeQ/0syhFIdI0pCZF2siauLjxHdYgP5U7D71PoVe+75j4tHuv0T0WBogBGkkAnMvAxpNg1horVGVhvg2t47UwMrsDTb91j00hmE0DplraV/Smlfec/DBE4UMB9AjanOjHdMxpMfqxVFfMq9umicdlxEN3qt4iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097517; c=relaxed/simple;
	bh=nTuBf7fW68cmHEkmDYrtejR0f0z5ZbbPfVsaBOa6QFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXXSamFU6DOyf0I3QRkVIczMGR15u2AlBRmU6Ap6jzKzAJlxRsV15GzLSHRSVW9Y2XQZumvRCWIknOLxSme9KuKmefcE/+prMhoBRll5kDXS2Y6I+pYhwIX3IeyBgdvlRo4wF0J1inns/j1D5p9C6SbWpXlLbtwzstumMeDnGSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=CocaTxkR; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="CocaTxkR"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Wnk1M3RCFzR4p;
	Mon, 19 Aug 2024 21:58:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1724097511;
	bh=bilRigCR9rzEGvVaqFgvHt8gMB6RK0eoP2c0Cg2SkmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CocaTxkRxXpNaugZdgZ/kKEoaL3Ag3ROwicubIkVqj2iM4UjwjusyvR9YGECai07T
	 njK46hK2BASZbUNuQ0EUOFKdu02uOVred1ui9GU2mBn28iX0bLu/4g5ACS6ze0SjVV
	 V0bkXmssbnEjDkmXvJ3UOK7tfFO8lOYagLyIh9jE=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Wnk1L3cf8z4Dw;
	Mon, 19 Aug 2024 21:58:30 +0200 (CEST)
Date: Mon, 19 Aug 2024 21:58:27 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v9 0/5] Landlock: Add abstract unix socket connect
 restriction
Message-ID: <20240819.Gie1thiegeek@digikod.net>
References: <cover.1723615689.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723615689.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

There are still some issues (mainly with tests) but overall the kernel
part looks good!  I pushed this patch series to the -next branch.  I'll
update with the next versions of this series.

I'll do the same with the next signal scoping patch series once the
lifetime issue that Jann reported is fixed.

On Wed, Aug 14, 2024 at 12:22:18AM -0600, Tahera Fahimi wrote:
> This patch series adds scoping mechanism for abstract unix sockets.
> Closes: https://github.com/landlock-lsm/linux/issues/7
> 
> Problem
> =======
> 
> Abstract unix sockets are used for local inter-process communications
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
> abstract unix sockets, we introduce
> "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" field to specify that a ruleset
> will deny any connection from within the sandbox domain to its parent
> (i.e. any parent sandbox or non-sandbox processes).
> 
> Example
> =======
> 
> Starting a listening socket with socat(1):
> 	socat abstract-listen:mysocket -
> 
> Starting a sandboxed shell from $HOME with samples/landlock/sandboxer:
> 	LL_FS_RO=/ LL_FS_RW=. LL_SCOPED="a" ./sandboxer /bin/bash
> 
> If we try to connect to the listening socket, the connection would be
> refused.
> 	socat - abstract-connect:mysocket --> fails
> 
> 
> Notes of Implementation
> =======================
> 
> * Using the "scoped" field provides enough compatibility and flexibility
>   to extend the scoping mechanism for other IPCs(e.g. signals).
> 
> * To access the domain of a socket, we use its credentials of the file's FD
>   which point to the credentials of the process that created the socket.
>   (see more details in [3]). Cases where the process using the socket has
>   a different domain than the process created it are covered in the 
>   unix_sock_special_cases test.
> 
> [3]https://lore.kernel.org/all/20240611.Pi8Iph7ootae@digikod.net/
> 
> Previous Versions
> =================
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
> Tahera Fahimi (5):
>   Landlock: Add abstract unix socket connect restriction
>   selftests/Landlock: Abstract unix socket restriction tests
>   selftests/Landlock: Adding pathname Unix socket tests
>   sample/Landlock: Support abstract unix socket restriction
>   Landlock: Document LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET and ABI
>     versioning
> 
>  Documentation/userspace-api/landlock.rst      |   33 +-
>  include/uapi/linux/landlock.h                 |   27 +
>  samples/landlock/sandboxer.c                  |   58 +-
>  security/landlock/limits.h                    |    3 +
>  security/landlock/ruleset.c                   |    7 +-
>  security/landlock/ruleset.h                   |   23 +-
>  security/landlock/syscalls.c                  |   17 +-
>  security/landlock/task.c                      |  129 ++
>  tools/testing/selftests/landlock/base_test.c  |    2 +-
>  tools/testing/selftests/landlock/common.h     |   38 +
>  tools/testing/selftests/landlock/net_test.c   |   31 +-
>  .../landlock/scoped_abstract_unix_test.c      | 1146 +++++++++++++++++
>  12 files changed, 1469 insertions(+), 45 deletions(-)
>  create mode 100644 tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> 
> -- 
> 2.34.1
> 
> 
