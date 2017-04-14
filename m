From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 14 Apr 2017 15:08:13 +0200
Subject: [PATCH 18/38] Annotate hardware config module parameters in
	drivers/net/can/
In-Reply-To: <149141157162.29162.10145088436840145584.stgit@warthog.procyon.org.uk>
References: <149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
	<149141157162.29162.10145088436840145584.stgit@warthog.procyon.org.uk>
Message-ID: <8f7e225b-15fb-58c8-9e3f-34cfafb330d6@pengutronix.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 04/05/2017 06:59 PM, David Howells wrote:
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
> This patch annotates drivers in drivers/net/can/.
> 
> Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> cc: Wolfgang Grandegger <wg@grandegger.com>
> cc: linux-can at vger.kernel.org
> cc: netdev at vger.kernel.org

Who whill take this patch? Or will it be allied as part of the series by
some of my upstreams?

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://kernsec.org/pipermail/linux-security-module-archive/attachments/20170414/f12cd92f/attachment.sig>
