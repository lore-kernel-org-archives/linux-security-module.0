Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0E332182
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jan 2024 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195976; cv=none; b=Tnw7RzcAJChiXjhSaAQ2SEh/RIC4OwUibeTHHEQ/dwqi3IiNI1AKevxbOQdnTGE3V1wkhhzDkgknDjR8wyUtdnfXjM97dJH4N7XSVC9kBSNzvzTTpfcM211ztfKN0V0qlQQZZZqd/xPFbjLWbV6MSypltFCjBxF9Cjo7sZBJh5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195976; c=relaxed/simple;
	bh=BmvDdeljIENX1smYGKU6VIP04aCOW69cMANOrGYY+Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=N6hqSnFxoUevgS5zj03I/p0flnpJHcpdQCqXZyUtQHsIeIwGPszQBTsM9ru24QuK+xuV95tb2b2DfxAD6KQNDtJV+Qq6AVUyc1SejTO4+yozfx1naPVmswpY7jiYjS4uQSZZ5sZ5VbIGpKA+4JYdVFwaDBVHf2bSwmJStUboqvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 40PFJSS9081736;
	Fri, 26 Jan 2024 00:19:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Fri, 26 Jan 2024 00:19:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 40PFJSu9081733
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 26 Jan 2024 00:19:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a8868907-91bb-4125-8f7a-79acd9c01f08@I-love.SAKURA.ne.jp>
Date: Fri, 26 Jan 2024 00:19:29 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: security_file_free contract/expectations
Content-Language: en-US
To: Ben Smith <ben.smith@crowdstrike.com>
References: <CF22CFC7-11A8-4BE5-BA61-04A55FDEA1DB@contoso.com>
Cc: "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CF22CFC7-11A8-4BE5-BA61-04A55FDEA1DB@contoso.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/01/25 8:46, Ben Smith wrote:
> Hi, I'm looking at a kernel panic and I'm trying to figure out whether
> the code in question is doing something that breaks the contract for
> the security_file_free hook. I'm specifically wondering whether it's
> expected/safe for code called from security_file_free to open and read
> from a file. In the case I'm looking at what happens is:
> 
> - Process exit
> - exit_fs() sets current->fs to NULL
> - exit_task_work() calls __fput() on files which were closed in exit_files()
> - __fput() calls security_file_free()
> - security_file_free() then reads the file that was just closed in order
>   to gather information about it.
> - a filesystem driver (I've seen this with two out-of-tree filesystems) then
>   accesses current->fs and panics.
> 
> So I'm wondering if the expectation here is that filesystem code should NULL
> check current->fs before using it or that an LSM shouldn't try to read a file
> from security_file_free().

I guess the out-of-tree filesystems are used by CrowdStrike products and
therefore the source code etc. cannot be shared. (It took me 2 years to prove
that an out-of-tree filesystem used by TrendMicro products was the culprit.)
But are you sure that the location that triggered panic is at reading current->fs ?

security_file_free() is not meant for reading files. But if the location were
really at reading current->fs, whether an LSM shouldn't try to read a file from
security_file_free() is a bogus question.

security_file_release() proposed by Roberto Sassu would be OK. But I guess that
the kernel version you want to load the out-of-tree filesystems is not the latest...

Without more details, we can't give you appropriate suggestions.

