From: azhar.shaikh@intel.com (Shaikh, Azhar)
Date: Thu, 8 Jun 2017 19:27:34 +0000
Subject: [PATCH v3] tpm: Enable CLKRUN protocol for Braswell systems
In-Reply-To: <20170608195005.6edc9242@lxorguk.ukuu.org.uk>
References: <1496369044-38234-1-git-send-email-azhar.shaikh@intel.com>
	<1496870610-29462-1-git-send-email-azhar.shaikh@intel.com>
	<20170607224444.5043f545@lxorguk.ukuu.org.uk>
	<5FFFAD06ADE1CA4381B3F0F7C6AF5828910C7B@ORSMSX109.amr.corp.intel.com>
	<20170608192259.43150ffa@lxorguk.ukuu.org.uk>
	<20170608183920.GA7984@obsidianresearch.com>
	<20170608195005.6edc9242@lxorguk.ukuu.org.uk>
Message-ID: <5FFFAD06ADE1CA4381B3F0F7C6AF5828910FC0@ORSMSX109.amr.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



> -----Original Message-----
> From: Alan Cox [mailto:gnomes at lxorguk.ukuu.org.uk]
> Sent: Thursday, June 8, 2017 11:50 AM
> To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Cc: Shaikh, Azhar <azhar.shaikh@intel.com>;
> jarkko.sakkinen at linux.intel.com; tpmdd-devel at lists.sourceforge.net; linux-
> kernel at vger.kernel.org; linux-security-module at vger.kernel.org
> Subject: Re: [PATCH v3] tpm: Enable CLKRUN protocol for Braswell systems
> 
> > For that purpose all that should be required is strong ordering of the
> > outb relative to the other TPM commands at the LPC interface FIFO. I
> > also think the wmb is not needed because outb is already defined to be
> > strongly in order with respect to writel/readl ?
> 
> That's my assumption but given this is all some kind of 'it's broken'
> fixup I thought best to ask. Assuming there is nothing else magical going on
> then yes it should be deleted.
> 

As Jason mentioned, outb is already define to be strongly ordered, then wmb is not needed.
I will delete it.

> Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
