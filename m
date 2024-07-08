Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474291D6AA
	for <linux-security-module@vger.kernel.org>; Mon,  8 Jul 2024 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720459904; cv=none; b=CufnZvQUOgrAUwoumGdNkddk+rcZ3hLY95+bV/K1UVcl4X+j9NZCGRhcj3nwbxqqWEgyNrwmpS2i+xi0Yz8LK+UrROkFB2EHSgMRZR0a9AyjuIzplLady1v9bUxLpKoWRjlICcy/yEg3vOpp7YynfnrBROEi3qYRvv+wj527PSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720459904; c=relaxed/simple;
	bh=lJ2932qDkC0LYg+crodmOu1OYYAGfPXir2mvX7XuYlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=az0B4611UHxz50eXw8daXqfrEx0UoYpvpYIdnSgVIgCKV2eQHx3nTm1LBMyvo7rClxTqVGaL2qoDlnvcS8u92CMBSUmYEha3gdFZIPj0Kv0H7eH6/i/+i+yk/ieUAL/IWjUo1SMGFwyCzcpFG/qC61b6XmTlyQa7DpYG4znL77c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=wrHC8FpA; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="wrHC8FpA"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WHrlH2nGgz7CV;
	Mon,  8 Jul 2024 19:31:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720459899;
	bh=mQnW5NCn1TmU2xbMOO/R79KgJurHxMXyQn21myAso+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wrHC8FpAa0Nrl6MDhZVLEh2IeCdDaKszP59Loyn9h+Zj4ecIdUMCDDZKe7nSZkOwP
	 uzWsImMOqfvVuCwR+BC6UzTKJmdW3P8jRIgpiH2ZG68a9aMTMVELy+D/AFwLi4zKW1
	 hotUiwgj3pzOluGti7Y3vY2hLM6TYdSwJLXo5s3g=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WHrlG41Ygz3C2;
	Mon,  8 Jul 2024 19:31:38 +0200 (CEST)
Date: Mon, 8 Jul 2024 19:31:35 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Jann Horn <jannh@google.com>, outreachy@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH 0/2] Landlock: Add abstract unix socket connect
 reastriction
Message-ID: <20240708.nujahgh6Zeec@digikod.net>
References: <cover.1720203255.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1720203255.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

Please send inline patches, and don't forget to set the patch series
version.  Because the difference with the previous series is only about
formatting, I'l only review the previous one.

On Fri, Jul 05, 2024 at 12:58:10PM -0600, Tahera Fahimi wrote:
> This patch series introduces the optional scoping of abstract unix
> sockets. This feature aims to scope the connection of an abstract socket
> from a sandbox process to other sockets outside of the sandbox domain.
> (see [1, 2])
> 
> The following changes are included in this series:
>   [PATCH 1/2]: Introduce the "scoped" field to the ruleset structure in
>                the user space interface, and add the restriction
>                mechanism to Landlock.
>   [PATCH 2/2]: Add three comprehensive tests for the new feature.
> 
> Tahera Fahimi (2):
>   Landlock: Add abstract unix socket connect restriction
>   Landlock: Abstract unix socket restriction tests
> 
>  include/uapi/linux/landlock.h                 |  29 +
>  security/landlock/limits.h                    |   3 +
>  security/landlock/ruleset.c                   |   7 +-
>  security/landlock/ruleset.h                   |  23 +-
>  security/landlock/syscalls.c                  |  12 +-
>  security/landlock/task.c                      |  62 ++
>  .../testing/selftests/landlock/ptrace_test.c  | 786 ++++++++++++++++++
>  7 files changed, 916 insertions(+), 6 deletions(-)
> 
> [1]: https://lore.kernel.org/all/20231023.ahphah4Wii4v@digikod.net/
> [2]: https://lore.kernel.org/all/20231102.MaeWaepav8nu@digikod.net/
> -- 
> 2.34.1
> 



