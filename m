From: dhowells@redhat.com (David Howells)
Date: Thu, 06 Apr 2017 11:43:20 +0100
Subject: [PATCH 02/24] Add the ability to lock down access to the running
	kernel image
In-Reply-To: <alpine.LRH.2.20.1704061840090.12226@namei.org>
References: <alpine.LRH.2.20.1704061840090.12226@namei.org>
	<149141219387.31282.6648284836568938717.stgit@warthog.procyon.org.uk>
	<149141221365.31282.16276273075946694481.stgit@warthog.procyon.org.uk>
Message-ID: <32240.1491475400@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

James Morris <jmorris@namei.org> wrote:

> > +static __read_mostly bool kernel_locked_down;
> 
> How about marking this __ro_after_init if ALLOW_LOCKDOWN_LIFT is not 
> configured?

I guess lock_kernel_down() would need to be __init also in that case.

Also, the implementation of lift_kernel_lockdown() should be conditional on
CONFIG_ALLOW_LOCKDOWN_LIFT.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
