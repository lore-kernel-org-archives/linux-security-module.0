From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 15 Nov 2017 07:37:20 -0500
Subject: [GIT PULL] Security subsystem: integrity updates for v4.15
In-Reply-To: <alpine.LFD.2.20.1711130901380.28856@localhost>
References: <alpine.LFD.2.20.1711130901380.28856@localhost>
Message-ID: <1510749440.3711.285.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2017-11-13 at 09:05 +1100, James Morris wrote:
> Hi Linus,
> 
> Please pull these fixes for the Integrity subsystem.
> 
> (From Mimi)
> 
> "There is a mixture of bug fixes, code cleanup, preparatory code for new 
> functionality and new functionality.
> 
> Commit 26ddabfe96bb "evm: enable EVM when X509 certificate is loaded" 
> enabled EVM without loading a symmetric key, but was limited to defining 
> the x509 certificate pathname at build.  Included in this set of patches 
> is the ability of enabling EVM, without loading the EVM symmetric key, 
> from userspace.  New is the ability to prevent the loading of an EVM 
> symmetric key."

James, thank you for keeping the integrity patches separate, as
requested, and sending the extra pull request. ?This is extra work for
you, but I really appreciate it. ?The pull request seems to have gone
smoothly.

So much of the integrity subsystem is dependent on the other security
subsystems (eg. keys, TPM, LSM hooks). ?Having a common security
testing branch is really helpful. ?It makes collaboration that much
easier.

Thanks!

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
