Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ACD225D6;
	Wed, 27 Nov 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728033; cv=none; b=MAIYfe+gKCmI+yiI0e6zKGJW6qB2UMBfE8rh1U1X/5SqDXpbqgQl4FHsXSd7nenYy+JrQlTRQ16+19v6OYkRRf8EvEUYU+91/ulvVm7LrBcDPLaozasZ5jOFvICF5DMyseTczBcAJJnZ2nKm2VtGBu2YAceDRlNyuYOrF8IVvV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728033; c=relaxed/simple;
	bh=mpyGGqPht6QEiY3RU88ACzruKbGM4Y82JYRu8p6kqOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osbF+uCkV0LAR6z3tmRIzUu4xGc3eOrC8WZVONTarU68gHXWkBhpvOn2UjqwR9eY+EmE8Wi3Dxz5H4IhA7EV+i3KPm3ukzCY+NsVT8tvUBbcsjvP8rDs1NtMATHbkLMoNBudSLODd/qrXAx7Qq0jDFUBGbBkL7qoBAFWTN8Git8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id ACB9D654; Wed, 27 Nov 2024 11:20:21 -0600 (CST)
Date: Wed, 27 Nov 2024 11:20:21 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	Jordan Rome <linux@jordanrome.com>,
	linux-security-module@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>,
	Paul Moore <paul@paul-moore.com>
Subject: Re: [GIT PULL] capabilities
Message-ID: <20241127172021.GA25444@mail.hallyn.com>
References: <Zztcp-fm9Ln57c-t@lei>
 <20241122173418.GA518018@mail.hallyn.com>
 <CAHC9VhRtuDmRX37asbFTFnwnoGTAidS1PArwZ9EfY4992fXQXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRtuDmRX37asbFTFnwnoGTAidS1PArwZ9EfY4992fXQXg@mail.gmail.com>

On Mon, Nov 25, 2024 at 01:52:59PM -0500, Paul Moore wrote:
> On Fri, Nov 22, 2024 at 12:34 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> >
> > On Mon, Nov 18, 2024 at 03:26:31PM +0000, sergeh@kernel.org wrote:
> > > Hi Linus,
> >
> > Hi,
> >
> > before the merge window closes, I just wanted to make sure this didn't get
> > lost.
> 
> ... and while Serge may not have sent a pull request for the
> capability code in a while, I just want to vouch that Serge is a real
> person and this is a legit pull request :)

Hi Linus,

don't mean to nag, but as the end of the merge window is approaching,
figure I should try one more time (or else ask Paul to send it instead).
Did you receive this PR?  Are there any changes I need to make?

thanks,
-serge
