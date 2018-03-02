From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 02 Mar 2018 16:10:15 -0500
Subject: [PATCH v2 3/4] ima: fail signature verification based on policy
In-Reply-To: <20180228153015.GA30654@mail.hallyn.com>
References: <1519335184-17808-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1519335184-17808-4-git-send-email-zohar@linux.vnet.ibm.com>
	<20180227223545.GB18767@mail.hallyn.com>
	<1519817938.3737.72.camel@linux.vnet.ibm.com>
	<20180228153015.GA30654@mail.hallyn.com>
Message-ID: <1520025015.10396.142.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2018-02-28 at 09:30 -0600, Serge E. Hallyn wrote:
> Quoting Mimi Zohar (zohar at linux.vnet.ibm.com):
> > On Tue, 2018-02-27 at 16:35 -0600, Serge E. Hallyn wrote:
> > > Quoting Mimi Zohar (zohar at linux.vnet.ibm.com):
> > > > This patch addresses the fuse privileged mounted filesystems in
> > > > environments which are unwilling to accept the risk of trusting the
> > > > signature verification and want to always fail safe, but are for
> > > > example using a pre-built kernel.
> > > > 
> > > > This patch defines a new builtin policy "unverifiable_sigs", which can
> > > 
> > > How about recalc_unverifiable_sigs?
> > 
> > Cute, I really like that name, but in this case we're failing the
> > signature verification.
> > 
> > > It's long, but unverifiable_sigs
> > > is  not clear about whether the intent is to accept or recalculate them.
> > > 
> > > (or fail_unverifiable_sigs like the flag)
> > 
> > Could we abbreviate it to "fail_usigs"? ?Or perhaps allow both
> > "fail_unverifiable_sigs" and "fail_usigs".
> 
> That sounds good.  Or fail_unverified?  But so long as 'fail' is somehow
> clearly implied by the name.

None of these names mean anything to anyone but us. ?How about
"fail_safe"? ?That at least has some meaning to some people.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
