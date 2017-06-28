From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Wed, 28 Jun 2017 11:25:37 +0300
Subject: [PATCH 3/3] Make LSM Writable Hooks a command line option
In-Reply-To: <20170627175118.GA14286@infradead.org>
References: <20170627173323.11287-1-igor.stoppa@huawei.com>
	<20170627173323.11287-4-igor.stoppa@huawei.com>
	<20170627175118.GA14286@infradead.org>
Message-ID: <bd570517-c05f-7f37-aba0-6e4c14938dfb@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Resending my reply, I mistakenly used the wrong mail account yesterday
and my reply didn't et to the ml.

On 27/06/17 20:51, Christoph Hellwig wrote:
> On Tue, Jun 27, 2017 at 08:33:23PM +0300, Igor Stoppa wrote:

[...]

>> The default value is disabled, unless SE Linux debugging is turned on.
> 
> Can we please just force it to be read-only?

I'm sorry, I'm not quite sure I understand your comment.

I'm trying to replicate the behavior of __lsm_ro_after_init:

line 1967 @ [1]   - Did I get it wrong?

thanks, igor



[1]
https://kernel.googlesource.com/pub/scm/linux/kernel/git/jmorris/linux-security/+/5965453d5e3fb425e6f9d6b4fec403bda3f33107/include/linux/lsm_hooks.h

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
