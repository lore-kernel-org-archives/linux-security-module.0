Received: from mail.nightmared.fr (mail.nightmared.fr [51.158.148.24])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC9E231C81
	for <linux-security-module@vger.kernel.org>; Sat,  5 Oct 2024 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.158.148.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728149670; cv=none; b=W1Wc0DRf/Umarra30Yvw7PHntsoNjXLNrxEfCbAuXLDAeoJRxIxifFL+rCFOivQiFKpOSb8LSrMGeqjk6nd86ER3r2N42UU1jiHvXu5TYqKltmxqq3iFfuDK4Bd0D08/mDKJBJVynvsxf1jcqzEmE0jMfmZWhhPF9rjMPM2rD6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728149670; c=relaxed/simple;
	bh=t4j0Cc6xR/4r6W3pH1zuEjJWM/OJSLYIe8q+BAcAy4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GD1AaPKmighziSkSuTPg+e7qsmXXTsHjLftzdpzk6MjglgOAJTBvwd+E7J/05Ph+FS3Zm9VRyIFeQa5sIP+MFFWHzBuqR8r1FypuS5xAzHhBG/4avJB1W5ksZAg1FrHO9sXL4mo4bsp81fc97YQu/l3k05a1KBknjPbEyJEFfSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr; spf=pass smtp.mailfrom=nightmared.fr; dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b=WVp+7faI; arc=none smtp.client-ip=51.158.148.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b="WVp+7faI"
Received: from [192.168.1.3] (alyon-657-1-781-204.w80-9.abo.wanadoo.fr [80.9.175.204])
	by mail.nightmared.fr (Postfix) with ESMTPSA id 54A0F10E0053;
	Sat,  5 Oct 2024 17:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nightmared.fr;
	s=docker; t=1728149317;
	bh=t4j0Cc6xR/4r6W3pH1zuEjJWM/OJSLYIe8q+BAcAy4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WVp+7faI0er6HFNGgtDcHajBO5exDZ7fMPIlMq/8Zb84WGgS3OL4zzDLQy5Lpr7dy
	 T6sByyp//0KvBfSiNzzVuFKmLWa5edx5gFQ/aCEf6Io8lNusiBEa09YGIqxwYPyKic
	 cag2EVxvn5JL/BmibSOZ71kx3HRdJQq13JFHO7P+XKuXFjVjy6vZW8NIUYa8FUQgJW
	 91F/T+D5w2CHsjKB7kgRpn4oErzhM/edxBqtxRRMbrz4YLotZjgWIqwoar2TmF/IZI
	 0yL0aqgvvLDgiwl2P4i8t7Ghd0GeBnwsf7ya3M1dIXiziD8g8C+awgv6kKQDJgUHaJ
	 sKgOePNA5lAsA==
Message-ID: <ec8770e0-8f7c-42b7-b66b-7f830be7271a@nightmared.fr>
Date: Sat, 5 Oct 2024 19:28:35 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TOMOYO's pull request for v6.12
To: Paul Moore <paul@paul-moore.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Kees Cook <kees@kernel.org>, Fan Wu <wufan@linux.microsoft.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 John Johansen <john.johansen@canonical.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-security-module@vger.kernel.org
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <202410041305.544EA7E4E@keescook>
 <ece0c7bd-0d28-4562-8760-c54b0077583a@I-love.SAKURA.ne.jp>
 <202410041645.27A48DA@keescook>
 <5b09909b-fe43-4a9c-b9a7-2e1122b2cdb6@I-love.SAKURA.ne.jp>
 <CAHC9VhQLONjomYjs6pK2tibVfOaPY+TbDA2CYQ1YEGX7ENVkYw@mail.gmail.com>
Content-Language: en-US
From: Simon Thoby <git@nightmared.fr>
In-Reply-To: <CAHC9VhQLONjomYjs6pK2tibVfOaPY+TbDA2CYQ1YEGX7ENVkYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/5/24 6:30 PM, Paul Moore wrote:
> On Sat, Oct 5, 2024 at 3:11 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> I think that this pull request succeeded in revealing what LSM community thinks.
>> Each developer is thinking different things. One thinks "anyone can rebuild kernels
>> with whatever changes", but that opinion ignored secure boot / module signing part.
> 
> As I believe that I'm the developer quoted above, let me say that my
> comment did not ignore UEFI SB.  The Machine Owner Key (MOK) concept
> provided by shims/bootloaders is designed just for this use case.
> More advanced users can even replace the UEFI SB key databases, on
> hardware that supports it, with their own to permit loading of their
> self-built kernels without the need for the MOK; this is arguably one
> of the most "secure" UEFI SB configurations.
> 
> I've successfully used MOK on my own systems to support my own kernel
> builds, and I've successfully replaced the UEFI SB key databases in
> VMs to use UEFI SB and my own kernel builds without MOK.
> 

Indeed, I'm probably sidetracking the discussion a bit, but I have met all three use
cases both personally and professionally:
- Signing an out-of-tree kernel modules with a local certificate (MOK) enrolled in the
  MOKList via shim (e.g. to support Nvidia GPUs on SecureBoot-enabled machines)
- Enrolling user boot keys (changing the PK, adding my own KEK to Microsoft's and the platform
  manufacturer's, then extending the DB list) the signing my kernel with my own key
- Completely replacing the secure boot keys to only allow my own (sadly, this may be risky
  on some platforms, like ThinkPads, where essential UEFIs drivers may not load, thus
  bricking the device)

I say all this to emphasize that the options outlined by Paul are not theoretical, but
very practical use cases that one may encounter in the industry (and I have, even
in fairly conservative industries).
In addition, I strongly believe this is the way to go: any kernel module or dynamic
configuration (if I push this idea to the extreme, maybe in the future this could
even include eBPF payloads in some hardened configurations) should be signed by a trusted
authority to be loaded in the kernel.
That authority may be the Linux distribution, but it can also be you (or your company
IT department), thanks to MOK (or its heavier alternatives).
You retain the flexibility to load kernel modules not built by the distributor,
or even out-of-tree modules, but without degrading the security of your computers
(assuming the signing keys are properly protected, of course).

Perhaps you would be better served by providing your users with a snippet of documentation
explaining how to configure MOK and to rebuild the RHEL kernel with TOMOYO enabled?
To be fair, I know that your customers may find this a time-consuming ordeal compared to using
the official kernel - especially as you want to keep up with the frequent updates.
But OTOH that's not end-of-the-world complexity either, which makes it fine for occasional use,
e.g. to behave like "a sort of system-wide strace-like profiler" (I'm guessing your customers
are only doing this operation from time to time, not continuously in production).
There's no perfect solution I guess, but to keep lobbying distributors to enabled TOMOYO
in their kernels.

Simon
