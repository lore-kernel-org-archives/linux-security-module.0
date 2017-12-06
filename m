From: hareeshg@codeaurora.org (Hareesh Gundu)
Date: Wed, 6 Dec 2017 20:45:01 +0530
Subject: [PATCH] security: Export few symbols referred by other modules
In-Reply-To: <201712052221.HDJ00044.tOOHVMFQFOJLSF@I-love.SAKURA.ne.jp>
References: <1512471537-23865-1-git-send-email-hareeshg@codeaurora.org>
	<alpine.LFD.2.20.1712052259390.14735@localhost>
	<201712052221.HDJ00044.tOOHVMFQFOJLSF@I-love.SAKURA.ne.jp>
Message-ID: <0322ddc2-f1a2-93f5-d34d-d57f6be734a3@codeaurora.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 12/5/2017 6:51 PM, Tetsuo Handa wrote:
> James Morris wrote:
>> On Tue, 5 Dec 2017, Hareesh Gundu wrote:
>>
>>> Export mmap_min_addr and security_mmap_addr() to allow
>>> kernel modules to use them.
>>>
>>> Signed-off-by: Hareesh Gundu <hareeshg@codeaurora.org>
Can other folks comment whether this should be EXPORT_SYMBOL or 
EXPORT_SYMBOL_GPL ?
>> I'm not sure whether this should be EXPORT_SYMBOL or EXPORT_SYMBOL_GPL, as
>> this hook was added in 2009, well after EXPORT_SYMBOL_GPL came into being.
>>
>> Most of the LSM hooks are marked EXPORT_SYMBOL because they were part of
>> an existing interface when EXPORT_SYMBOL_GPL was introduced, IIRC.
>>
>> What do folks think?
>>
 ?That's right, This change is for outside kernel tree modules.
> We don't export symbols not used by in-tree modules.
> Which in-tree module needs to access these symbols?
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
