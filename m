From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 09 Nov 2017 08:46:53 -0500
Subject: [RFC PATCH] ima: require secure_boot rules in lockdown mode
In-Reply-To: <alpine.LFD.2.20.1711100020240.514@localhost>
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
Message-ID: <1510235213.4484.165.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2017-11-10 at 00:28 +1100, James Morris wrote:
> On Wed, 8 Nov 2017, Mimi Zohar wrote:
> 
> > > So since those patches are now in James tree, you should drop them from
> > > the integrity tree.
> > 
> > Ok, I had been planning on sending an independent pull request to
> > Linus, as requested.
> 
> That was not requested.  Linus wants separate branches to pull from, but 
> this does not mean separate trees.  The x86 and some other subsystems use 
> separate branches in the same tree, which is the model we're now using 
> generally with the security subsystem.
> 
> It's _also_ possible to send pull requests independently (which is what 
> the SELinux and AppArmor maintainers decided to do), although that was not 
> what Linus was asking for.
> 
> It's up to you if you want to send pull requests directly to Linus or 
> continue to merge via the security tree.

Thank you for the clarification (and patience). ?There are a lot of
interactions between the integrity subsystem and the other security
subsystems, especially the TPM. ?Assuming it is acceptable, as you
said, I'd really prefer continuing to have the integrity subsystem
merged via the security tree.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
