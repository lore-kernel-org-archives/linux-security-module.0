Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BA0278161;
	Thu,  9 Apr 2026 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741358; cv=none; b=cc75/psWtHEKvDYPVONhd/JyAqlMQp1P95MgWf0IjnRdjvClvIt31+80Gc02/q8RyPyflhInmZgg2mQ461v1XqEuBmizBEddSPhX/9nPzHLPNKlLGSJpvvcsgtx071J7LT5ikLRykIQvDQ0LeRrglpMz/od4gNlrTMYByakTbqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741358; c=relaxed/simple;
	bh=djDdSMdqOGVdSJJ4JPsKERci5+Mr5nMi1DGuXs8IRL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgM6MiHn8DI8CCP270hSrRpcpao6aM+jln5UgxK57BI7qvZSIie2PhhcDTsAT8lDAav/kOW45BrdYgRCuo33KiiImglrx/WQYpBO/np/UZnjhmiF54FhOcabsrDDyh9q4bDWUV8iOd6DTyPhCYWkAibAaxIW4YWu7UEX1jB00T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRToOjtq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRToOjtq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CECC4CEF7;
	Thu,  9 Apr 2026 13:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775741358;
	bh=djDdSMdqOGVdSJJ4JPsKERci5+Mr5nMi1DGuXs8IRL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRToOjtqikAyOfNhhTSXdnxVjRRQudoinX0PnO6nq32VQJphO0WhSoZCbr4PwkF8H
	 7RXslPPFdfBPeyKtVOT0gzR36cLcZg8jOLDeGH47EhPxLUSM4KBM5OcAXEPIL0dUmP
	 1mGuLuW8tsu6YjU0F1YrXcTxEaYe41NezeHMehC7Gv4MNxjT6FKOKhgluGs9uZdW7f
	 D5sVNA2dwJzN1AZaQTLElx6Io2qlSLWjeSvpQdbV3ZSBDpx2YrSBnkpkO2/r5/9TyH
	 GoZsariL7XGKAL6yKBrq1RF5+Go6VatUl5BJLWZKFKJV+1dyNWdOP5K3/oe33siHcH
	 E5wwK/E5GA6+A==
Date: Thu, 9 Apr 2026 15:29:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Justin Suess <utilityemal77@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 02/11] security: Add LSM_AUDIT_DATA_NS for
 namespace audit records
Message-ID: <20260409-besoffen-beinen-7ee307ec5c94@brauner>
References: <20260312100444.2609563-1-mic@digikod.net>
 <20260312100444.2609563-3-mic@digikod.net>
 <20260325-fachgebiet-parzelle-8ae15e6f305f@brauner>
 <20260401.XohYeim7tah8@digikod.net>
 <20260401.AhPieg6heeth@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260401.AhPieg6heeth@digikod.net>

On Wed, Apr 01, 2026 at 08:48:23PM +0200, Mickaël Salaün wrote:
> On Wed, Apr 01, 2026 at 06:38:34PM +0200, Mickaël Salaün wrote:
> > On Wed, Mar 25, 2026 at 01:32:42PM +0100, Christian Brauner wrote:
> > > On Thu, Mar 12, 2026 at 11:04:35AM +0100, Mickaël Salaün wrote:
> > > > Add a new LSM audit data type LSM_AUDIT_DATA_NS that logs namespace
> > > > information in audit records.  Two fields are provided, matching the
> > > > field names of struct ns_common:
> > > > 
> > > > - ns_type: the CLONE_NEW* flag identifying the namespace type, logged in
> > > >   hexadecimal.
> > > > 
> > > > - inum: the proc inode number identifying a specific namespace instance.
> > > >   Namespace inode numbers are allocated by proc_alloc_inum() via
> > > >   ida_alloc_max() bounded to UINT_MAX, so the value always fits in 32
> > > >   bits.
> > > > 
> > > > A new audit data type is needed because no existing LSM_AUDIT_DATA_*
> > > > type carries namespace information.  The closest alternatives (e.g.
> > > > LSM_AUDIT_DATA_TASK or LSM_AUDIT_DATA_NONE with custom strings) would
> > > > either lose the namespace type or require ad-hoc formatting that
> > > > bypasses the structured audit data union.
> > > > 
> > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > Cc: Günther Noack <gnoack@google.com>
> > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > > ---
> > > >  include/linux/lsm_audit.h | 5 +++++
> > > >  security/lsm_audit.c      | 4 ++++
> > > >  2 files changed, 9 insertions(+)
> > > > 
> > > > diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> > > > index 382c56a97bba..6e20a56b8c22 100644
> > > > --- a/include/linux/lsm_audit.h
> > > > +++ b/include/linux/lsm_audit.h
> > > > @@ -78,6 +78,7 @@ struct common_audit_data {
> > > >  #define LSM_AUDIT_DATA_NOTIFICATION 16
> > > >  #define LSM_AUDIT_DATA_ANONINODE	17
> > > >  #define LSM_AUDIT_DATA_NLMSGTYPE	18
> > > > +#define LSM_AUDIT_DATA_NS		19
> > > >  	union 	{
> > > >  		struct path path;
> > > >  		struct dentry *dentry;
> > > > @@ -100,6 +101,10 @@ struct common_audit_data {
> > > >  		int reason;
> > > >  		const char *anonclass;
> > > >  		u16 nlmsg_type;
> > > > +		struct {
> > > > +			u32 ns_type;
> > > > +			unsigned int inum;
> > > 
> > > fwiw, you might want to start the 64-bit namespace id as well.
> > > But either way:
> > 
> > Right now these numbers are generated by ida_alloc_max(), which return
> > an int.  Is there an ongoing patch series for this change?
> 
> OK, we should not use the inode's number (32-bit) but the namespace ID
> (64-bit) which is readable with the NS_GET_ID IOCTL on the namespace
> FDs.  I'll use that with ns_id instead of inum.  I'll also update the
> Landlock code and tests accordingly.

Yes, it's embedded in struct ns_common.
