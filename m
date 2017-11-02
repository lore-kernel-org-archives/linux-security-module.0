From: dhowells@redhat.com (David Howells)
Date: Thu, 02 Nov 2017 21:43:39 +0000
Subject: [RFC PATCH] ima: require secure_boot rules in lockdown mode
In-Reply-To: <1509658253.3416.1.camel@linux.vnet.ibm.com>
References: <1509658253.3416.1.camel@linux.vnet.ibm.com>
	<1509382827.3583.143.camel@linux.vnet.ibm.com>
	<1508774387.3639.128.camel@linux.vnet.ibm.com>
	<750.1509378910@warthog.procyon.org.uk>
	<22475.1509642717@warthog.procyon.org.uk>
Message-ID: <13298.1509659019@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> > +	bool kernel_locked_down = kernel_is_locked_down();
> 
> kernel_is_locked_down() requires a string.

Hmmm...  Probably don't want to call kernel_is_locked_down() here as that'll
get a message printed saying that you tried to do something that's disallowed.

Possibly:

	... = __kernel_is_locked_down("", false);

Though it might be better to provide a second vector.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
