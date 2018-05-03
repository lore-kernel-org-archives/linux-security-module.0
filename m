From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 03 May 2018 19:02:43 -0400
Subject: [PATCH v5 2/5] efi: Add embedded peripheral firmware support
In-Reply-To: <20180503222329.GD27853@wotan.suse.de>
References: <20180429093558.5411-1-hdegoede@redhat.com>
	<20180429093558.5411-3-hdegoede@redhat.com>
	<1525185374.5669.49.camel@linux.vnet.ibm.com>
	<dc122066-9973-a1be-3456-6d6181a8fc9f@redhat.com>
	<1525202847.5669.64.camel@linux.vnet.ibm.com>
	<20180503222329.GD27853@wotan.suse.de>
Message-ID: <1525388563.3539.97.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2018-05-03 at 22:23 +0000, Luis R. Rodriguez wrote:
> On Tue, May 01, 2018 at 03:27:27PM -0400, Mimi Zohar wrote:
> > On Tue, 2018-05-01 at 21:11 +0200, Hans de Goede wrote:
> > > Only the pre hook?  I believe the post-hook should still be called too,
> > > right? So that we've hashes of all loaded firmwares in the IMA core.
> > 
> > Good catch! ?Right, if IMA-measurement is enabled, then we would want
> > to add the measurement.
> 
> Mimi, just a heads up, we only use the post hook for the syfs fallback
> mechanism, ie, we don't even use the post hook for direct fs lookup.
> Do we want that there?

The direct fs lookup calls kernel_read_file_from_path(), which calls
the security_kernel_read_file() and security_kernel_post_read_file()
hooks. ?So there is no need to add a direct call to either of these
security calls.

Mimi



??

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
