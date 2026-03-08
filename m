Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC9D2727F3;
	Sun,  8 Mar 2026 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772998891; cv=none; b=lYbdhOvnFD4x45o9iW6BBxgrkfsK1cCXqjBZwRrfgZxEwKOcrGVFHfz3ai1nSCBzJcRfq6YdW3TtgLgc/uzuDOHnI3+PSKTMOlJswmkv0+tkFwNx1N2scBoIfQo39VZPlVB/mXmkAHCEBzBcdwHYT/75AFhcTby/nUsAeMxWK5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772998891; c=relaxed/simple;
	bh=sLY/dzS+Uruwmsh+umiW9j40z6XTbubJak4DCA0zzUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6ooe+rgFuuS2GhLat7UtRQxIG2U1eJF//a4H77BlfSZ/wyApSzc1/Gou8NnLHXZV00u+GeqWqY8p2KlZckGUHz1jURrTyKuFs9DNGWxjc7VcOY/FYvuQY/Mwky4npFldsvFIgfdst4VSu11IFr4II0JR2/fTHof3wglrPGRzFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ts3dhgUc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ts3dhgUc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Ciuj3SCC4PTq68olyTMdKKA/KQ8KJfZL5HLloa626DQ=; b=Ts3dhgUct+eS2Felvb/ow0uC91
	c0KUkRri1hDjiQysHoTmZaZhXk7+eVjF1ryerNKnDi9iSNMFNQCeiZwxrWZcytimrUb7Gril9q2BP
	rFR3rVncAOOXEmud6vOpvILGsUpSp1N583FGni4bqYrDI+zufgXHGfAgfMi1j2+ToTEXxjeuAMSgw
	WRWSttPP4G4oettWAPyyBCZc1cj38IUHF13lpvcmyGdKQQosV5S9whpkYwHvuvf+F4ykOL6oKA+Tc
	dxu0mp/lpM6ZWjNc4P9RWEVecFRdj3Wm5Cppi1TZm+b9v2EGY3lXu7JoAAFq5cQFkpOET6ZamLWbC
	17qlt/JQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzK06-00000006JEm-2JKW;
	Sun, 08 Mar 2026 19:41:18 +0000
Message-ID: <134fc611-a662-4d94-a922-6831f50895b3@infradead.org>
Date: Sun, 8 Mar 2026 12:41:16 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: security: ipe: fix typos and grammar
To: Evan Ducas <evan.j.ducas@gmail.com>, wufan@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org
Cc: bagasdotme@gmail.com, linux-security-module@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260308180734.5792-1-evan.j.ducas@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260308180734.5792-1-evan.j.ducas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/8/26 11:07 AM, Evan Ducas wrote:
> Fix several spelling and grammar mistakes in the IPE
> documentation.
> 
> No functional change.
> 
> Signed-off-by: Evan Ducas <evan.j.ducas@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/security/ipe.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/security/ipe.rst b/Documentation/security/ipe.rst
> index 4a7d953abcdc..5eb3e6265fbd 100644
> --- a/Documentation/security/ipe.rst
> +++ b/Documentation/security/ipe.rst
> @@ -18,7 +18,7 @@ strong integrity guarantees over both the executable code, and specific
>  *data files* on the system, that were critical to its function. These
>  specific data files would not be readable unless they passed integrity
>  policy. A mandatory access control system would be present, and
> -as a result, xattrs would have to be protected. This lead to a selection
> +as a result, xattrs would have to be protected. This led to a selection
>  of what would provide the integrity claims. At the time, there were two
>  main mechanisms considered that could guarantee integrity for the system
>  with these requirements:
> @@ -195,7 +195,7 @@ of the policy to apply the minute usermode starts. Generally, that storage
>  can be handled in one of three ways:
>  
>    1. The policy file(s) live on disk and the kernel loads the policy prior
> -     to an code path that would result in an enforcement decision.
> +     to a code path that would result in an enforcement decision.
>    2. The policy file(s) are passed by the bootloader to the kernel, who
>       parses the policy.
>    3. There is a policy file that is compiled into the kernel that is
> @@ -235,8 +235,8 @@ Updatable, Rebootless Policy
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  As requirements change over time (vulnerabilities are found in previously
> -trusted applications, keys roll, etcetera). Updating a kernel to change the
> -meet those security goals is not always a suitable option, as updates are not
> +trusted applications, keys roll, etcetera), updating a kernel to meet
> +those security goals is not always a suitable option, as updates are not
>  always risk-free, and blocking a security update leaves systems vulnerable.
>  This means IPE requires a policy that can be completely updated (allowing
>  revocations of existing policy) from a source external to the kernel (allowing
> @@ -370,7 +370,7 @@ Simplified Policy:
>  Finally, IPE's policy is designed for sysadmins, not kernel developers. Instead
>  of covering individual LSM hooks (or syscalls), IPE covers operations. This means
>  instead of sysadmins needing to know that the syscalls ``mmap``, ``mprotect``,
> -``execve``, and ``uselib`` must have rules protecting them, they must simple know
> +``execve``, and ``uselib`` must have rules protecting them, they must simply know
>  that they want to restrict code execution. This limits the amount of bypasses that
>  could occur due to a lack of knowledge of the underlying system; whereas the
>  maintainers of IPE, being kernel developers can make the correct choice to determine

-- 
~Randy
