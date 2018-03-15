From: why2jjj.linux@gmail.com (J Freyensee)
Date: Thu, 15 Mar 2018 11:51:16 -0700
Subject: [PATCH 4/8] struct page: add field for vm_struct
In-Reply-To: <6924c919-dbfb-a9f6-748a-0bbfe8d876b1@huawei.com>
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
	<20180313214554.28521-5-igor.stoppa@huawei.com>
	<20180313220040.GA15791@bombadil.infradead.org>
	<7b18521c-539b-2ba1-823e-e83be071c13f@gmail.com>
	<6924c919-dbfb-a9f6-748a-0bbfe8d876b1@huawei.com>
Message-ID: <007b20f7-54f8-0397-88ce-4a106bfdb8e9@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 3/15/18 2:38 AM, Igor Stoppa wrote:
> On 14/03/18 19:43, J Freyensee wrote:
>> On 3/13/18 3:00 PM, Matthew Wilcox wrote:
> [...]
>
>>>> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
>>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>> Igor, do you mind sticking these tags on the files that have spent some
>> time reviewing a revision of your patchset (like the Reviewed-by: tags I
>> provided last revision?)
> Apologies, that was not intentional, I forgot it.
> I will do it, although most of the files will now change so much that I
> am not sure what will survive, beside this patch, in the form that you
> reviewed.
>
> I suppose the Review-by tag drops, if the patch changes.

That's true, if so much of the patch changes it basically looks like 
something different, the Reviewed-by: would drop.

Jay

>
> --
> igor

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
