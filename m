From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 20 Nov 2017 08:53:40 -0500
Subject: [PATCH v2 06/15] ima: add parser of digest lists metadata
In-Reply-To: <175600e1-c472-69fc-2b4d-4255d8e827b5@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
	<20171107103710.10883-7-roberto.sassu@huawei.com>
	<20171118042030.GA13456@mail.hallyn.com>
	<1511047410.5920.111.camel@linux.vnet.ibm.com>
	<175600e1-c472-69fc-2b4d-4255d8e827b5@huawei.com>
Message-ID: <1511186020.4729.66.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2017-11-20 at 10:40 +0100, Roberto Sassu wrote:
> On 11/19/2017 12:23 AM, Mimi Zohar wrote:
> > Hi Serge,
> > 
> > On Fri, 2017-11-17 at 22:20 -0600, Serge E. Hallyn wrote:
> >> On Tue, Nov 07, 2017 at 11:37:01AM +0100, Roberto Sassu wrote:
> >>> from a predefined position (/etc/ima/digest_lists/metadata), when rootfs
> >>> becomes available. Digest lists must be loaded before IMA appraisal is in
> >>> enforcing mode.
> >>
> >> I'm sure there's a good reason for it, but this seems weird to me.
> >> Why read it from a file on disk instead of accepting it through say
> >> a securityfile write?
> 
> There are two reasons.
> 
> Digest lists must be loaded before any file is accessed, otherwise IMA
> will deny the operation if appraisal is in enforcing mode. With digest
> lists it is possible to appraise files in the initial ram disk without
> including extended attributes (the default policy excludes those files).

There are a number of people interested in extending CPIO to support
extended attributes, not just for IMA-appraisal. (Years ago I started
but unfortunately haven't had time to finish it.) ?Isn't the right
solution to add extended attribute support to CPIO?

> The second reason is that appraisal has to be temporarily disabled
> because the file containing digest list metadata is not signed. The same
> happens when loading a public key (check ima_load_x509() in ima_init.c).

In terms of the x509 certificate, in order to validate the file
containing the x509 certificate, there needs to be a key on the IMA
keyring.

Since x509 certificates themselves are signed by a key on the builtin
keyring, it is safe to load them on the IMA keyring without first
validating the file signature.

Once a public key is loaded on the IMA keyring, all other file
signatures can be appraised. ?There's no need for treating the digest
list file any differently than other files, as there is for the x509
certificate.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
