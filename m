From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Mon, 12 Feb 2018 13:17:01 +0200
Subject: [PATCH 1/6] genalloc: track beginning of allocations
In-Reply-To: <20180211122444.GB13931@rapoport-lnx>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
	<20180211031920.3424-2-igor.stoppa@huawei.com>
	<20180211122444.GB13931@rapoport-lnx>
Message-ID: <f0a244f2-f63a-376b-28f2-debbe914da34@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 11/02/18 14:24, Mike Rapoport wrote:
> On Sun, Feb 11, 2018 at 05:19:15AM +0200, Igor Stoppa wrote:
[...]

>> +/**
>> + * mem_to_units - convert references to memory into orders of allocation
> 
> Documentation/doc-guide/kernel-doc.rst recommends to to include brackets
> for function comments. I haven't noticed any difference in the resulting
> html, so I'm not sure if the brackets are actually required.

This is what I see in the example from mailine docs:

/**
 * foobar() - Brief description of foobar.
 * @argument1: Description of parameter argument1 of foobar.
 * @argument2: Description of parameter argument2 of foobar.
 *
 * Longer description of foobar.
 *
 * Return: Description of return value of foobar.
 */
int foobar(int argument1, char *argument2)


What are you referring to?

[...]

>> + * @size: amount in bytes
>> + * @order: power of 2 represented by each entry in the bitmap
>> + *
>> + * Returns the number of units representing the size.
> 
> Please s/Return/Return:/

:-( I thought I had fixed them all. thanks for spotting this.

[...]

>> + * Return: If two users alter the same bit, to one it will return
>> + * remaining entries, to the other it will return 0.
> 
> And what if there are three or four concurrent users? ;-)
> 
> I believe that a more elaborate description about what happens with
> concurrent attempts to alter the bitmap would be really helpful.

ok

--
thanks, igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
