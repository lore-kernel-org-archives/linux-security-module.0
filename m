Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61A44028E6
	for <linux-security-module@vger.kernel.org>; Thu,  9 Jul 2026 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590601; cv=none; b=uPWZZ6+jWbMyzdepJLgYU4zRUqP5m+KAmIIE8NlpxDIc7eAHEIAwxE2hCkf01NiAF70KruJPnZx1nEoyMJm9nUejfpJ0N46+fWw9xPZpcjuvlzeDFYP1MaRMCdd38tUy1flt/Za2ECMkt14gW1kdsCaoS6DNXp6U3PenIy2LWhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590601; c=relaxed/simple;
	bh=jTFvyUggpn9b7ir5dJXF/0vV6aESSqllkJsE1EJX8x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MG9WhPecYj/Ib64Etd7ZJ5LM9PdzKAXH50XDRLRImxxOb5+ubf+ONE4f2u7XIZwQoeKuF3640oPdZS22mxjvtX5T+Au1wNP92cSK7HiAbgLFFRCX3TA+4SfKTKpit9U46MUWytARLd/bc3SkRbUtLirqeAvw5vNLV8XNIuOkjMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PovcRIVX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PovcRIVX"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b61b52b6so15647535e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 Jul 2026 02:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783590589; x=1784195389; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MXemn+RWgfgniHXL+Z+iccp115cwF5wMpUS4nNjdkFs=;
        b=PovcRIVXEPSF/FJeQlxhlzoXjqZOrbs3CiE5bUYuum/kokSouOcrfuWzkJz+QZ+EEU
         bXZutBCPHghMPuDpORpgqEkhwf9ItYai/C2Wls7hXpV8JBACI0ISAzSZohMkmVLXApNn
         fZlxwp5LQbRlt1W9WkBqq04596J259cyQGkTEsx5D5ai1Vpe/8NCZrLqgzS5soekf8Zd
         N1CUWCeoaHYptaJl5ecJ1ZzDp9e7jZkz7Z27dZDIG4LQ8N1cI1J5HRitdDR0mFAuAiJK
         tCK2hnhPLuoPo29pU3Y3TxhIiW33KldSOjrnaQ78LbO8JgLXI4Yv8EB+9OvmBldN7dCE
         StRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590589; x=1784195389;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MXemn+RWgfgniHXL+Z+iccp115cwF5wMpUS4nNjdkFs=;
        b=L35Vs1DdehkNRBl3+zqk+yYqk0KHZNjtbielPlG6QZpIp35ggv7ZWrO9yrsPMsqlmL
         pACbp4ARnfCpYJ0NOAld7kAwOwtWwZGAE/B+dAuWFmsflmHSdq5qTghQvOg6Y8bi61m4
         ZO3TPXBjckpx7KPH81GLc5GZ25Za+91weJyGNLpYNkyH3KeAq6MPk4r6wpzseVqtQ/9B
         hwjJ3Q4atBTlaIm8jixH4rmUxfJ195KWfIDqUhVIAUKHjZ+yLnlZOUPx7BNLFfQE1RLS
         UpUiU82TcfRrkDjOhNGHOz/Ih4Y7sVfbirsU3O7KmNx6CBtxaL3h0kThRyTj87Llf5ZX
         mJlg==
X-Forwarded-Encrypted: i=1; AHgh+RqA8KWKPNqY4g+7pRG4pZlk0kv9OHF0+xL26woILhZnxj6qMjICSDJ44w6YzwMmghCV2Vka/yeAdzDCFs6cN3b8mV/UL1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQtRTv1hzRukU9BsntCU6QmjGWOhnZDxfxFzuL73SrbRliGbdZ
	XqCUzCRSmcEHjmEEvkO/AqawjKc7Zi0jyAXZRAj8vPeWhch9r0ob3Ub5+NwP3mr+/ww=
X-Gm-Gg: AfdE7ck+Ncfz+zfuRZ7CthNURgLbJMPqmCdBJzy1muK+igILZ7TtObZltJUaABIl5X3
	43imrmSfi4v8RpbazL6xK44iP4yQc/kPSNKyPonPmP33MY4WqS6kHuVyVHDOhgJeuBegj+j32i4
	ISjMqbDaJp5a9JuBonlezf4Jh5q0day0eRUCMFbtE9ngO5mHsHNdAt+5kNMozPgdgo41qHuBEH6
	Uq/Tf90rQIK6pSIdxTvzYVioomCy5v+Hkq3pb0fIskmVw8YfLSuJzvxP5AzoKlk9ZiEpFjEztfX
	WeNjV4Lh7r/kFtu5J0v+oWaQ++gS74PTfw5+imAxoM+mafBpdfggRM4oDbuvUh0YzqhDSvcJoHy
	D5BO/UJyLeBiIOsLX+P3uaJJF5BKnfRf9nQs2U2IDRvO9iplh4Ff6QeQb9uChA8TArm5K93LNOZ
	jlrUmaLssXsL2KKUPHeiOmCUFZpNL0pEe60A==
X-Received: by 2002:a05:600c:c1d7:20b0:490:9782:3eb8 with SMTP id 5b1f17b1804b1-493e68c3535mr47652155e9.25.1783590588957;
        Thu, 09 Jul 2026 02:49:48 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6d53absm47837275e9.6.2026.07.09.02.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 02:49:48 -0700 (PDT)
Message-ID: <3e2ae6e8-41ad-45f0-a885-131a5711c276@suse.com>
Date: Thu, 9 Jul 2026 11:49:45 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] umh, treewide: Explicitly include linux/umh.h where
 needed
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Michal Januszewski <spock@gentoo.org>, Helge Deller <deller@gmx.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Nikolay Aleksandrov
 <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 drbd-dev@lists.linux.dev, linux-block@vger.kernel.org,
 greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
 cgroups@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
 bridge@lists.linux.dev, netdev@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260708154510.6794-1-petr.pavlu@suse.com>
 <20260708154510.6794-2-petr.pavlu@suse.com>
 <ak6STbqZd-Q-c56v@localhost.localdomain>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <ak6STbqZd-Q-c56v@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/8/26 8:13 PM, Michal Koutný wrote:
> Hi Petr.
> 
> On Wed, Jul 08, 2026 at 05:44:29PM +0200, Petr Pavlu <petr.pavlu@suse.com> wrote:
>> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
>> index a4337c9b5287..60eb994c32ae 100644
>> --- a/kernel/cgroup/cgroup-v1.c
>> +++ b/kernel/cgroup/cgroup-v1.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/pid_namespace.h>
>>  #include <linux/cgroupstats.h>
>>  #include <linux/fs_parser.h>
>> +#include <linux/umh.h>
>>  
>>  #include <trace/events/cgroup.h>
> 
> There is kmod.h in here too but it's unnecessary, no module lazy loading
> in this code.

You're right. I'll remove the kmod.h include from
kernel/cgroup/cgroup-v1.c. I went through all the files again and it
seems this was the only place I missed.

-- 
Thanks,
Petr
