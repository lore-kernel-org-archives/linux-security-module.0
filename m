Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED38918643
	for <linux-security-module@vger.kernel.org>; Tue, 11 Jun 2024 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718093965; cv=none; b=um1oGJDBmwnu10CU7p6DhQ8vD289m0OFdSLnNIUGEQrwr6l3EqPmhboatqf/53mRXW7NvoQ87mq24G+89E32YE1DuBT+SltLvHOTxhFCSUO4u1wfn/fYdkhRYnv22NorSbpE+6MtowzFwDB1HFW9mXId4sRZ/gqkzZUqeVFFTxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718093965; c=relaxed/simple;
	bh=DyfZMNqfbelowjKg7Fg2Zw3jpBlT2GRYPwzy3WhZrVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7bVJLUpnzvvCJJJv/wzeRnVAr5UtDr0HNjHraUaQSXlUsKW5yP8bLpfiisP2/8u4KwltxyQJThmNQqjf2VHU3KOHXMoijhSMonmm1lzzLnj3LOZZ4SMB/Gaq4PgH9fw8dcnOz7qF7OUbzj1HYA7Hq6922rYD7FYra+WzFdQTrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=et2xVbPX; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="et2xVbPX"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vz1mH1BnxzmBh;
	Tue, 11 Jun 2024 10:19:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1718093951;
	bh=7HhB4sE7NSHxAQDCrk3KUOzkf7diWu3HyUqm9CqHvEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=et2xVbPXxCumQmIsI+DjulepJsWh1kePvzlLTh4VmveVuXji/VJMRwDKZ3SrExvKX
	 gB5KaN1tbWKEs1gfnEsT9+mhjcY6BXpSapxm/IjeqIl+fslwsbZvLtl1qjnOZWtbhT
	 dU9ltWH1xnmMN0+1OKYI+k090IpP/lU8XYhZ66o4=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Vz1mF6P1kzqRS;
	Tue, 11 Jun 2024 10:19:09 +0200 (CEST)
Date: Tue, 11 Jun 2024 10:19:06 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jann Horn <jannh@google.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, outreachy@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v3] landlock: Add abstract unix socket connect restriction
Message-ID: <20240611.Eed0Oochaht4@digikod.net>
References: <ZmJJ7lZdQuQop7e5@tahera-OptiPlex-5000>
 <ZmLEoBfHyUR3nKAV@google.com>
 <ZmNic8S1KtyLcp7i@tahera-OptiPlex-5000>
 <20240610.Aifee5ingugh@digikod.net>
 <CAG48ez3MBGi6i9Xcj29+pD9Lo1_hKkEtWYn-jNqvOZ_WWQZjYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3MBGi6i9Xcj29+pD9Lo1_hKkEtWYn-jNqvOZ_WWQZjYA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Jun 10, 2024 at 11:49:21PM +0200, Jann Horn wrote:
> On Mon, Jun 10, 2024 at 6:36 PM Mickaël Salaün <mic@digikod.net> wrote:
> > On Fri, Jun 07, 2024 at 01:41:39PM -0600, Tahera Fahimi wrote:
> > > On Fri, Jun 07, 2024 at 10:28:35AM +0200, Günther Noack wrote:
> > > > Is it intentional that you are both restricting the connection and the sending
> > > > with the same flag (security_unix_may_send)?  If an existing Unix Domain Socket
> > > > gets passed in to a program from the outside (e.g. as stdout), shouldn't it
> > > > still be possible that the program enables a Landlock policy and then still
> > > > writes to it?  (Does that work?  Am I mis-reading the patch?)
> >
> > If a passed socket is already connected, then a write/send should work.
> 
> If I'm reading unix_dgram_sendmsg() correctly, we'll always hit
> security_unix_may_send() for any UNIX socket type other than
> SOCK_SEQPACKET (meaning SOCK_STREAM and SOCK_DGRAM), even if the
> socket is already connected, and then we'll do the landlock check.
> That's probably not the intended behavior for Landlock, unless I'm
> misreading the code?
> 
> Maybe to get nice semantics it's necessary to add a parameter to
> security_unix_may_send() that says whether the destination address
> came from the caller or from the socket?

I think it would make sense to ignore connected sockets with
security_unix_may_send() because it should already be controlled by
security_unix_stream_connect().  This would still allow passed/inherited
connected sockets to be used, which is an important feature and would
be consistent with read/write on other passed FDs.  This would not work
with dgram sockets though.

We need tests for this case and with different socket modes (inspired by
the net_test.c:protocol variants).
