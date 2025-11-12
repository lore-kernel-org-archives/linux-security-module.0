Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6322D73B0
	for <linux-security-module@vger.kernel.org>; Wed, 12 Nov 2025 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762967010; cv=none; b=MrFBzgmAm6vyJWJUPbWUi1fIf9MCNRwfoR+BhxefzLga1PxGpMed+dBboSG8KE+OsoA/6g9D58uhQ4Cp4tAFdn1zE2/Z9D0ksjOBzD71TEIC2ETSbHLaHIKTUAyrXtoHIaCD3j0JzZgLK4JFPJWl1R004UBFnOD+yHaM/wu6yJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762967010; c=relaxed/simple;
	bh=bzl9kw1v55JrzNj39zOlh/CGfRCrVUPdAF2Xs788tD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cc5zqjctOSO/WPvqDg62IOTRvovvm2qMlyA+lipjyvB1RV7y2DJ3UEMC7lnFbBmuOeBkrFHGoqZMgpx7VTmCMnig41HDbXzAVwVYWaULz8GKQKTSpUKNpyHDw+LbuvQT1pNgazVvQW6VVCdHhAa7tx423zp8BLWGa2WRUDL7vqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OQABuwGA; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OQABuwGA"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d68qR09JRz12vm;
	Wed, 12 Nov 2025 18:03:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1762966994;
	bh=7ide/Co3o20IJteqMoG6hAIdrj7+9V+hrcgIeeRx/KQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OQABuwGAGjQXWh2YtLbLtj0qE/avciU8gP/AE3B09Cwef6wAWvsaOHW9a9SDmON9V
	 LBAzugADm5hUJe2pOmogDKTCAvYBud/hI16ID6uJKDwAtDgZEv8CBqcWYZ7So1bZ6E
	 RaTs4u+JdX0vnuf7E5/xwcLIZ2BAZCkpi7p9LLVw=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4d68qQ3sH7zKgr;
	Wed, 12 Nov 2025 18:03:14 +0100 (CET)
Date: Wed, 12 Nov 2025 18:03:13 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] selftests/landlock: Fix makefile header list
Message-ID: <20251112.viiboowaiNg5@digikod.net>
References: <20251027011440.1838514-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251027011440.1838514-1-matthieu@buffet.re>
X-Infomaniak-Routing: alpha

On Mon, Oct 27, 2025 at 02:14:40AM +0100, Matthieu Buffet wrote:
> Make all headers part of make's dependencies computations.
> Otherwise, updating audit.h, common.h, scoped_base_variants.h,
> scoped_common.h, scoped_multiple_domain_variants.h, or wrappers.h,
> re-running make and running selftests could lead to testing stale headers.
> 
> Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
> Fixes: fefcf0f7cf47 ("selftests/landlock: Test abstract UNIX socket scoping")
> Fixes: 5147779d5e1b ("selftests/landlock: Add wrappers.h")
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
> I was troubleshooting why some auditing selftests kept failing at random
> (recvfrom() sometimes returning EAGAIN in audit_recv()). I did not
> troubleshoot it yet, but I did find this first step while trying to edit
> audit.h in vain:

Thanks! I'll merge this patch in -next.

> 
>  tools/testing/selftests/landlock/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
> index a3f449914bf9..044b83bde16e 100644
> --- a/tools/testing/selftests/landlock/Makefile
> +++ b/tools/testing/selftests/landlock/Makefile
> @@ -4,7 +4,7 @@
>  
>  CFLAGS += -Wall -O2 $(KHDR_INCLUDES)
>  
> -LOCAL_HDRS += common.h
> +LOCAL_HDRS += $(wildcard *.h)
>  
>  src_test := $(wildcard *_test.c)
>  
> 
> base-commit: 6dde339a3df80a57ac3d780d8cfc14d9262e2acd
> -- 
> 2.47.2
> 
> 
