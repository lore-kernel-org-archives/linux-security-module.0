From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 02 May 2017 15:01:22 -0400
Subject: [PATCH 09/24] kexec_file: Disable at runtime if securelevel has
	been set
In-Reply-To: <13679.1491830392@warthog.procyon.org.uk>
References: <1491568577.4184.97.camel@linux.vnet.ibm.com>
	<1491551180.4184.50.camel@linux.vnet.ibm.com>
	<1491536950.4184.10.camel@linux.vnet.ibm.com>
	<149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142335441.5101.2294976563846442575.stgit@warthog.procyon.org.uk>
	<20170407030545.GA4296@dhcp-128-65.nay.redhat.com>
	<21572.1491548994@warthog.procyon.org.uk>
	<27362.1491556638@warthog.procyon.org.uk>
	<13679.1491830392@warthog.procyon.org.uk>
Message-ID: <1493751682.3680.11.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi David,

On Mon, 2017-04-10 at 14:19 +0100, David Howells wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> > From an IMA perspective, either a file hash or signature are valid,
> > but for this usage it must be a signature.
> 
> Not necessarily.  If IMA can guarantee that a module is the same based on its
> hash rather than on a key, I would've thought that should be fine.

File hashes can be modified on the running system, so they're normally
used,?in conjunction with EVM, to detect off line modification of
mutable files and prevent their usage.

These patches https://lkml.org/lkml/2017/5/2/465?should provide some
of the missing functionality.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
