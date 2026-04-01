Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15BA1E98FF
	for <linux-security-module@vger.kernel.org>; Wed,  1 Apr 2026 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069318; cv=none; b=lyusLXlyZUS2cAkiB+xUvevqmQbUBY3WLBuKgu61hyDhkpZYJP1rdNQa3ol5n5kQyekIZwDaEdAW9zJVdEh/B3asJ11aH6qwXxmlgqaIkX4VDI14MRHYAiWfEsKXfnm2nmmt/RY+oCJiqAtoCPXT6NgLRA6G4t4kWbEXc4cw82s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069318; c=relaxed/simple;
	bh=70xkO9fukGzOt75CMLoBHnbVLdCYyPPkfIOhVCUNkag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8Xp7EtUYgO5Gcjxn1LSISuiKJHfxcg9Q/IjUv4Hdiwefq/Mq2CXqUzojR7+sZ4l7JGCWh7APsyMkwHjC2JKl3Q7AtmFJyIsUPGjlx/tyhwjLl+OlBMcvucQd5LbB9f7Mi4TMNTg14cLAc2oL6AN+up2s2rAUgG/WCGE9YcYHgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=X3HfVWrN; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="X3HfVWrN"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fmDXD2hXQz9fr;
	Wed,  1 Apr 2026 20:48:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775069308;
	bh=fEjnc3/92nMQeQxa3qfHMIDqyr0yZRh+moDnFMUUcZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X3HfVWrNFhj4+Ni7/mf3pqJlVZF2OFVW3pKZ8dwk8/cKeEEEwhfeoMp6UAHr1TPk8
	 XYPcqCuAb32mlNSGNhQR+7OOGgOcy9Mz4umbicFk42S/rvju5zPNmSfUUG7hVEJ/yD
	 iwhbAygqqgjEH+ObwcSDPkb4LNqtuhmUZgNwZe7w=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fmDXC23RQzsH9;
	Wed,  1 Apr 2026 20:48:27 +0200 (CEST)
Date: Wed, 1 Apr 2026 20:48:23 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Justin Suess <utilityemal77@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 02/11] security: Add LSM_AUDIT_DATA_NS for
 namespace audit records
Message-ID: <20260401.AhPieg6heeth@digikod.net>
References: <20260312100444.2609563-1-mic@digikod.net>
 <20260312100444.2609563-3-mic@digikod.net>
 <20260325-fachgebiet-parzelle-8ae15e6f305f@brauner>
 <20260401.XohYeim7tah8@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260401.XohYeim7tah8@digikod.net>
X-Infomaniak-Routing: alpha

On Wed, Apr 01, 2026 at 06:38:34PM +0200, Mickaël Salaün wrote:
> On Wed, Mar 25, 2026 at 01:32:42PM +0100, Christian Brauner wrote:
> > On Thu, Mar 12, 2026 at 11:04:35AM +0100, Mickaël Salaün wrote:
> > > Add a new LSM audit data type LSM_AUDIT_DATA_NS that logs namespace
> > > information in audit records.  Two fields are provided, matching the
> > > field names of struct ns_common:
> > > 
> > > - ns_type: the CLONE_NEW* flag identifying the namespace type, logged in
> > >   hexadecimal.
> > > 
> > > - inum: the proc inode number identifying a specific namespace instance.
> > >   Namespace inode numbers are allocated by proc_alloc_inum() via
> > >   ida_alloc_max() bounded to UINT_MAX, so the value always fits in 32
> > >   bits.
> > > 
> > > A new audit data type is needed because no existing LSM_AUDIT_DATA_*
> > > type carries namespace information.  The closest alternatives (e.g.
> > > LSM_AUDIT_DATA_TASK or LSM_AUDIT_DATA_NONE with custom strings) would
> > > either lose the namespace type or require ad-hoc formatting that
> > > bypasses the structured audit data union.
> > > 
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Günther Noack <gnoack@google.com>
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > ---
> > >  include/linux/lsm_audit.h | 5 +++++
> > >  security/lsm_audit.c      | 4 ++++
> > >  2 files changed, 9 insertions(+)
> > > 
> > > diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> > > index 382c56a97bba..6e20a56b8c22 100644
> > > --- a/include/linux/lsm_audit.h
> > > +++ b/include/linux/lsm_audit.h
> > > @@ -78,6 +78,7 @@ struct common_audit_data {
> > >  #define LSM_AUDIT_DATA_NOTIFICATION 16
> > >  #define LSM_AUDIT_DATA_ANONINODE	17
> > >  #define LSM_AUDIT_DATA_NLMSGTYPE	18
> > > +#define LSM_AUDIT_DATA_NS		19
> > >  	union 	{
> > >  		struct path path;
> > >  		struct dentry *dentry;
> > > @@ -100,6 +101,10 @@ struct common_audit_data {
> > >  		int reason;
> > >  		const char *anonclass;
> > >  		u16 nlmsg_type;
> > > +		struct {
> > > +			u32 ns_type;
> > > +			unsigned int inum;
> > 
> > fwiw, you might want to start the 64-bit namespace id as well.
> > But either way:
> 
> Right now these numbers are generated by ida_alloc_max(), which return
> an int.  Is there an ongoing patch series for this change?

OK, we should not use the inode's number (32-bit) but the namespace ID
(64-bit) which is readable with the NS_GET_ID IOCTL on the namespace
FDs.  I'll use that with ns_id instead of inum.  I'll also update the
Landlock code and tests accordingly.
