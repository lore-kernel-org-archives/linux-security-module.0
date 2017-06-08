From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 8 Jun 2017 19:50:05 +0100
Subject: [PATCH v3] tpm: Enable CLKRUN protocol for Braswell systems
In-Reply-To: <20170608183920.GA7984@obsidianresearch.com>
References: <1496369044-38234-1-git-send-email-azhar.shaikh@intel.com>
	<1496870610-29462-1-git-send-email-azhar.shaikh@intel.com>
	<20170607224444.5043f545@lxorguk.ukuu.org.uk>
	<5FFFAD06ADE1CA4381B3F0F7C6AF5828910C7B@ORSMSX109.amr.corp.intel.com>
	<20170608192259.43150ffa@lxorguk.ukuu.org.uk>
	<20170608183920.GA7984@obsidianresearch.com>
Message-ID: <20170608195005.6edc9242@lxorguk.ukuu.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> For that purpose all that should be required is strong ordering of the
> outb relative to the other TPM commands at the LPC interface FIFO. I
> also think the wmb is not needed because outb is already defined to be
> strongly in order with respect to writel/readl ?

That's my assumption but given this is all some kind of 'it's broken'
fixup I thought best to ask. Assuming there is nothing else magical going
on then yes it should be deleted.

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
