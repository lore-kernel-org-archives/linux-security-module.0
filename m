From: dhowells@redhat.com (David Howells)
Date: Thu, 26 Oct 2017 15:51:44 +0100
Subject: [PATCH 07/27] kexec_file: Disable at runtime if securelevel has
	been set
In-Reply-To: <1508774083.3639.124.camel@linux.vnet.ibm.com>
References: <1508774083.3639.124.camel@linux.vnet.ibm.com>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842468754.7923.10037578333644594134.stgit@warthog.procyon.org.uk>
Message-ID: <25997.1509029504@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> The patch title and description needs to be updated to refer to
> lockdown, not securelevel.

Fixed, thanks.

> An additional patch could force these rules to be added to the custom
> policy, if lockdown is enabled.

I'll have a look at your patch, though at this point I'm leaning towards
passing the current series to James for security/next and then passing your
patch along afterwards, if that's okay with you.  It should still get in the
next merge window if that's the case.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
