From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Tue, 25 Jul 2017 11:49:14 -0700
Subject: [RFC PATCH 1/5] ima: extend clone() with IMA namespace support
In-Reply-To: <20170725175317.GA727@mail.hallyn.com>
References: <20170720225033.21298-1-mkayaalp@linux.vnet.ibm.com>
	<20170720225033.21298-2-mkayaalp@linux.vnet.ibm.com>
	<20170725175317.GA727@mail.hallyn.com>
Message-ID: <1501008554.3689.30.camel@HansenPartnership.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-07-25 at 12:53 -0500, Serge E. Hallyn wrote:
> On Thu, Jul 20, 2017 at 06:50:29PM -0400, Mehmet Kayaalp wrote:
> > 
> > From: Yuqiong Sun <suny@us.ibm.com>
> > 
> > Add new CONFIG_IMA_NS config option.??Let clone() create a new IMA
> > namespace upon CLONE_NEWNS flag. Add ima_ns data structure in
> > nsproxy.
> > ima_ns is allocated and freed upon IMA namespace creation and exit.
> > Currently, the ima_ns contains no useful IMA data but only a dummy
> > interface. This patch creates the framework for namespacing the
> > different
> > aspects of IMA (eg. IMA-audit, IMA-measurement, IMA-appraisal).
> > 
> > Signed-off-by: Yuqiong Sun <suny@us.ibm.com>
> > 
> > Changelog:
> > * Use CLONE_NEWNS instead of a new CLONE_NEWIMA flag
> 
> Hi,
> 
> So this means that every mount namespace clone will clone a new IMA
> namespace.??Is that really ok?

Based on what: space concerns (struct ima_ns is reasonably small)? or
whether tying it to the mount namespace is the correct thing to do. ?On
the latter, it does seem that this should be a property of either the
mount or user ns rather than its own separate ns. ?I could see a use
where even a container might want multiple ima keyrings within the
container (say containerised apache service with multiple tenants), so
instinct tells me that mount ns is the correct granularity for this.

James

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
