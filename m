Received: from mail.nightmared.fr (mail.nightmared.fr [51.158.148.24])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384494C91
	for <linux-security-module@vger.kernel.org>; Sun,  6 Oct 2024 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.158.148.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728213269; cv=none; b=M/jgMed6wX58Kd9OPXPQNSFhBZtXx8KFIZy2JMM8bQLeDLxP+MrrXMobUbp9EdexJgLwikIn1RJhG5AvWMlz5u8FT1xy2OkHHuTVz+wtPK/1EZEqae9W5mx7fYLtt5NBh2lAHll4BDSGZqkS0OQZtsrwZbg4ujmUuC3MnO6yon8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728213269; c=relaxed/simple;
	bh=pbQ4V7UIHtfqV+fBHg9bkg8SUzjh26eJX5oaOGP/36g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKwB24twyNu57Z1+fe7vAHoI7sryxUK2avgQ5GmNxXSIx21fgEvaAMIySvUrQXiD0WPeiG053CorQpjYIoG/iJA0w3IIYHAKhDXFqNKfmQt2L9FLVQZTDxzwAWizjh26MHrI6lFpsLb/vbI7jjnxrIuh4kD2ABM4DXk+XgZ1zRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr; spf=pass smtp.mailfrom=nightmared.fr; dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b=Nl0FqEKB; arc=none smtp.client-ip=51.158.148.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b="Nl0FqEKB"
Received: from [192.168.1.3] (alyon-657-1-781-204.w80-9.abo.wanadoo.fr [80.9.175.204])
	by mail.nightmared.fr (Postfix) with ESMTPSA id E967E10E00A8;
	Sun, 06 Oct 2024 11:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nightmared.fr;
	s=docker; t=1728213264;
	bh=pbQ4V7UIHtfqV+fBHg9bkg8SUzjh26eJX5oaOGP/36g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Nl0FqEKB6qdxUUL/6FoCbPECl5L7mlmuW38L+GishVxgiHUvRCX/umMjXs7+hxukZ
	 v6JXrVXV0SjZAoQrXljF8rtEApm8JT6sVqq8z88U5LrFDmIZrp1gcBJeG52Im1zhsm
	 YiNVxBdUUiFYVJ5mm4cLiPCwTgCoaXz7NOIjFd97gRmE7qQ1Dbl1fxICRZc4PthHVP
	 zF/2kr81hKRj/4ZMYhq21pXqwz0BBcALyg04zX34wYs7txLyMnuJN8h2O0iRMsOA0J
	 de/aLYjpKUEuC3HqjmYDcyLfUzUNmLqmLTus10fmV3I2ZwCCLKo9DCqWhsSku/565f
	 U1c5VXoMf3PNQ==
Message-ID: <3f43ee1c-b297-4a4d-bc3a-bdcaa1613039@nightmared.fr>
Date: Sun, 6 Oct 2024 13:14:23 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TOMOYO's pull request for v6.12
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: Paul Moore <paul@paul-moore.com>, Kees Cook <kees@kernel.org>,
 Fan Wu <wufan@linux.microsoft.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, Mimi Zohar <zohar@linux.ibm.com>,
 Micah Morton <mortonm@chromium.org>, Casey Schaufler
 <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-security-module@vger.kernel.org
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <202410041305.544EA7E4E@keescook>
 <ece0c7bd-0d28-4562-8760-c54b0077583a@I-love.SAKURA.ne.jp>
 <202410041645.27A48DA@keescook>
 <5b09909b-fe43-4a9c-b9a7-2e1122b2cdb6@I-love.SAKURA.ne.jp>
 <CAHC9VhQLONjomYjs6pK2tibVfOaPY+TbDA2CYQ1YEGX7ENVkYw@mail.gmail.com>
 <ec8770e0-8f7c-42b7-b66b-7f830be7271a@nightmared.fr>
 <20241006000206.GA901131@mail.hallyn.com>
 <28dd6c35-c201-4367-b853-d637534d9d3f@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Simon Thoby <git@nightmared.fr>
In-Reply-To: <28dd6c35-c201-4367-b853-d637534d9d3f@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/6/24 12:02 PM, Tetsuo Handa wrote:
> On 2024/10/06 9:02, Serge E. Hallyn wrote:
>> On Sat, Oct 05, 2024 at 07:28:35PM +0200, Simon Thoby wrote:
>> ...
>>> Perhaps you would be better served by providing your users with a snippet of documentation
>>> explaining how to configure MOK and to rebuild the RHEL kernel with TOMOYO enabled?
>>> To be fair, I know that your customers may find this a time-consuming ordeal compared to using
>>> the official kernel - especially as you want to keep up with the frequent updates.
>>
>> Tetsuo's problem, AIUI, is not that it's difficult to rebuild the kernel enabling
>> tomoyo, it's that once his customers do so, RedHat will not support/debug in case
>> of failures.

You're probably right. In my email I said it could be "fine for occasional use" where users
want to trace the system when a problem occurs.
Of course this only works if the problem is reproducible (or frequent enough) that you can
build a new kernel with TOMOYO enabled, boot on it, and wait for the problem to produce itself.
If the goal is instead to have TOMOYO enabled at all time on the company systems, then I
do not envy Tetsuo's position, because I believe this to be an impasse (regarding TOMOYO
itself, not necessarily the tracing problem - more on that later).

> 
> There are a lot of problems.
> 
> TOMOYO is a personal project (the company when I wrote TOMOYO is no longer
> involved since 2012). Also, the company I currently belong to does not have
> much involvement in OSS community. There are some Java programmers, but there
> are little C programmers. Programmers who can understand the Linux kernel are
> endangered species. And I'm working as a troubleshooting staff who can investigate
> problems using C programmer's skill / Linux kernel developer's knowledge.
> 
> Because such a situation, talking with managers needs to be done at a level for
> non-programmers, and communicating with developers/operators needs to be done
> using almost copy-and-paste level procedure manual. In short, Linux systems are
> black-box for them, and I want to use TOMOYO as one of tools for helping them to
> escape from black-box.
> 
> Most of Linux systems are RHEL servers, but since TOMOYO is not included in RHEL
> kernels, I can't use TOMOYO. I was using AKARI until now, but the "static calls"
> change broke AKARI. Thus, I'm close to panic() condition.
> 
> As far as I'm involved in, all RHEL servers are running inside protected
> environment (e.g. commercial WAF/IPS devices inspect traffics before forwarding,
> commercial firewalls/LBs devices minimize possible networking communication
> routes, SSO is enforced for users to login, AV/EDR are protecting individual
> server). Because such a situation, there is little needs for updating packages
> due to security bugs. It may not be a good practice, but even packages that
> reached EOL might be used for years after EOL. For such environments, e.g.
> TSC counter overflows after 208.5 days and freezes the system is more impacting
> problem and is the reason to update kernel packages.

I personally does not agree with the position that "there is little needs for updating
packages due to security bugs", because I believe this does not account for one important
source of attacks: the internal actor, working inside the company, and thus behind all
your WAF/IPS/Firewalls and whatnot (I do not say this to belittle these tools, they help
protect your company against external actors, but they do not protect against a malicious
or angry employee). So updates (not just security updates, after all in the kernel it is
very hard to know what update carries a security fix) are always a good thing in my book.

But fair enough, I have also seen the "If it ain’t broke, don’t fix it" quite a fair
amount of time in a few years working with the industry. And when you cannot justify
investing money into upgrades with your hierarchy, you have to compromise.

Anyway, I sidetracked myself again :/

> 
> I could rebuild RHEL kernels with TOMOYO enabled. But I can't afford providing
> infrastructure for distributing rebuilt kernels / packages relevant with the
> rebuilt kernels (e.g. debuginfo packages) nor resource for acting as front-end
> for receiving any problems that happens with the rebuilt kernels. How difficult
> will it be to let my customers rebuild RHEL kernels with TOMOYO enabled and
> let my customers prove Red Hat that the cause of their problem (bugs) is in
> stock RHEL kernels? (Not limited to runtime bugs, but also questions etc. for
> configuring kernel part that is not related to TOMOYO.) As with problems that
> happen when using e.g. out-of-tree products, I need to rely on Linux distributor
> as front-end. As a back-end, I will handle problems (bugs) in TOMOYO part.
> 
> It is AV / EDR companies who are most thinking empathetically and contributing
> to security for my customer's individual RHEL servers. What the LSM community
> considers as threats and what my customers consider as threats are different.
> It is sad that the LSM community does not like e.g. loadable LSM modules despite
> writable variables are not a practical attack vector for my customers...
>

The difficulty is that the LSM community need to think of what's best for all users,
and that include users where the writable static calls may be an exploitable path.
If RedHat were to enable TOMOYO_LKM, they would expose their users to that risk.
Thus, I do not believe (as maybe have said already) that your patch would serve
your objective of getting it added into RedHat, but rather the contrary: guaranteeing
that RedHat will never enable it in Fedora/RHEL kernels.

While I sympathize with your position (between the anvil of not getting TOMOYO enabled
in distributions and the hammer of your customers in need of solutions), I do not
think this design of a LKM updating static calls that provide security functions
holds a real chance of getting merged someday.


On another note, the way the patch was sent to Linus (very close to the end of the
merge window, and without CC'ing the linux-security-module ML) may be seen as a way
to bypass reviewers and get it merged "no matter what". While I do not attribute
malice to that merge request, I understand that it may be somewhat ill perceived.
Which again, may warp RedHat's (and others, like Canonical's) perception of TOMOYO
negatively.
Maintaining a piece of kernel functionality for over a decade in an impressive feat,
and I commend you for that, but I know that losing trust is often far easier (and takes
far less effort) than regaining it afterwards.
And I think the "trust credit" may play an important role in the political aspects
of enabling a kernel feature on a given distribution.


> 
> 
> Going back to tomoyo.ko seen from my customers point of view.
> 
> Advantage of building TOMOYO into vmlinux is that the procedure for
> communicating with managers/developers/operators becomes simple.
> 
> Advantage of building TOMOYO as tomoyo.ko is that users can update only
> tomoyo.ko (thanks to KABI in RHEL kernels) when a bug is found in TOMOYO.
> Minimizing possible code changes helps minimizing cost for updating packages.
> But secure boot / module signing (not a topic to consider for current
> environment, but possibly becomes a topic to consider for future environment)
> needs to be taken into account.

Finally, I must admit that I know nearly nothing of both TOMOYO and BPF-LSM.
Nevertheless, for your tracing needs (this may not work well for enforcing a
policy, but I kind of inferred from your emails that you were mostly interested
in tracing/debugging capabilities), may you could reproduce the necessary functionalities
of TOMOYO via BPF-LSM?
I don't presume to know the complexity of that endeavor, nor how the limitations of
the ePBF verifier may make that partial rewrite difficult (and it certainly would be).
But it seems to me that you have three options:
- Get TOMOYO LKM merged, and wait a few years for it to be enabled by distros, readily
  available then deployed by your customers
- Pressure distributions into enabling TOMOYO (without the LKM), and wait a few years too
- Provide an eBPF program that can instrument LSM operations to extract the tracing information
  you need to debug your customers. You may also have to wait a few years to get the full
  feature set of TOMOYO working, or to get eventual missing features enabled in BPF-LSM, but
  a limited version may work on many kernels (even existing ones), and updates would be
  easier (not tied to a specific kernel version).

I am not saying that BPF-LSM is THE solution - it has too many limitations for that - but if
you desire to have a LSM for tracing needs (again, not for enforcement, where you cannot afford
to have a userland process load the BPF program) that you can update at will without rebooting,
that does not create new potential security issues (if we ignore speculative execution attacks
in eBPF), there is some appeal to that idea.

Simon

> 
> I'm not familiar with secure boot / module signing. I had a feeling that effectively
> only distributors can sign tomoyo.ko . But it seems that I can also sign tomoyo.ko
> if conditions are met. But I won't be able to provide infrastructure / support for
> problems related to secure boot, for I need to prepare copy-and-paste level
> procedure manual (not a snippet!) and support. tomoyo.ko being signed by
> distributors is much appreciated.
> 
> 

