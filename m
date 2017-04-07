From: dhowells@redhat.com (David Howells)
Date: Fri, 07 Apr 2017 08:09:54 +0100
Subject: [PATCH 09/24] kexec_file: Disable at runtime if securelevel has
	been set
In-Reply-To: <1491536950.4184.10.camel@linux.vnet.ibm.com>
References: <1491536950.4184.10.camel@linux.vnet.ibm.com>
	<149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142335441.5101.2294976563846442575.stgit@warthog.procyon.org.uk>
	<20170407030545.GA4296@dhcp-128-65.nay.redhat.com>
Message-ID: <21572.1491548994@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> > > +	if (!IS_ENABLED(CONFIG_KEXEC_VERIFY_SIG) && kernel_is_locked_down())
> > > +		return -EPERM;
> > > +
> > >  
> 
> IMA can be used to verify file signatures too, based on the LSM hooks
> in ?kernel_read_file_from_fd(). ?CONFIG_KEXEC_VERIFY_SIG should not be
> required.

Okay, fair enough.  I can stick in an OR with an IS_ENABLED on some IMA
symbol.  CONFIG_IMA_KEXEC maybe?  And also require IMA be enabled?

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
