From: dhowells@redhat.com (David Howells)
Date: Thu, 19 Oct 2017 23:12:30 +0100
Subject: [PATCH 02/27] Add a SysRq option to lift kernel lockdown
In-Reply-To: <97659d0c-6992-3025-0f85-819d23e954cc@infradead.org>
References: <97659d0c-6992-3025-0f85-819d23e954cc@infradead.org>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842464774.7923.7951986297563109339.stgit@warthog.procyon.org.uk>
Message-ID: <10671.1508451150@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> wrote:

> > +config ALLOW_LOCKDOWN_LIFT
> > +	bool
> > +	help
> > +	  Allow the lockdown on a kernel to be lifted, thereby restoring the
> > +	  ability of userspace to access the kernel image (eg. by SysRq+x under
> 
> how about:                                                                on
> 
> > +	  x86).

I'll just get rid of this config option, I think - it doesn't make anything
available outside of lock_down.c.

> > +#ifdef CONFIG_ALLOW_LOCKDOWN_LIFT_BY_KEY
> 
> is that the same as: CONFIG_ALLOW_LOCKDOWN_LIFT_BY_SYSRQ ?
> tested?

My test machine doesn't have a physical keyboard attached, but you're right.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
