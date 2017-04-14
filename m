From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 14 Apr 2017 13:27:11 +0200
Subject: [PATCH 32/38] Annotate hardware config module parameters in
	drivers/video/
In-Reply-To: <149141169417.29162.14993661679501972758.stgit@warthog.procyon.org.uk>
References: <149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
	<149141169417.29162.14993661679501972758.stgit@warthog.procyon.org.uk>
	<CGME20170414112713epcas5p218f3663e4f0ea4ca1bfaf4155d4724c8@epcas5p2.samsung.com>
Message-ID: <1776542.mxlLkUsWmV@amdc3058>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wednesday, April 05, 2017 06:01:34 PM David Howells wrote:
> When the kernel is running in secure boot mode, we lock down the kernel to
> prevent userspace from modifying the running kernel image.  Whilst this
> includes prohibiting access to things like /dev/mem, it must also prevent
> access by means of configuring driver modules in such a way as to cause a
> device to access or modify the kernel image.
> 
> To this end, annotate module_param* statements that refer to hardware
> configuration and indicate for future reference what type of parameter they
> specify.  The parameter parser in the core sees this information and can
> skip such parameters with an error message if the kernel is locked down.
> The module initialisation then runs as normal, but just sees whatever the
> default values for those parameters is.
> 
> Note that we do still need to do the module initialisation because some
> drivers have viable defaults set in case parameters aren't specified and
> some drivers support automatic configuration (e.g. PNP or PCI) in addition
> to manually coded parameters.
> 
> This patch annotates drivers in drivers/video/.
> 
> Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jaya Kumar <jayalk@intworks.biz>
> cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> cc: linux-fbdev at vger.kernel.org

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
