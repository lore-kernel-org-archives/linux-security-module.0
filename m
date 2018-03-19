From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Sun, 18 Mar 2018 20:13:23 -0600
Subject: [PATCH] tpm: allow TCPA log area to be empty
In-Reply-To: <20180316125525.GB5035@linux.intel.com>
References: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
	<20180312150231.GA24717@ziepe.ca>
	<20180316125525.GB5035@linux.intel.com>
Message-ID: <20180319021323.GD27186@ziepe.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Mar 16, 2018 at 02:55:25PM +0200, Jarkko Sakkinen wrote:
> On Mon, Mar 12, 2018 at 09:02:32AM -0600, Jason Gunthorpe wrote:
> > On Sat, Mar 10, 2018 at 06:16:37PM +0200, Jarkko Sakkinen wrote:
> > > TCPA log are can be empty when the TPM is disabled. This commit changes the
> > > behavior of tpm_read_log_acpi() to return successfully in this case.
> > 
> > The commit should explain why we'd want this..
> > 
> > eg Why does it matter to create the extra sysfs files to report an empty
> > log?
> > 
> > Jason
> 
> The initialization of the driver will fail otherwise. Not sure if I
> understand your question.

Well, I mean in the sense of what is broken and why is this the right
fix. Why not return -ENODEV?

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
