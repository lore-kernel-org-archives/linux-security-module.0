Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35951758B;
	Sat,  8 Mar 2025 03:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405495; cv=none; b=qODQxJzeK21bIr8t90piOHgKA2x8lA4SZ65bnoHf+MdO1DPCbc/AnW85VqN+7IRggAEod5G+6dXNQ7W/mYZJ54AsD7TzOC1WyygZwTEGyDvU7BNPq+wrmrz9AQyskzy38Ffkqy4UeU6t38trZLAE5MXasj0YvYV1aaOPh0sThy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405495; c=relaxed/simple;
	bh=9FXqXEgPrSCUdss8mDXDjVLyF7i2swbdCmkkvaXmW1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXobNatvN35Z9m8IuNQpusnTsnn1lPuj8p+cOWeD5IxOIWmA3x6ZjTlWmSButziuKPVs9tTvtNyvtPBY3tqRx7jfx0eZxBU+JGjRoYrMIrumx/A1lemUWOv9K2q0OCDi2UtiICdRWrwNgYxG8P4kUvoQvsQkjtbIHGil7XoqHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDYEpfkv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDYEpfkv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340BFC4CED1;
	Sat,  8 Mar 2025 03:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405494;
	bh=9FXqXEgPrSCUdss8mDXDjVLyF7i2swbdCmkkvaXmW1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SDYEpfkv1LnTuakx0Jefgl82P7kqsmINLdpgFAwvNUt9dtEMj84obMfxepV0tK/as
	 DwiGHIzea7o56O4Ug8PfBYvqIFl+QCZjrHS4lvD8udn+Y39NzYbCRfzHatK7XLp8mb
	 NYLGzTFxwfnVqM0mffjsBxprAJRINN5nWyEUSSiZ1NMsZzV5FJbp00BEEjW9q0AUW0
	 dJ+t97GkpnIZaKlKKMHQkC8v8Hsi0ksOUk3o5LKd14rOL32x7k6BmP4X+CW4WkLVf4
	 5HCVM7RxlvSy5J693GMJzF6rT4Tlb37gI4rYKgrlitggQjkXprzB3tPWtm1JFMecSM
	 jOEBCndUXpf6g==
Date: Sat, 8 Mar 2025 03:44:50 +0000
From: sergeh@kernel.org
To: Paul Moore <paul@paul-moore.com>
Cc: linux@treblig.org, serge@hallyn.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] capability: Remove unused has_capability
Message-ID: <Z8u9MhM450tD3lYe@lei>
References: <20241219172859.188117-1-linux@treblig.org>
 <CAHC9VhQ73qdL2Qf-jOMMVSf=+h-H8K+mz165XZztb5X6XjH11w@mail.gmail.com>
 <CAHC9VhTuvNuNfeLrR+5b+LOB_kC8a_67EvLPnOJO4vcvkcuMYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTuvNuNfeLrR+5b+LOB_kC8a_67EvLPnOJO4vcvkcuMYQ@mail.gmail.com>

On Wed, Feb 26, 2025 at 07:08:52PM -0500, Paul Moore wrote:
> On Thu, Dec 19, 2024 at 1:28 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Thu, Dec 19, 2024 at 12:29 PM <linux@treblig.org> wrote:
> > >
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > >
> > > The vanilla has_capability() function has been unused since 2018's
> > > commit dcb569cf6ac9 ("Smack: ptrace capability use fixes")
> > >
> > > Remove it.
> > >
> > > Fixup a comment in security/commoncap.c that referenced it.
> > >
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > > ---
> > >  include/linux/capability.h |  5 -----
> > >  kernel/capability.c        | 16 ----------------
> > >  security/commoncap.c       |  9 +++++----
> > >  3 files changed, 5 insertions(+), 25 deletions(-)
> >
> > Now that Serge has the capabilities tree back up and running I'm
> > assuming he will grab this patch, if not just let me know Serge and I
> > can take it.
> >
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
> 
> Bump this thread to make sure Serge sees it ...

d'oh, sorry, yes

Acked-by: Serge Hallyn <serge@hallyn.com>

I will apply this now.

-serge
