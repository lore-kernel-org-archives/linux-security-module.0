From: dhowells@redhat.com (David Howells)
Date: Thu, 20 Apr 2017 15:37:37 +0100
Subject: [PATCH 5/6] MODSIGN: Export module signature definitions.
In-Reply-To: <1492691712.3081.85.camel@linux.vnet.ibm.com>
References: <1492691712.3081.85.camel@linux.vnet.ibm.com>
	<1492546666-16615-1-git-send-email-bauerman@linux.vnet.ibm.com>
	<1492546666-16615-6-git-send-email-bauerman@linux.vnet.ibm.com>
Message-ID: <21102.1492699057@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> On Tue, 2017-04-18 at 17:17 -0300, Thiago Jung Bauermann wrote:
> > IMA will use the module_signature format for append signatures, so export
> > the relevant definitions and factor out the code which verifies that the
> > appended signature trailer is valid.
> > 
> > Also, create a CONFIG_MODULE_SIG_FORMAT option so that IMA can select it
> > and be able to use validate_module_signature without having to depend on
> > CONFIG_MODULE_SIG.
> 
> Basically we want to generalize the concept of an appended signature.
> ?Referring to it as a "module signature format" seems a bit confusing.
> 
> David, would you have a problem with changing the appended string from
> "~Module signature appended~\n" to something more generic?

Conceptually, no.  Is it possible that doing so could break someone's module
that they load on multiple versions of the kernel?  Say a module that only
exports things and doesn't use anything from the core or any other module.

Also, it needs to reasonably long and distinct enough to prevent a false
positive match.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
