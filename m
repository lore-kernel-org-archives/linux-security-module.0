From: serge@hallyn.com (Serge E. Hallyn)
Date: Fri, 23 Jun 2017 12:01:08 -0500
Subject: [PATCH 0/3] Enable namespaced file capabilities
In-Reply-To: <ef37880d-6baa-12a6-eab1-bcd0a4e94d53@schaufler-ca.com>
References: <1498157989-11814-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAOQ4uxj=_Riih1K+QOYasZU8vZKCSrsg393f=17mJ2O-909e=Q@mail.gmail.com>
	<20170623160026.GA18257@mail.hallyn.com>
	<aa62373e-7cd6-39dd-2e38-2b6d6dbe18a8@schaufler-ca.com>
	<20170623163030.GA18820@mail.hallyn.com>
	<ef37880d-6baa-12a6-eab1-bcd0a4e94d53@schaufler-ca.com>
Message-ID: <20170623170108.GA19354@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Casey Schaufler (casey at schaufler-ca.com):
> On 6/23/2017 9:30 AM, Serge E. Hallyn wrote:
> > Quoting Casey Schaufler (casey at schaufler-ca.com):
> >> Or maybe just security.ns.capability, taking James' comment into account.
> > That last one may be suitable as an option, useful for his particular
> > (somewhat barbaric :) use case, but it's not ok for the general solution.
> 
> security.ns at uid=100.capability

I'm ok with this.  It gives protection from older kernels, and puts
the 'ns at uid=' at predictable locations for security and trusted.

> It makes the namespace part explicit and separate from
> the rest of the attribute name. It also generalizes for
> other attributes.
> 
> security.ns at uid=1000 at smack=WestOfOne.SMACK64

Looks good to me.

Do we want to say that '.' ends the attribute list?  That of
course means '.' cannot be in the attributes.  Perhaps end
with '@@' instead?  Just a thought.

What do others think?

thanks,
-serge
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
