From: james.l.morris@oracle.com (James Morris)
Date: Fri, 10 Nov 2017 06:17:49 +1100 (AEDT)
Subject: [RFC PATCH] ima: require secure_boot rules in lockdown mode
In-Reply-To: <1510235213.4484.165.camel@linux.vnet.ibm.com>
References: <1509382827.3583.143.camel@linux.vnet.ibm.com>
	<1508774387.3639.128.camel@linux.vnet.ibm.com>
	<750.1509378910@warthog.procyon.org.uk>
	<3691.1509383138@warthog.procyon.org.uk>
	<1509385178.3583.159.camel@linux.vnet.ibm.com>
	<alpine.LFD.2.20.1710311424310.22021@localhost>
	<1510173982.4484.30.camel@linux.vnet.ibm.com>
	<20171109075334.1809f4cc@canb.auug.org.au>
	<1510175047.4484.35.camel@linux.vnet.ibm.com>
	<20171109102635.7691281d@canb.auug.org.au>
	<1510196818.4484.120.camel@linux.vnet.ibm.com>
	<alpine.LFD.2.20.1711100020240.514@localhost>
	<1510235213.4484.165.camel@linux.vnet.ibm.com>
Message-ID: <alpine.LFD.2.20.1711100617360.5638@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 9 Nov 2017, Mimi Zohar wrote:

> Thank you for the clarification (and patience). ?There are a lot of
> interactions between the integrity subsystem and the other security
> subsystems, especially the TPM. ?Assuming it is acceptable, as you
> said, I'd really prefer continuing to have the integrity subsystem
> merged via the security tree.

That's fine, whatever works for you.


-- 
James Morris
<james.l.morris@oracle.com>
