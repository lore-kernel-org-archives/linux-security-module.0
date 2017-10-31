From: james.l.morris@oracle.com (James Morris)
Date: Tue, 31 Oct 2017 14:25:26 +1100 (AEDT)
Subject: [RFC PATCH] ima: require secure_boot rules in lockdown mode
In-Reply-To: <1509385178.3583.159.camel@linux.vnet.ibm.com>
References: <1509382827.3583.143.camel@linux.vnet.ibm.com>
	<1508774387.3639.128.camel@linux.vnet.ibm.com>
	<750.1509378910@warthog.procyon.org.uk>
	<3691.1509383138@warthog.procyon.org.uk>
	<1509385178.3583.159.camel@linux.vnet.ibm.com>
Message-ID: <alpine.LFD.2.20.1710311424310.22021@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 30 Oct 2017, Mimi Zohar wrote:

> James is staging the subsystem patches independently of each other, in
> case of a similar problem, so that they can be pulled separately.
> ?There's a new "next-general" branch.

If you send me a pull request, I'm combining branches into next-testing, 
too, which is pulled into -next.


-- 
James Morris
<james.l.morris@oracle.com>
