From: dhowells@redhat.com (David Howells)
Date: Fri, 07 Apr 2017 10:17:18 +0100
Subject: [PATCH 09/24] kexec_file: Disable at runtime if securelevel has
	been set
In-Reply-To: <1491551180.4184.50.camel@linux.vnet.ibm.com>
References: <1491551180.4184.50.camel@linux.vnet.ibm.com>
	<1491536950.4184.10.camel@linux.vnet.ibm.com>
	<149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142335441.5101.2294976563846442575.stgit@warthog.procyon.org.uk>
	<20170407030545.GA4296@dhcp-128-65.nay.redhat.com>
	<21572.1491548994@warthog.procyon.org.uk>
Message-ID: <27362.1491556638@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> > Okay, fair enough.  I can stick in an OR with an IS_ENABLED on some IMA
> > symbol.  CONFIG_IMA_KEXEC maybe?  And also require IMA be enabled?
> 
> Not quite, since as Dave pointed out, IMA is policy driven.  As a
> policy is installed, we could set a flag.

Does such a flag exist as yet?

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
