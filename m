From: nivedita@alum.mit.edu (Arvind Sankar)
Date: Wed, 31 Jan 2018 21:03:32 -0500
Subject: [RFC PATCH] rootfs: force mounting rootfs as tmpfs
In-Reply-To: <a538e55c-81ca-6d59-20cf-21b47387c3e2@landley.net>
References: <1517348777.3469.5.camel@linux.vnet.ibm.com>
	<1814af5c-170d-39c0-58fd-02eb7216e008@landley.net>
	<1517436423.3469.237.camel@linux.vnet.ibm.com>
	<a538e55c-81ca-6d59-20cf-21b47387c3e2@landley.net>
Message-ID: <20180201020331.GA3774@rani.riverdale>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jan 31, 2018 at 05:48:20PM -0600, Rob Landley wrote:
> On 01/31/2018 04:07 PM, Mimi Zohar wrote:
> > On Wed, 2018-01-31 at 13:32 -0600, Rob Landley wrote:>> (The old "I configured in tmpfs and am using rootfs but I want that
> rootfs
> >> to be ramfs, not tmpfs" code doesn't seem to be a real-world concern, does
> >> it?)
> > 
> > I must be missing something. ?Which systems don't specify "root=" on
> > the boot command line.
> 
> Any system using initrd or initramfs?
> 

Don't a lot of initramfs setups use root= to tell the initramfs which
actual root file system to switch to after early boot?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
