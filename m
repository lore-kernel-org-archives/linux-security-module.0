From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Mon, 22 May 2017 22:50:09 +0300
Subject: [PATCH] LSM: Make security_hook_heads a local variable.
In-Reply-To: <d98f4cd5-3f21-3f7b-2842-12b9a009e453@schaufler-ca.com>
References: <20170520085147.GA4619@kroah.com>
	<1495365245-3185-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<20170522140306.GA3907@infradead.org>
	<d98f4cd5-3f21-3f7b-2842-12b9a009e453@schaufler-ca.com>
Message-ID: <d25e2fd3-da11-4ec0-8edc-f1327c04fa6e@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 22/05/17 18:09, Casey Schaufler wrote:
> On 5/22/2017 7:03 AM, Christoph Hellwig wrote:

[...]

>> But even with those we can still chain
>> them together with a list with external linkage.
> 
> I gave up that approach in 2012. Too many unnecessary calls to
> null functions, and massive function vectors with a tiny number
> of non-null entries. From a data structure standpoint, it was
> just wrong. The list scheme is exactly right for the task at
> hand.

I understand this as a green light, for me to continue with the plan of
using LSM Hooks as example for making dynamically allocated data become
read-only, using also Tetsuo's patch (thanks, btw).

Is that correct?

---
thanks, igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
