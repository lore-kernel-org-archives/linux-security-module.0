From: peterhuewe@gmx.de (Peter Huewe)
Date: Wed, 13 Sep 2017 12:01:20 -0700
Subject: [tpmdd-devel] [PATCH v2 1/4] tpm: ignore burstcount to improve
	tpm_tis send() performance.
In-Reply-To: <3c418974-a4c7-518e-b218-f6373c10209e@linux.vnet.ibm.com>
References: <20170906125643.5070-1-nayna@linux.vnet.ibm.com>
	<20170906125643.5070-2-nayna@linux.vnet.ibm.com>
	<20170906161246.GA9747@obsidianresearch.com>
	<3c418974-a4c7-518e-b218-f6373c10209e@linux.vnet.ibm.com>
Message-ID: <5C86BF5C-76AA-47DB-B15B-DE524823CF9F@gmx.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



Am 13. September 2017 11:52:12 GMT-07:00 schrieb Ken Goldman <kgold@linux.vnet.ibm.com>:
>On 9/6/2017 12:12 PM, Jason Gunthorpe wrote:
>> 
>> The problem with this approach is that the TPM could totally block
>> the CPU for very long periods of time.
>> 
>> It seems very risky to enable..
>> 
>
>How would you characterize "very long"?
>
>The TPM vendors confirm that they empty the FIFO at internal speeds
>that
>are comparable to the bus speed.  Thus, any stall will be sub-usec.  Is
>that an issue?

If the tpm does behave correctly, this is fine. 
If the tpm hangs for whatever reason, your machine is frozen and you will never figure out why.

That's my concern there.
However ddwg seems fine.

>
>In addition, new TPMs have ever larger FIFO's, making stalls less
>likely
>going forward.
But also reduced the polling loops that introduce the performance penalty ;)

>
>
>------------------------------------------------------------------------------
>Check out the vibrant tech community on one of the world's most
>engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>_______________________________________________
>tpmdd-devel mailing list
>tpmdd-devel at lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/tpmdd-devel

-- 
Sent from my mobile
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
