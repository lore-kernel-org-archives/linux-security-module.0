From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Apr 2017 12:42:32 +0200
Subject: [PATCH 08/38] Annotate hardware config module parameters in
	drivers/gpio/
In-Reply-To: <149141147489.29162.566616944109123278.stgit@warthog.procyon.org.uk>
References: <149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
	<149141147489.29162.566616944109123278.stgit@warthog.procyon.org.uk>
Message-ID: <CACRpkdaLW6egEB-w1iEfy1b0RM=yB8QoYFkatiUvEE8fvWJSiw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Apr 5, 2017 at 6:57 PM, David Howells <dhowells@redhat.com> wrote:

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
> This patch annotates drivers in drivers/gpio/.
>
> Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> cc: Alexandre Courbot <gnurou@gmail.com>
> cc: linux-gpio at vger.kernel.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I see that I don't have this symbol in my tree so I guess the patch
series adds it and this patch needs to follow it.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
