Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E4E16FF44
	for <linux-security-module@vger.kernel.org>; Sun,  6 Oct 2024 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728208967; cv=none; b=toaHSO8TL6Ws2oS3YdJRNs0sQ3loLyy+VbxjJZfbWZQjFeQbTIuaCnn4iec3oHMJHzAtJAjWrSAPJSUkfVXuRfuQdRlpNwU+bh2/ctCGdHoMPGCTNMKYtwm/wqJe4HrM24kIWT5nB23Duj+zNnHNf6D+TDCogbLG96C1hx3/iOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728208967; c=relaxed/simple;
	bh=z9oYkFeckks6wymuyoxlGg+4t7gq+DYHOJ0NY74UNm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=javiX/s2EG1CoKw+EtX3Nsn2MeygdegOvRbCBlJW1Ef6pcwpfvjwHHMpStqsfOpOyAOVj0B9IBXHBzHay4cbUACshHOhgZnwWzIkwIfF80AEpXXRu1/0PpYwL3dZ4/6ItjJFjr7ttGuGXOLR1YYAXQ4rt4u/EuMStWv/65jXL7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 496A2bCG014800;
	Sun, 6 Oct 2024 19:02:37 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 496A2btX014795
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 6 Oct 2024 19:02:37 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <28dd6c35-c201-4367-b853-d637534d9d3f@I-love.SAKURA.ne.jp>
Date: Sun, 6 Oct 2024 19:02:35 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TOMOYO's pull request for v6.12
To: "Serge E. Hallyn" <serge@hallyn.com>, Simon Thoby <git@nightmared.fr>
Cc: Paul Moore <paul@paul-moore.com>, Kees Cook <kees@kernel.org>,
        Fan Wu <wufan@linux.microsoft.com>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>,
        Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler
 <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        KP Singh <kpsingh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-security-module@vger.kernel.org
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <202410041305.544EA7E4E@keescook>
 <ece0c7bd-0d28-4562-8760-c54b0077583a@I-love.SAKURA.ne.jp>
 <202410041645.27A48DA@keescook>
 <5b09909b-fe43-4a9c-b9a7-2e1122b2cdb6@I-love.SAKURA.ne.jp>
 <CAHC9VhQLONjomYjs6pK2tibVfOaPY+TbDA2CYQ1YEGX7ENVkYw@mail.gmail.com>
 <ec8770e0-8f7c-42b7-b66b-7f830be7271a@nightmared.fr>
 <20241006000206.GA901131@mail.hallyn.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20241006000206.GA901131@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav103.rs.sakura.ne.jp

On 2024/10/06 9:02, Serge E. Hallyn wrote:
> On Sat, Oct 05, 2024 at 07:28:35PM +0200, Simon Thoby wrote:
> ...
>> Perhaps you would be better served by providing your users with a snippet of documentation
>> explaining how to configure MOK and to rebuild the RHEL kernel with TOMOYO enabled?
>> To be fair, I know that your customers may find this a time-consuming ordeal compared to using
>> the official kernel - especially as you want to keep up with the frequent updates.
> 
> Tetsuo's problem, AIUI, is not that it's difficult to rebuild the kernel enabling
> tomoyo, it's that once his customers do so, RedHat will not support/debug in case
> of failures.

There are a lot of problems.

TOMOYO is a personal project (the company when I wrote TOMOYO is no longer
involved since 2012). Also, the company I currently belong to does not have
much involvement in OSS community. There are some Java programmers, but there
are little C programmers. Programmers who can understand the Linux kernel are
endangered species. And I'm working as a troubleshooting staff who can investigate
problems using C programmer's skill / Linux kernel developer's knowledge.

Because such a situation, talking with managers needs to be done at a level for
non-programmers, and communicating with developers/operators needs to be done
using almost copy-and-paste level procedure manual. In short, Linux systems are
black-box for them, and I want to use TOMOYO as one of tools for helping them to
escape from black-box.

Most of Linux systems are RHEL servers, but since TOMOYO is not included in RHEL
kernels, I can't use TOMOYO. I was using AKARI until now, but the "static calls"
change broke AKARI. Thus, I'm close to panic() condition.

As far as I'm involved in, all RHEL servers are running inside protected
environment (e.g. commercial WAF/IPS devices inspect traffics before forwarding,
commercial firewalls/LBs devices minimize possible networking communication
routes, SSO is enforced for users to login, AV/EDR are protecting individual
server). Because such a situation, there is little needs for updating packages
due to security bugs. It may not be a good practice, but even packages that
reached EOL might be used for years after EOL. For such environments, e.g.
TSC counter overflows after 208.5 days and freezes the system is more impacting
problem and is the reason to update kernel packages.

I could rebuild RHEL kernels with TOMOYO enabled. But I can't afford providing
infrastructure for distributing rebuilt kernels / packages relevant with the
rebuilt kernels (e.g. debuginfo packages) nor resource for acting as front-end
for receiving any problems that happens with the rebuilt kernels. How difficult
will it be to let my customers rebuild RHEL kernels with TOMOYO enabled and
let my customers prove Red Hat that the cause of their problem (bugs) is in
stock RHEL kernels? (Not limited to runtime bugs, but also questions etc. for
configuring kernel part that is not related to TOMOYO.) As with problems that
happen when using e.g. out-of-tree products, I need to rely on Linux distributor
as front-end. As a back-end, I will handle problems (bugs) in TOMOYO part.

It is AV / EDR companies who are most thinking empathetically and contributing
to security for my customer's individual RHEL servers. What the LSM community
considers as threats and what my customers consider as threats are different.
It is sad that the LSM community does not like e.g. loadable LSM modules despite
writable variables are not a practical attack vector for my customers...



Going back to tomoyo.ko seen from my customers point of view.

Advantage of building TOMOYO into vmlinux is that the procedure for
communicating with managers/developers/operators becomes simple.

Advantage of building TOMOYO as tomoyo.ko is that users can update only
tomoyo.ko (thanks to KABI in RHEL kernels) when a bug is found in TOMOYO.
Minimizing possible code changes helps minimizing cost for updating packages.
But secure boot / module signing (not a topic to consider for current
environment, but possibly becomes a topic to consider for future environment)
needs to be taken into account.

I'm not familiar with secure boot / module signing. I had a feeling that effectively
only distributors can sign tomoyo.ko . But it seems that I can also sign tomoyo.ko
if conditions are met. But I won't be able to provide infrastructure / support for
problems related to secure boot, for I need to prepare copy-and-paste level
procedure manual (not a snippet!) and support. tomoyo.ko being signed by
distributors is much appreciated.

