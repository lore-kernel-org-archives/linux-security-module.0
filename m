From: tadeusz.struk@intel.com (Tadeusz Struk)
Date: Thu, 21 Jun 2018 10:36:20 -0700
Subject: [PATCH v3 0/2] tpm: add support for nonblocking operation
In-Reply-To: <20180621171746.GJ11859@linux.intel.com>
References: <152882630662.30206.8805136953394285180.stgit@tstruk-mobl1.jf.intel.com>
	<20180619131046.GC5609@linux.intel.com>
	<e402d3d0-d9de-35a9-d434-d472d8f68e62@intel.com>
	<20180621171746.GJ11859@linux.intel.com>
Message-ID: <fff9a2ae-6f18-2401-f65b-d53f1506bbdf@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 06/21/2018 10:17 AM, Jarkko Sakkinen wrote:
> On Tue, Jun 19, 2018 at 05:45:35PM -0700, Tadeusz Struk wrote:
>> Hi Jarkko,
>> Thanks for reviewing the patch.
>> There are applications/frameworks where a worker thread is not an option.
>> Take for example the IoT use-cases and frameworks like IoT.js, or "Node.js for IoT".
>> They are all single threaded, event-driven frameworks, using non-blocking I/O as the base of their processing model.
>> Similarly embedded applications, which are basically just a single threaded event loop, quite often don't use threads because of resources constrains.
>>
>> If your concern is that user space will not adopt to this, I can say that TSS library [1] is currently blocked on this feature, and we can not enable some of the use-cases mentioned above because of this.
>>
>> Thanks,
>> Tadeusz
>>
>> [1] https://github.com/tpm2-software/tpm2-tss
> 
> I put this into "mathematical" terms. TPM is by nature is blocking. It
> does not scale this way so you are essentially just simulating
> non-blocking behaviour.
> 

That is correct, and this is exactly why we need this.
Thanks,
-- 
Tadeusz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
