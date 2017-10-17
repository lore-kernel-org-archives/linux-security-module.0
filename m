From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Oct 2017 15:06:29 +0100
Subject: [PATCH v9 00/20] simplify crypto wait for async op
In-Reply-To: <1508059209-25529-1-git-send-email-gilad@benyossef.com>
References: <1508059209-25529-1-git-send-email-gilad@benyossef.com>
Message-ID: <20171017140629.GO20805@n2100.armlinux.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Oct 15, 2017 at 10:19:45AM +0100, Gilad Ben-Yossef wrote:
> Many users of kernel async. crypto services have a pattern of
> starting an async. crypto op and than using a completion
> to wait for it to end.
> 
> This patch set simplifies this common use case in two ways:
> 
> First, by separating the return codes of the case where a
> request is queued to a backlog due to the provider being
> busy (-EBUSY) from the case the request has failed due
> to the provider being busy and backlogging is not enabled
> (-EAGAIN).
> 
> Next, this change is than built on to create a generic API
> to wait for a async. crypto operation to complete.
> 
> The end result is a smaller code base and an API that is
> easier to use and more difficult to get wrong.
> 
> The patch set was boot tested on x86_64 and arm64 which
> at the very least tests the crypto users via testmgr and
> tcrypt but I do note that I do not have access to some
> of the HW whose drivers are modified nor do I claim I was
> able to test all of the corner cases.
> 
> The patch set is based upon linux-next release tagged
> next-20171013.

Has there been any performance impact analysis of these changes?  I
ended up with patches for one of the crypto drivers which converted
its interrupt handling to threaded interrupts being reverted because
it caused a performance degredation.

Moving code to latest APIs to simplify it is not always beneficial.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
