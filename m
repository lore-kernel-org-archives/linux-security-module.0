Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E024120C48E;
	Mon, 26 May 2025 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748284678; cv=none; b=n3fsXNIB6Wxrnz2LrreMCFTB2/woHYgr36AkeipTP/xCMXahHiAolQ2dyf7eDG3bI1RMu+ewRx3ozhKfpYbk+9UtLX851lEOk+1kiAOcsks/M9l8lwo7jz1aAbQSfWQ0Wb7a2hvyekYoPtaHi6du4+lXLLZQx8ZUi0EElGPzK40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748284678; c=relaxed/simple;
	bh=4E9+IkJX9kqMF1AIYZ6urJI5zdn917yy/O9i6F8chxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LsicLhU6z8PMPVGA3qr3Y7k30LRE9MrlrAO3ZLl6qAG7c2FT/ndTumhbeeRx8ijZMZqcQkZ6orYVdD3LlISlc1Sv3PJ9szuJtsLjQw+ZcoBcLfX32NsuEdQ+fEbSDW8BdsnUs1d0v7blbzYLdfUVTL8Ow0LkaL3DEwp40te6On8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=idUEjQoy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IPGCN4pw; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="idUEjQoy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IPGCN4pw"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CC5FF25401B8;
	Mon, 26 May 2025 14:37:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 26 May 2025 14:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748284674;
	 x=1748371074; bh=EQrWm3nt+fG59q1P3OT4c7WxMUW1rdjS2TWL/754fgA=; b=
	idUEjQoy/iY5BV6Mz0Za5IV7qidwTIsnL0Jq+ZvF9tgKhxFRfCNAaclripbtlTEx
	+4xYjy1zm2thrN2xSmdssTBuzlGYPi/4FbNNGenlOmCqaT6NcTdrTME9ZHjiuZjJ
	he7uz4O4u4gDOV72OOlbtPIKfWQ8VrxSpzLMGWpWgvDDappUFaE2BLnz8Nazjxt9
	BIDNuz7CrhgOlAeSblv9dKu29XTlBc3y5LP4cin960Ceg4dYiZwJWK3VnKh3vay9
	h5GYyOEnDWu9/K1tf2e/FHTw8dLvj4VxR38ppJVjdy8JhURrUPHsTHkrBk/3RTvS
	KJJi0C1hARCWabp3TSjCNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748284674; x=
	1748371074; bh=EQrWm3nt+fG59q1P3OT4c7WxMUW1rdjS2TWL/754fgA=; b=I
	PGCN4pwT2XLN1NhQ4oJJ+1Sg5sIeXgG6LbAm1qyHIfaUUbOHJrMSi2a0mST31FiE
	F+cFTgXQHhzGZTN7kIZzlJoGSOmjLOBgU3/GUmFSA7QHLy/9CEXZSWDQyV7KzzCO
	w4TapGhPquDaNQ7VIJU9CVx2EiLsXFQRw658mjllZnp1Z/V4OQpYtGt6LswNcKyQ
	JHsjAxbkimEFM5W0tmLuJg8mc6b3PBcVLBf/R4jRZuG7EZpnZ8rS9ytxvxvdLnNu
	wXII/c+N0mrDce6fVMsk2SORC8+CEqYkUeh4fATiwM0cxIij9PzY2l46CDkyPTMz
	sT//Xgimn7V1tEzowO/MA==
X-ME-Sender: <xms:ArU0aLzUy6TzW8aVmO2-whNf8NaBYZuwQczNkshCiyVwB6am1RqKag>
    <xme:ArU0aDSYMLlF1x9TnIl-lTPULvT_jxbSV5HDxGq7OF3693Q4cokMFXemOTRCVBdKl
    H1ws_cWSYb85iZZ5UE>
X-ME-Received: <xmr:ArU0aFXev-HyZx-Bk7Q9ko3sS2tjUj2A8IYc5g1Sj1LpMgv5K_8y_t2XWX7JzZrI_9c8rwbzttO7BDY_tGpkUglm>
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
X-ME-Proxy: <xmx:ArU0aFh0sXHkvNnZmm1IcsH5GbDzG1vmixj_Eu27WBFyYqhKaJ4w-g>
    <xmx:ArU0aNBdeaSzRvnGx-erwqVpNFrBZddPD0iZ8dpLXM8vGFvC8KZcOA>
    <xmx:ArU0aOJtnG61tfKkSC31WaAzeblu7E7r-JnXsA1A0hznEDk6CNMrQw>
    <xmx:ArU0aMBmSV4BPNLeVuVHCLr3S0aTak15ydMTZ2mdJmapywqTAy06sA>
    <xmx:ArU0aMWrn2PzjpH19amg7ij3DmbJSbPz0kMISDq6042ls2tvedUGxCC_>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 14:37:52 -0400 (EDT)
Message-ID: <d61717c2-df30-4cd2-a14e-e05ca9f69892@maowtm.org>
Date: Mon, 26 May 2025 19:37:52 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 4/5] landlock: Add landlock_add_rule_fs tracepoint
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
 <20250523165741.693976-5-mic@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250523165741.693976-5-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/23/25 17:57, Mickaël Salaün wrote:
> Add a tracepoint for Landlock path_beneath rule addition.  This is
> useful to tie a Landlock object with a file for debug purpose.
> 
> Allocate the absolute path names when adding new rules.  This is OK
> because landlock_add_rule(2) is not a performance critical code.
> 
> Here is an example of landlock_add_rule_fs traces:
>    ruleset=0x000000007e3b1c4a key=inode:0xffff888004f59260 allowed=0xd dev=0:16 ino=306 path=/usr
>    ruleset=0x000000007e3b1c4a key=inode:0xffff888004f59240 allowed=0xffff dev=0:16 ino=346 path=/root
> 
> TODO: Use Landlock IDs instead of kernel addresses to identify Landlock
> objects (e.g. inode).

Do you mean like the u64 domain ID for audit, but for objects?  Since 
there currently isn't a u64, non-pointer ID, I guess we would have to 
create one for the object just for tracing?

My understanding is that kernel pointers are not hidden from the root 
user / someone who can read traces, so maybe just printing the pointer 
is good enough?

> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tingmao Wang <m@maowtm.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>   MAINTAINERS                     |  1 +
>   include/trace/events/landlock.h | 68 +++++++++++++++++++++++++++++++++
>   security/landlock/Makefile      | 11 +++++-
>   security/landlock/fs.c          | 22 +++++++++++
>   security/landlock/fs.h          |  3 ++
>   security/landlock/trace.c       | 14 +++++++
>   6 files changed, 117 insertions(+), 2 deletions(-)
>   create mode 100644 include/trace/events/landlock.h
>   create mode 100644 security/landlock/trace.c
> 
 > > [...]
 > > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 73a20a501c3c..e5d673240882 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -36,6 +36,7 @@
>   #include <linux/types.h>
>   #include <linux/wait_bit.h>
>   #include <linux/workqueue.h>
> +#include <trace/events/landlock.h>
>   #include <uapi/linux/fiemap.h>
>   #include <uapi/linux/landlock.h>
>   
> @@ -345,6 +346,27 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>   	mutex_lock(&ruleset->lock);
>   	err = landlock_insert_rule(ruleset, ref, access_rights);
>   	mutex_unlock(&ruleset->lock);
> +
> +	if (!err && trace_landlock_add_rule_fs_enabled()) {
> +		const char *pathname;
> +		/* Does not handle deleted files. */
> +		char *buffer __free(__putname) = __getname();
> +
> +		if (buffer) {
> +			const char *absolute_path =
> +				d_absolute_path(path, buffer, PATH_MAX);
> +			if (!IS_ERR_OR_NULL(absolute_path))
> +				pathname = absolute_path;
> +			else
> +				pathname = "<too_long>";

Not sure if it's necessary to go that far, but I think d_absolute_path 
returns -ENAMETOOLONG in the too long case, and -EINVAL in the "not 
possible to construct a path" case (I guess e.g. if it's an anonymous 
file or detached mount).  We could add an else if branch to check which 
case it is and use different strings.

> +		} else {
> +			/* Same format as audit_log_d_path(). */
> +			pathname = "<no_memory>";
> +		}
> +		trace_landlock_add_rule_fs(ruleset, &ref, access_rights, path,
> +					   pathname);
> +	}
> +
>   	/*
>   	 * No need to check for an error because landlock_insert_rule()
>   	 * increments the refcount for the new object if needed.
> diff --git a/security/landlock/fs.h b/security/landlock/fs.h
> index bf9948941f2f..60be95ebfb0b 100644
> --- a/security/landlock/fs.h
> +++ b/security/landlock/fs.h
> @@ -11,6 +11,7 @@
>   #define _SECURITY_LANDLOCK_FS_H
>   
>   #include <linux/build_bug.h>
> +#include <linux/cleanup.h>
>   #include <linux/fs.h>
>   #include <linux/init.h>
>   #include <linux/rcupdate.h>
> @@ -128,4 +129,6 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>   			    const struct path *const path,
>   			    access_mask_t access_hierarchy);
>   
> +DEFINE_FREE(__putname, char *, if (_T) __putname(_T))

Out of curiosity why not put this in include/linux/fs.h (seems to 
compile for me when added there)?

> +
>   #endif /* _SECURITY_LANDLOCK_FS_H */
> diff --git a/security/landlock/trace.c b/security/landlock/trace.c
> new file mode 100644
> index 000000000000..98874cda473b
> --- /dev/null
> +++ b/security/landlock/trace.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Landlock - Tracepoints
> + *
> + * Copyright © 2025 Microsoft Corporation
> + */
> +
> +#include <linux/path.h>
> +
> +#include "access.h"
> +#include "ruleset.h"
> +
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/landlock.h>

