Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690DBEBB
	for <linux-security-module@vger.kernel.org>; Sat, 30 Mar 2024 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711810009; cv=none; b=huuVFddSzEkivmOz/g2HUChkmz2Jk5b+tXzWP9HPuY0uQEYILO2oep210/rd7KiA46FZ7SrxVdrDnO8LVzjvah3hUxmnWF9srYDRISUMkuFp4EpkZ/e88V1m9NZcPp/Zg0rRtKgUG1zDozvlbuhQ7p3+2nm/s2yxmjM2uG2XLlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711810009; c=relaxed/simple;
	bh=bQUfCY4pSrvICPVBo0cYWiOpX3/xa4keSeFDSH2EpDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeeF6QrVYVOj06RiRLX8l+3kXVDDe0aoRm8yhRMKbYHiItIDbaWFjeYkt4Wm3sAtRi72ezmGsyWq49jp1XoeMHHuEP0DeOpKNtREv7FnnT5lqn8cI5pnKfPvQLkqAQ2VQgFX2MN4YIvRhAHG2CpJC5U9lgdCPNU2aCZTqsoXtqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 42UEk5uH004633;
	Sat, 30 Mar 2024 09:46:06 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 42UEk4sB004632;
	Sat, 30 Mar 2024 09:46:04 -0500
Date: Sat, 30 Mar 2024 09:46:04 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, roberto.sassu@huaweicloud.com
Subject: Re: [PATCH] Do not require attributes for security_inode_init_security.
Message-ID: <20240330144604.GA4625@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240324223231.6249-1-greg@enjellic.com> <CAHC9VhQ22ef_o_OYue93RZfff70LPuOaCuN7Czv7HiEy346Svw@mail.gmail.com> <20240326103047.GA19964@wind.enjellic.com> <CAHC9VhQvN43LL-ynV-ZZgR2L8wFfUeq2-SZb5QHh9ZMWtz4C1A@mail.gmail.com> <20240327091644.GA32347@wind.enjellic.com> <CAHC9VhSjjeBH2CE5i+PK9Zyg661k-ryDbYkoPLtEe-g52DW0Fw@mail.gmail.com> <20240328153800.GA17524@wind.enjellic.com> <CAHC9VhTwZD7OU9v36HOd28a6jULLJeoQTdNSBYZWSrsY+jf7ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTwZD7OU9v36HOd28a6jULLJeoQTdNSBYZWSrsY+jf7ZA@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Sat, 30 Mar 2024 09:46:06 -0500 (CDT)

On Thu, Mar 28, 2024 at 08:26:11PM -0400, Paul Moore wrote:

> On Thu, Mar 28, 2024 at 11:38???AM Dr. Greg <greg@enjellic.com> wrote:
> >
> > BPF provides an implementation and would be affected ...

> Casey pretty much summed up my thoughts fairly well, including the
> "Bear poking trimmed" comment, which was worth a good laugh :)

Very good, we will take Casey's e-mail as the official position of the
Linux security maintainers on the functionality under discussion and
similar issues moving forward.

> paul-moore.com

Have a good weekend.

As always,
Dr. Greg

   The Quixote Project - Flailing at the Travails of Cybersecurity
		  https://github.com/Quixote-Project
