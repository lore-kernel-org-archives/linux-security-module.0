From: dhowells@redhat.com (David Howells)
Date: Thu, 25 May 2017 07:53:22 +0100
Subject: [PATCH 3/5] Add the ability to lock down access to the running
	kernel image
In-Reply-To: <80bdc6c9-004b-800f-ffd0-4b5ebf8cdeba@schaufler-ca.com>
References: <80bdc6c9-004b-800f-ffd0-4b5ebf8cdeba@schaufler-ca.com>
	<149563711758.9419.11406612723056598045.stgit@warthog.procyon.org.uk>
	<149563714531.9419.16811189348445249219.stgit@warthog.procyon.org.uk>
Message-ID: <19783.1495695202@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> > +#ifdef CONFIG_LOCK_DOWN_KERNEL
> > +extern bool kernel_is_locked_down(void);
> > +#else
> > +static inline bool kernel_is_locked_down(void)
> 
> Should this be a bool or an int? I can imagine that someone is going to want
> various different degrees of lock down for kernels. As an int you could
> return a bitmap indicating which features were locked. This would allow
> additional things to be locked down without changing the interface.

At the moment it makes no difference, since the return value is only ever
passed directly to an if-statement.

Also, do you have an idea as to how is should be divided up?

There aren't so many cases, at least not yet, that they can't be fixed up,
perhaps with a coccinelle script.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
