From: tiwai@suse.de (Takashi Iwai)
Date: Fri, 07 Apr 2017 10:42:37 +0200
Subject: [PATCH 35/38] Annotate hardware config module parameters in
	sound/drivers/
In-Reply-To: <149141171975.29162.18186172352089656358.stgit@warthog.procyon.org.uk>
References: <149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
	<149141171975.29162.18186172352089656358.stgit@warthog.procyon.org.uk>
Message-ID: <s5hzifs8v7m.wl-tiwai@suse.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 05 Apr 2017 19:01:59 +0200,
David Howells wrote:
> 
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
> This patch annotates drivers in sound/drivers/.
> 
> Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jaroslav Kysela <perex@perex.cz>
> cc: Takashi Iwai <tiwai@suse.com>
> cc: alsa-devel at alsa-project.org

The changes look fairly straightforward, so feel free to take my ack
for sound/* stuff:
  Acked-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
