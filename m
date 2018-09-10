From: alison.schofield@intel.com (Alison Schofield)
Date: Mon, 10 Sep 2018 14:47:32 -0700
Subject: [RFC 11/12] keys/mktme: Add a new key service type for memory
	encryption keys
In-Reply-To: <105F7BF4D0229846AF094488D65A098935424C2D@PGSMSX112.gar.corp.intel.com>
References: <cover.1536356108.git.alison.schofield@intel.com>
	<1a14a6feb02f968c5e6b98360f6f16106b633b58.1536356108.git.alison.schofield@intel.com>
	<105F7BF4D0229846AF094488D65A098935424C2D@PGSMSX112.gar.corp.intel.com>
Message-ID: <20180910214731.GA29337@alison-desk.jf.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Sep 09, 2018 at 08:29:29PM -0700, Huang, Kai wrote:
> > -----Original Message-----
> > From: keyrings-owner at vger.kernel.org [mailto:keyrings-
> > owner at vger.kernel.org] On Behalf Of Alison Schofield
> > Sent: Saturday, September 8, 2018 10:39 AM
> > To: dhowells at redhat.com; tglx at linutronix.de
> > Cc: Huang, Kai <kai.huang@intel.com>; Nakajima, Jun
> > <jun.nakajima@intel.com>; Shutemov, Kirill <kirill.shutemov@intel.com>;
> > Hansen, Dave <dave.hansen@intel.com>; Sakkinen, Jarkko
> > <jarkko.sakkinen@intel.com>; jmorris at namei.org; keyrings at vger.kernel.org;
> > linux-security-module at vger.kernel.org; mingo at redhat.com; hpa at zytor.com;
> > x86 at kernel.org; linux-mm at kvack.org
> > Subject: [RFC 11/12] keys/mktme: Add a new key service type for memory
> > encryption keys
> > 
> > MKTME (Multi-Key Total Memory Encryption) is a technology that allows
> > transparent memory encryption in upcoming Intel platforms. MKTME will
> > support mulitple encryption domains, each having their own key. The main use
> > case for the feature is virtual machine isolation. The API needs the flexibility to
> > work for a wide range of uses.
> > 
> > The MKTME key service type manages the addition and removal of the memory
> > encryption keys. It maps software keys to hardware keyids and programs the
> > hardware with the user requested encryption options.
> > 
> > The only supported encryption algorithm is AES-XTS 128.
> > 
> > The MKTME key service is half of the MKTME API level solution. It pairs with a
> > new memory encryption system call: encrypt_mprotect() that uses the keys to
> > encrypt memory.
> > 


Kai -
Splitting out responses by subject...

> > +cpumask_var_t mktme_cpumask;		/* one cpu per pkg to program
> > keys */
> 
> Oh the 'mktme_cpumask' is here. Sorry I didn't notice when replying to your patch 10. :)
> 
> But I think you can just move what you did in patch 10 here and leave intel_pconfig.h unchanged. It's much clearer. 

I'll try that out and see how it works.

> > +
> > +	for_each_online_cpu(online_cpu) {
> > +		online_pkgid = topology_physical_package_id(online_cpu);
> > +
> > +		for_each_cpu(mktme_cpu, mktme_cpumask) {
> > +			mktme_pkgid =
> > topology_physical_package_id(mktme_cpu);
> > +			if (mktme_pkgid == online_pkgid)
> > +				break;
> > +		}
> > +		if (mktme_pkgid != online_pkgid)
> > +			cpumask_set_cpu(online_cpu, mktme_cpumask);
> > +	}
> 
> Could we use 'for_each_online_node', 'cpumask_first/next', etc to simplify the logic?

Sure - I'll look at those. 

Thanks!
Alison
