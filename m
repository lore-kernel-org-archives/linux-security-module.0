Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DBD4AA58F;
	Wed,  2 Sep 2026 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369717; cv=none; b=jl7AEFIlUbKAA/WZWM9FP7c/0M6na2SZ8OiTUyIx6kBDhfPvcO41dUQV9p+I9ePYliz6eVt1nu54gG7lJkVI28xlg0tceE94SB5VvWaxaxj+Kp8FhZuaHa+WtAnXgi2Ws8B78GX8MbuJ3fce0LUBvMsdzV7rzwpTTPV/uZUaHMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369717; c=relaxed/simple;
	bh=BPcF7tK+9wjEO8AHHaaT7RkdtWrPCMtrKpsxJUOa4Ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CW6u0JG/BXIja9MWjUesjsIWSjOHwfQLjnmA5Q+3bgeLisgvznnlPTkK3C0CMqpOlOfRv8tA0xGw1w9EjLQDSuJUsPHQLhr3ezGM/dcADu637qn+Gbgc6t2iYhGnZF3MFdebLFpUuw/2poHxMjZaM7SIOBWKHwVzMF1h7hGIGVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Epf2Eq7n; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Epf2Eq7n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ijDI5sjv0PAMOD6lrMuq488aWX1/T3nzo96haAqvwtY=; b=Epf2Eq7ntw5PUbmPjPRkZVAo9R
	gaF3QCTuhcNqvxkUh6JOCZMhWNbdw4nG5AYzx2tkiJeTSLUnybpbyq/kEAlie++TN5ijQJxlkbEN1
	wuYgJl/TJAJs2dk7RPp7sTJCRWpKf4vAYEa9DRG3jiuBifkuVaVXt1EfGr+sNJOtv0ClhS0wnicGv
	iPAnxEUAbHpL3PrIHVMldhifWwgYp88vhizjjWwhNrUp4WJVsGcXpjX3Vb7PUA/UvgKJWUyruOEst
	ndmwH6cWVjDTOJE8STEm2q+FFPjtgwDbJLxw1rRQVBoEPR7I69p4d6Fhc5mXzxKCO0sJoA3ji0WfM
	ndH7BzWg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1oeo-0000000FQIJ-1S7G;
	Wed, 02 Sep 2026 17:21:54 +0000
Message-ID: <a4f81c75-bd83-499d-9dc7-b891ec9cd922@infradead.org>
Date: Wed, 2 Sep 2026 10:21:53 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ipe: fix invalid sgid value in audit event
 documentation
To: Manuel Ebner <manuelebnerli@mailbox.org>, Fan Wu <wufan@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Deven Bowers <deven.desai@linux.microsoft.com>,
 Paul Moore <paul@paul-moore.com>
Cc: Manuel Ebner <manuelebner@mailbox.org>, Fan Wu
 <wufan@linux.microsoft.com>, linux-security-module@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260902152910.708743-3-manuelebnerli@mailbox.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260902152910.708743-3-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/2/26 8:29 AM, Manuel Ebner wrote:
> From: Manuel Ebner <manuelebner@mailbox.org>
> 
> The audit event example in the IPE documentation contains 'sgid=)',
> which is not a valid Set Group ID value. Fix it to use 'sgid=0'.
> 
> Fixes: ac6731870ed9 ("documentation: add IPE documentation")
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
> [v3]
>  Really fix commit message.
>  
> [v2]
>  Add Fixes tag.
>  Fix commit message
> 
> Thanks for the help Fan Wu.
> ---
>  Documentation/admin-guide/LSM/ipe.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
> index a756d8158531..bebf14fc2411 100644
> --- a/Documentation/admin-guide/LSM/ipe.rst
> +++ b/Documentation/admin-guide/LSM/ipe.rst
> @@ -502,11 +502,11 @@ The following table lists the error codes that may appear in the errno field whi
>  Event Examples::
>  
>     type=1404 audit(1653425689.008:55): enforcing=0 old_enforcing=1 auid=4294967295 ses=4294967295 enabled=1 old-enabled=1 lsm=ipe res=1
> -   type=1300 audit(1653425689.008:55): arch=c000003e syscall=1 success=yes exit=2 a0=1 a1=55c1065e5c60 a2=2 a3=0 items=0 ppid=405 pid=441 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=)
> +   type=1300 audit(1653425689.008:55): arch=c000003e syscall=1 success=yes exit=2 a0=1 a1=55c1065e5c60 a2=2 a3=0 items=0 ppid=405 pid=441 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0
>     type=1327 audit(1653425689.008:55): proctitle="-bash"
>  
>     type=1404 audit(1653425689.008:55): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295 enabled=1 old-enabled=1 lsm=ipe res=1
> -   type=1300 audit(1653425689.008:55): arch=c000003e syscall=1 success=yes exit=2 a0=1 a1=55c1065e5c60 a2=2 a3=0 items=0 ppid=405 pid=441 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=)
> +   type=1300 audit(1653425689.008:55): arch=c000003e syscall=1 success=yes exit=2 a0=1 a1=55c1065e5c60 a2=2 a3=0 items=0 ppid=405 pid=441 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0
>     type=1327 audit(1653425689.008:55): proctitle="-bash"
>  
>  This record will always be emitted in conjunction with a ``AUDITSYSCALL`` record for the ``write`` syscall.

-- 
~Randy
