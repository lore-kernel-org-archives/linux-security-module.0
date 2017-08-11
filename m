From: kgold@linux.vnet.ibm.com (Ken Goldman)
Date: Fri, 11 Aug 2017 17:42:43 -0400
Subject: [Linux-ima-devel] [tpmdd-devel] [PATCH] tpm: improve tpm_tis
	send() performance by ignoring burstcount
In-Reply-To: <db0359cc-5e6b-2055-734a-bd9104e4a99f@linux.vnet.ibm.com>
References: <20170807114632.1339-1-nayna@linux.vnet.ibm.com>
	<E37DFCB0-2E74-45F6-B2DF-70EF59F310BC@gmx.de>
	<20170808191145.kggmoczd5laiccrn@linux.intel.com>
	<db0359cc-5e6b-2055-734a-bd9104e4a99f@linux.vnet.ibm.com>
Message-ID: <7ec8265f-265d-641a-6da3-d931f8df4819@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Following up on this thread based on this week's TCG call ...

1 - burstCount can safely be ignored on writes.  This is explicit in
most places in the TCG spec.  In places where it is not explicit, it was 
simply an editorial omission.  We are going through the spec and adding 
"without incurring wait states."

TCG is willing to publish an errata if that makes developers more 
comfortable.

2 - These are multi-mhz buses.  The TPM vendors conformed that wait 
states, even if incurred, will be sub-usec.  I.e., less that a microsecond.

Essentially, the DD is loading the FIFO, and the TPM is unloading the 
FIFO at processor speeds.

Thus, even if one were worried about an odd system new enough to have a 
TPM, but old enough to have an LPC attached printer, keyboard, mouse or 
floppy, the delay in printing or typing will be insignificant.

3 - I asked several platform vendors with long TCG experience, and they 
said that they know of no motherboards that share the LPC bus with a TPM 
plus another device.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
