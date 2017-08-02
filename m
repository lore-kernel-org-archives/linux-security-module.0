From: jmorris@namei.org (James Morris)
Date: Wed, 2 Aug 2017 17:22:30 +1000 (AEST)
Subject: [Linux-ima-devel] [PATCH, RESEND 08/12] ima: added parser for
	RPM data type
In-Reply-To: <11206fd8-d189-deb0-ab67-aec373f8d979@huawei.com>
References: <20170725154423.24845-9-roberto.sassu@huawei.com>
	<20170801102036.15371-1-roberto.sassu@huawei.com>
	<20170801102709.GA24285@infradead.org>
	<11206fd8-d189-deb0-ab67-aec373f8d979@huawei.com>
Message-ID: <alpine.LRH.2.20.1708021716440.1117@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 1 Aug 2017, Roberto Sassu wrote:

> On 8/1/2017 12:27 PM, Christoph Hellwig wrote:
> > On Tue, Aug 01, 2017 at 12:20:36PM +0200, Roberto Sassu wrote:
> > > This patch introduces a parser for RPM packages. It extracts the digests
> > > from the RPMTAG_FILEDIGESTS header section and converts them to binary
> > > data
> > > before adding them to the hash table.
> > >
> > > The advantage of this data type is that verifiers can determine who
> > > produced that data, as headers are signed by Linux distributions vendors.
> > > RPM headers signatures can be provided as digest list metadata.
> >
> > Err, parsing arbitrary file formats has no business in the kernel.
> 
> The benefit of this choice is that no actions are required for
> Linux distribution vendors to support the solution I'm proposing,
> because they already provide signed digest lists (RPM headers).
> 
> Since the proof of loading a digest list is the digest of the
> digest list (included in the list metadata), if RPM headers are
> converted to a different format, remote attestation verifiers
> cannot check the signature.
> 
> If the concern is security, it would be possible to prevent unsigned
> RPM headers from being parsed, if the PGP key type is upstreamed
> (adding in CC keyrings at vger.kernel.org).

It's a security concern and also a layering violation, there should be no 
need to parse package file formats in the kernel.

I'm not really clear on exactly how this patch series works.  Can you 
provide a more concrete explanation of what steps would occur during boot 
and attestation? 

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
