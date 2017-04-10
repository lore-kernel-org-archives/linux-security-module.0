From: dhowells@redhat.com (David Howells)
Date: Mon, 10 Apr 2017 14:19:52 +0100
Subject: [PATCH 09/24] kexec_file: Disable at runtime if securelevel has
	been set
In-Reply-To: <1491568577.4184.97.camel@linux.vnet.ibm.com>
References: <1491568577.4184.97.camel@linux.vnet.ibm.com>
	<1491551180.4184.50.camel@linux.vnet.ibm.com>
	<1491536950.4184.10.camel@linux.vnet.ibm.com>
	<149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142335441.5101.2294976563846442575.stgit@warthog.procyon.org.uk>
	<20170407030545.GA4296@dhcp-128-65.nay.redhat.com>
	<21572.1491548994@warthog.procyon.org.uk>
	<27362.1491556638@warthog.procyon.org.uk>
Message-ID: <13679.1491830392@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> From an IMA perspective, either a file hash or signature are valid,
> but for this usage it must be a signature.

Not necessarily.  If IMA can guarantee that a module is the same based on its
hash rather than on a key, I would've thought that should be fine.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
