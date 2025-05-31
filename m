Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07A714831E
	for <linux-security-module@vger.kernel.org>; Sat, 31 May 2025 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748731354; cv=none; b=iAy6hsguS9niGs9c/fby0cXBv+vDjezG6WR83xwfcheW7JNHogcgqkyMiG5bE+QlhZrrlZ7dwPQSwent50mtdod0qpcXuw3W3M7xYUEuowvWMZeUq8sUD/P7sDMx4PuvcQSTMMPS4KdANcc4waMQKri02ModFQgtwJN73JnqNlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748731354; c=relaxed/simple;
	bh=V1vnaXbC6/Fh60JkZADEAcl+hIj5AJHugK4ZqFv3vT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKtUYpsaqp3GpORmaYyZ0bSrSic1IXbkScLjzF9Jy2nd6blrre0oAiNvwC9i1UWPokZhSQk+/mE0i9L0ut2CXmd1Dub+RmabHdf7GWQCdttSZag5TDqTi8dTRhGTaMyyKNFH6cvjnrFwP0byzdUlJVtuoyekEc1+tzPIUNHOixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id C7EBFBFC; Sat, 31 May 2025 17:37:22 -0500 (CDT)
Date: Sat, 31 May 2025 17:37:22 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: =?utf-8?B?4oSw8J2Tg/Cdk4/ihLQg4oSx8J2TivCdk4DihK8=?= <milesonerd@outlook.com>
Cc: "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 1/3] security: add Lilium - Linux Integrity Lock-In User
 Module
Message-ID: <20250531223722.GA84941@mail.hallyn.com>
References: <CPUP152MB625985A52C6370FD04970507B060A@CPUP152MB6259.LAMP152.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CPUP152MB625985A52C6370FD04970507B060A@CPUP152MB6259.LAMP152.PROD.OUTLOOK.COM>

On Sat, May 31, 2025 at 01:19:27PM +0000, ℰ𝓃𝓏ℴ ℱ𝓊𝓀ℯ wrote:
> This patch adds the Lilium (Linux Integrity Lock-In User Module) security module that blocks ptrace, mmap/mprotect with PROT_EXEC, kexec_load, clone and unshar, delete_module, init_module, open and openat, and ioctl, with modular configuration via sysfs.

1. Please send your patches as inline text, one patch per email
2. Your MAINTAINERS patch has the whole file, not a patch
3. The other patches actually lack the contents of the files you are adding.

-serge
