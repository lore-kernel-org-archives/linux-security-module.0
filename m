From: tadeusz.struk@intel.com (Tadeusz Struk)
Date: Thu, 21 Jun 2018 09:20:38 -0700
Subject: [PATCH v3 0/2] tpm: add support for nonblocking operation
In-Reply-To: <1529558767.3118.1.camel@HansenPartnership.com>
References: <152882630662.30206.8805136953394285180.stgit@tstruk-mobl1.jf.intel.com>
	<20180619131046.GC5609@linux.intel.com>
	<e402d3d0-d9de-35a9-d434-d472d8f68e62@intel.com>
	<1529539176.4163.2.camel@HansenPartnership.com>
	<0e46c2e9-af2b-550f-2b3d-98cbc1840bc1@gmail.com>
	<1529558767.3118.1.camel@HansenPartnership.com>
Message-ID: <279e1857-dbed-808d-0481-ced43f7fa64b@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 06/20/2018 10:26 PM, James Bottomley wrote:
>> Yes, it does polling:
>> http://docs.libuv.org/en/v1.x/design.html#the-i-o-loop
> But that's for networking.  You'll be talking to the TPM RM over the
> file descriptor so that follows the thread pool model in
> 
> http://docs.libuv.org/en/v1.x/design.html#file-i-o
> 
> This precisely describes the current file descriptor abstraction we'd
> use for the TPM.

That is for the file IO that doesn't support non-blocking, because there
is no need for it as the operations are "fast".
Operations on the TPM would fall under the io loop model.

> 
>> Regardless of how it actually might be used, I'm happy that we agree
>> on that this *is* the right thing to do.
> I didn't say that.  I think using a single worker thread queue is the
> correct abstraction for the TPM.  If there's a legacy use case for
> poll(), I don't see why not since the code seems to be fairly small and
> self contained, but I don't really see it as correct or necessary to do
> it that way.

This discussion starts to go around the circle. You don't agree, but you
also don't disagree? Is this what you are saying?
Thanks,
-- 
Tadeusz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
