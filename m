From: keescook@chromium.org (Kees Cook)
Date: Thu, 16 Nov 2017 17:08:57 -0800
Subject: [PATCH v2 00/15] ima: digest list feature
In-Reply-To: <aec4e72a-7f74-43e7-c226-f51077e7c619@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
	<1510061855.3425.113.camel@linux.vnet.ibm.com>
	<aec4e72a-7f74-43e7-c226-f51077e7c619@huawei.com>
Message-ID: <CAGXu5jKjXqn-1j881vYc1F0POPhPJOPZB1w=W_zfgdXTsiyX6A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Nov 7, 2017 at 8:45 AM, Roberto Sassu <roberto.sassu@huawei.com> wrote:
> On 11/7/2017 2:37 PM, Mimi Zohar wrote:
>> Normally, the protection of kernel memory is out of scope for IMA.
>> This patch set introduces an in kernel white list, which would be a
>> prime target for attackers looking for ways of by-passing IMA-
>> measurement, IMA-appraisal and IMA-audit.  Others might disagree, but
>> from my perspective, this risk is too high.

BTW, which part of the series does the whitelist? I'd agree generally,
though: we don't want to make things writable if they're normally
read-only.

> It would be much easier for an attacker to just set ima_policy_flag to
> zero.

That's a fair point. I wonder if ima_policy_flag could be marked
__ro_after_init? Most of the writes are from __init sections, but I
haven't looked closely at when ima_update_policy() gets called.

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
