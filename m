From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 08 Nov 2017 15:46:22 -0500
Subject: [RFC PATCH] ima: require secure_boot rules in lockdown mode
In-Reply-To: <alpine.LFD.2.20.1710311424310.22021@localhost>
References: <1509382827.3583.143.camel@linux.vnet.ibm.com>
	<1508774387.3639.128.camel@linux.vnet.ibm.com>
	<750.1509378910@warthog.procyon.org.uk>
	<3691.1509383138@warthog.procyon.org.uk>
	<1509385178.3583.159.camel@linux.vnet.ibm.com>
	<alpine.LFD.2.20.1710311424310.22021@localhost>
Message-ID: <1510173982.4484.30.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

[Cc'ing Stephen Rothwell]

On Tue, 2017-10-31 at 14:25 +1100, James Morris wrote:
> On Mon, 30 Oct 2017, Mimi Zohar wrote:
> 
> > James is staging the subsystem patches independently of each other, in
> > case of a similar problem, so that they can be pulled separately.
> > ?There's a new "next-general" branch.
> 
> If you send me a pull request, I'm combining branches into next-testing, 
> too, which is pulled into -next.

linux-next already has the IMA patches, which might be confusing.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
