Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E502F2A
	for <linux-security-module@vger.kernel.org>; Sat,  5 Oct 2024 07:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728112260; cv=none; b=fAmMMfX9mOZFVvn22hJurODW1q+plPRa3oxtqPm5Y/sM/BPnLF4+grCX3iY/FfwwrZy6Iz6hlEFPjSYcq0COikNjTQvU5I+8x1djxHKTr+xr3KuLVMF/anm2Bl9ZahjafZTJdIYLtgF/GYVIt+22rhsGBeQbE5TBct+ZqTYzR7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728112260; c=relaxed/simple;
	bh=L691bXztsZbdU4tDdsqWioNRxaQdH/1XDcoFMSBritI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PPLvlkNNvMyEpNm9SgattCnUNfTQggAlKxeSKBB3TRDPCwpPc+3nPQGL7cTJNOst0G/bIDoEKD31yejbE/rTYvHLBVq99VjC22nDL3Dz+qbj+B0Q+vyX6Lt+DCcFPROFJeAt8pFhJErwoiCXQo+zv+GgPNxrzOsqZb7qggNRejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4957AtFR031816;
	Sat, 5 Oct 2024 16:10:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4957AtNh031810
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 5 Oct 2024 16:10:55 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5b09909b-fe43-4a9c-b9a7-2e1122b2cdb6@I-love.SAKURA.ne.jp>
Date: Sat, 5 Oct 2024 16:10:56 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TOMOYO's pull request for v6.12
To: Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Fan Wu <wufan@linux.microsoft.com>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        KP Singh <kpsingh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-security-module@vger.kernel.org
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <202410041305.544EA7E4E@keescook>
 <ece0c7bd-0d28-4562-8760-c54b0077583a@I-love.SAKURA.ne.jp>
 <202410041645.27A48DA@keescook>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <202410041645.27A48DA@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav305.rs.sakura.ne.jp
X-Virus-Status: clean

On 2024/10/05 9:17, Kees Cook wrote:
>> Even if kernels are built with CONFIG_SECURITY_TOMOYO_LKM=y, callbacks
>> registered by tomoyo_register_hooks() won't be called unless "security=tomoyo
>> is specified or tomoyo is included in the lsm= kernel command line options", for
>> the proxy callbacks that use static call tables are not registered.
> 
> This part I overlooked. I forgot that Tomoyo is still not fully stackable,
> so it isn't getting included in CONFIG_LSM= for the distros that do
> build it.

Excuse me, but TOMOYO is fully stackable since Linux 5.1.
The reason tomoyo isn't getting included in CONFIG_LSM= is that majority of
CONFIG_SECURITY_TOMOYO=y distro kernel users do not need TOMOYO. (Also,
needlessly enabling TOMOYO when userspace tools for TOMOYO is not installed
causes a needless kernel message.)

> 
>> Even if kernels are built with CONFIG_SECURITY_TOMOYO_LKM=y, and "security=tomoyo
>> is specified or tomoyo is included in the lsm= kernel command line options",
>> tomoyo_register_hooks() can be called only once.
> 
> An attacker with a read/write primitive would be able to locate and
> write to "registered" (since it is not read-only), allowing them to call
> tomoyo_register_hooks() multiple times.

But we can mitigate it by making "static calls" in tomoyo_register_hooks() read-only
before returning from tomoyo_register_hooks(). Changes we need will be

  locate the "static calls" tables in tomoyo_register_hooks() into a page aligned
  address (like __ro_after_init section), and call the API that updates page attributes
  containing the tables read-only
  ( https://sourceforge.net/p/tomoyo/akari/HEAD/tree/tags/patches/1.0.50/lsm-4.12.c#l1347 )

. I think that we can define what l1347 does as an API for the LSM framework if the LSM
framework needs it in order to allow hook registration after __init phase completed.

> 
>> And tomoyo.ko is loaded by the
>> time /sbin/init (nowadays /usr/lib/systemd/systemd) starts. That is, by the time
>> an attacker can login from console or can start attacking via network,
>> tomoyo_register_hooks() is no longer callable.
> 
> See above -- calling tomoyo_register_hooks() after boot is entirely
> feasible given a read/write attack primitive.

See above. By making the "static calls" tables read-only before returning from
tomoyo_register_hooks(), calling tomoyo_register_hooks() again after somehow
resetting "registered" variable in tomoyo_register_hooks() will just fail with
crashing the kernel.

Please don't say what if an attacker with a read/write primitive is able to locate
variables and do what l1338 does. That is a never-ending story. The read-only in
the kernel space is implemented as a page attribute. If the attacker can do what
l1338 does, neither "const" nor "__ro_after_init" can make variables read-only.

>> As a whole, I don't think tomoyo.ko approach is unacceptably dangerous.
> 
> I agree, this implementation is safer than I initial assessed (due to the
> LSM's view of the hooks being skipped due to lsm= not including tomoyo).
> I still think how this patch ended up in Linus's tree was a big mistake,
> though.

Commit 8b985bbfabbe ("tomoyo: allow building as a loadable LSM module") says

  This patch is intended for demonstrating that there is nothing difficult
  for supporting TOMOYO-like loadable LSM modules.

. https://lkml.kernel.org/r/7dce903c-2f76-43b2-bb6f-808cb50d0696@I-love.SAKURA.ne.jp says

  Since Paul Moore continues ignoring my concerns, waiting for support of loadable
  LSMs at LSM framework layer won't help. I had to express my concerns and
  demonstrate/prove that loadable LSM can work immediately. I know that people shall
  forget my concerns if I didn't take action right now.

. I really wanted to hear all of your concerns when I responded that "static call"
makes loadable LSM modules difficult. We had whole one year of time before I had to
go with this pull request.

I think that this pull request succeeded in revealing what LSM community thinks.
Each developer is thinking different things. One thinks "anyone can rebuild kernels
with whatever changes", but that opinion ignored secure boot / module signing part.
"You need to discard existing security in order to use an LSM module which is not
built-in" is not something a security person should say. In practice, only known
entities like distributors can build kernels and sign them. This results in attempt
to built-in whatever LSM modules into the distributor kernels. And many of you are
saying that the distributor builds kernels with TOMOYO built-in is better than
separating as tomoyo.ko . And the same thing will be applicable to other LSMs such
as Landlock. Since distributors have upstream-first policy (does not want to build
kernel code that are not included into the upstream kernel), the pressure to make
whatever LSM modules included in the upstream kernel will get stronger. The bandwidth
problem will remain, but at least I think that the "patent examination" needs to be
removed. I believe that the only requirement for getting an LSM module accepted in
the upstream kernel is that the author/supporter of an LSM module remains cooperative
about solving problems (fixing bugs). It is possible that an attempt to make it
possible to use SELinux and Smack together is a wrong direction. Even if SELinux
and TSEM conflicts about their security models (and cannot be used together), it
might not be something we need to care...

