Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E4F33FE1F
	for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778772055; cv=none; b=ZRFYW8JUnOSf9L4JcmTesKrux4/GlvZVdvLZ/hiAINPhlrjIVuX4r4/noz46mVxQN4PMy7Z6LDMF0WDHkuOcs+ZPf436r8g3bWAycvsTYbt8MT4oaEsEqfZJMd9CsTrNkChFCYNeO8Kl3+eVvWJGYPFB6N/s2BvHs0yvONr1YH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778772055; c=relaxed/simple;
	bh=CCK4llSk6oE0oPfj7vapFnsggmsdqtAkv2KFCkqFHbQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j3Kkaib36zpQxFYQXWTDHv/h6LDgjSNzJEcJJjYR7UK7FvmRkg87jnjgiyx5vNjen9R1tVEcaBMLtXrrR4YUD9OD+V+FuzLh6fq9IjelPshvHlimVPSuhY1ZXgIKQh/GskkWCmPdiWFXrtqyCjCAIf4/hejExmkf5yyaoObMlV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qTBXJ9aL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qTBXJ9aL"
Received: from narnia (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2DBFE20B7166;
	Thu, 14 May 2026 08:20:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2DBFE20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778772049;
	bh=+9mhxUKn7Jml/P12zydg1WD36pJj/XVMZr3fVpG9hRA=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=qTBXJ9aLAr9BaR3m3n7PhDD3kY22dpsZDQyZmVUUWBoDUtrFdkEh4UVh7kWpvo+qD
	 V80W24bwdvTkGjvIhd8zb85cFInjF+f13Fu65zE7Q1Gl0llV4E/XmOQig25ITxIYzg
	 pfeek/PEdGbTFZdtIk9MxMLy0LpEn9AzaZJA4NM4=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] hornet: depend on CONFIG_SECURITY and CONFIG_BPF_SYSCALL
In-Reply-To: <20260514011456.504527-2-paul@paul-moore.com>
References: <20260514011456.504527-2-paul@paul-moore.com>
Date: Thu, 14 May 2026 08:20:50 -0700
Message-ID: <87fr3u9fvx.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paul Moore <paul@paul-moore.com> writes:

> Hornet only makes sense as a LSM if the LSM framework is enabled
> via CONFIG_SECURITY and eBPF is enabled via CONFIG_BPF_SYSCALL.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605140655.YX9jzufG-lkp@intel.com/
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/hornet/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/security/hornet/Kconfig b/security/hornet/Kconfig
> index 5be71d97daee..537ad015958c 100644
> --- a/security/hornet/Kconfig
> +++ b/security/hornet/Kconfig
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config SECURITY_HORNET
>  	bool "Hornet support"
> +	depends on SECURITY && BPF_SYSCALL
>  	select CRYPTO_LIB_SHA256
>  	select PKCS7_MESSAGE_PARSER
>  	select SYSTEM_DATA_VERIFICATION
> -- 
> 2.54.0

Acked-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
