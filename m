From: kgold@linux.vnet.ibm.com (Ken Goldman)
Date: Wed, 9 Aug 2017 16:23:12 -0400
Subject: [tpmdd-devel] [PATCH] tpm: improve tpm_tis send() performance by
	ignoring burstcount
In-Reply-To: <20170808191145.kggmoczd5laiccrn@linux.intel.com>
References: <20170807114632.1339-1-nayna@linux.vnet.ibm.com>
	<E37DFCB0-2E74-45F6-B2DF-70EF59F310BC@gmx.de>
	<20170808191145.kggmoczd5laiccrn@linux.intel.com>
Message-ID: <819e3d38-3f16-a32b-1928-c425b763d5f8@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 8/8/2017 3:11 PM, Jarkko Sakkinen wrote:
> On Mon, Aug 07, 2017 at 01:52:34PM +0200, Peter Huewe wrote:
>> Imho: NACK from my side.
> After these viewpoints definitive NACK from my side too...


I responded to the thread comments separately.  However, assuming NACK 
is the final response, I have a question.

The problem is the 5 msec sleep between polls of burst count.  In the 
case of one TPM with an 8 byte FIFO, a 32 byte transfer incurs 4 of 
these sleeps.

Would another solution be to reduce the burst count poll and sleep to, 
e.g., 100 usec or even 10 usec?  This would probably help greatly, but 
still not incur the wait states that triggered the NACK.

My worry is that the scheduler would not be able to context switch that 
fast, and so we wouldn't actually see usec speed polling.

Can a kernel expert offer an opinion?


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
