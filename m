From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Thu, 22 Mar 2018 12:47:14 -0400
Subject: [RFC PATCH v2 1/3] ima: extend clone() with IMA namespace support
In-Reply-To: <1521140467.5348.94.camel@HansenPartnership.com>
References: <20180309201421.6150-1-stefanb@linux.vnet.ibm.com>
	<20180309201421.6150-2-stefanb@linux.vnet.ibm.com>
	<87vadxfwqj.fsf@xmission.com>
	<c18b6e92-57f0-5994-eb60-5fadc6671832@linux.vnet.ibm.com>
	<1521135192.5348.64.camel@HansenPartnership.com>
	<2183a3b4-6270-d2e9-70ad-a7399eb1681c@linux.vnet.ibm.com>
	<1521139535.5348.89.camel@HansenPartnership.com>
	<0dc5b856-8dc6-7b5a-eeac-febd19f6498c@linux.vnet.ibm.com>
	<1521140467.5348.94.camel@HansenPartnership.com>
Message-ID: <8d9220d5-2acc-2818-c351-36b369e4b50e@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 03/15/2018 03:01 PM, James Bottomley wrote:
> On Thu, 2018-03-15 at 14:51 -0400, Stefan Berger wrote:
>> On 03/15/2018 02:45 PM, James Bottomley wrote:
> [...]
>>>>> going to need some type of keyring namespace and there's
>>>>> already
>>>>> one hanging off the user_ns:
>>>>>
>>>>> commit f36f8c75ae2e7d4da34f4c908cebdb4aa42c977e
>>>>> Author: David Howells <dhowells@redhat.com>
>>>>> Date:   Tue Sep 24 10:35:19 2013 +0100
>>>>>
>>>>>        KEYS: Add per-user_namespace registers for persistent
>>>>> per-UID
>>>>> kerberos caches
>>>> The benefit for IMA would be that this would then tie the keys
>>>> needed for appraising to the IMA namespace's policy.
>>>> However, if you have an appraise policy in your IMA namespace,
>>>> which is now hooked to the user namespace, and you join that user
>>>> namespace but your files don't have signatures, nothing will
>>>> execute anymore. That's now a side effect of joining this user
>>>> namespace unless we have a magic  exception. My feeling is,
>>>> people may not like that...
>>> Agree, but I think the magic might be to populate the ima keyring
>>> with the parent on user_ns creation.  That way the user_ns owner
>>> can delete the parent keys if they don't like them, but by default
>>> the parent appraisal policy should just work.
>> That may add keys to your keyring but doesn't get you signatures on
>> your  files.
> But it doesn't need to.  The only way we'd get a failure is if the file
> is already being appraised and we lose access to the key.  If the
> parent policy isn't appraisal, entering the IMA NS won't cause
> appraisal to be turned on unless the owner asks for it, in which case
> it's caveat emptor: As it works today, if as root I add a default
> appraisal policy to IMA without either a key or xattrs, I get an
> unusable system.

When I post a next implementation for the spawning if an IMA namespace, 
what shall be the criterion for accepting it?

     Stefan

>
> James
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
