From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Mon, 12 Feb 2018 13:26:28 +0200
Subject: [PATCH 4/6] Protectable Memory
In-Reply-To: <20180211123743.GC13931@rapoport-lnx>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
	<20180211031920.3424-5-igor.stoppa@huawei.com>
	<20180211123743.GC13931@rapoport-lnx>
Message-ID: <e7ea02b4-3d43-9543-3d14-61c27e155042@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 11/02/18 14:37, Mike Rapoport wrote:
> On Sun, Feb 11, 2018 at 05:19:18AM +0200, Igor Stoppa wrote:

>> + * Return: 0 if the object does not belong to pmalloc, 1 if it belongs to
>> + * pmalloc, -1 if it partially overlaps pmalloc meory, but incorectly.
> 
> typo:                                            ^ memory

thanks :-(

[...]

>> +/**
>> + * When the sysfs is ready to receive registrations, connect all the
>> + * pools previously created. Also enable further pools to be connected
>> + * right away.
>> + */
> 
> This does not seem as kernel-doc comment. Please either remove the second *
> from the opening comment mark or reformat the comment.

For this too, I thought I had caught them all, but I was wrong ...

I didn't find any mention of automated checking for comments.
Is there such tool?

--
thanks, igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
