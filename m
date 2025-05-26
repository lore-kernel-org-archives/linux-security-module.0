Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0D41420DD;
	Mon, 26 May 2025 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748284670; cv=none; b=M2bsNxKqAmDYs5gLOvio/ve+kM4pJ7KyRK9NSt2XSatfDJMtkvsht+HdJKyRnD6r1bFrBxDds8JP7gSEJNAKcrxigfAMyQSt9+qaHbDQx3DJRhsOZEH/3CHA7WQio3VFxacUpdpClhA4T9Z/Nf5fokN5R5SVpwYBzaRI5l2l7ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748284670; c=relaxed/simple;
	bh=ojjx1UooVPleEs1fSqiRsCJTjbSFwj35Er+72Wo/aT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nc3uCeosGCeV+S1axuZigohcB3t7k9TY/R6nfh2QmblYQrQr9pndYr8keriD2JXF24G1yVT+5Jyt2pNzLBQAh0gLu5GKVWZivNN1c1vV/5VIZWxrLZ/2FnmZ83M1CDnWlFRMrpeZY4s5mnmb2aBiNMRxgrF9+qVt1uY9/qjUcoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Vgytm2BH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ms6VXDzT; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Vgytm2BH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ms6VXDzT"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 60BD811401A2;
	Mon, 26 May 2025 14:37:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 26 May 2025 14:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748284666;
	 x=1748371066; bh=5cRdsNinjTvwrTkvkfKbsOZ8190VOUjMicymsFl66R8=; b=
	Vgytm2BHWHmlWQfy53YKhY134bVVeI74ea1qN0ZTmBKVlGUDhkvCnt3Dw3WD0+vj
	5YkwGY1e3dQs55UFpYVdGowwpIvIstIzaKuaISl7NRyevJXTtxTF3CXJJ/l8+59K
	X7lyj4I35mNZqVXw+gRLiOyTcrENwBCAwxrbM8CMMt0gTMryG5M9yb6MGHTc/s1Z
	q3IEbs9Buf6OusFYNc+WliwCQ8G+6+BSrpOmjTTj4aDyI9qDtCbWCvohp3kV9O9r
	HpcN5tmGR1w9w9StsG1VXv6A1QQc2NsO1x7DHlF2rPnQKu+GjVGP9kx9XcuQDstY
	ZWRgDWcqdVBmnGtMNMeYFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748284666; x=
	1748371066; bh=5cRdsNinjTvwrTkvkfKbsOZ8190VOUjMicymsFl66R8=; b=m
	s6VXDzTg+V8AABAP44thN0vA/8mAFM3DwkNevmDYQQLY0cSwa+zU3WqBETuvl57j
	iP7KrvxT3c8lDmJoQXjTmDbL7ujUhaMvVNdVXuNG1lhg/VodQOCBtXwTHkt0aVaK
	RebJ5uyjwHfYs5J/Tkx/vuuKdHKqPRAzqSPwZ4ljf0v+NNnsl7N2+xP9/30/675Z
	fvOhPp2BTavqM2wHLJcaTVdGD5bHVOBa5OpDbkv37LyH3OylzNF66JxAUut7cTEY
	eV4UXjzUFiTBvwbUdwzenwkzJ9PPhttVIXTxGyrKEE+m9ctv/Kr/J2ZORAAcOI6i
	Jse2ZwDVGcOYYpyjEmf7Q==
X-ME-Sender: <xms:-LQ0aCiIAApBi77lqo3UzTjjSxP-8CU4beARWBLoVSgQNqXwXDsniw>
    <xme:-LQ0aDAFZDmjIAnOvd6w4SZgzLTaNZ9E9TWqiu3HVfaf9BUMPyW7YbF9V9imVhNf3
    6FBinCk9hDiUsvKS1s>
X-ME-Received: <xmr:-LQ0aKGt36seOLq-bpbG-wAKguoJGnieiyJJjf9tG2z0HqYzatM-dU4uWor5dEhAH2AVmYxQqTJQsuxZp60IRFfx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddukedvieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfev
    fhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomh
    esmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpedukeevhfegvedvveeihedv
    vdeghfeglefgudegfeetvdekiefgledtheeggefhgfenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghr
    tghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguih
    hgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopegusghurhhgvghnvghrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtoh
    hmpdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhgv
    fhhfgihusehgohhoghhlvgdrtghomhdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepmhhhihhrrghmrghtsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdprh
    gtphhtthhopehmrghtthhhihgvuhessghufhhfvghtrdhrvg
X-ME-Proxy: <xmx:-LQ0aLT_ihfAHX8-10CkSzezWVTIjtBgwzci4MnNBY9WFUAi3q-CMA>
    <xmx:-LQ0aPxbHvYDW2cFjBcjCGuLzzo8Iz5mj4k9WLOpxZQfhzDQhSDbcg>
    <xmx:-LQ0aJ4uyOYySZzajgC3vXH3kmIf0_lx-H7bMZs5xDTn0Ssecx3kMQ>
    <xmx:-LQ0aMxeY40oN-ISdpbWfEl-s-wgWlShdg3hh7hfCP5w5kyqaJwODw>
    <xmx:-rQ0aKGt8zwGsT68BBMdaLZiljcy1KowTXqxmGs7hWPPVer7UODlN77M>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 14:37:42 -0400 (EDT)
Message-ID: <b6f1e330-6a9f-4359-a221-bec30d94fb20@maowtm.org>
Date: Mon, 26 May 2025 19:37:41 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/5] Landlock tracepoints
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Daniel Burgener <dburgener@linux.microsoft.com>,
 Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>,
 Kees Cook <kees@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 Ryan Sullivan <rysulliv@redhat.com>, Shervin Oloumi
 <enlightened@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250523165741.693976-1-mic@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250523165741.693976-1-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/23/25 17:57, Mickaël Salaün wrote:
> Hi,
> 
> This series adds two tracepoints to Landlock, one tied to rule addition,
> and another to rule checking.  With these new tracepoints, we can see
> all steps leading to an access decision.  They can be directly used with
> /sys/kernel/tracing/events/landlock/* or attached by eBPF programs to
> get a more complete view of Landlock internals.
> 
> This new feature is useful to trouble shoot policy issues, and it should
> also limit the need for custom debugging kernel code when developing new
> Landlock features.
> 
> Landlock already has audit support, which enables us to log denied
> access requests.  Audit is useful to identify security issues or sandbox
> misconfiguration.  However, it might not be enough to debug Landlock
> policies.  The main differences with audit events is that traces are
> disabled by default, can be very verbose, and can be filtered according
> to process and Landlock properties (e.g. domain ID).
> 
> As for audit, this tracing feature may expose sensitive information and
> must then only be accessible to the system administrator.
> 
> This RFC only fully supports filesystem rules but the next series will
> also support network rules.  Tests are also missing for now.
> 
> Regards,
> 
> Mickaël Salaün (5):
>    landlock: Rename landlock_id to landlock_rule_ref
>    landlock: Merge landlock_find_rule() into landlock_unmask_layers()
>    tracing: Add __print_untrusted_str()
>    landlock: Add landlock_add_rule_fs tracepoint
>    landlock: Add landlock_check_rule tracepoint
> 
>   MAINTAINERS                                |   1 +
>   include/linux/trace_events.h               |   3 +
>   include/trace/events/landlock.h            | 124 ++++++++++++++
>   include/trace/stages/stage3_trace_output.h |   4 +
>   include/trace/stages/stage7_class_define.h |   1 +
>   kernel/trace/trace_output.c                |  40 +++++
>   security/landlock/Makefile                 |  11 +-
>   security/landlock/fs.c                     | 178 +++++++++++++--------
>   security/landlock/fs.h                     |   3 +
>   security/landlock/net.c                    |  18 +--
>   security/landlock/ruleset.c                |  65 ++++----
>   security/landlock/ruleset.h                |  15 +-
>   security/landlock/trace.c                  |  15 ++
>   13 files changed, 365 insertions(+), 113 deletions(-)
>   create mode 100644 include/trace/events/landlock.h
>   create mode 100644 security/landlock/trace.c
> 
> 
> base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21

Tested-by: Tingmao Wang <m@maowtm.org>

Here is an example output I got with `trace-cmd record -e landlock`:

landlock-add-ru-776   [001] 75134.554776: landlock_add_rule_fs: [FAILED 
TO PARSE] ruleset=0xffff88811a459200 ref_key=18446612686420679296 
allowed=57343 dev=21 ino=53 pathname=/tmp/test
landlock-add-ru-776   [001] 75134.555336: landlock_check_rule:  [FAILED 
TO PARSE] domain_id=7838764077 access_request=4 ref_type=1 
ref_key=18446612686420679296 layers=ARRAY[ff, df]
I suggest adding some more events which I think shouldn't be too 
difficult to implement and I can see them helping a lot with tracing / 
debugging especially by BPF programs or someone new to landlock:

- landlock_restrict_self: Currently we trace out the ruleset pointer in 
add rule, and the domain ID in check rule.  However there is no way for 
someone just looking at this trace (or a BPF program for landlock) to 
relate which rulesets are applied to which domains. I think a simple 
event we could add that will help with this is, on 
landlock_restrict_self, prints out the ruleset passed in as well as the 
domain ID newly created.  Maybe also num_rules and num_layers on the new 
ruleset since it's trivial to do so, and could be informative to someone 
analyzing a Landlock thing.

- landlock_check_fs: Distinct from landlock_check_rule, this will happen 
once the outcome of the access check is determined (maybe at the end of 
is_access_to_paths_allowed and collect_domain_accesses?). It would 
include the pathname of the target file (only allocated if this event is 
enabled of course), so something like:

   landlock_check_fs: domain_id=7838764077 access_request=4 
pathname=/tmp/test allowed=true
   landlock_check_fs: domain_id=7838764077 access_request=4 
pathname=/tmp/test2 allowed=false

We already produces audit logs for denied requests so it is a little bit 
duplicating that, but I think this trace event shouldn't be too costly 
to include.  It has the benefit that

1. If an access is denied because no rules matched, we don't get any 
landlock_check_rule traces, and so there's no way for someone looking at 
the trace log to find out landlock denied something.

2. Having an event that represents an access check makes it possible for 
BPF programs to find out about all landlock access checks (most 
interestingly denied ones but we could expose the allowed ones too), and 
potentially relate the various `landlock_check_rule` events to an access 
check.

Actually, maybe it's worth having a "landlock_check_fs_enter", emitted 
at the beginning of is_access_to_paths_allowed and 
collect_domain_accesses? This could be useful for performance 
measurements, and also makes it more explicit which landlock_check_rule 
resulted from which access check.  Maybe the pathname and domain_id 
could be printed on the enter event, and the exit event would just have 
the outcome?  (Just an idea, I feel less certain about this. 
"Enter"/"exit" naming taken from sys_enter_*/sys_exit_* but start/end 
also works)
