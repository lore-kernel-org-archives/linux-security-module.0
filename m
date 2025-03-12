Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E0615853B
	for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776642; cv=none; b=ssMdWFys7dXiJkauZxHX2Oay/2IXuK+V8nm5uBvlwHGnZYCFwTsxDYn5hoz3AQLWluNE/mJVZcCqZPlbNcjKG6Jck2PWZVNnKnPSi3cgH69LZRym17CJ8iwv1FAfcuEuzruYWqxSidrZh/4HpbgIRj9hOkt8dusYU54L7KZ09O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776642; c=relaxed/simple;
	bh=U5XJSsfeManpSewW0ZriJlWyFI52vsnpvCBerp4qQMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSSzhx++ubh7HM9dLEzOjWThASkn8A1GcHm+bGrC7xl66xBzCMudLUW6ie7aDmbVmbVfpx/DAslQZBw5vWLizIuJAzt5k06dX9SysVMTf81/lEgKnxCN6xyf6XDlGXM0MufArHcmTHAhpE5xm74yeGHLBgGsm+vKKFSUufx9kGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=V6XOWX5I; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="V6XOWX5I"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZCS8T0xKNzqYy;
	Wed, 12 Mar 2025 11:50:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741776633;
	bh=vZiyFCkf3+MjcKB4BK4kknllsQ51D64k9sTt0xv/768=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6XOWX5IJWWVNhI+CUe5Wiz+ndLu03SMCaXdoToMCJeiPh6jXBHWtbFL8l4Zh6E8I
	 GsR5GPOnax4YGMcYRsvluJ0o6zhxvc5EIFyP2yidf46IrzlAlG9cueyqxPf+W/QWYh
	 T94RGyGVjU9aPlmzNngydBtxIBcvWpUAf2uBz+7Q=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZCS8S3CxwztxC;
	Wed, 12 Mar 2025 11:50:32 +0100 (CET)
Date: Wed, 12 Mar 2025 11:50:31 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-security-module@vger.kernel.org, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [bug report] landlock: Add AUDIT_LANDLOCK_DOMAIN and log domain
 status
Message-ID: <20250312.ungooTh8Iotu@digikod.net>
References: <2425110b-b5ca-4b33-bf75-e6fca0b0de63@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2425110b-b5ca-4b33-bf75-e6fca0b0de63@stanley.mountain>
X-Infomaniak-Routing: alpha

On Wed, Mar 12, 2025 at 11:33:29AM +0300, Dan Carpenter wrote:
> Hello Mickaël Salaün,
> 
> Commit 96cc6f48a8e4 ("landlock: Add AUDIT_LANDLOCK_DOMAIN and log
> domain status") from Mar 8, 2025 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	security/landlock/domain.c:66 get_current_exe()
> 	warn: 'size' unsigned <= 0

Hi,

Thanks for the report, I'll fix this issue.

I'm using Smatch's kchecker (commit f4f26f80d4f3) but I didn't get this
warning.  I tried with and without build_kernel_data.sh but I get the same
result. Which command are you using?

> 
> security/landlock/domain.c
>     39 static const void *get_current_exe(const char **const exe_str,
>     40                                    size_t *const exe_size)
>     41 {
>     42         const size_t buffer_size = LANDLOCK_PATH_MAX_SIZE;
>     43         struct mm_struct *mm = current->mm;
>     44         struct file *file __free(fput) = NULL;
>     45         char *buffer __free(kfree) = NULL;
>     46         const char *exe;
>     47         size_t size;
>     48 
>     49         if (!mm)
>     50                 return NULL;
>     51 
>     52         file = get_mm_exe_file(mm);
>     53         if (!file)
>     54                 return NULL;
>     55 
>     56         buffer = kmalloc(buffer_size, GFP_KERNEL);
>     57         if (!buffer)
>     58                 return ERR_PTR(-ENOMEM);
>     59 
>     60         exe = d_path(&file->f_path, buffer, buffer_size);
>     61         if (WARN_ON_ONCE(IS_ERR(exe)))
>     62                 /* Should never happen according to LANDLOCK_PATH_MAX_SIZE. */
>     63                 return ERR_CAST(exe);
>     64 
>     65         size = buffer + buffer_size - exe;
> 
> d_path() takes a buffer and returns exe which is a pointer to the
> somewhere in the middle of buffer.
> 
> --> 66         if (WARN_ON_ONCE(size <= 0))
> 
> So size can't be negative.  And also size is declared as unsigned so it
> can't be negative for that reason either.
> 
>     67                 return ERR_PTR(-ENAMETOOLONG);
>     68 
>     69         *exe_size = size;
>     70         *exe_str = exe;
>     71         return no_free_ptr(buffer);
>     72 }
> 
> regards,
> dan carpenter
> 
