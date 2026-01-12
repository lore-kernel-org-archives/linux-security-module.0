Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFF533EAF5
	for <linux-security-module@vger.kernel.org>; Mon, 12 Jan 2026 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768233824; cv=none; b=lMhjd++wBIUyWsyb5UR2qtdOBrJUhZQ9+6MoSVMUhP8sF6FtnWxKc+Xf/f/Spfnal5rJmc2XnmpxY2YtsOsG+zYWpww7Jid4KVMgGz8whIMCLU639OI4KaB9Z6MXRzLE4UJUCX4hi6m9OIhgc1YoqUkYxpU4252p4c4zCzVDVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768233824; c=relaxed/simple;
	bh=ezX19OiJ9Qrne5YfP1HJfHYyooTbL+s9PvSLallRe3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2bdZS2ErdOtzaOfF7K/+OamkBHMr3kUPevLNmQqgs/L4B5FhwKGnkfROAFZM4qsohp5a8P9jxr2NM762TU0WimtpzEMRkXKUKLC18bt3xpBjfEuHzuL0NPHEM8wbsUpVh8WKKiQ+E+QYSMoPacH3PUTBVA2e8AqWy7VefPnMX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=i3xgziqH; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="i3xgziqH"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dqccV235Qzfrg;
	Mon, 12 Jan 2026 17:03:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1768233818;
	bh=MjO1E6Wv/qr7NYngukS8EJ8W/elT3vtEBYCOGj64cRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i3xgziqHVYQKveLXj1f8Y3pUIm6V+EEfOj/vZbj/F3U2oq9RBG6yjH34QB3X4QZXt
	 JDlSwxvOJdUxnMIRkFrOdd9cUAkc/iy0h3SpuvmNLNjGNdp41TMsoLbyTKFBijhZWO
	 xODNjN/UxHAivehRNOQDCbN6QGbrITW1WRIUza8s=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dqccR40gYzdrd;
	Mon, 12 Jan 2026 17:03:35 +0100 (CET)
Date: Mon, 12 Jan 2026 17:03:30 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Matthieu Buffet <matthieu@buffet.re>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, linux-security-module@vger.kernel.org, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, netdev@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/8] landlock: Add UDP access control support
Message-ID: <20260112.Bee3chi7xa8D@digikod.net>
References: <20251212163704.142301-1-matthieu@buffet.re>
 <20260111.f025d6aefcf4@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260111.f025d6aefcf4@gnoack.org>
X-Infomaniak-Routing: alpha

On Sun, Jan 11, 2026 at 10:23:16PM +0100, Günther Noack wrote:
> Hello Matthieu!
> 
> On Fri, Dec 12, 2025 at 05:36:56PM +0100, Matthieu Buffet wrote:
> > Here is v3 of UDP support for Landlock. My apologies for the delay, I've
> > had to deal with unrelated problems. All feedback from v1/v2 should be
> > merged, thanks again for taking the time to review them.
> 
> Good to see the patch again. :)
> 
> Apologies for review delay as well.  There are many Landlock reviews
> in flight at the moment, it might take some time to catch up with all
> of them.
> 
> FYI: In [1], I have been sending a patch for controlling UNIX socket
> lookup, which is restricting connect() and sendmsg() operations for
> UNIX domain sockets of types SOCK_STREAM, SOCK_DGRAM and
> SOCK_SEQPACKET.  I am bringing it up because it feels that the
> semantics for the UDP and UNIX datagram access rights hook in similar
> places and therefore should work similarly?

Thanks for bringing this up.

> 
> In the current UNIX socket patch set (v2), there is only one Landlock
> access right which controls both connect() and sendmsg() when they are
> done on a UNIX datagram socket.  This feels natural to be, because you
> can reach the same recipient address whether that is done with
> connect() or with sendmsg()...?
> 
> (Was there a previous discussion where it was decided that these
> should be two different access rights for UDP sockets and UNIX dgram
> sockets?)

The rationale for these three access rights (connect, bind, and sendto)
is in the related commit message and it was discussed here:
https://lore.kernel.org/all/3631edfd-7f41-4ff1-9f30-20dcaa17b726@buffet.re/

Access rights for UNIX sockets can be simpler because we always know the
peer process, which is not the case for IP requests.  For the later,
being able to filter on the socket type can help.

> 
> [1] https://lore.kernel.org/all/20260101134102.25938-1-gnoack3000@gmail.com/
> 
> Thanks,
> –Günther
> 
