Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A8120C01E
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2025 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508293; cv=none; b=KZFD/ugeI62poaUDCS46mDHsLkyosKezEe02Joz//yc8rEPcBQ8gw2ibCol3CEVmDbOGsAtX+2au+RaMWmG0Dc/Oy0OXsAEbvkntekgQp+eTScuKua8HlTakCa3G3mlkbwo0aqqNk7bdii6SZ/c/Oam299EiZNfKYN19RGCFNbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508293; c=relaxed/simple;
	bh=u+miRPmykWaMcbm+E2jQE4Aelfc3F5Gf5ycv/4LqgyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsNNjKXeKabVGjGlwdm4EYGkVzaLxaqbSrPjqy0k0p2R4yoGv7Y1s4hoZzQOVerHGEiFDjnu/jNo8PbA7hsRtZ/cyEEX+myOZiT6Mse8vI0SDNLxHmMwIe9Gr/Un+fkDClhp29UYYDgjituzBInzgtnTrsRGdK6A8293nYXjaNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Nxby1j75; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Nxby1j75"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YTzp9335Gz36b;
	Fri, 10 Jan 2025 12:24:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736508289;
	bh=m7YAAWVaDWoEsVCSyyiS4Bk+6Em2lWyy1M/jEsj8f50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nxby1j75kilfF6bQ38XTQO6c7RfTNTN4cQn0GA22GUT53SSjl2a2qy/9XOnr6vvEe
	 tfGAtw3OaBsL5MBw2fQf3raZ26tyny0FV4D2Ey6W27KxHeHh92CZ8Q0QOAo9ki3mRS
	 sVReQpoIHJPCZEu7oMrGqYGKY8Ba4F+UOSitnubU=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YTzp84jZMzcQ8;
	Fri, 10 Jan 2025 12:24:48 +0100 (CET)
Date: Fri, 10 Jan 2025 12:24:48 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, Francis Laniel <flaniel@linux.microsoft.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 20/30] selftests/landlock: Fix error message
Message-ID: <20250110.aiYiinie3aeb@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
 <20250108154338.1129069-21-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250108154338.1129069-21-mic@digikod.net>
X-Infomaniak-Routing: alpha

On Wed, Jan 08, 2025 at 04:43:28PM +0100, Mickaël Salaün wrote:
> The global variable errno may not be set in test_execute().  Do not use
> it in related error message.
> 
> Cc: Günther Noack <gnoack@google.com>
> Fixes: e1199815b47b ("selftests/landlock: Add user space tests")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20250108154338.1129069-21-mic@digikod.net

Pushed in my next tree to simplify next patch series.

> ---
> 
> Changes since v3:
> - New patch.
> ---
>  tools/testing/selftests/landlock/fs_test.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 42ce1e79ba82..a359c0d3107f 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -2011,8 +2011,7 @@ static void test_execute(struct __test_metadata *const _metadata, const int err,
>  	ASSERT_EQ(1, WIFEXITED(status));
>  	ASSERT_EQ(err ? 2 : 0, WEXITSTATUS(status))
>  	{
> -		TH_LOG("Unexpected return code for \"%s\": %s", path,
> -		       strerror(errno));
> +		TH_LOG("Unexpected return code for \"%s\"", path);
>  	};
>  }
>  
> -- 
> 2.47.1
> 
> 
