From: john.johansen@canonical.com (John Johansen)
Date: Wed, 18 Apr 2018 08:59:01 -0700
Subject: [RFC PATCH v3 1/3] ima: extend clone() with IMA namespace support
In-Reply-To: <bc03161e-394b-bf4d-48c4-858dcf05458a@linux.vnet.ibm.com>
References: <1522159038-14175-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1522159038-14175-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<87sh8lcecn.fsf@xmission.com>
	<bc03161e-394b-bf4d-48c4-858dcf05458a@linux.vnet.ibm.com>
Message-ID: <cdb2a5b2-f0e8-e7ba-7b76-bd295dc654ad@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 03/28/2018 04:10 AM, Stefan Berger wrote:
> On 03/27/2018 07:01 PM, Eric W. Biederman wrote:
>> Stefan Berger <stefanb@linux.vnet.ibm.com> writes:
>>
>>> From: Yuqiong Sun <suny@us.ibm.com>
>>>
>>> Add new CONFIG_IMA_NS config option.? Let clone() create a new IMA
>>> namespace upon CLONE_NEWUSER flag. Attach the ima_ns data structure
>>> to user_namespace. ima_ns is allocated and freed upon IMA namespace
>>> creation and exit, which is tied to USER namespace creation and exit.
>>> Currently, the ima_ns contains no useful IMA data but only a dummy
>>> interface. This patch creates the framework for namespacing the different
>>> aspects of IMA (eg. IMA-audit, IMA-measurement, IMA-appraisal).
>> Tying IMA to the user namespace is far better than tying IMA
>> to the mount namespace.? It may even be the proper answer.
>>
>>
>> You had asked what it would take to unstick this so you won't have
>> problems next time you post and I did not get as far as answering.
>>
>> I had a conversation a while back with Mimi and I believe what was
>> agreed was that IMA to start doing it's thing early needs a write
>> to securityfs/imafs.
> 
> Above you say 'proper answer' for user namespace. Now this sounds like making it independent.
> 
Agreed, and if we want to broaden out to LSMs implementing namespacing keeping them independent is the correct solution

>>
>> As such I expect the best way to create the ima namespace is by simply
>> writing to securityfs/imafs.? Possibly before the user namespace is
>> even unshared.? That would allow IMA to keep track of things from
>> before a container is created.
> 
> So you are saying to not tie it to user namespace but make it an independent namespace and to not use a clone flag (0x1000) but use the filesystem to spawn a new namespace. Should that be an IMA specific file or a file that can be shared with other subsystems?
> 

A clone flag could work for IMA, but I don't see it working for all the LSMs looking at or doing namespacing, especially if the stacking work ever lands.

As for using an IMA specific file vs shared with the other subsystems, I think subsystem specific makes sense, that or we are going to have to design something that can be shared if LSM stacking ever lands.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
