From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Fri, 26 Jan 2018 14:28:11 +0200
Subject: [kernel-hardening] [PATCH 4/6] Protectable Memory
In-Reply-To: <20180125153839.GA3542@redhat.com>
References: <20180124175631.22925-1-igor.stoppa@huawei.com>
	<20180124175631.22925-5-igor.stoppa@huawei.com>
	<CAG48ez0JRU8Nmn7jLBVoy6SMMrcj46R0_R30Lcyouc4R9igi-g@mail.gmail.com>
	<6c6a3f47-fc5b-0365-4663-6908ad1fc4a7@huawei.com>
	<CAFUG7CfP_UyEH=1dmX=wsBz73+fQ0syDAy8ArKT0d4nMyf9n-g@mail.gmail.com>
	<20180125153839.GA3542@redhat.com>
Message-ID: <8eb12a75-4957-d5eb-9a14-387788728b8a@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 25/01/18 17:38, Jerome Glisse wrote:
> On Thu, Jan 25, 2018 at 10:14:28AM -0500, Boris Lukashev wrote:
>> On Thu, Jan 25, 2018 at 6:59 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
> 
> [...]
> 
>> DMA/physmap access coupled with a knowledge of which virtual mappings
>> are in the physical space should be enough for an attacker to bypass
>> the gating mechanism this work imposes. Not trivial, but not
>> impossible. Since there's no way to prevent that sort of access in
>> current hardware (especially something like a NIC or GPU working
>> independently of the CPU altogether)

[...]

> I am not saying that this can not happen but that we are trying our best
> to avoid it.

How about an opt-in verification, similar to what proposed by Boris
Lukashev?

When reading back the data, one could access the pointer directly and
bypass the verification, or could use a function that explicitly checks
the integrity of the data.

Starting from an unprotected kmalloc allocation, even just turning the
data into R/O is an improvement, but if one can afford the overhead of
performing the verification, why not?

It would still be better if the service was provided by the library,
instead than implemented by individual users, I think.

--
igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
