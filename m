From: Jens.Rottmann@ADLINKtech.com (Jens Rottmann)
Date: Tue, 18 Apr 2017 18:24:03 +0200
Subject: [PATCH 06/38] Annotate hardware config module parameters in
	drivers/clocksource/
In-Reply-To: <alpine.DEB.2.20.1704142021320.2327@nanos>
References: <149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
	<149141145858.29162.13072730133817038218.stgit@warthog.procyon.org.uk>
	<alpine.DEB.2.20.1704142021320.2327@nanos>
Message-ID: <96f4b1b3-636b-51c1-53d4-c3c3cd330dce@ADLINKtech.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

On 04/14/2017 20:25, Thomas Gleixner wrote:
>>  static int timer_irq;
>> -module_param_named(irq, timer_irq, int, 0644);
>> +module_param_hw_named(irq, timer_irq, int, irq, 0644);
>>  MODULE_PARM_DESC(irq, "Which IRQ to use for the clock source MFGPT ticks.");
> 
> I'm not sure about this. AFAIR the parameter is required to work on
> anything else than some arbitrary hardware which has it mapped to 0.

Parameter defaults to 0, which means:
1. autodetect (=keep IRQ BIOS has set up)
2. if that fails use CONFIG_CS5535_MFGPT_DEFAULT_IRQ
(see drivers/misc/cs5535-mfgpt.c: cs5535_mfgpt_set_irq())

Autodetect works fine for our (ex-LiPPERT, now ADLINK) COTS boards:
Linux auto-uses IRQ chosen in BIOS Setup. Wouldn't know about other
companies, of course, but (2.) means parameter can be avoided via make
menuconfig.

On 04/15/2017 00:59, David Howells wrote:
> Should it then be set through in-kernel platform initialisation
> since the AMD Geode is an embedded chip?

Don't know what each and every of our COTS customers is doing, but I'm
not aware of anyone having written a platform driver. AFAIK many are
running pretty standard distros, e.g. Debian. I happen to have booted
Slackware with a vanilla kernel only a few hours ago.

Cheers,
Jens
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
