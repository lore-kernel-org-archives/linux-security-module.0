From: serge@hallyn.com (Serge E. Hallyn)
Date: Mon, 20 Nov 2017 10:52:06 -0600
Subject: [PATCH v2 06/15] ima: add parser of digest lists metadata
In-Reply-To: <1511186020.4729.66.camel@linux.vnet.ibm.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
	<20171107103710.10883-7-roberto.sassu@huawei.com>
	<20171118042030.GA13456@mail.hallyn.com>
	<1511047410.5920.111.camel@linux.vnet.ibm.com>
	<175600e1-c472-69fc-2b4d-4255d8e827b5@huawei.com>
	<1511186020.4729.66.camel@linux.vnet.ibm.com>
Message-ID: <20171120165206.GA14752@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Mimi Zohar (zohar at linux.vnet.ibm.com):
> On Mon, 2017-11-20 at 10:40 +0100, Roberto Sassu wrote:
> > On 11/19/2017 12:23 AM, Mimi Zohar wrote:
> > > Hi Serge,
> > > 
> > > On Fri, 2017-11-17 at 22:20 -0600, Serge E. Hallyn wrote:
> > >> On Tue, Nov 07, 2017 at 11:37:01AM +0100, Roberto Sassu wrote:
> > >>> from a predefined position (/etc/ima/digest_lists/metadata), when rootfs
> > >>> becomes available. Digest lists must be loaded before IMA appraisal is in
> > >>> enforcing mode.
> > >>
> > >> I'm sure there's a good reason for it, but this seems weird to me.
> > >> Why read it from a file on disk instead of accepting it through say
> > >> a securityfile write?
> > 
> > There are two reasons.
> > 
> > Digest lists must be loaded before any file is accessed, otherwise IMA
> > will deny the operation if appraisal is in enforcing mode. With digest
> > lists it is possible to appraise files in the initial ram disk without
> > including extended attributes (the default policy excludes those files).
> 
> There are a number of people interested in extending CPIO to support
> extended attributes, not just for IMA-appraisal. (Years ago I started
> but unfortunately haven't had time to finish it.) ?Isn't the right
> solution to add extended attribute support to CPIO?

(For the record) Yes, yes it is. 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
