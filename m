Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01810441030
	for <linux-security-module@vger.kernel.org>; Wed, 21 Jan 2026 22:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033823; cv=none; b=ViFxoePUNJotiUlBaimYjQ6k2vCBeCGnLtJyzzAiY2Qt8cPAUchuDlQTXvCfVEYtWLsA4odejBz9J+9Fa/dOIizyxkTIV9515u1fnSu/8tkTdhSs1xZSknz5MlM8nNL/ELyM46GIVwjjPcgzY5NfzURgax+xSoNoFep1bSBz1SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033823; c=relaxed/simple;
	bh=Ey4EMn+8C6Ed9DgmC3+xSbgecyaGuaw68enbpV58avE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCAfUUCDhHFjqtkneT40AIRZiTarjXbUpYBzS+7Ofs5AkJGfSd2e5Tv10T/5h1sQnAAG6Fvru68+m1WriC9Qto2jWBX/B+ltfoLU6o3+TU6NrLomKYWFtzaHVcrhlhi7mOvk+72hlAwvU+JzReLsdyNuWPMszBtNnCXBvuuH980=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=S4dG24wt; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="S4dG24wt"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dxJSv6qNjzrwx;
	Wed, 21 Jan 2026 23:16:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1769033807;
	bh=6az7+I2dsOoX/r8d1bLgbw9XOtkL24htYR2/5dF/Mro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S4dG24wtozqU97T4EmY0uIsO6QbF+xfoKIRu7pUplFJ0XM7zFLkCiIKln7jlt5ReQ
	 G329+8F0EUn3Z4/AtIMh+sWN7Dy1euBIb822QulI9KRUovXnXhIeexAOnfmCTNbONY
	 m7uhN+eyyu9YbUfO6D9kkHQfMvRzeoLEG3m8X80k=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dxJSv15hTz3d4;
	Wed, 21 Jan 2026 23:16:47 +0100 (CET)
Date: Wed, 21 Jan 2026 23:16:42 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com
Subject: Re: [RFC PATCH 2/2] landlock: transpose the layer masks data
 structure
Message-ID: <20260121.fae3Dahc3foo@digikod.net>
References: <20251230103917.10549-3-gnoack3000@gmail.com>
 <20251230103917.10549-7-gnoack3000@gmail.com>
 <20260111.11c57c607174@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260111.11c57c607174@gnoack.org>
X-Infomaniak-Routing: alpha

On Sun, Jan 11, 2026 at 10:52:26PM +0100, Günther Noack wrote:
> On Tue, Dec 30, 2025 at 11:39:21AM +0100, Günther Noack wrote:
> > diff --git a/security/landlock/access.h b/security/landlock/access.h
> > index 7961c6630a2d7..aa0efa36a37db 100644
> > --- a/security/landlock/access.h
> > +++ b/security/landlock/access.h
> >  [...]
> >  /*
> >   * Tracks domains responsible of a denied access.  This is required to avoid
> >   * storing in each object the full layer_masks[] required by update_request().
> > + *
> > + * Each nibble represents the layer index of the newest layer which denied a
> > + * certain access right.  For file system access rights, the upper four bits are
> > + * the index of the layer which denies LANDLOCK_ACCESS_FS_IOCTL_DEV and the
> > + * lower nibble represents LANDLOCK_ACCESS_FS_TRUNCATE.
> >   */
> >  typedef u8 deny_masks_t;
> 
> FYI: I left this out for now because it felt a bit out of scope (and
> transposing the layer masks was adventurous enough), but I was tempted
> to go one step further here and turn this into a struct with
> bitfields:
> 
> /* A collection of layer indices denying specific access rights. */
> struct layers_denying_fs_access {
>   unsigned int truncate  : 4;
>   unsigned int ioctl_dev : 4;
> }
> 
> (Type name TBD, I am open for suggestions.)
> 
> I think if we accept that this data structure is specific to FS access
> rights, we win clarity in the code.  When I came across the code that
> put this together dynamically and in a more generic way, it took me a
> while to figure out what it did.

This change should help indeed (in a standalone patch).  Maybe we could
make the rest of the logic more generic in a way that it would be
simpler to add this kind of access right?
