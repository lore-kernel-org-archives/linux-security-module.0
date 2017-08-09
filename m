From: kgold@linux.vnet.ibm.com (Ken Goldman)
Date: Wed, 9 Aug 2017 16:25:48 -0400
Subject: [tpmdd-devel] [PATCH] tpm: improve tpm_tis send() performance by
	ignoring burstcount
In-Reply-To: <20170808191145.kggmoczd5laiccrn@linux.intel.com>
References: <20170807114632.1339-1-nayna@linux.vnet.ibm.com>
	<E37DFCB0-2E74-45F6-B2DF-70EF59F310BC@gmx.de>
	<20170808191145.kggmoczd5laiccrn@linux.intel.com>
Message-ID: <db0359cc-5e6b-2055-734a-bd9104e4a99f@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 8/8/2017 3:11 PM, Jarkko Sakkinen wrote:
 > On Mon, Aug 07, 2017 at 01:52:34PM +0200, Peter Huewe wrote:

 >> Are you sure this is a good idea?
 >> On lpc systems this more or less stalls the bus, including 
keyboard/mouse (if connected via superio lpc).
 >>
 >> On which systems have you tested this?
 >> Spi/Lpc? Architecture?
 >>
 >> This might not be noticable for small transfers, but think about 
much larger transfers....
 >>
 >> Imho: NACK from my side.
 >>
 >> Thanks,
 >> Peter
 >
 > Thanks Peter, a great insight. TPM could share the bus with other
 > devices. Even if this optimizes the performance for TPM it might cause
 > performance issues elsewhere.

Does anyone know of platforms where this occurs?

I suspect (but not sure) that the days of SuperIO connecting floppy 
drives, printer ports, and PS/2 mouse ports on the LPC bus are over, and 
such legacy systems will not have a TPM. Would SuperIO even support the 
special TPM LPC bus cycles?

Even then, the wait states of a mhz speed LPC are likely to be usec,
not noticeable for even a mouse.

Is this a reasonable assumption?

If so, to we affect TPM performance to the point where it's unusable to 
help a case that is unlikely to appear in current platforms?

 >
 > One more viewpoint: TCG must added the burst count for a reason (might
 > be very well related what Peter said). Is ignoring it something that TCG
 > recommends? Not following standard exactly in the driver code sometimes
 > makes sense on *small details* but I would not say that this a small
 > detail...

I checked with the TCG's device driver work group (DDWG).  Both the spec 
editor and 3 TPM vendors - Infineon, Nuvoton, and ST Micro - agreed that 
ignoring burst count may incur wait states but nothing more.  Operations 
will still be successful.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
