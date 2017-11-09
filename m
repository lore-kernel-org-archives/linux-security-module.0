From: james.l.morris@oracle.com (James Morris)
Date: Fri, 10 Nov 2017 00:28:40 +1100 (AEDT)
Subject: [RFC PATCH] ima: require secure_boot rules in lockdown mode
In-Reply-To: <1510196818.4484.120.camel@linux.vnet.ibm.com>
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
Message-ID: <alpine.LFD.2.20.1711100020240.514@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 8 Nov 2017, Mimi Zohar wrote:

> > So since those patches are now in James tree, you should drop them from
> > the integrity tree.
> 
> Ok, I had been planning on sending an independent pull request to
> Linus, as requested.

That was not requested.  Linus wants separate branches to pull from, but 
this does not mean separate trees.  The x86 and some other subsystems use 
separate branches in the same tree, which is the model we're now using 
generally with the security subsystem.

It's _also_ possible to send pull requests independently (which is what 
the SELinux and AppArmor maintainers decided to do), although that was not 
what Linus was asking for.

It's up to you if you want to send pull requests directly to Linus or 
continue to merge via the security tree.


- James
-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
