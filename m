From: tomas.winkler@intel.com (Winkler, Tomas)
Date: Mon, 5 Mar 2018 21:21:37 +0000
Subject: [PATCH 1/6] tpm: sort objects in the Makefile
In-Reply-To: <20180305211206.GB9335@ziepe.ca>
References: <20180305202017.24008-1-tomas.winkler@intel.com>
	<20180305202017.24008-2-tomas.winkler@intel.com>
	<20180305211206.GB9335@ziepe.ca>
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422E7F3@hasmsx108.ger.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> On Mon, Mar 05, 2018 at 10:20:12PM +0200, Tomas Winkler wrote:
> > Make the tpm Makefile a bit more in order by putting objects in one
> > column and group together tpm2 modules
> >
> > Prefer tpm-objs += instead of tpm-y += notation.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > drivers/char/tpm/Makefile | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> > index acd758381c58..2fc0e9a73cd6 100644
> > +++ b/drivers/char/tpm/Makefile
> > @@ -3,9 +3,17 @@
> >  # Makefile for the kernel tpm device drivers.
> >  #
> >  obj-$(CONFIG_TCG_TPM) += tpm.o
> > -tpm-y := tpm-interface.o tpm-dev.o tpm-sysfs.o tpm-chip.o tpm2-cmd.o \
> > -	 tpm-dev-common.o tpmrm-dev.o tpm1_eventlog.o tpm2_eventlog.o
> \
> > -         tpm2-space.o
> > +tpm-objs := tpm-interface.o
> > +tpm-objs += tpm-dev.o
> > +tpm-objs += tpm-chip.o
> > +tpm-objs += tpm-dev-common.o
> > +tpm-objs += tpmrm-dev.o
> > +tpm-objs += tpm-sysfs.o
> > +tpm-objs += tpm1_eventlog.o
> > +tpm-objs += tpm2-cmd.o
> > +tpm-objs += tpm2-space.o
> > +tpm-objs += tpm2_eventlog.o
> 
> If you are going to do this then sort the list please

I've sorted in that way that in the future will probably will compile tpm1- out, you probably mean to alphabetically. 
> 
> Seems weird to me though, there are not that many examples of this pattern
> in the kernel.

#find -name Makefile  | xargs grep -e 'objs +=' | awk -F: '{print $1}' | uniq  | wc -l
74

Just a personal taste maybe. 

> What is wrong with:
> 
> tpm-objs := \
> 	 tpm-interface.o \
> 	 tpm-dev.o \
> 	 [..]
> 
For me it's less error prone without backslashes, but at the end it's just the same again just a personal test.

Thanks
Tomas


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
