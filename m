From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 15 Jun 2018 11:20:25 -0400
Subject: [integrity:next-integrity-queued 22/22]
	security/integrity/evm/evm_crypto.c:93: undefined reference to
	`hash_algo_name'
In-Reply-To: <1529060150.3740.79.camel@linux.vnet.ibm.com>
References: <201806140958.6pTSK5nT%fengguang.wu@intel.com>
	<1529060150.3740.79.camel@linux.vnet.ibm.com>
Message-ID: <1529076025.3740.89.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2018-06-15 at 06:55 -0400, Mimi Zohar wrote:
> On Thu, 2018-06-14 at 09:07 +0800, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity-queued
> > head:   6497009f11c75bae55a3329dedcd3eeb8e282eaf
> > commit: 6497009f11c75bae55a3329dedcd3eeb8e282eaf [22/22] evm: Allow non-SHA1 digital signatures
> > config: x86_64-randconfig-ws0-06140615 (attached as .config)
> > compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> > reproduce:
> >         git checkout 6497009f11c75bae55a3329dedcd3eeb8e282eaf
> >         # save the attached .config to linux build tree
> >         make ARCH=x86_64 
> > 
> > All errors (new ones prefixed by >>):
> >    security/integrity/evm/evm_crypto.o: In function `init_desc':
> > >> security/integrity/evm/evm_crypto.c:93: undefined reference to `hash_algo_name'
> > 
> > vim +93 security/integrity/evm/evm_crypto.c
> 
> Thanks! ?Removing the hash.h include should fix it. ?(commit updated.)

Reverting this change and selecting?CRYPTO_HASH_INFO instead.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
