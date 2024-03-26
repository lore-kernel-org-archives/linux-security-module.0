Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C8F1CD1B
	for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2024 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441968; cv=none; b=O985Kv7QDvURfvQxsfX6cpTtYmNa5Nn3qSS2FY/VdAR3fNBVqTm3puEaubG9PIEm494KQeKkWJIHe4h+qelJutlHHFcH2orDbsen/2cnfnCrQjcR8FZWVeWO4wUaiSNWnt1iXlFR+Nf8ANxswps/1Xo/JVfOAFk3/stDpSVKWD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441968; c=relaxed/simple;
	bh=lOmMwKNNzagft7kUe3depGA5Xz8mH58kecSmOwBREFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPTE/m5aEQd9qwAwKt8Pi9rgSWsD/Xvw7USR3N63dzyvnAj/qG7blNG5vSm5T9IIPotTHAaB9jCQUen5GiicHJQ0dPaNxsOO9vA+Tw2jtF0A2yDbzQzpWGTqQEwNNF8iiKwIHpNF4JsQQydDy1BQ7I6EfIy2ULME5zoBEUlCpBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=UlvZSkZz; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="UlvZSkZz"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V3jjG3fK7zxrD;
	Tue, 26 Mar 2024 09:32:34 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4V3jjF4wJmzMppKw;
	Tue, 26 Mar 2024 09:32:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1711441954;
	bh=lOmMwKNNzagft7kUe3depGA5Xz8mH58kecSmOwBREFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UlvZSkZzU4PljVYaMzwHMADOpFQx+TKUD5kwJhtnyC0ec+Q6/TBbRDrV/MULWFwEI
	 zRLk4WrOva7zZA7k1xhJlyi3OTP0T7OBp9F8pURLYxN4aPLDPI/beRpKs8e6h3PnTR
	 0ydVsEaGbCtweuVrIDaWOfBXk3tA+YgxB5Oa6QEg=
Date: Tue, 26 Mar 2024 09:32:33 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v12 1/9] security: Introduce ENOFILEOPS return value for
 IOCTL hooks
Message-ID: <20240326.pie9eiF2Weis@digikod.net>
References: <20240325134004.4074874-1-gnoack@google.com>
 <20240325134004.4074874-2-gnoack@google.com>
 <80221152-70dd-4749-8231-9bf334ea7160@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80221152-70dd-4749-8231-9bf334ea7160@app.fastmail.com>
X-Infomaniak-Routing: alpha

On Mon, Mar 25, 2024 at 04:19:25PM +0100, Arnd Bergmann wrote:
> On Mon, Mar 25, 2024, at 14:39, Günther Noack wrote:
> > If security_file_ioctl or security_file_ioctl_compat return
> > ENOFILEOPS, the IOCTL logic in fs/ioctl.c will permit the given IOCTL
> > command, but only as long as the IOCTL command is implemented directly
> > in fs/ioctl.c and does not use the f_ops->unhandled_ioctl or
> > f_ops->compat_ioctl operations, which are defined by the given file.
> >
> > The possible return values for security_file_ioctl and
> > security_file_ioctl_compat are now:
> >
> >  * 0 - to permit the IOCTL
> >  * ENOFILEOPS - to permit the IOCTL, but forbid it if it needs to fall
> >    back to the file implementation.
> >  * any other error - to forbid the IOCTL and return that error
> >
> > This is an alternative to the previously discussed approaches [1] and [2],
> > and implements the proposal from [3].
> 
> Thanks for trying it out, I think this is a good solution
> and I like how the code turned out.

This is indeed a simpler solution but unfortunately this doesn't fit
well with the requirements for an access control, especially when we
need to log denied accesses.  Indeed, with this approach, the LSM (or
any other security mechanism) that returns ENOFILEOPS cannot know for
sure if the related request will allowed or not, and then it cannot
create reliable logs (unlike with EACCES or EPERM).
